package com.gg.trade.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

import com.gg.board.dao.BoardDAO;
import com.gg.dto.GGDto;
import com.gg.user.dao.AlarmDAO;
import com.gg.user.dao.PointDAO;

public class TradeDAO {

	public Connection conn = null;
	public ResultSet rs = null;
	public PreparedStatement ps = null;

	public TradeDAO() {
		try {
			Context ctx = new InitialContext();
			DataSource ds = (DataSource) ctx.lookup("java:comp/env/jdbc/Oracle");
			conn = ds.getConnection();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	public void resClose() {
		try {
			if (rs != null && !rs.isClosed()) {
				rs.close();
			}
			if (ps != null && !ps.isClosed()) {
				ps.close();
			}
			if (conn != null && !conn.isClosed()) {
				conn.close();
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	// 구매요청
	public boolean buyRequest(int p_no, String u_id) {
		String sql = "INSERT INTO REQUEST VALUES(RQ_no_seq.NEXTVAL,?,?,'0',SYSDATE)";
		int success = 0;
		try {
			ps = conn.prepareStatement(sql);
			ps.setInt(1, p_no);
			ps.setString(2, u_id);
			success = ps.executeUpdate();
			if (success > 0) {
				pushBuyRequestAlarm(p_no, u_id);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}

		return success > 0 ? true : false;
	}

	// 구매요청 취소
	public boolean buyRequestCancel(int p_no, String u_id) {
		String sql = "DELETE FROM REQUEST WHERE P_NO = ? AND RQ_ID = ?";
		int success = 0;
		try {
			ps = conn.prepareStatement(sql);
			ps.setInt(1, p_no);
			ps.setString(2, u_id);
			success = ps.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		}

		return success > 0 ? true : false;
	}

//입찰하기
	public HashMap<String, Object> auctionBid(int p_no, int ha_bidPr, String ha_bidUsr) throws SQLException {

		// 반환값(성공여부, 실패시 ->현재 최고 입찰가, 성공여부 초기상태
		// msg를 뿌려줄 예정 (성공/ 현재입찰자 = 최고입찰자 / 입찰금액 <최고입찰긍)
		int checker = 0;
		boolean success = false;
		boolean instantYN = false;
		int instantPr = 0;
		String sql = "";
		String msg = "";
		HashMap<String, Object> map = new HashMap<String, Object>();
		AlarmDAO Aldao = new AlarmDAO();
		BoardDAO Bdao = new BoardDAO();

		// 즉결구매가 이상을 입력한 경우
		sql = "select au_instantpr from auction where p_no=?";
		ps = conn.prepareStatement(sql);
		ps.setInt(1, p_no);
		rs = ps.executeQuery();

		if (rs.next()) {// 무조건 즉결가는 존재(이미 보유포인트에서 거를 예정이기에)
			instantPr = rs.getInt("au_instantpr");
			System.out.println("경매글 최고 입찰가 : " + instantPr);

			ha_bidPr = (ha_bidPr >= instantPr) ? instantPr : ha_bidPr;
			System.out.println("변경된 입찰가 : " + ha_bidPr);
		}

		// 변경된 입찰금액과 즉결가를 비교해서 동일한 경우 즉결구매로 넘김
		if (ha_bidPr == instantPr) {

			success = buyNow(p_no, ha_bidUsr, ha_bidPr);
			System.out.println("즉결구매 성공 여부 : " + success);
			if (success) {
				msg = "즉결구매에 성공하였습니다.";
			} else {
				msg = "즉결구매에 실패하였습니다.";
			}

		} else {
			// 이전 최고입찰자와 최고입찰금액 가져오는 쿼리
			sql = "select his.ha_bidpr, his.ha_bidusr from his_auction his where his.ha_bidpr =(select max(ha_bidpr) from his_auction  group by p_no having p_no=?) and p_no = ?";
			ps = conn.prepareStatement(sql);
			ps.setInt(1, p_no);
			ps.setInt(2, p_no);
			rs = ps.executeQuery();
			if (rs.next()) {
				String bidUsr = rs.getString("ha_bidusr");
				int bidPr = rs.getInt("ha_bidpr");
				System.out.println("최고 입찰자 : " + bidUsr + " / 최고입찰가 : " + bidPr);

				if (bidUsr.equals(ha_bidUsr)) { // 내가 이미 최고입찰자인 경우
					msg = "이미 최고입찰자 입니다.";
				} else if (bidPr >= ha_bidPr) { // 내가 입력한 입찰금이 최고 입찰금보다 적을 때
					msg = "입찰금액이 최고입찰가보다 적습니다. 다시 입찰해주세요.";
					map.put("bidPr", bidPr);
				} else { // 내가 입력한 금액이 최고 입찰금액보다 큰 경우
					sql = "INSERT INTO his_auction(p_no,ha_bidpr,ha_bidusr,ha_bidtm) VALUES(?,?,?,SYSDATE) ";
					ps = conn.prepareStatement(sql);
					ps.setInt(1, p_no);
					ps.setInt(2, ha_bidPr);
					ps.setString(3, ha_bidUsr);
					checker = ps.executeUpdate();

					// insert 성공시
					if (checker > 0) {
						success = true;
						msg = "입찰에 성공하였습니다.";
						if (success) {
							instantYN = bidRecordYN(p_no, ha_bidUsr);
							System.out.println("시작금 인출 여부 : " + instantYN);

							// 입찰자 변경알람 보내기
							String title = Bdao.getTitle(p_no);
							System.out.println("게시글 제목 : " + title);
							title = Aldao.cutTitle(title);
							System.out.println("자른 게시글 제목 : " + title);
							Aldao.insertAlarm(bidUsr, "A010", "[" + title + "]입찰자가 변경되었습니다.", "Y",
									"./auctionDetail?p_no=" + p_no);

						}
					}
				}
			} else {// 이전 입찰자가 없었을 때
				sql = "INSERT INTO his_auction(p_no,ha_bidpr,ha_bidusr,ha_bidtm) VALUES(?,?,?,SYSDATE) ";
				ps = conn.prepareStatement(sql);
				ps.setInt(1, p_no);
				ps.setInt(2, ha_bidPr);
				ps.setString(3, ha_bidUsr);
				checker = ps.executeUpdate();

				// insert 성공시
				if (checker > 0) {
					success = true;
					msg = "입찰에 성공하였습니다.";
					if (success) {
						instantYN = bidRecordYN(p_no, ha_bidUsr);
						System.out.println("시작금 인출 여부 : " + instantYN);
					}

				}
			}
		}

		// 입찰금액 입력 쿼리
		System.out.println("경매 히스토리 입력여부 : " + success);

		Aldao.resClose();
		Bdao.resClose();

		map.put("success", success);
		System.out.println("메세지 확인 : " + msg);
		map.put("msg", msg);

		return map;
	}

	// 입찰횟수 늘리기
	public int upAucCnt(int p_no) throws SQLException {
		String sql = "update auction set au_count = au_count+1 where p_no=?";
		ps = conn.prepareStatement(sql);
		ps.setInt(1, p_no);
		int success = ps.executeUpdate();
		System.out.println("올라간 입찰 수 : " + success);

		return success;
	}

	// 즉시구매하는 기능
	public boolean buyNow(int p_no, String u_id, int ha_bidPr) throws SQLException {
		// 즉결가 조회
		String sql = "SELECT AU_INSTANTPR FROM AUCTION WHERE P_NO = ?";
		// 낙찰자를 등록
		String sql2 = "UPDATE AUCTION SET AU_SUCCESSER = ? WHERE P_NO = ?";
		// 경매상태를 거래중으로 변경
		String sql3 = "UPDATE AUCTION SET AU_CODE = 'Au002', AU_SUCTM = SYSDATE WHERE P_NO = ?";
		// 경매히스토리에 이력을 저장
		String sql4 = "INSERT INTO his_auction(p_no,ha_bidpr,ha_bidusr,ha_bidtm) VALUES(?,?,?,SYSDATE)";
		AlarmDAO Aldao = new AlarmDAO();
		BoardDAO Bdao = new BoardDAO();
		int success = 0;
		int au_instantpr = 0;
		try {
			ps = conn.prepareStatement(sql);
			ps.setInt(1, p_no);
			rs = ps.executeQuery();
			System.out.println("DAO buyNow 즉결가 조회");

			if (rs.next()) {
				au_instantpr = rs.getInt("au_instantpr");
				System.out.println("DAO buyNow au_instantpr : " + au_instantpr);
			}
			System.out.println("DAO buyNow au_instantpr == ha_bidPr : " + (au_instantpr == ha_bidPr));
			if (au_instantpr == ha_bidPr) {
				System.out.println("테스트");
				ps = conn.prepareStatement(sql2);
				ps.setString(1, u_id);
				ps.setInt(2, p_no);

				if (ps.executeUpdate() > 0) {
					System.out.println("DAO buyNow 낙찰자 등록");
					ps = conn.prepareStatement(sql3);
					ps.setInt(1, p_no);
					if (ps.executeUpdate() > 0) {
						System.out.println("DAO buyNow 경매상태 거래중으로 변경 성공");
						ps = conn.prepareStatement(sql4);
						ps.setInt(1, p_no);
						ps.setInt(2, ha_bidPr);
						ps.setString(3, u_id);
						success = ps.executeUpdate();
						System.out.println("DAO buyNow 경매히스토리 이력 저장 완료");
					}
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
		}

		boolean result = bidRecordYN(p_no, u_id);
		System.out.println("시작금 인출 여부 : " + result);
		// 시작가 조회
		int startPr = selectAuctionAu_startPr(p_no);
		// 입찰금 반환 메서드 실행
		returnStartPr(p_no, startPr);
		// 해당 글번호로 판매자를 알아오기
		String p_id = selectPostP_id(p_no);
		System.out.println("p_id : " + p_id);
		// 글번호, 판매자, 구매자를 인자값으로 넣어서, 거래페이지 생성과, 거래히스토리에 "0원" "생성" 추가
		int t_no = insertTrade(p_no, p_id, u_id);
		// 글번호로 제목을 가져오는 기능
		String p_title = Bdao.getTitle(p_no);
		p_title = Aldao.cutTitle(p_title);
		// 알람보내기
		PointDAO Pdao = new PointDAO();
		String u_nname = Pdao.getNname(u_id);
		Aldao.insertAlarm(u_id, "A004", "[" + p_title + "]낙찰자로 선정되었습니다.", "Y", "./tradeDetail?t_no=" + t_no);// 경매글 낙찰자
		Aldao.insertAlarm(p_id, "A011", "[" + p_title + "]경매가 종료 되었습니다.", "Y", "./auctionDetail?p_no=" + p_no);// 경매글
																												// 작성자
		Aldao.insertAlarm(p_id, "A004", "[" + p_title + "]" + u_nname + "님이 낙찰자로 선정되었습니다.", "Y",
				"./tradeDetail?t_no=" + t_no);// 경매글 작성자
		Aldao.resClose();
		Bdao.resClose();
		Pdao.resClose();

		return success > 0 ? true : false;
	}

	/// 경매 종료 메서드///
	public GGDto endAuction(int p_no, String au_code, String ha_bidusr) throws SQLException {

		GGDto dto = new GGDto();
		//int instantpr = 0;
		//AlarmDAO Aldao = new AlarmDAO();
		//BoardDAO Bdao = new BoardDAO();
		// 낙찰시간,경매상태,낙찰자 변경
		String sql = "update auction set au_suctm = SYSDATE, au_code= 'Au002' ,au_successer = (select u_id from userinfo where u_nname= ?) where p_no=? ";
		ps = conn.prepareStatement(sql);
		ps.setString(1, ha_bidusr);
		ps.setInt(2, p_no);

		int success = ps.executeUpdate();

		// 성공했을 때 경매상태, 낙찰시간, 낙찰자 데이터 가져와서 담아주기
		if (success > 0) {
			sql = "select au_code,au_successer,au_suctm,au_instantpr from auction where p_no=?";
			ps = conn.prepareStatement(sql);
			ps.setInt(1, p_no);
			//ps.setInt(2, p_no);
			//ps.setInt(3, p_no);


			rs = ps.executeQuery();

			if (rs.next()) {
				dto.setAu_code(rs.getString("au_code"));
				dto.setAu_successer(rs.getString("au_successer"));
				dto.setAu_sucTm(rs.getDate("au_suctm"));
				//instantpr = rs.getInt("au_instantpr");
				
				System.out.println("endauction aucode : "+dto.getAu_code());
				System.out.println("endauction ausuccesser : "+dto.getAu_successer());
				System.out.println("endauction ausuctm : "+dto.getAu_sucTm());
				
			}

			String successer = dto.getAu_successer();

			// 시작가 조회
			int startPr = selectAuctionAu_startPr(p_no);
			// 입찰금 반환 메서드 실행
			returnStartPr(p_no, startPr);

			// 해당 글번호로 판매자, 제목을 알아오기
			String p_id = selectPostP_id(p_no);
			//String p_title = Bdao.getTitle(p_no);
			//p_title = Aldao.cutTitle(p_title);
			// 글번호, 판매자, 구매자를 인자값으로 넣어서, 거래페이지 생성과, 거래히스토리에 "0원" "생성" 추가
			int t_no = insertTrade(p_no, p_id, dto.getAu_successer());
			dto.setT_no(t_no);
			
			/*
			 //알람보내기
			Aldao.insertAlarm(successer, "A004", "["+p_title+"..]낙찰자로 선정되었습니다.", "Y", "./tradeDetail?t_no="+t_no);//경매글 낙찰자
			Aldao.insertAlarm(p_id, "A011", "["+p_title+"..]경매가 종료 되었습니다.", "Y", "./tradeDetail?t_no="+t_no);//경매글 작성자
			Aldao.resClose();
			Bdao.resClose();
			*/
			
		}

		return dto;
	}

	public boolean bidRecordYN(int p_no, String user_id) throws SQLException {

		boolean success = false;
		PointDAO dao = new PointDAO();

		// 입찰내역이 있는지 확인
		String sql = "select count(*) as count from (select * from his_auction where p_no=?) where ha_bidusr = ? group by ha_bidusr";
		ps = conn.prepareStatement(sql);
		ps.setInt(1, p_no);
		ps.setString(2, user_id);

		rs = ps.executeQuery();
		int count = 0;
		if (rs.next()) {
			count = rs.getInt("count");
			if (count == 1) {
				// 입찰한 내역이 없는 경우
				sql = "select au_startpr from auction where p_no=?";

				ps = conn.prepareStatement(sql);
				ps.setInt(1, p_no);
				rs = ps.executeQuery();
				rs.next();

				int pnt_point = rs.getInt("au_startpr"); // 시작가격 가져오기
				System.out.println("시작가격 pnt_point : " + pnt_point);
				success = dao.insertPoint(user_id, pnt_point, "SYSTEM", "PNT006", p_no);
				System.out.println("시작금 인출여부 : " + success);
			}
		}

		dao.resClose();
		return success;

	}

	public void returnStartPr(int p_no, int startPr) throws SQLException {

		boolean insertRs = false;
		PointDAO dao = new PointDAO();
		AlarmDAO Aldao = new AlarmDAO();
		/// 입찰금반환 메서드 실행
		String sql = "select distinct ha_bidusr,(select p_title from post where p_no=?) as p_title from his_auction where ha_bidusr <> (select au_successer from auction where p_no=?) and p_no=?";

		ps = conn.prepareStatement(sql);
		ps.setInt(1, p_no);
		ps.setInt(2, p_no);
		ps.setInt(3, p_no);

		rs = ps.executeQuery();
		System.out.println("=========입찰금 반환 목록==========");
		while (rs.next()) {
			String bid_id = rs.getString("ha_bidusr");
			String p_title = rs.getString("p_title");
			System.out.println("bid_id:" + bid_id);
			System.out.println("p_title:" + p_title);

			p_title = Aldao.cutTitle(p_title);

			// 경매종료 알람보내기
			Aldao.insertAlarm(bid_id, "A011", "[" + p_title + "]경매가 종료 되었습니다.", "Y", "./auctionDetail?p_no=" + p_no);
			insertRs = dao.insertPoint(bid_id, startPr, "SYSTEM", "PNT007", p_no);

			if (insertRs) {
				System.out.println("입찰금 반환 id :" + bid_id + "/ 반환할 입찰금 : " + startPr);
			}

		}
		System.out.println("==========================");

		Aldao.resClose();
		dao.resClose();

	}

	// ====================구매 요청 수락, 거절=====================
	// 구매요청을 수락하면 거래페이지 생성, 거절하면 끝
	public int buyRequestProcess(int rq_no, String rq_YN, int p_no, String t_saler, String t_buyer) {
		System.out.println("[TRADEDAO]/BUYREQUESTPROCESS START");
		String sql = "UPDATE REQUEST SET RQ_YN = ? WHERE RQ_NO = ?";
		int success = 0;
		boolean insertNsaleNscodeSuccess = false;
		int t_no = 0;
		try {
			ps = conn.prepareStatement(sql);
			ps.setString(1, rq_YN);
			ps.setInt(2, rq_no);
			success = ps.executeUpdate();
			System.out.println("[TRADEDAO]/BUYREQUESTPROCESS SUCCESS : " + success);
			System.out.println("구매요청 수락 거절 여부:" + rq_YN);
			if (success > 0) {
				// 수락했을 경우
				System.out.println("[TRADEDAO]/BUYREQUESTPROCESS RQ_YN : " + rq_YN);
				if (rq_YN.toUpperCase().equals("Y")) {
					// 판매글의 상태를 거래중으로 변경
					insertNsaleNscodeSuccess = updateNsaleNscode(p_no, "NS_002");
					System.out.println(
							"[TRADEDAO]/BUYREQUESTPROCESS INSETNSALENSCODESUCCESS : " + insertNsaleNscodeSuccess);
					if (insertNsaleNscodeSuccess) {
						// 구매요청자의 id는 href, 판매자의 id는 session를 받아서 거래페이지 생성
						t_no = insertTrade(p_no, t_saler, t_buyer);
						System.out.println("[TRADEDAO]/BUYREQUESTPROCESS T_NO : " + t_no);
						// 구매요청 수락 알람
						pushRequestResult(p_no, t_no, t_saler, t_buyer, rq_YN);
					}
				} else {
					// 구매요청 거절 알람
					pushRequestResult(p_no, -199, t_saler, t_buyer, rq_YN);
				}
			}

		} catch (SQLException e) {
			e.printStackTrace();
		}
		System.out.println("[TRADEDAO]/BUYREQUESTPROCESS END");

		return t_no;
	}

	// 판매글 상태를 변경하는 기능
	public boolean updateNsaleNscode(int p_no, String ns_code) {
		System.out.println("[TRADEDAO]/UPDATENSALENSCODE START");
		String sql = "UPDATE N_SALE SET NS_CODE = ? WHERE P_NO = ?";
		int success = 0;
		try {
			ps = conn.prepareStatement(sql);
			ps.setString(1, ns_code);
			ps.setInt(2, p_no);
			success = ps.executeUpdate();
			System.out.println("[TRADEDAO]/UPDATENSALENSCODE SUCCESS : " + success);
		} catch (SQLException e) {
			e.printStackTrace();
		}
		System.out.println("[TRADEDAO]/UPDATENSALENSCODE END");

		return success > 0 ? true : false;
	}

	// ====================거래 페이지=======================
	// 거래페이지 생성, 구매요청 수락 또는 경매완료시 실행
	public int insertTrade(int p_no, String t_saler, String t_buyer) {
		System.out.println("[TRADEDAO]/INSERTTRADE START");
		String sql = "INSERT INTO TRADE (T_NO, P_NO, T_SALER, T_BUYER, T_CANCLEID, T_ADMACC) VALUES(T_NO_SEQ.NEXTVAL, ?, ?, ?, NULL, 'N')";
		int success = 0;
		int t_no = 0;
		boolean insertHisTradeSuccess = false;
		try {
			ps = conn.prepareStatement(sql);
			ps.setInt(1, p_no);
			ps.setString(2, t_saler);
			ps.setString(3, t_buyer);
			success = ps.executeUpdate();
			System.out.println("[TRADEDAO]/INSERTTRADE SUCCESS : " + success);
			if (success > 0) {
				// 거래히스토리에 0원, 생성 추가
				t_no = selectTradeT_no(p_no, t_saler, t_buyer);
				insertHisTradeSuccess = insertHisTrade(t_no, 0, "HT001");
				System.out.println("[TRADEDAO]/INSERTTRADE T_NO : " + t_no);
				System.out.println("[TRADEDAO]/INSERTTRADE insertHisTradeSuccess : " + insertHisTradeSuccess);

				// 거래댓글에 '거래를 시작하세요' 매세지를 추가 (조인시 행이 사라지는 것을 방지하기 위함)
				boolean insertTradeCommentSuccess = insertTradeComment(t_no, "거래를 시작하세요", "SYSTEM");
				System.out.println("[TRADEDAO]/INSERTTRADE INSERTTRADECOMMENTSUCCESS : " + insertTradeCommentSuccess);

			}

		} catch (SQLException e) {
			e.printStackTrace();
		}
		System.out.println("[TRADEDAO]/INSERTTRADE END");

		return t_no;
	}

	// 거래페이지번호를 조회하는 기능 (필요값 : 글번호, 구매자, 판매자)
	public int selectTradeT_no(int p_no, String t_saler, String t_buyer) {
		System.out.println("[TRADEDAO]/SELECTTRADET_NO START");
		String sql = "SELECT T_NO FROM TRADE WHERE P_NO = ? AND T_SALER = ? AND T_BUYER = ?";
		int t_no = 0;
		try {
			ps = conn.prepareStatement(sql);
			ps.setInt(1, p_no);
			ps.setString(2, t_saler);
			ps.setString(3, t_buyer);
			rs = ps.executeQuery();
			if (rs.next()) {
				t_no = rs.getInt("t_no");
				System.out.println("[TRADEDAO]/SELECTTRADET_NO T_NO : " + t_no);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		System.out.println("[TRADEDAO]/SELECTTRADET_NO END");

		return t_no;

	}

	// 거래히스토리에 행을 추가하는 기능
	public boolean insertHisTrade(int t_no, int ht_point, String ht_code) {
		System.out.println("[TRADEDAO]/INSERTHISTRADE START");
		String sql = "INSERT INTO HIS_TRADE (T_NO, HT_DATE, HT_POINT, HT_CODE) VALUES(?, SYSDATE, ?, ?)";
		int success = 0;
		try {
			ps = conn.prepareStatement(sql);
			ps.setInt(1, t_no);
			ps.setInt(2, ht_point);
			ps.setString(3, ht_code);
			success = ps.executeUpdate();
			System.out.println("[TRADEDAO]/INSERTHISTRADE SUCCESS : " + success);
		} catch (SQLException e) {
			e.printStackTrace();
		}
		System.out.println("[TRADEDAO]/INSERTHISTRADE END");

		return success > 0 ? true : false;
	}

	// 거래페이지에서 취소한 사람 ID를 넣는 기능
	public boolean updateTradeT_cancleId(String t_cancleId, int t_no) {
		System.out.println("[TRADEDAO]/UPDATETRADET_CANCLEID START");
		String sql = "UPDATE TRADE SET T_CANCLEID = ? WHERE T_NO = ?";
		int success = 0;
		try {
			ps = conn.prepareStatement(sql);
			ps.setString(1, t_cancleId);
			ps.setInt(2, t_no);
			success = ps.executeUpdate();
			System.out.println("[TRADEDAO]/UPDATETRADET_CANCLEID SUCCESS : " + success);
		} catch (SQLException e) {
			e.printStackTrace();
		}
		System.out.println("[TRADEDAO]/UPDATETRADET_CANCLEID END");

		return success > 0 ? true : false;
	}

	// 거래페이지의 글번호로 게시글이 판매인지 경매인지 확인하는 기능
	public String selectPostP_code(int p_no) {
		System.out.println("[TRADEDAO]/CHECKP_CODE START");
		String sql = "SELECT P_CODE FROM POST WHERE P_NO = ?";
		String p_code = "";
		try {
			ps = conn.prepareStatement(sql);
			ps.setInt(1, p_no);
			rs = ps.executeQuery();
			if (rs.next()) {
				p_code = rs.getString("p_code");
				System.out.println("[TRADEDAO]/CHECKP_CODE P_CODE : " + p_code);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		System.out.println("[TRADEDAO]/CHECKP_CODE END");

		return p_code;
	}

	// 경매테이블에서 글번호로 시작가를 가져오는 기능
	public int selectAuctionAu_startPr(int p_no) {
		System.out.println("[TRADEDAO]/SELECTAUCTIONAU_STARTPR START");
		String sql = "SELECT AU_STARTPR FROM AUCTION WHERE P_NO = ?";
		int au_startPr = 0;
		try {
			ps = conn.prepareStatement(sql);
			ps.setInt(1, p_no);
			rs = ps.executeQuery();
			if (rs.next()) {
				au_startPr = rs.getInt("au_startpr");
				System.out.println("[TRADEDAO]/SELECTAUCTIONAU_STARTPR AU_STARTPR : " + au_startPr);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		System.out.println("[TRADEDAO]/SELECTAUCTIONAU_STARTPR END");

		return au_startPr;
	}

	// 경매히스토리에서 글번호로 최고입찰가를 가져오는 기능
	public int selectHis_AuctionMax_Ha_bidPr(int p_no) {
		System.out.println("[TRADEDAO]/SELECTHIS_AUCTIONMAX_HA_BIDPR START");
		String sql = "SELECT MAX(HA_BIDPR) MAX_HA_BIDPR FROM HIS_AUCTION WHERE P_NO = ?";
		int max_ha_bidPr = 0;
		try {
			ps = conn.prepareStatement(sql);
			ps.setInt(1, p_no);
			rs = ps.executeQuery();
			if (rs.next()) {
				max_ha_bidPr = rs.getInt("max_ha_bidpr");
				System.out.println("[TRADEDAO]/SELECTHIS_AUCTIONMAX_HA_BIDPR MAX_HA_BIDPR : " + max_ha_bidPr);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		System.out.println("[TRADEDAO]/SELECTHIS_AUCTIONMAX_HA_BIDPR END");

		return max_ha_bidPr;
	}

	// 경매히스토리에서 글번호로 최고입찰자를 가져오는 기능
	public String selectHis_AuctionHa_bidUsr(int p_no) {
		System.out.println("[TRADEDAO]/SELECTHIS_AUCTIONHA_BIDUSR START");
		String sql = "SELECT hau.ha_bidusr FROM his_auction hau, (SELECT P_NO, MAX(HA_BIDPR) TOPPR FROM HIS_AUCTION GROUP BY P_NO) haum WHERE hau.p_no = haum.p_no and hau.ha_bidpr = haum.toppr and hau.p_no=?";
		String ha_bidUsr = "";
		try {
			ps = conn.prepareStatement(sql);
			ps.setInt(1, p_no);
			rs = ps.executeQuery();
			if (rs.next()) {
				ha_bidUsr = rs.getString("ha_bidusr");
				System.out.println("[TRADEDAO]/SELECTHIS_AUCTIONHA_BIDUSR HA_BIDUSR : " + ha_bidUsr);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		System.out.println("[TRADEDAO]/SELECTHIS_AUCTIONHA_BIDUSR END");

		return ha_bidUsr;
	}

	// 경매글을 경매완료로 변경하는 기능
	public boolean updateAuctionAu_code(int p_no, String au_code) {
		System.out.println("[TRADEDAO]/UPDATEAUCTIONAU_CODE START");
		String sql = "UPDATE AUCTION SET AU_CODE = ? WHERE P_NO = ?";
		int success = 0;
		try {
			ps = conn.prepareStatement(sql);
			ps.setString(1, au_code);
			ps.setInt(2, p_no);
			success = ps.executeUpdate();
			System.out.println("[TRADEDAO]/UPDATEAUCTIONAU_CODE SUCCESS : " + success);
		} catch (Exception e) {
			e.printStackTrace();
		}
		System.out.println("[TRADEDAO]/UPDATEAUCTIONAU_CODE END");

		return success > 0 ? true : false;
	}

	// 거래페이지 상세보기
	public GGDto tradeDetail(int t_no) {
		System.out.println("[TRADEDAO]/TRADEDETAIL START");
		String sql = "SELECT T.T_NO, T.P_NO, T.T_SALER, T.T_BUYER, NVL(T.T_CANCLEID,'NULL') T_CANCLEID, T.T_ADMACC, H.HT_DATE, H.HT_POINT, H.HT_CODE, (SELECT C_NAME FROM CODES WHERE C_CODE = H.HT_CODE) HT_NAME FROM TRADE T, (SELECT * FROM HIS_TRADE WHERE T_NO = ? AND HT_DATE = (SELECT MAX(HT_DATE) FROM HIS_TRADE WHERE T_NO = ?)) H WHERE T.T_NO = H.T_NO";
		GGDto dto = null;

		// 게시글 정보 담기 위해서 실행
		BoardDAO bdao = new BoardDAO();
		GGDto bdto = null;

		// 구매자의 보유포인트를 담기 위해서 실행
		PointDAO pdao = new PointDAO();

		try {
			ps = conn.prepareStatement(sql);
			ps.setInt(1, t_no);
			ps.setInt(2, t_no);
			rs = ps.executeQuery();
			if (rs.next()) {
				dto = new GGDto();
				dto.setT_no(rs.getInt("t_no"));// 거래페이지 번호
				dto.setP_no(rs.getInt("p_no"));// 글번호
				dto.setT_saler(rs.getString("t_saler"));// 판매자
				dto.setT_buyer(rs.getString("t_buyer"));// 구매자
				// dto.setT_cancleId(rs.getString("t_cancleId"));//거래취소한 사람의 id (없을 경우 'NULL')
				dto.setT_admAcc(rs.getString("t_admacc"));// 관리자 접근가능 여부
				dto.setHt_point(rs.getInt("ht_point"));// 송금 포인트
				dto.setHt_code(rs.getString("ht_code"));// 거래히스토리 분류코드
				dto.setHt_name(rs.getString("ht_name"));// 거래히스토리 분류명
				System.out.println("[TRADEDAO]/TRADEDETAIL P_NO : " + dto.getP_no());
				System.out.println("[TRADEDAO]/TRADEDETAIL HT_CODE : " + dto.getHt_code());

				// 구매자의 보유포인트
				dto.setT_point(pdao.pointPop(dto.getT_buyer()));// 구매자의 보유포인트
				System.out.println("[TRADEDAO]/TRADEDETAIL T_POINT : " + dto.getT_point());

				// 경매 or 판매 여부
				String p_code = selectPostP_code(dto.getP_no());
				System.out.println("[TRADEDAO]/TRADEDETAIL P_CODE : " + p_code);// 글 분류코드
				dto.setP_code(p_code);

				// 경매일 경우
				if (p_code.equals("P001")) {
					// int au_startPr = selectAuctionAu_startPr(dto.getP_no());
					// System.out.println("[TRADEDAO]/TRADEDETAIL AU_STARTPR : "+au_startPr);//경매
					// 시작가
					// dto.setAu_startPr(au_startPr);

					bdto = bdao.auctionDetail(dto.getP_no());
					dto.setP_title(bdto.getP_title());// 게시글 제목
					dto.setP_name(bdto.getP_name());// 글 분류명
					dto.setI_newName(bdto.getI_newName());// 이미지이름
					System.out.println("[TRADEDAO]/TRADEDETAIL AUCTION BDTO : " + bdto);

					int max_ha_bidPr = selectHis_AuctionMax_Ha_bidPr(dto.getP_no());
					System.out.println("[TRADEDAO]/TRADEDETAIL MAX_HA_BIDPR : " + max_ha_bidPr);
					dto.setHa_bidPr(max_ha_bidPr);// 경매 최고입찰자 or 낙찰가
					// 판매일 경우
				} else {
					bdto = bdao.salesDetail(dto.getP_no());
					dto.setP_title(bdto.getP_title());// 게시글 제목
					dto.setP_name(bdto.getP_name());// 글 분류명
					dto.setI_newName(bdto.getI_newName());// 이미지이름
					System.out.println("[TRADEDAO]/TRADEDETAIL AUCTION BDTO : " + bdto);
				}
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}

		bdao.resClose();
		pdao.resClose();
		System.out.println("[TRADEDAO]/TRADEDETAIL END");
		return dto;
	}

	// 글번호로 판매자를 알 수 있는 기능
	public String selectPostP_id(int p_no) {
		System.out.println("[TRADEDAO]/SELECTPOSTP_ID START");
		String sql = "SELECT P_ID FROM POST WHERE P_NO = ?";
		String p_id = "";
		try {
			ps = conn.prepareStatement(sql);
			ps.setInt(1, p_no);
			rs = ps.executeQuery();
			if (rs.next()) {
				p_id = rs.getString("p_id");
				System.out.println("[TRADEDAO]/SELECTPOSTP_ID P_ID : " + p_id);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		System.out.println("[TRADEDAO]/SELECTPOSTP_ID END");

		return p_id;
	}

	// 거래페이지 목록을 보여주는 기능
	public HashMap<String, Object> tradeList(String id, String p_code, int pageNum) {
		System.out.println("[TRADEDAO]/TRADELIST START");
		/*String sql = "SELECT T.RNUM, T.T_NO, T.P_NO, T.T_SALER, T.T_BUYER, (SELECT U_NNAME FROM USERINFO WHERE U_ID = T_SALER) T_SALER_NNAME, (SELECT U_NNAME FROM USERINFO WHERE U_ID = T_BUYER) T_BUYER_NNAME, (SELECT U_NEWNAME FROM USERINFO WHERE U_ID = T_SALER) T_SALER_NEWNAME, (SELECT U_NEWNAME FROM USERINFO WHERE U_ID = T_BUYER) T_BUYER_NEWNAME, P.P_TITLE, P.P_CODE, H.HT_DATE, H.HT_POINT, H.HT_CODE, (SELECT C_NAME FROM CODES WHERE C_CODE = H.HT_CODE) HT_NAME, TC.TC_CONTENT, TC.TC_TM, TC.TC_ID FROM (SELECT ROW_NUMBER() OVER(ORDER BY T_NO ASC) RNUM, T_NO, P_NO, T_SALER, T_BUYER, T_CANCLEID, T_ADMACC FROM TRADE ) T, HIS_TRADE H,(SELECT T_NO, MAX(HT_DATE) HT_DATE FROM HIS_TRADE GROUP BY T_NO) HM, TRADE_COMMENT TC, (SELECT T_NO, MAX(TC_TM) TC_TM FROM TRADE_COMMENT GROUP BY T_NO) TCM, POST P WHERE T.T_NO = H.T_NO AND H.T_NO = HM.T_NO AND HM.T_NO = TC.T_NO AND TC.T_NO = TCM.T_NO AND TC.TC_TM = TCM.TC_TM AND H.HT_DATE = HM.HT_DATE AND (T_SALER = ? OR T_BUYER = ?) AND T.P_NO = P.P_NO";
		System.out.println("p_code : "+p_code);
		if (p_code.equals("P000")) {
			System.out.println("[TRADEDAO]/TRADELIST 거래페이지 전체 목록 ");
		} else if (p_code.equals("P001")) {
			sql += " AND P_CODE = 'P001'";
			System.out.println("[TRADEDAO]/TRADELIST 거래페이지 경매 목록 ");
		} else if (p_code.equals("P002")) {
			sql += " AND P_CODE = 'P002'";
			System.out.println("[TRADEDAO]/TRADELIST 거래페이지 판매 목록 ");
		}
		sql += " AND T.RNUM BETWEEN ? AND ? ORDER BY H.HT_DATE DESC";*/

		String sql = "SELECT T.RNUM, T.T_NO, T.P_NO, T.T_SALER, T.T_BUYER, (SELECT U_NNAME FROM USERINFO WHERE U_ID = T_SALER) T_SALER_NNAME, (SELECT U_NNAME FROM USERINFO WHERE U_ID = T_BUYER) T_BUYER_NNAME, (SELECT U_NEWNAME FROM USERINFO WHERE U_ID = T_SALER) T_SALER_NEWNAME, (SELECT U_NEWNAME FROM USERINFO WHERE U_ID = T_BUYER) T_BUYER_NEWNAME, P.P_TITLE, P.P_CODE, H.HT_DATE, H.HT_POINT, H.HT_CODE, (SELECT C_NAME FROM CODES WHERE C_CODE = H.HT_CODE) HT_NAME, TC.TC_CONTENT, TC.TC_TM, TC.TC_ID FROM (SELECT ROW_NUMBER() OVER(ORDER BY T_NO ASC) RNUM, T_NO, P_NO, T_SALER, T_BUYER, T_CANCLEID, T_ADMACC FROM TRADE ) T, HIS_TRADE H,(SELECT T_NO, MAX(HT_DATE) HT_DATE FROM HIS_TRADE GROUP BY T_NO) HM, TRADE_COMMENT TC, (SELECT T_NO, MAX(TC_TM) TC_TM FROM TRADE_COMMENT GROUP BY T_NO) TCM, POST P WHERE T.T_NO = H.T_NO AND H.T_NO = HM.T_NO AND HM.T_NO = TC.T_NO AND TC.T_NO = TCM.T_NO AND TC.TC_TM = TCM.TC_TM AND H.HT_DATE = HM.HT_DATE AND (T_SALER = ? OR T_BUYER = ?) AND T.P_NO = P.P_NO ORDER BY H.HT_DATE DESC";
		
		
		HashMap<String, Object> map = new HashMap<>();
		ArrayList<GGDto> list = new ArrayList<GGDto>();

		int currentPage = pageNum; // 클릭한 페이지 넘버
		int pagePerCnt = 5; // 한 페이지당 보여줄 목록 수
		int end = pageNum * pagePerCnt; // 거래페이지 종료
		int start = end - pagePerCnt + 1; // 거래페이지 시작
		int totalNum = selectTradeCount(id, p_code); // 총 거래페이지 수
		int totalPage = 0; // 총 페이지 수
		if (totalNum <= pagePerCnt) {
			totalPage = 1;
		} else if (totalNum > pagePerCnt && totalNum % pagePerCnt == 0) {
			totalPage = totalNum / pagePerCnt;
		} else if (totalNum > pagePerCnt && totalNum % pagePerCnt != 0) {
			totalPage = totalNum / pagePerCnt + 1;
		}
		System.out.println("[TRADEDAO]/TRADELIST CURRENTPAGE : " + currentPage);
		System.out.println("[TRADEDAO]/TRADELIST END : " + end);
		System.out.println("[TRADEDAO]/TRADELIST START : " + start);
		System.out.println("[TRADEDAO]/TRADELIST TOTALNUM : " + totalNum);
		System.out.println("[TRADEDAO]/TRADELIST TOTALPAGE : " + totalPage);

		try {
			ps = conn.prepareStatement(sql);
			ps.setString(1, id);
			ps.setString(2, id);
			//ps.setInt(3, start);
			//ps.setInt(4, end);
			rs = ps.executeQuery();
			while (rs.next()) {
				GGDto dto = new GGDto();
				dto.setT_no(rs.getInt("t_no"));
				dto.setP_no(rs.getInt("p_no"));
				dto.setT_saler(rs.getString("t_saler"));
				dto.setT_buyer(rs.getString("t_buyer"));
				dto.setT_buyer_nname(rs.getString("t_buyer_nname"));
				dto.setT_saler_nname(rs.getString("t_saler_nname"));
				dto.setT_saler_newName(rs.getString("t_saler_newname"));
				dto.setT_buyer_newName(rs.getString("t_buyer_newname"));
				dto.setP_title(rs.getString("p_title"));
				dto.setHt_date(rs.getDate("ht_date"));
				dto.setHt_point(rs.getInt("ht_point"));
				dto.setHt_code(rs.getString("ht_code"));
				dto.setHt_name(rs.getString("ht_name"));
				dto.setTc_content(rs.getString("tc_content"));
				dto.setTc_tm(rs.getDate("tc_tm"));
				dto.setTc_id(rs.getString("tc_id"));
				list.add(dto);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}

		map.put("list", list);
		map.put("currentPage", currentPage);
		map.put("totalPage", totalPage);

		System.out.println("[TRADEDAO]/TRADELIST LIST_SIZE : " + list.size());
		System.out.println("[TRADEDAO]/TRADELIST END");

		return map;
	}

	// 거래페이지 목록수를 가져오는 기능
	public int selectTradeCount(String id, String p_code) {
		System.out.println("[TRADEDAO]/SELECTTRADECOUNT START");
		String sql = "SELECT COUNT(*) COUNT FROM TRADE T, POST P WHERE T.P_NO = P.P_NO AND (T.T_SALER = ? OR T.T_BUYER = ? )";
		if (p_code.equals("P000")) {
			System.out.println("[TRADEDAO]/SELECTTRADECOUNT 거래페이지 전체 목록 ");
		} else if (p_code.equals("P001")) {
			sql += " AND P_CODE = 'P001'";
			System.out.println("[TRADEDAO]/SELECTTRADECOUNT 거래페이지 경매 목록 ");
		} else if (p_code.equals("P002")) {
			sql += " AND P_CODE = 'P002'";
			System.out.println("[TRADEDAO]/SELECTTRADECOUNT 거래페이지 판매 목록 ");
		}

		int count = 0;

		try {
			ps = conn.prepareStatement(sql);
			ps.setString(1, id);
			ps.setString(2, id);
			rs = ps.executeQuery();

			if (rs.next()) {
				count = rs.getInt("COUNT");
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		System.out.println("[TRADEDAO]/SELECTTRADECOUNT END");
		return count;
	}

	// 거래페이지 댓글 추가 기능
	public boolean insertTradeComment(int t_no, String tc_content, String tc_id) {
		String sql = "INSERT INTO TRADE_COMMENT (TC_NO, T_NO, TC_CONTENT, TC_TM, TC_ID) VALUES(TC_NO_SEQ.NEXTVAL, ?, ?, SYSDATE, ?)";
		int success = 0;
		try {
			ps = conn.prepareStatement(sql);
			ps.setInt(1, t_no);
			ps.setString(2, tc_content);
			ps.setString(3, tc_id);
			success = ps.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return success > 0 ? true : false;
	}

	// 구매요청 알람보내기
	public void pushBuyRequestAlarm(int p_no, String u_id) {
		AlarmDAO Adao = new AlarmDAO();
		BoardDAO Bdao = new BoardDAO();
		PointDAO Pdao = new PointDAO();

		try {
			String p_title = Bdao.getTitle(p_no);// 글 제목
			p_title = Adao.cutTitle(p_title);// 글 제목 자르기
			String u_nname = Pdao.getNname(u_id);// 구매요청아이디 닉네임
			String p_id = selectPostP_id(p_no);// 글 작성자 아이디
			Adao.insertAlarm(p_id, "A002", "[" + p_title + "]" + u_nname + "님이 구매요청하였습니다.", "Y",
					"./salesDetail?p_no=" + p_no);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			Adao.resClose();
			Bdao.resClose();
			Pdao.resClose();
		}
	}

	// 구매요청 수락, 거절 알람
	public void pushRequestResult(int p_no, int t_no, String t_saler, String t_buyer, String rq_YN) {
		AlarmDAO Adao = new AlarmDAO();
		BoardDAO Bdao = new BoardDAO();
		PointDAO Pdao = new PointDAO();
		try {
			String p_title = Bdao.getTitle(p_no);// 제목가져오기
			p_title = Adao.cutTitle(p_title);// 자르기
			String b_nname = Pdao.getNname(t_buyer);// 닉네임가져오기
			String path = null;
			System.out.println("구매요청 수락 거절 여부:" + rq_YN);
			if (rq_YN.equals("Y")) {// 수락알람 -> 거래페이지로 이동
				path = "./tradeDetail?t_no=" + t_no;
				Adao.insertAlarm(t_buyer, "A008", "[" + p_title + "]구매요청이 수락되었습니다.", "Y", path);
				Adao.insertAlarm(t_saler, "A008", "[" + p_title + "]" + b_nname + "의 구매요청이 수락되었습니다.", "Y", path);
			} else {// 거절알람 -> 해당 판매 페이지로 이동
				path = "./salesDetail?p_no=" + p_no;
				Adao.insertAlarm(t_buyer, "A009", "[" + p_title + "]구매요청이 거절되었습니다.", "Y", path);
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			Adao.resClose();
			Bdao.resClose();
			Pdao.resClose();
		}
	}

	// 거래댓글 목록 보기
	public HashMap<String, Object> tradeCommentList(int t_no) {
		HashMap<String, Object> map = new HashMap<String, Object>();
		ArrayList<GGDto> list = new ArrayList<GGDto>();
		GGDto dto = null;
		String sql = "SELECT T.T_NO, T.T_SALER, T.T_BUYER, TC.TC_NO, TC.TC_CONTENT, TC.TC_TM, TC.TC_ID, (SELECT U_NNAME FROM USERINFO WHERE U_ID = TC.TC_ID) TC_NNAME FROM TRADE T, TRADE_COMMENT TC WHERE T.T_NO = TC.T_NO AND T.T_NO = ? ORDER BY TC_NO ASC";

		try {
			ps = conn.prepareStatement(sql);
			ps.setInt(1, t_no);
			rs = ps.executeQuery();
			while (rs.next()) {
				dto = new GGDto();
				dto.setT_no(rs.getInt("t_no"));
				dto.setT_saler(rs.getString("t_saler"));
				dto.setT_buyer(rs.getString("t_buyer"));
				dto.setTc_id(rs.getString("tc_id"));
				dto.setTc_content(rs.getString("tc_content"));
				dto.setTc_tm(rs.getDate("tc_tm"));
				dto.setTc_nname(rs.getString("tc_nname"));
				list.add(dto);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}

		map.put("list", list);
		System.out.println("list size : " + list.size());
		return map;
	}

	// 아이디로 닉네임을 알 수 있는 기능
	public String selectUserinfoU_nname(String id) {
		String sql = "SELECT U_NNAME FROM USERINFO WHERE U_ID = ?";
		String u_nname = "";
		try {
			ps = conn.prepareStatement(sql);
			ps.setString(1, id);
			rs = ps.executeQuery();
			if (rs.next()) {
				u_nname = rs.getString("u_nname");
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return u_nname;
	}
	
	//거래페이지 판매자, 구매자 가져오는 기능
	public ArrayList<String> selectSandB(int t_no) {
		ArrayList<String> list = new ArrayList<String>();
		
		String sql = "SELECT t_saler, t_buyer from trade where t_no=?";
		String t_saler = "";
		String t_buyer = "";
		try {
			ps = conn.prepareStatement(sql);
			ps.setInt(1, t_no);
			rs = ps.executeQuery();
			if(rs.next()) {
				t_saler = rs.getString("t_saler");
				t_buyer = rs.getString("t_buyer");
				System.out.println(t_saler);
				System.out.println(t_buyer);
				list.add(t_saler);
				list.add(t_buyer);
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		System.out.println("거래페이지 판매자 : "+list.get(0));
		System.out.println("거래페이지 구매자 : "+list.get(1));
		
		return list;
		
	}
	
	//해당 거래페이지 번호를 가져다가 게시글 제목을 가져오는 기능
	public String getTitleFromTno(int t_no) {
		String title = null;
		String sql = "select p_title from post where p_no=(select p_no from trade where t_no=?)";
		try {
			ps = conn.prepareStatement(sql);
			ps.setInt(1, t_no);
			rs = ps.executeQuery();
			if(rs.next()) {
				title = rs.getString("p_title");
				System.out.println("해당 거래페이지의 게시글 제목 : "+title);
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return title;
		
	}
	/*
	public void pushTradeAlarm(int t_no, int ht_point, String ht_code,String t_cancleId) {
		AlarmDAO dao = new AlarmDAO();
		String p_title = getTitleFromTno(t_no); //제목 가져오기
		p_title = dao.cutTitle(p_title);
		ArrayList<String>list = new ArrayList<String>();
		list = selectSandB(t_no);
		String t_saler = list.get(0);
		String t_buyer = list.get(1);
		if() {//HT002 : 송금
			
		}else if() { //HT003 : 승인거부
			
		}else if() { //HT004 : 승인
			
		}else if() { //HT005 : 배송
			
		}else if() { //HT006 : 수취확인
			
		}else if() { //HT007 : 거래취소
		dao.insertAlarm(u_id, a_code, a_content, a_impoyn, a_path);
		dao.insertAlarm(u_id, a_code, a_content, a_impoyn, a_path);
		
	}*/

}
