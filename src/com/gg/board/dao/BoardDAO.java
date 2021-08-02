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
		String sql = "SELECT P.P_NO, P.P_ID, P.P_TITLE, P.P_CONTENT, P.P_TM, P.P_VIEW, P.P_LIKECOUNT, P.P_BLINDYN, (SELECT C_NAME FROM CODES WHERE C_CODE = P.P_CODE) AS P_NAME, S.S_DELIVERYYN, S.S_FOLLOWLIMYN, (SELECT C_NAME FROM CODES WHERE C_CODE = S.S_CODE) AS S_NAME, N.NS_PR, (SELECT C_NAME FROM CODES WHERE C_CODE = N.NS_CODE) AS NS_NAME, I.I_NEWNAME, LPAD((SELECT U_ADDR FROM USERINFO WHERE U_ID = P.P_ID), 20, ' ') AS U_ADDR , (SELECT U_NNAME FROM USERINFO WHERE U_ID = P_ID) AS U_NNAME FROM POST P, SALE S, N_SALE N, IMG I WHERE P.P_NO=S.P_NO AND S.P_NO=N.P_NO AND N.P_NO=I.P_NO AND P.P_NO = ?";
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
				
				dto.setU_nname(rs.getString("U_nname"));
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
	public ArrayList<GGDto> sold_list(String userid, int listwhatadd, int listhowaline) throws SQLException {
		String sql = "";
		if (listwhatadd == 0) {//전체 NS_001 NS_003
			if (listhowaline == 0) {//시간최신 -desc
			//sql = "select * FROM  post p,N_Sale n,img i where (n.ns_code = 'NS_001' or n.ns_code = 'NS_003') and p.p_code = 'P002' and p.p_no = n.p_no and p.p_id = ? order BY p.p_tm DESC";				
			//sql = "SELECT p.p_id,p.p_no,p.p_title,p.p_likecount,p.p_tm,n.ns_pr,n.ns_code,p.p_code,i.i_newname FROM  post p,N_Sale n,img i,SALE S WHERE p.p_code = 'P002' and P.P_NO=S.P_NO AND s.P_NO = N.P_NO AND N.P_NO = P.P_NO and N.P_NO = i.p_no and (n.ns_code = 'NS_001' or n.ns_code = 'NS_003')";
			sql = "SELECT P.P_NO, P.P_ID, P.P_TITLE, P.P_CONTENT, P.P_TM, P.P_VIEW, P.P_LIKECOUNT, P.P_BLINDYN, (SELECT C_NAME FROM CODES WHERE C_CODE = P.P_CODE) AS P_NAME, S.S_DELIVERYYN, S.S_FOLLOWLIMYN, (SELECT C_NAME FROM CODES WHERE C_CODE = S.S_CODE) AS S_NAME, N.NS_PR, (SELECT C_NAME FROM CODES WHERE C_CODE = N.NS_CODE) AS NS_NAME, I.I_NEWNAME, LPAD((SELECT U_ADDR FROM USERINFO WHERE U_ID = P.P_ID), 20, ' ') AS U_ADDR FROM POST P, SALE S, N_SALE N, IMG I WHERE P.P_NO=S.P_NO AND S.P_NO=N.P_NO AND N.P_NO=I.P_NO AND p.p_id = ? and (n.ns_code = 'NS_001' or n.ns_code = 'NS_003') and p.p_code = 'P002' order BY p.p_tm DESC";
			
			}else if(listhowaline == 1) {//좋아요많은쪽 -desc
				//sql= "select * FROM  post p,N_Sale n where (n.ns_code = 'NS_001' or n.ns_code = 'NS_003') and p.p_code = 'P002' and p.p_no = n.p_no and p.p_id = ? order BY p.P_likeCount DESC";
				sql = "SELECT P.P_NO, P.P_ID, P.P_TITLE, P.P_CONTENT, P.P_TM, P.P_VIEW, P.P_LIKECOUNT, P.P_BLINDYN, (SELECT C_NAME FROM CODES WHERE C_CODE = P.P_CODE) AS P_NAME, S.S_DELIVERYYN, S.S_FOLLOWLIMYN, (SELECT C_NAME FROM CODES WHERE C_CODE = S.S_CODE) AS S_NAME, N.NS_PR, (SELECT C_NAME FROM CODES WHERE C_CODE = N.NS_CODE) AS NS_NAME, I.I_NEWNAME, LPAD((SELECT U_ADDR FROM USERINFO WHERE U_ID = P.P_ID), 20, ' ') AS U_ADDR FROM POST P, SALE S, N_SALE N, IMG I WHERE P.P_NO=S.P_NO AND S.P_NO=N.P_NO AND N.P_NO=I.P_NO AND p.p_id = ? and (n.ns_code = 'NS_001' or n.ns_code = 'NS_003') and p.p_code = 'P002' order BY p.P_likeCount DESC";
				
			}
		}else if (listwhatadd == 1) {//판매중 NS_001 NS_003
			if (listhowaline == 0) {//시간최신 -desc
				//sql = "select * FROM  post p,N_Sale n where n.ns_code = 'NS_001' and p.p_code = 'P002' and p.p_no = n.p_no and p.p_id = ? order BY p.p_tm DESC";				
				sql = "SELECT P.P_NO, P.P_ID, P.P_TITLE, P.P_CONTENT, P.P_TM, P.P_VIEW, P.P_LIKECOUNT, P.P_BLINDYN, (SELECT C_NAME FROM CODES WHERE C_CODE = P.P_CODE) AS P_NAME, S.S_DELIVERYYN, S.S_FOLLOWLIMYN, (SELECT C_NAME FROM CODES WHERE C_CODE = S.S_CODE) AS S_NAME, N.NS_PR, (SELECT C_NAME FROM CODES WHERE C_CODE = N.NS_CODE) AS NS_NAME, I.I_NEWNAME, LPAD((SELECT U_ADDR FROM USERINFO WHERE U_ID = P.P_ID), 20, ' ') AS U_ADDR FROM POST P, SALE S, N_SALE N, IMG I WHERE P.P_NO=S.P_NO AND S.P_NO=N.P_NO AND N.P_NO=I.P_NO AND p.p_id = ? and n.ns_code = 'NS_001' and p.p_code = 'P002' order BY p.p_tm DESC";
			}else if(listhowaline == 1) {//좋아요많은쪽 -desc
				//sql= "select * FROM  post p,N_Sale n where n.ns_code = 'NS_001' and p.p_code = 'P002' and p.p_no = n.p_no and p.p_id = ? order BY p.P_likeCount DESC";
				sql = "SELECT P.P_NO, P.P_ID, P.P_TITLE, P.P_CONTENT, P.P_TM, P.P_VIEW, P.P_LIKECOUNT, P.P_BLINDYN, (SELECT C_NAME FROM CODES WHERE C_CODE = P.P_CODE) AS P_NAME, S.S_DELIVERYYN, S.S_FOLLOWLIMYN, (SELECT C_NAME FROM CODES WHERE C_CODE = S.S_CODE) AS S_NAME, N.NS_PR, (SELECT C_NAME FROM CODES WHERE C_CODE = N.NS_CODE) AS NS_NAME, I.I_NEWNAME, LPAD((SELECT U_ADDR FROM USERINFO WHERE U_ID = P.P_ID), 20, ' ') AS U_ADDR FROM POST P, SALE S, N_SALE N, IMG I WHERE P.P_NO=S.P_NO AND S.P_NO=N.P_NO AND N.P_NO=I.P_NO AND p.p_id = ? and n.ns_code = 'NS_001' and p.p_code = 'P002' order BY p.P_likeCount DESC";
			}
		}else if (listwhatadd == 2) {//판매완료 NS_003
			if (listhowaline == 0) {//시간최신 -desc
				//sql = "select * FROM  post p,N_Sale n where n.ns_code = 'NS_003' and p.p_code = 'P002' and p.p_no = n.p_no and p.p_id = ? order BY p.p_tm DESC";				
				sql = "SELECT P.P_NO, P.P_ID, P.P_TITLE, P.P_CONTENT, P.P_TM, P.P_VIEW, P.P_LIKECOUNT, P.P_BLINDYN, (SELECT C_NAME FROM CODES WHERE C_CODE = P.P_CODE) AS P_NAME, S.S_DELIVERYYN, S.S_FOLLOWLIMYN, (SELECT C_NAME FROM CODES WHERE C_CODE = S.S_CODE) AS S_NAME, N.NS_PR, (SELECT C_NAME FROM CODES WHERE C_CODE = N.NS_CODE) AS NS_NAME, I.I_NEWNAME, LPAD((SELECT U_ADDR FROM USERINFO WHERE U_ID = P.P_ID), 20, ' ') AS U_ADDR FROM POST P, SALE S, N_SALE N, IMG I WHERE P.P_NO=S.P_NO AND S.P_NO=N.P_NO AND N.P_NO=I.P_NO AND p.p_id = ? and n.ns_code = 'NS_003' and p.p_code = 'P002' order BY p.p_tm DESC";

			}else if(listhowaline == 1) {//좋아요많은쪽 -desc
				//sql= "select * FROM  post p,N_Sale n where n.ns_code = 'NS_003' and p.p_code = 'P002' and p.p_no = n.p_no and p.p_id = ? order BY p.P_likeCount DESC";
				sql = "SELECT P.P_NO, P.P_ID, P.P_TITLE, P.P_CONTENT, P.P_TM, P.P_VIEW, P.P_LIKECOUNT, P.P_BLINDYN, (SELECT C_NAME FROM CODES WHERE C_CODE = P.P_CODE) AS P_NAME, S.S_DELIVERYYN, S.S_FOLLOWLIMYN, (SELECT C_NAME FROM CODES WHERE C_CODE = S.S_CODE) AS S_NAME, N.NS_PR, (SELECT C_NAME FROM CODES WHERE C_CODE = N.NS_CODE) AS NS_NAME, I.I_NEWNAME, LPAD((SELECT U_ADDR FROM USERINFO WHERE U_ID = P.P_ID), 20, ' ') AS U_ADDR FROM POST P, SALE S, N_SALE N, IMG I WHERE P.P_NO=S.P_NO AND S.P_NO=N.P_NO AND N.P_NO=I.P_NO AND p.p_id = ? and n.ns_code = 'NS_003' and p.p_code = 'P002' order BY p.P_likeCount DESC";

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
			dto.setI_newName(rs.getString("I_newName"));
			
			soldlist.add(dto);
		}
		System.out.println("soldlist:"+soldlist);
		return soldlist;
	}

	public ArrayList<GGDto> auction_list(String userid, int listwhatadd) throws SQLException {
		String sql = "";
		if (listwhatadd == 0) {//전체 Au001 Au003
			sql = "SELECT  DISTINCT P.P_NO, P.P_ID, P.P_TITLE, a.au_endTm, H.HA_BIDUSR,a.au_count ,HM.TOPPR,I.I_NEWNAME,A.Au_startPr,A.Au_instantPr,P.P_TM FROM POST P, AUCTION A,IMG I,HIS_AUCTION H,(SELECT P_NO, MAX(HA_BIDPR) TOPPR FROM HIS_AUCTION GROUP BY P_NO) HM WHERE P.P_NO = A.P_NO AND A.P_NO = HM.P_NO AND HM.P_NO = H.P_NO AND a.p_no = i.p_no AND H.HA_BIDPR = HM.TOPPR AND P_ID = 'admin1' and  p.p_code ='P001' and (a.Au_code = 'Au001' or a.Au_code = 'Au003') and P.P_ID = ? ";
		}else if (listwhatadd == 1) {//경매중   Au001
			sql = "SELECT  DISTINCT P.P_NO, P.P_ID, P.P_TITLE, a.au_endTm,H.HA_BIDUSR,a.au_count ,HM.TOPPR,I.I_NEWNAME,A.Au_startPr,A.Au_instantPr,P.P_TM FROM POST P, AUCTION A,IMG I,HIS_AUCTION H,(SELECT P_NO, MAX(HA_BIDPR) TOPPR FROM HIS_AUCTION GROUP BY P_NO) HM WHERE P.P_NO = A.P_NO AND A.P_NO = HM.P_NO AND HM.P_NO = H.P_NO AND a.p_no = i.p_no AND H.HA_BIDPR = HM.TOPPR AND P_ID = 'admin1' and  p.p_code ='P001' and a.Au_code = 'Au001' and P.P_ID = ? ";
		}else if (listwhatadd == 2) {//경매완료  Au003
			sql = "SELECT  DISTINCT P.P_NO, P.P_ID, P.P_TITLE, a.au_endTm,H.HA_BIDUSR,a.au_count ,HM.TOPPR,I.I_NEWNAME,A.Au_startPr,A.Au_instantPr,P.P_TM FROM POST P, AUCTION A,IMG I,HIS_AUCTION H,(SELECT P_NO, MAX(HA_BIDPR) TOPPR FROM HIS_AUCTION GROUP BY P_NO) HM WHERE P.P_NO = A.P_NO AND A.P_NO = HM.P_NO AND HM.P_NO = H.P_NO AND a.p_no = i.p_no AND H.HA_BIDPR = HM.TOPPR AND P_ID = 'admin1' and  p.p_code ='P001' and a.Au_code = 'Au003' and P.P_ID = ? ";
		}

		ArrayList<GGDto> auctionlist = new ArrayList<GGDto>();
		
		System.out.println("auctionlist:"+auctionlist);
		
		ps = conn.prepareStatement(sql);
		
		System.out.println("daouserID:"+userid);
		
		ps.setString(1, userid);
		rs = ps.executeQuery();
		System.out.println("rs:" + rs);
		
		while (rs.next()) {
			GGDto dto = new GGDto();
			dto.setP_no(rs.getInt("P_NO"));
			dto.setP_id(rs.getString("P_ID"));
			dto.setP_title(rs.getString("P_TITLE"));
			dto.setHa_bidUsr(rs.getString("HA_BIDUSR"));
			dto.setAu_count(rs.getInt("au_count"));
			dto.setAu_endTm(rs.getDate("au_endTm"));
			dto.setHm(rs.getLong("TOPPR"));
			dto.setI_newName(rs.getString("I_NEWNAME"));
			dto.setAu_startPr(rs.getInt("Au_startPr"));
			dto.setAu_instantPr(rs.getInt("Au_instantPr"));
			dto.setP_tm(rs.getDate("P_TM"));
			auctionlist.add(dto);
		}
		System.out.println("actionlist:"+auctionlist);
		return auctionlist;
	}
	
	public ArrayList<GGDto> maide_list(String userid) throws SQLException {

		String sql = "select p.p_title,pi.pnt_point,pi.pnt_tm,i.i_newname,pi.pnt_otherid,c.c_name,pi.PNT_otherId from post p,point pi,img i,codes c where (p.p_code='P002' or p.p_code='P001') and p.p_code = c.c_code and pi.pnt_code='PNT003' and p.p_no = pi.p_no and p.p_no = i.p_no and p.p_id = pi.PNT_id and pi.PNT_id = ?";

		ArrayList<GGDto> maidelist = new ArrayList<GGDto>();
		
		System.out.println("maidelist:"+maidelist);
		
		ps = conn.prepareStatement(sql);
		
		System.out.println("daouserID:"+userid);
		ps.setString(1, userid);
		rs = ps.executeQuery();

		
		while (rs.next()) {
			GGDto dto = new GGDto();
			dto.setP_title(rs.getString("P_title"));
			dto.setPnt_point(rs.getInt("pnt_point"));
			dto.setPnt_tm(rs.getDate("pnt_tm"));
			dto.setI_newName(rs.getString("I_newName"));
			dto.setC_name(rs.getString("c_name"));;
			dto.setPnt_otherId(rs.getString("pnt_otherid"));
			maidelist.add(dto);
		}
		System.out.println("maidelist:"+maidelist);
		return maidelist;
	}
	
	public ArrayList<GGDto> community_list(String userid) throws SQLException {
		
		String sql = "SELECT DISTINCT p.p_no,pc.p_catename,p.p_title,p.p_tm,p.P_view FROM post p,Post_codes pc,Codes c where pc.p_cate = p.p_cate and p.p_code = c.c_code and p.p_id = ?";

		ArrayList<GGDto> communitylist = new ArrayList<GGDto>();
		
		System.out.println("communitylist:"+communitylist);
		
		ps = conn.prepareStatement(sql);
		
		System.out.println("daouserID:"+userid);
		ps.setString(1, userid);
		rs = ps.executeQuery();

		
		while (rs.next()) {
			GGDto dto = new GGDto();
			dto.setP_no(rs.getInt("P_NO"));
			dto.setP_cateName(rs.getString("p_catename"));
			dto.setP_title(rs.getString("P_title"));
			dto.setP_tm(rs.getDate("p_tm"));
			dto.setP_view(rs.getInt("p_view"));
			communitylist.add(dto);
		}
		System.out.println("communitylist:"+communitylist);
		return communitylist;
	}
	
	
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////
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
		int checker = 0;
		int p_no = 0;
		boolean success = false;
		try {
			ps = conn.prepareStatement(sql, new String[] { "p_no" });
			ps.setString(1, dto.getP_id());
			ps.setString(2, dto.getP_title());
			ps.setString(3, dto.getP_content());
			ps.setString(4, "N");
			ps.setString(5, dto.getP_code());

			checker += ps.executeUpdate();
			if(checker == 1) {
				success = true;
				System.out.println("게시판 테이블 작성 성공: " + success);
				success = false;
			}
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

				checker += ps.executeUpdate();

				if (checker ==2) {
					success = true;
					System.out.println("판매 테이블 작성 성공: " + success);
					success = false;
					
					sql = "INSERT INTO n_sale VALUES(?,?,?)";
					ps = conn.prepareStatement(sql);
					ps.setInt(1, p_no);
					ps.setInt(2, dto.getNs_pr());
					ps.setString(3, "NS_001");

					checker += ps.executeUpdate();
					
				}
				if (checker ==3) {
					success = true;
					System.out.println("일반 판매 테이블 작성 성공: " + success);
					System.out.println("판매글 작성 번호 : " + p_no);
					System.out.println("판매글 작성 성공 ");
				}
			}

		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return p_no;
	}

	public int writeCommu(GGDto dto) throws SQLException {
		
		boolean success = false;
		int checker = 0;
		int p_no = 0;

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
			success = true;
			p_no = rs.getInt(1);
			System.out.println("글 작성 번호 : " + p_no);
			System.out.println("글 작성 성공 여부 :"+ success);
		}

		return p_no;
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

	public GGDto auctionDetail(int p_no) throws SQLException {
		
		//경매 상세보기(경매 히스토리 테이블 제외)
		String sql = "select p.p_no, p.p_id, p.p_title, p.p_content, p.p_view, p.p_likeCount, p.p_blindYN, p.p_code, (select u.u_nname from userinfo u where u.u_id = p_id) as u_nname,(select u.u_addr from userinfo u where u.u_id= p_id) as u_addr, s.s_deliveryyn, s.s_followlimyn, s.s_code, a.au_code ,(select c.c_name from codes c where c.c_code = a.au_code) as au_c_name, a.au_startpr,a.au_instantpr,a.au_starttm,a.au_endtm ,a.au_count, i.i_newname from post p, sale s, auction a, img i where p.p_no=s.p_no and p.p_no= i.p_no and s.p_no = a.p_no and p.p_no=?";
		GGDto dto = new GGDto();
		ps = conn.prepareStatement(sql);
		ps.setInt(1, p_no);
		rs = ps.executeQuery();
		if(rs.next()) {
			dto.setP_no(rs.getInt("p_no")); //글번호
			dto.setP_id(rs.getString("p_id")); //글작성자
			dto.setP_title(rs.getString("p_title")); //글제목
			dto.setP_content(rs.getString("p_content")); //글내용
			dto.setP_view(rs.getInt("p_view")); //조회수
			dto.setP_likeCount(rs.getInt("p_likeCount")); //좋아요수
			dto.setP_blindYN(rs.getString("p_blindYN")); //블라인드 여부
			dto.setP_code(rs.getString("p_code")); //게시글 카테고리
			dto.setU_nname(rs.getString("u_nname"));//판매자 닉네임
			dto.setU_addr(rs.getString(("u_addr"))); //간편주소
			dto.setS_DeliveryYN(rs.getString("s_deliveryyn")); //택배여부
			dto.setS_followLimYN(rs.getString("s_followlimyn")); //팔로워한정판매여부
			dto.setS_code(rs.getString("s_code")); //판매, 경매 카테고리
			dto.setAu_code(rs.getString("au_code")); //경매상태(코드)
			dto.setC_name(rs.getString("au_c_name")); //경매상태(한글)
			dto.setAu_startPr(rs.getInt("au_startpr")); //경매 시작 가격
			dto.setAu_instantPr(rs.getInt("au_instantpr")); //경매 즉결 가격
			dto.setAu_endTm(rs.getDate("au_starttm")); //경매 종료 시간
			dto.setAu_endTm(rs.getDate("au_endtm")); //경매 종료 시간
			dto.setAu_count(rs.getInt("au_count")); //입찰횟수
			//dto.setHa_bidPr(rs.getInt("ha_bidpr"));
			//dto.setHa_bidUsr(rs.getString("ha_bidusr"));
			dto.setI_newName(rs.getString("i_newname")); //사진명 
			
			System.out.println(dto.getAu_count());
			System.out.println(rs.getString("i_newname"));
			System.out.println(dto.getP_title());
			System.out.println(dto.getU_addr());
			System.out.println("경매 상태: "+dto.getAu_code());
			System.out.println(dto.getP_code());
		}
		
		//경매 상세보기 (히스토리 테이블)
		sql = "SELECT (select u_nname from userinfo where u_id = ha_bidusr) u_nname, haum.toppr toppr FROM his_auction hau, (SELECT P_NO, MAX(HA_BIDPR) TOPPR FROM HIS_AUCTION GROUP BY P_NO) haum WHERE hau.p_no = haum.p_no and hau.ha_bidpr = haum.toppr and hau.p_no=?";
		
		ps = conn.prepareStatement(sql);
		ps.setInt(1, p_no);
		rs = ps.executeQuery();
		if(rs.next()) {//입찰기록이 있을 경우
			dto.setHa_bidPr(rs.getInt("toppr")); //최고 입찰가
			dto.setHa_bidUsr(rs.getString("u_nname"));//최고 입찰자
		}else {//입찰기록이 없을 경우
			dto.setHa_bidPr(0); 
			dto.setHa_bidUsr("-");
		}
		
		return dto;
		
		
	}

	public HashMap<String,Object> auctionBid(int p_no, int ha_bidPr, String ha_bidUsr) throws SQLException {
		
		//반환값(성공여부, 실패시 ->현재 최고 입찰가, 성공여부 초기상태
		//msg를 뿌려줄 예정 (성공/ 현재입찰자 = 최고입찰자 / 입찰금액 <최고입찰긍)
		int checker = 0;
		boolean success = false;
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
					
				}
			}
		}
		//입찰금액 입력 쿼리
		System.out.println("경매 히스토리 입력여부 : "+success);
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
	

	public GGDto commDetail(String p_no) {
		String sql = "SELECT u.u_nname,u.u_newName,p.p_no,p_title,p.p_content,p.p_tm,p.p_view,i.i_newname,c_name,u_id FROM "+ 
				"    UserInfo u INNER JOIN Post p ON u.u_id = p.p_id" + 
				"    INNER JOIN codes c ON p.p_cate = c.c_code" + 
				"    LEFT OUTER JOIN Img i ON p.p_no = i.p_no" + 
				"    LEFT OUTER JOIN Post_Comment pc ON p.p_no = pc.p_no" + 
				"    WHERE p.p_code = 'P004' AND p.p_blindyn = 'N' AND p.p_no=?";
		GGDto dto = new GGDto();
		try {
			ps = conn.prepareStatement(sql);
			ps.setString(1,p_no);
			rs = ps.executeQuery();
			if(rs.next()) {
				dto.setU_nname(rs.getString("u_nname"));
				dto.setU_newName(rs.getString("u_newName"));
				dto.setP_no(rs.getInt("p_no"));
				dto.setP_title(rs.getString("p_title"));
				dto.setP_content(rs.getString("p_content"));
				dto.setP_tm(rs.getDate("p_tm"));
				dto.setP_view(rs.getInt("p_view"));
				dto.setI_newName(rs.getString("i_newName"));
				dto.setC_name(rs.getString("c_name"));
				dto.setU_id(rs.getString("u_id"));
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}finally {
			resClose();
		}
		return dto;
	}
	
	public boolean buyNow(int p_no, String u_id, int ha_bidPr) {
		//즉결가 조회
		String sql = "SELECT AU_INSTANTPR FROM AUCTION WHERE P_NO = ?";
		//낙찰자를 등록
		String sql2 = "INSERT INTO AUCTION (AU_SUCCESSER) VALUES(?)";
		//경매상태를 거래중으로 변경
		String sql3 = "UPDATE FROM AUCTION SET AU_CODE = 'Au002' WHERE P_NO = ?";
		//경매히스토리에 이력을 저장
		String sql4 = "INSERT INTO his_auction(p_no,ha_bidpr,ha_bidusr,ha_bidtm) VALUES(?,?,?,SYSDATE)";
		int success = 0;
		try {
			ps = conn.prepareStatement(sql);
			ps.setInt(1, p_no);
			rs = ps.executeQuery();
			System.out.println("DAO buyNow 즉결가 조회");
			int au_instantpr = 0;
			if(rs.next()) {
				au_instantpr = rs.getInt("au_instantpr");
				System.out.println("DAO buyNow au_instantpr : "+au_instantpr);
			}
			System.out.println("DAO buyNow au_instantpr == ha_bidPr : "+(au_instantpr == ha_bidPr));
			if(au_instantpr == ha_bidPr) {
				ps = conn.prepareStatement(sql2);
				ps.setString(1, u_id);
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
		return success>0?true:false;
	}
	
}
