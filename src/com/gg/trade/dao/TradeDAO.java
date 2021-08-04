package com.gg.trade.dao;

import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.HashMap;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

import com.gg.dto.GGDto;
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
	
	public boolean buyRequest(int p_no, String u_id) {
		String sql = "INSERT INTO REQUEST VALUES(RQ_no_seq.NEXTVAL,?,?,NULL,SYSDATE)";
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
public HashMap<String,Object> auctionBid(int p_no, int ha_bidPr, String ha_bidUsr) throws SQLException {
		
		//반환값(성공여부, 실패시 ->현재 최고 입찰가, 성공여부 초기상태
		//msg를 뿌려줄 예정 (성공/ 현재입찰자 = 최고입찰자 / 입찰금액 <최고입찰긍)
		int checker = 0;
		boolean success = false;
		boolean instantYN = false;
		int instantPr =0;
		String sql = "";
		String msg = "";
		HashMap<String,Object> map = new HashMap<String,Object>();
		
		//즉결구매가 이상을 입력한 경우
		sql = "select au_instantpr from auction where p_no=?";
		ps = conn.prepareStatement(sql);
		ps.setInt(1, p_no);
		rs = ps.executeQuery();
		
		if(rs.next()) {//무조건 즉결가는 존재(이미 보유포인트에서 거를 예정이기에)
			instantPr = rs.getInt("au_instantpr");
			System.out.println("경매글 최고 입찰가 : "+instantPr);
			
			ha_bidPr = (ha_bidPr >=instantPr) ? instantPr : ha_bidPr;
			System.out.println("변경된 입찰가 : "+ha_bidPr);
		}
		
		//변경된 입찰금액과 즉결가를 비교해서 동일한 경우 즉결구매로 넘김
		if(ha_bidPr == instantPr) {
				
			success = buyNow(p_no, ha_bidUsr, ha_bidPr);
			System.out.println("즉결구매 성공 여부 : "+success);
			if(success) {
					msg = "즉결구매에 성공하였습니다.";
				}else {
					msg="즉결구매에 실패하였습니다.";
				}
				
		}else {
			//최고입찰자와 최고입찰금액 가져오는 쿼리
			sql = "select his.ha_bidpr, his.ha_bidusr from his_auction his where his.ha_bidpr =(select max(ha_bidpr) from his_auction  group by p_no having p_no=?) and p_no = ?";
			ps = conn.prepareStatement(sql);
			ps.setInt(1, p_no);
			ps.setInt(2, p_no);
			rs = ps.executeQuery();
			if(rs.next()) {
				String bidUsr = rs.getString("ha_bidusr");
				int bidPr =rs.getInt("ha_bidpr");
				System.out.println("최고 입찰자 : "+ bidUsr+" / 최고입찰가 : "+bidPr );
				
				if(bidUsr.equals(ha_bidUsr)) { //내가 이미 최고입찰자인 경우
					msg = "이미 최고입찰자 입니다.";
				}else if( bidPr >= ha_bidPr){ //내가 입력한 입찰금이 최고 입찰금보다 적을 때
					msg="입찰금액이 최고입찰가보다 적습니다. 다시 입찰해주세요.";
					map.put("bidPr", bidPr);
				}else { //내가 입력한 금액이 최고 입찰금액보다 큰 경우
					sql = "INSERT INTO his_auction(p_no,ha_bidpr,ha_bidusr,ha_bidtm) VALUES(?,?,?,SYSDATE) ";
					ps = conn.prepareStatement(sql);
					ps.setInt(1,p_no);
					ps.setInt(2, ha_bidPr);
					ps.setString(3, ha_bidUsr);
					checker = ps.executeUpdate();
	
					//insert 성공시
					if(checker>0) {
						success = true;
						msg = "입찰에 성공하였습니다.";
						if(success) {
							instantYN = bidRecordYN(p_no,ha_bidUsr);
							System.out.println("시작금 인출 여부 : "+instantYN);
						}
					}
				}
			}else {//이전 입찰자가 없었을 때
				sql = "INSERT INTO his_auction(p_no,ha_bidpr,ha_bidusr,ha_bidtm) VALUES(?,?,?,SYSDATE) ";
				ps = conn.prepareStatement(sql);
				ps.setInt(1,p_no);
				ps.setInt(2, ha_bidPr);
				ps.setString(3, ha_bidUsr);
				checker = ps.executeUpdate();
	
				//insert 성공시
				if(checker>0) {
					success = true;
					msg = "입찰에 성공하였습니다.";
					if(success) {
						instantYN = bidRecordYN(p_no,ha_bidUsr);
						System.out.println("시작금 인출 여부 : "+instantYN);
					}
					
				}
			}
		}
		
		//입찰금액 입력 쿼리
		System.out.println("경매 히스토리 입력여부 : "+success);
		
		
		
		//시작금액 빼가는 쿼리
		
		
		map.put("success", success);
		System.out.println("메세지 확인 : "+msg);
		map.put("msg", msg);
		return map;
	}
	
	//입찰횟수 늘리기
	public int upAucCnt(int p_no) throws SQLException {
		String sql = "update auction set au_count = au_count+1 where p_no=?";
		ps = conn.prepareStatement(sql);
		ps.setInt(1,p_no);
		int success = ps.executeUpdate();
		System.out.println("올라간 입찰 수 : "+success);
		
		return success;
	}
	
	public boolean buyNow(int p_no, String u_id, int ha_bidPr) throws SQLException {
		//즉결가 조회
		String sql = "SELECT AU_INSTANTPR FROM AUCTION WHERE P_NO = ?";
		//낙찰자를 등록
		String sql2 = "UPDATE AUCTION SET AU_SUCCESSER = ? WHERE P_NO = ?";
		//경매상태를 거래중으로 변경
		String sql3 = "UPDATE AUCTION SET AU_CODE = 'Au002', AU_SUCTM = SYSDATE WHERE P_NO = ?";
		//경매히스토리에 이력을 저장
		String sql4 = "INSERT INTO his_auction(p_no,ha_bidpr,ha_bidusr,ha_bidtm) VALUES(?,?,?,SYSDATE)";
		int success = 0;
		int au_instantpr = 0;
		try {
			ps = conn.prepareStatement(sql);
			ps.setInt(1, p_no);
			rs = ps.executeQuery();
			System.out.println("DAO buyNow 즉결가 조회");
			
			if(rs.next()) {
				au_instantpr = rs.getInt("au_instantpr");
				System.out.println("DAO buyNow au_instantpr : "+au_instantpr);
			}
			System.out.println("DAO buyNow au_instantpr == ha_bidPr : "+(au_instantpr == ha_bidPr));
			if(au_instantpr == ha_bidPr) {
				System.out.println("테스트");
				ps = conn.prepareStatement(sql2);
				ps.setString(1, u_id);
				ps.setInt(2, p_no);
				
				if(ps.executeUpdate()>0) {
					System.out.println("DAO buyNow 낙찰자 등록");
					ps = conn.prepareStatement(sql3);
					ps.setInt(1, p_no);
					if(ps.executeUpdate()>0) {
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
		}catch(Exception e) {
			
		}
		
		boolean result = bidRecordYN(p_no,u_id);
		System.out.println("시작금 인출 여부 : "+result);
		//입찰금 반환 메서드 실행
		returnStartPr(p_no, au_instantpr);
		
		return success>0?true:false;
	}
	
	///경매 종료 메서드///
		public GGDto endAuction(int p_no,String au_code,String ha_bidusr) throws SQLException {
			
			GGDto dto = new GGDto();
			int instantpr = 0;
	
			//낙찰시간,경매상태,낙찰자 변경
			String sql = "update auction set au_suctm = SYSDATE, au_code= 'Au002' ,au_successer = (select u_id from userinfo where u_nname= ?) where p_no=? ";
			ps = conn.prepareStatement(sql);
			ps.setString(1,ha_bidusr);
			ps.setInt(2, p_no);
			
			int success = ps.executeUpdate();
			
			//성공했을 때 경매상태, 낙찰시간, 낙찰자 데이터 가져와서 담아주기
			if(success > 0) {
				sql ="select au_code,au_successer,au_suctm,au_instantpr from auction where p_no=?";
				ps = conn.prepareStatement(sql);
				ps.setInt(1, p_no);
				
				rs = ps.executeQuery();
				
				if(rs.next()) {
					dto.setAu_code(rs.getString("au_code"));
					dto.setAu_successer(rs.getString("au_successer"));
					dto.setAu_sucTm(rs.getDate("au_suctm"));
					instantpr = rs.getInt("au_instantpr");
				}
				
				//입찰금 반환 메서드 실행
				returnStartPr(p_no, instantpr);

			}
			
			return dto;
		}

		
		public boolean bidRecordYN(int p_no,String user_id) throws SQLException {

			boolean success = false;
			PointDAO dao = new PointDAO();
			
			//입찰내역이 있는지 확인 
			String sql="select count(*) as count from (select * from his_auction where p_no=?) where ha_bidusr = ? group by ha_bidusr";
			ps = conn.prepareStatement(sql);
			ps.setInt(1, p_no);
			ps.setString(2, user_id);
			
			
			rs = ps.executeQuery();
			int count = 0;
			if(rs.next()) {
				count = rs.getInt("count");
				if(count == 1) {			
					//입찰한 내역이 없는 경우
					sql = "select au_startpr from auction where p_no=?";
					
					ps = conn.prepareStatement(sql);
					ps.setInt(1, p_no);
					rs = ps.executeQuery();
					rs.next();
					
					int pnt_point =  rs.getInt("au_startpr"); //시작가격 가져오기
					System.out.println("시작가격 pnt_point : "+pnt_point);
					success = dao.insertPoint(user_id, pnt_point, "SYSTEM", "PNT006", p_no);
					System.out.println("시작금 인출여부 : "+success);
				}
			}
			
			return success;
			
		}
		
		public void returnStartPr(int p_no,int instantpr) throws SQLException {
			
			boolean insertRs = false; 
			PointDAO dao = new PointDAO();
			
			///입찰금반환 메서드 실행
			String sql = "select distinct ha_bidusr from his_auction where ha_bidusr <> (select au_successer from auction where p_no=?) and p_no=?";
		
			ps = conn.prepareStatement(sql);
			ps.setInt(1, p_no);
			ps.setInt(2, p_no);
			
			rs = ps.executeQuery();
			System.out.println("=========입찰금 반환 목록==========");
			while(rs.next()) {
				String bid_id = rs.getString("ha_bidusr");
				insertRs = dao.insertPoint(bid_id, instantpr, "SYSTEM", "PNT007", p_no);
				
				if(insertRs) {
					System.out.println("입찰금 반환 id :"+bid_id+"/ 반환할 입찰금 : "+instantpr);
				}
				
				
			}
			System.out.println("==========================");
			
		}
		
		
}
