package com.gg.board.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

import com.gg.dto.GGDto;

public class BoardDAO {

	public Connection conn = null;
	public ResultSet rs = null;
	public PreparedStatement ps = null;

	public BoardDAO() {
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

	public GGDto salesDetail(int p_no) {
		System.out.println("DAO salesDetail 호출");
		GGDto dto = null;
		/*
		 * String sql =
		 * "SELECT P.P_NO, P.P_ID, P.P_TITLE, P.P_CONTENT, P.P_TM, P.P_VIEW, P.P_LIKECOUNT, P.P_BLINDYN, (SELECT C_NAME FROM CODES WHERE C_CODE = P.P_CODE) AS P_NAME,"
		 * +
		 * "S.S_DELIVERYYN, S.S_FOLLOWLIMYN, (SELECT C_NAME FROM CODES WHERE C_CODE = S.S_CODE) AS S_NAME,"
		 * + "N.NS_PR, (SELECT C_NAME FROM CODES WHERE C_CODE = N.NS_CODE) AS NS_NAME,"+
		 * "I.I_NEWNAME,"+
		 * "LPAD((SELECT U_ADDR FROM USERINFO WHERE U_ID = P.P_ID), 20, ' ') AS U_ADDR"+
		 * "FROM POST P, SALE S, N_SALE N, IMG I WHERE P.P_NO=S.P_NO AND S.P_NO=N.P_NO AND N.P_NO=I.P_NO AND P.P_NO = ?"
		 * ;
		 */
		String sql = "SELECT P.P_NO, P.P_ID, P.P_TITLE, P.P_CONTENT, P.P_TM, P.P_VIEW, P.P_LIKECOUNT, P.P_BLINDYN, (SELECT C_NAME FROM CODES WHERE C_CODE = P.P_CODE) AS P_NAME, S.S_DELIVERYYN, S.S_FOLLOWLIMYN, (SELECT C_NAME FROM CODES WHERE C_CODE = S.S_CODE) AS S_NAME, N.NS_PR, (SELECT C_NAME FROM CODES WHERE C_CODE = N.NS_CODE) AS NS_NAME, I.I_NEWNAME, LPAD((SELECT U_ADDR FROM USERINFO WHERE U_ID = P.P_ID), 20, ' ') AS U_ADDR FROM POST P, SALE S, N_SALE N, IMG I WHERE P.P_NO=S.P_NO AND S.P_NO=N.P_NO AND N.P_NO=I.P_NO AND P.P_NO = ?";
		try {
			ps = conn.prepareStatement(sql);
			ps.setInt(1, p_no);
			rs = ps.executeQuery();
			if (rs.next()) {
				dto = new GGDto();
				dto.setP_no(rs.getInt("P_no"));
				dto.setP_id(rs.getString("P_id"));
				//System.out.println("dto.getP_id:"+dto.getP_id());
				dto.setP_title(rs.getString("P_title"));
				dto.setP_content(rs.getString("P_content"));
				dto.setP_tm(rs.getDate("P_tm"));
				dto.setP_view(rs.getInt("P_view"));
				dto.setP_likeCount(rs.getInt("P_likeCount"));
				dto.setP_blindYN(rs.getString("P_blindYN"));
				dto.setP_name(rs.getString("P_name"));

				dto.setS_DeliveryYN(rs.getString("S_DeliveryYN"));
				dto.setS_followLimYN(rs.getString("S_followLimYN"));
				dto.setS_name(rs.getString("S_name"));

				dto.setNs_pr(rs.getInt("NS_pr"));
				dto.setNs_name(rs.getString("NS_name"));

				dto.setI_newName(rs.getString("I_newName"));

				dto.setU_addr(rs.getString("U_addr"));
				System.out.println("u_addr : " + dto.getU_addr());
			}
		} catch (Exception e) {
			e.printStackTrace();
		}

		return dto;
	}

	public int upP_view(int p_no) {
		System.out.println("DAO upP_view");
		String sql = "UPDATE POST SET P_VIEW = P_VIEW + 1 WHERE P_NO = ?";
		int success = 0;
		try {
			ps = conn.prepareStatement(sql);
			ps.setInt(1, p_no);
			success = ps.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		}
		System.out.println("DAO upP_view4");
		return success;
	}

	public boolean isLiked(String u_id, int p_no) {
		System.out.println("DAO isLiked");
		String sql = "SELECT * FROM LOVE WHERE L_ID = ? AND P_NO = ?";
		System.out.println("u_id : " + u_id);
		System.out.println("p_no : " + p_no);

		boolean isLiked = false;
		try {
			ps = conn.prepareStatement(sql);
			ps.setString(1, u_id);
			ps.setInt(2, p_no);
			rs = ps.executeQuery();
			if (rs.next()) {
				isLiked = true;
			}
			System.out.println("[DAO] isLiked : " + isLiked);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return isLiked;
	}

	public boolean lovePlus(String u_id, int p_no) {
		System.out.println("DAO lovePlus");
		String sql = "INSERT INTO LOVE VALUES(?,?,SYSDATE)";
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

	public boolean loveMinus(String u_id, int p_no) {
		System.out.println("DAO loveMinus");
		String sql = "DELETE FROM LOVE WHERE L_ID = ? AND P_NO = ?";
		int success = 0;
		try {
			ps = conn.prepareStatement(sql);
			ps.setString(1, u_id);
			ps.setInt(2, p_no);
			success = ps.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return success > 0 ? true : false;

	}

	public int loveCountPlus(int p_no) {
		System.out.println("DAO loveCountPlus");
		String sql = "UPDATE POST SET P_LIKECOUNT = P_LIKECOUNT + 1 WHERE P_NO = ?";
		int success = 0;
		try {
			ps = conn.prepareStatement(sql);
			ps.setInt(1, p_no);
			success = ps.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return success;
	}

	public int loveCountMinus(int p_no) {
		System.out.println("DAO loveCountMinus");
		String sql = "UPDATE POST SET P_LIKECOUNT = P_LIKECOUNT - 1 WHERE P_NO = ?";
		int success = 0;
		try {
			ps = conn.prepareStatement(sql);
			ps.setInt(1, p_no);
			success = ps.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return success;
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

	public boolean isBuyRequested(int p_no, String u_id) {
		String sql = "SELECT * FROM REQUEST WHERE P_NO = ? AND RQ_ID = ?";
		boolean success = false;
		try {
			ps = conn.prepareStatement(sql);
			ps.setInt(1, p_no);
			ps.setString(2, u_id);
			rs = ps.executeQuery();
			success = rs.next();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return success;
	}

	public ArrayList<GGDto> sale3List(String p_id) {
		String sql = "SELECT COUNT(*) FROM POST P, SALE S, N_SALE N, IMG I WHERE P.P_NO=S.P_NO AND S.P_NO=N.P_NO AND N.P_NO=I.P_NO AND P.P_ID = ?";
		String sql2 = "SELECT P.P_NO, P.P_ID, P.P_TITLE, P.P_CONTENT, P.P_TM, P.P_VIEW, P.P_LIKECOUNT, P.P_BLINDYN, (SELECT C_NAME FROM CODES WHERE C_CODE = P.P_CODE) AS P_NAME, S.S_DELIVERYYN, S.S_FOLLOWLIMYN, (SELECT C_NAME FROM CODES WHERE C_CODE = S.S_CODE) AS S_NAME, N.NS_PR, (SELECT C_NAME FROM CODES WHERE C_CODE = N.NS_CODE) AS NS_NAME, I.I_NEWNAME, LPAD((SELECT U_ADDR FROM USERINFO WHERE U_ID = P.P_ID), 20, ' ') AS U_ADDR FROM POST P, SALE S, N_SALE N, IMG I WHERE P.P_NO=S.P_NO AND S.P_NO=N.P_NO AND N.P_NO=I.P_NO AND P.P_ID = ?";
		ArrayList<GGDto> sale3List = new ArrayList<>();
		try {
			ps = conn.prepareStatement(sql);
			ps.setString(1,p_id);
			rs = ps.executeQuery();
			int rowCnt = rs.next()?rs.getInt(1):0;
			System.out.println("rowCnt : "+rowCnt);
			int forCnt = rowCnt>=3?3:rowCnt;
			System.out.println("forCnt : "+forCnt);
			ps = conn.prepareStatement(sql2);
			ps.setString(1,p_id);
			rs = ps.executeQuery();
			for(int i=0;i<forCnt;i++) {
				rs.next();
				GGDto dto = new GGDto();
				dto.setP_no(rs.getInt("P_no"));
				dto.setP_title(rs.getString("P_title"));
				dto.setNs_pr(rs.getInt("NS_pr"));
				dto.setI_newName(rs.getString("I_newName"));
				sale3List.add(dto);
				}
			
		}catch(Exception e) {
			e.printStackTrace();
		}
		return sale3List;
	}
	/* ================================================ */
	public ArrayList<GGDto> list(String userid, int listwhatadd, int listhowaline) throws SQLException {
		String sql = "";
		if (listwhatadd == 0) {//전체 NS_001 NS_003
			if (listhowaline == 0) {//시간최신 -desc
			sql = "select * FROM  post p,N_Sale n where (n.ns_code = 'NS_001' or n.ns_code = 'NS_003') and p.p_code = 'P002' and p.p_no = n.p_no and p.p_id = ? order BY p.p_tm DESC";				
			//sql = "SELECT p.p_id,p.p_no,p.p_title,p.p_likecount,p.p_tm,n.ns_pr,n.ns_code,p.p_code,i.i_newname FROM  post p,N_Sale n,img i,SALE S WHERE p.p_code = 'P002' and P.P_NO=S.P_NO AND s.P_NO = N.P_NO AND N.P_NO = P.P_NO and N.P_NO = i.p_no and (n.ns_code = 'NS_001' or n.ns_code = 'NS_003')";
			
			}else if(listhowaline == 1) {//좋아요많은쪽 -desc
				sql= "select * FROM  post p,N_Sale n where (n.ns_code = 'NS_001' or n.ns_code = 'NS_003') and p.p_code = 'P002' and p.p_no = n.p_no and p.p_id = ? order BY p.P_likeCount DESC";
			}
		}else if (listwhatadd == 1) {//판매중 NS_001 NS_003
			if (listhowaline == 0) {//시간최신 -desc
				sql = "select * FROM  post p,N_Sale n where n.ns_code = 'NS_001' and p.p_code = 'P002' and p.p_no = n.p_no and p.p_id = ? order BY p.p_tm DESC";				
			}else if(listhowaline == 1) {//좋아요많은쪽 -desc
				sql= "select * FROM  post p,N_Sale n where n.ns_code = 'NS_001' and p.p_code = 'P002' and p.p_no = n.p_no and p.p_id = ? order BY p.P_likeCount DESC";
			}
		}else if (listwhatadd == 2) {//판매완료 NS_003
			if (listhowaline == 0) {//시간최신 -desc
				sql = "select * FROM  post p,N_Sale n where n.ns_code = 'NS_003' and p.p_code = 'P002' and p.p_no = n.p_no and p.p_id = ? order BY p.p_tm DESC";				
			}else if(listhowaline == 1) {//좋아요많은쪽 -desc
				sql= "select * FROM  post p,N_Sale n where n.ns_code = 'NS_003' and p.p_code = 'P002' and p.p_no = n.p_no and p.p_id = ? order BY p.P_likeCount DESC";
			}
		}

		ArrayList<GGDto> soldlist = new ArrayList<GGDto>();
		
		System.out.println("soldlist:"+soldlist);
		
		ps = conn.prepareStatement(sql);
		
		System.out.println("daouserID:"+userid);
		ps.setString(1, userid);
		//System.out.println("ps:"+ps);
		rs = ps.executeQuery();
		//System.out.println("rs:"+rs);
		
		while (rs.next()) {
			GGDto dto = new GGDto();
			dto.setP_no(rs.getInt("P_no"));
			dto.setP_title(rs.getString("P_title"));
			dto.setP_tm(rs.getDate("p_tm"));
			dto.setP_likeCount(rs.getInt("p_likecount"));
			dto.setNs_pr(rs.getInt("NS_pr"));
			dto.setI_newName("i_newName");
			dto.setNs_code("ns_code");
			
			soldlist.add(dto);
		}
		
		System.out.println("list:"+soldlist);
		return soldlist;
	}

	public ArrayList<GGDto> list(String userid, int listwhatadd) throws SQLException {
		String sql = "";
		if (listwhatadd == 0) {//전체 NS_001 NS_003
			sql = "";
		}else if (listwhatadd == 1) {//경매중 NS_001 NS_003
			
		}else if (listwhatadd == 2) {//경매완료 NS_003
			
		}

		ArrayList<GGDto> actionlist = new ArrayList<GGDto>();
		
		System.out.println("actionlist:"+actionlist);
		
		ps = conn.prepareStatement(sql);
		
		System.out.println("daouserID:"+userid);
		ps.setString(1, userid);
		//System.out.println("ps:"+ps);
		rs = ps.executeQuery();
		//System.out.println("rs:"+rs);
		
		while (rs.next()) {
			GGDto dto = new GGDto();
			dto.setP_no(rs.getInt("P_no"));
			dto.setP_title(rs.getString("P_title"));
			dto.setP_tm(rs.getDate("p_tm"));
			dto.setP_likeCount(rs.getInt("p_likecount"));
			dto.setNs_pr(rs.getInt("NS_pr"));
			dto.setI_newName("i_newName");
			dto.setNs_code("ns_code");
			
			actionlist.add(dto);
		}
		
		System.out.println("list:"+actionlist);
		return actionlist;
	}
	
	
	
	
	public HashMap<String, ArrayList<GGDto>> category() {
		String sql = "select * from codes where c_code like 'S%'";
		HashMap<String, ArrayList<GGDto>> map = new HashMap<String, ArrayList<GGDto>>();
		ArrayList<GGDto> list1 = new ArrayList<GGDto>();
		ArrayList<GGDto> list2 = new ArrayList<GGDto>();
		try {
			ps = conn.prepareStatement(sql);
			rs = ps.executeQuery();
			while (rs.next()) {
				GGDto dto = new GGDto();
				dto.setC_code(rs.getString("c_code"));
				dto.setC_name(rs.getString("c_name"));
				list1.add(dto);
			}
			map.put("saleCat", list1);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		sql = "select * from post_codes where p_cate like 'C%'";
		try {
			ps = conn.prepareStatement(sql);
			rs = ps.executeQuery();
			while (rs.next()) {
				GGDto dto = new GGDto();
				dto.setP_cate(rs.getString("p_cate"));
				dto.setP_cateName(rs.getString("p_cateName"));
				list2.add(dto);
			}
			map.put("commuCat", list2);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

		return map;
	}

	public int writeSale(GGDto dto) {

		String sql = "INSERT INTO post(p_no,p_id,p_title,p_content,p_tm,p_view,p_likeCount,p_blindYN,p_code) VALUES(p_no_seq.NEXTVAL,?,?,?,SYSDATE,0,0,?,?)";
		int success = 0;
		int p_no = 0;
		try {
			ps = conn.prepareStatement(sql, new String[] { "p_no" });
			ps.setString(1, dto.getP_id());
			ps.setString(2, dto.getP_title());
			ps.setString(3, dto.getP_content());
			ps.setString(4, "N");
			ps.setString(5, dto.getP_code());

			success += ps.executeUpdate();
			System.out.println("게시판 테이블 작성 성공: " + success);

			rs = ps.getGeneratedKeys();

			if (rs.next()) {
				sql = "INSERT INTO sale VALUES(?,?,?,?,?)";
				ps = conn.prepareStatement(sql);
				p_no = rs.getInt(1);
				ps.setInt(1, p_no);
				ps.setString(2, dto.getS_DeliveryYN());
				ps.setString(3, dto.getS_followLimYN());
				ps.setString(4, dto.getP_id());
				ps.setString(5, dto.getS_code());

				success += ps.executeUpdate();
				System.out.println("판매 테이블 작성 성공: " + success);
				if (success==2) {
					sql = "INSERT INTO n_sale VALUES(?,?,?)";
					ps = conn.prepareStatement(sql);
					ps.setInt(1, p_no);
					ps.setInt(2, dto.getNs_pr());
					ps.setString(3, "NS_001");

					success += ps.executeUpdate();
					System.out.println("일반 판매 테이블 작성 성공: " + success);
				}
				if (success ==3) {
					System.out.println("판매글 작성 번호 : " + p_no);
					System.out.println("판매글 작성 성공");
				}
			}

		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return success;
	}

	public boolean writeCommu(GGDto dto) throws SQLException {

		boolean success = false;
		int checker = 0;

		String sql = "INSERT INTO post VALUES(p_no_seq.NEXTVAL,?,?,?,SYSDATE,0,0,?,?,?)";

		ps = conn.prepareStatement(sql, new String[] { "p_no" });
		ps.setString(1, dto.getP_id());
		ps.setString(2, dto.getP_title());
		ps.setString(3, dto.getP_content());
		ps.setString(4, "N");
		ps.setString(5, dto.getP_code());
		ps.setString(6, dto.getP_cate());
		checker = ps.executeUpdate();
		rs = ps.getGeneratedKeys();
		if (checker > 0) {
			rs.next();
			int pk = rs.getInt(1);
			success = true;
			System.out.println("글 작성 번호 : " + pk);
			System.out.println("글 작성 성공");
		}

		return success;
	}

	public int writeTrade(GGDto dto) throws SQLException {
		
		boolean success = false;
		int p_no = 0;
		int checker = 0;
		String sql = "INSERT INTO post(p_no,p_id,p_title,p_content,p_tm,p_view,p_likeCount,p_blindYN,p_code) VALUES(p_no_seq.NEXTVAL,?,?,?,SYSDATE,0,0,?,?)";
		
		ps = conn.prepareStatement(sql, new String[] { "p_no" });
		ps.setString(1, dto.getP_id());
		ps.setString(2, dto.getP_title());
		ps.setString(3, dto.getP_content());
		ps.setString(4, "N");
		ps.setString(5, dto.getP_code());

		checker += ps.executeUpdate();
		rs = ps.getGeneratedKeys();
		if (rs.next()) {
			if(checker>0) {success = true; System.out.println("게시글 테이블 진입 여부 : "+success);}
			success = false;
			p_no = rs.getInt(1);
			sql = "INSERT INTO sale VALUES(?,?,?,?,?)";
			
			ps = conn.prepareStatement(sql);
			ps.setInt(1, p_no);
			ps.setString(2, dto.getS_DeliveryYN());
			ps.setString(3, dto.getS_followLimYN());
			ps.setString(4, dto.getP_id());
			ps.setString(5, dto.getS_code());

			checker += ps.executeUpdate();
			
			if (checker==2) {
				success = true;
				System.out.println("판매 테이블 작성 성공: " + success);
				success = false;
				sql = "INSERT INTO auction(p_no,au_code,au_startpr,au_instantpr,au_starttm,au_endtm,au_count) VALUES(?,?,?,?,?,?,?)";
				ps = conn.prepareStatement(sql);
				ps.setInt(1, p_no);
				ps.setString(2, "Au001");
				ps.setInt(3, dto.getAu_startPr());
				ps.setInt(4, dto.getAu_instantPr());
				ps.setDate(5, dto.getAu_startTm());
				ps.setDate(6, dto.getAu_endTm());
				ps.setInt(7, 0);

				checker += ps.executeUpdate();
				
			}
			if (checker ==3) {
				success = true;
				System.out.println("경매 테이블 작성 성공: " + success);
				System.out.println("경매글 작성 번호 : " + p_no);
				System.out.println("경매글 작성 성공");
			}
		}
		
		return p_no;
	}


}
