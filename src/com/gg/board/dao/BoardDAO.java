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
import com.gg.user.dao.AlarmDAO;
import com.gg.user.dao.PointDAO;

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
		String sql = "SELECT P.P_NO, P.P_ID, P.P_TITLE, P.P_CONTENT, P.P_TM, P.P_VIEW, P.P_LIKECOUNT, P.P_BLINDYN, (SELECT C_NAME FROM CODES WHERE C_CODE = P.P_CODE) AS P_NAME, S.S_DELIVERYYN, S.S_FOLLOWLIMYN, S.S_CODE, (SELECT C_NAME FROM CODES WHERE C_CODE = S.S_CODE) AS S_NAME, N.NS_PR, (SELECT C_NAME FROM CODES WHERE C_CODE = N.NS_CODE) AS NS_NAME, I.I_NEWNAME, LPAD((SELECT U_ADDR FROM USERINFO WHERE U_ID = P.P_ID), 20, ' ') AS U_ADDR , (SELECT U_NNAME FROM USERINFO WHERE U_ID = P_ID) AS U_NNAME FROM POST P, SALE S, N_SALE N, IMG I WHERE P.P_NO=S.P_NO AND S.P_NO=N.P_NO AND N.P_NO=I.P_NO AND P.P_NO = ?";
		try {
			ps = conn.prepareStatement(sql);
			ps.setInt(1, p_no);
			rs = ps.executeQuery();
			if (rs.next()) {
				dto = new GGDto();
				dto.setP_no(rs.getInt("P_no"));
				dto.setP_id(rs.getString("P_id"));
				// System.out.println("dto.getP_id:"+dto.getP_id());
				dto.setP_title(rs.getString("P_title"));
				dto.setP_content(rs.getString("P_content"));
				dto.setP_tm(rs.getDate("P_tm"));
				dto.setP_view(rs.getInt("P_view"));
				dto.setP_likeCount(rs.getInt("P_likeCount"));
				dto.setP_blindYN(rs.getString("P_blindYN"));
				dto.setP_name(rs.getString("P_name"));

				dto.setS_DeliveryYN(rs.getString("S_DeliveryYN"));
				dto.setS_followLimYN(rs.getString("S_followLimYN"));
				dto.setS_code(rs.getString("S_code"));
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
		System.out.println("업 성공 여부 : " + success);
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

	public boolean isFollowed(String u_id, int p_no) {
		System.out.println("DAO isLiked");
		String sql = "SELECT * FROM FOLLOW WHERE F_RECEIVEID = (SELECT P_ID FROM POST WHERE P_NO = ?) AND F_SENDID = ?";
		System.out.println("u_id : " + u_id);
		System.out.println("p_no : " + p_no);

		boolean isFollowed = false;
		try {
			ps = conn.prepareStatement(sql);
			ps.setInt(1, p_no);
			ps.setString(2, u_id);
			rs = ps.executeQuery();
			if (rs.next()) {
				isFollowed = true;
			}
			System.out.println("[DAO] isFollowed : " + isFollowed);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return isFollowed;
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
			ps.setString(1, p_id);
			rs = ps.executeQuery();
			int rowCnt = rs.next() ? rs.getInt(1) : 0;
			System.out.println("rowCnt : " + rowCnt);
			int forCnt = rowCnt >= 3 ? 3 : rowCnt;
			System.out.println("forCnt : " + forCnt);
			ps = conn.prepareStatement(sql2);
			ps.setString(1, p_id);
			rs = ps.executeQuery();
			for (int i = 0; i < forCnt; i++) {
				rs.next();
				GGDto dto = new GGDto();
				dto.setP_no(rs.getInt("P_no"));
				dto.setP_title(rs.getString("P_title"));
				dto.setNs_pr(rs.getInt("NS_pr"));
				dto.setI_newName(rs.getString("I_newName"));
				sale3List.add(dto);
			}

		} catch (Exception e) {
			e.printStackTrace();
		}
		return sale3List;
	}

	/* ================================================ */
	public ArrayList<GGDto> sold_list(String userid, int listwhatadd, int listhowaline) throws SQLException {
		String sql = "";
		if (listwhatadd == 0) {// 전체 NS_001 NS_003
			if (listhowaline == 0) {// 시간최신 -desc
				// sql = "select * FROM post p,N_Sale n,img i where (n.ns_code = 'NS_001' or
				// n.ns_code = 'NS_003') and p.p_code = 'P002' and p.p_no = n.p_no and p.p_id =
				// ? order BY p.p_tm DESC";
				// sql = "SELECT
				// p.p_id,p.p_no,p.p_title,p.p_likecount,p.p_tm,n.ns_pr,n.ns_code,p.p_code,i.i_newname
				// FROM post p,N_Sale n,img i,SALE S WHERE p.p_code = 'P002' and P.P_NO=S.P_NO
				// AND s.P_NO = N.P_NO AND N.P_NO = P.P_NO and N.P_NO = i.p_no and (n.ns_code =
				// 'NS_001' or n.ns_code = 'NS_003')";
				sql = "SELECT P.P_NO, P.P_ID, P.P_TITLE, P.P_CONTENT, P.P_TM, P.P_VIEW, P.P_LIKECOUNT, P.P_BLINDYN, (SELECT C_NAME FROM CODES WHERE C_CODE = P.P_CODE) AS P_NAME, S.S_DELIVERYYN, S.S_FOLLOWLIMYN, (SELECT C_NAME FROM CODES WHERE C_CODE = S.S_CODE) AS S_NAME, N.NS_PR, (SELECT C_NAME FROM CODES WHERE C_CODE = N.NS_CODE) AS NS_NAME, I.I_NEWNAME, LPAD((SELECT U_ADDR FROM USERINFO WHERE U_ID = P.P_ID), 20, ' ') AS U_ADDR FROM POST P, SALE S, N_SALE N, IMG I WHERE P.P_NO=S.P_NO AND S.P_NO=N.P_NO AND N.P_NO=I.P_NO AND p.p_id = ? and (n.ns_code = 'NS_001' or n.ns_code = 'NS_003') and p.p_code = 'P002' order BY p.p_tm DESC";

			} else if (listhowaline == 1) {// 좋아요많은쪽 -desc
				// sql= "select * FROM post p,N_Sale n where (n.ns_code = 'NS_001' or n.ns_code
				// = 'NS_003') and p.p_code = 'P002' and p.p_no = n.p_no and p.p_id = ? order BY
				// p.P_likeCount DESC";
				sql = "SELECT P.P_NO, P.P_ID, P.P_TITLE, P.P_CONTENT, P.P_TM, P.P_VIEW, P.P_LIKECOUNT, P.P_BLINDYN, (SELECT C_NAME FROM CODES WHERE C_CODE = P.P_CODE) AS P_NAME, S.S_DELIVERYYN, S.S_FOLLOWLIMYN, (SELECT C_NAME FROM CODES WHERE C_CODE = S.S_CODE) AS S_NAME, N.NS_PR, (SELECT C_NAME FROM CODES WHERE C_CODE = N.NS_CODE) AS NS_NAME, I.I_NEWNAME, LPAD((SELECT U_ADDR FROM USERINFO WHERE U_ID = P.P_ID), 20, ' ') AS U_ADDR FROM POST P, SALE S, N_SALE N, IMG I WHERE P.P_NO=S.P_NO AND S.P_NO=N.P_NO AND N.P_NO=I.P_NO AND p.p_id = ? and (n.ns_code = 'NS_001' or n.ns_code = 'NS_003') and p.p_code = 'P002' order BY p.P_likeCount DESC";

			}
		} else if (listwhatadd == 1) {// 판매중 NS_001 NS_003
			if (listhowaline == 0) {// 시간최신 -desc
				// sql = "select * FROM post p,N_Sale n where n.ns_code = 'NS_001' and p.p_code
				// = 'P002' and p.p_no = n.p_no and p.p_id = ? order BY p.p_tm DESC";
				sql = "SELECT P.P_NO, P.P_ID, P.P_TITLE, P.P_CONTENT, P.P_TM, P.P_VIEW, P.P_LIKECOUNT, P.P_BLINDYN, (SELECT C_NAME FROM CODES WHERE C_CODE = P.P_CODE) AS P_NAME, S.S_DELIVERYYN, S.S_FOLLOWLIMYN, (SELECT C_NAME FROM CODES WHERE C_CODE = S.S_CODE) AS S_NAME, N.NS_PR, (SELECT C_NAME FROM CODES WHERE C_CODE = N.NS_CODE) AS NS_NAME, I.I_NEWNAME, LPAD((SELECT U_ADDR FROM USERINFO WHERE U_ID = P.P_ID), 20, ' ') AS U_ADDR FROM POST P, SALE S, N_SALE N, IMG I WHERE P.P_NO=S.P_NO AND S.P_NO=N.P_NO AND N.P_NO=I.P_NO AND p.p_id = ? and n.ns_code = 'NS_001' and p.p_code = 'P002' order BY p.p_tm DESC";
			} else if (listhowaline == 1) {// 좋아요많은쪽 -desc
				// sql= "select * FROM post p,N_Sale n where n.ns_code = 'NS_001' and p.p_code =
				// 'P002' and p.p_no = n.p_no and p.p_id = ? order BY p.P_likeCount DESC";
				sql = "SELECT P.P_NO, P.P_ID, P.P_TITLE, P.P_CONTENT, P.P_TM, P.P_VIEW, P.P_LIKECOUNT, P.P_BLINDYN, (SELECT C_NAME FROM CODES WHERE C_CODE = P.P_CODE) AS P_NAME, S.S_DELIVERYYN, S.S_FOLLOWLIMYN, (SELECT C_NAME FROM CODES WHERE C_CODE = S.S_CODE) AS S_NAME, N.NS_PR, (SELECT C_NAME FROM CODES WHERE C_CODE = N.NS_CODE) AS NS_NAME, I.I_NEWNAME, LPAD((SELECT U_ADDR FROM USERINFO WHERE U_ID = P.P_ID), 20, ' ') AS U_ADDR FROM POST P, SALE S, N_SALE N, IMG I WHERE P.P_NO=S.P_NO AND S.P_NO=N.P_NO AND N.P_NO=I.P_NO AND p.p_id = ? and n.ns_code = 'NS_001' and p.p_code = 'P002' order BY p.P_likeCount DESC";
			}
		} else if (listwhatadd == 2) {// 판매완료 NS_003
			if (listhowaline == 0) {// 시간최신 -desc
				// sql = "select * FROM post p,N_Sale n where n.ns_code = 'NS_003' and p.p_code
				// = 'P002' and p.p_no = n.p_no and p.p_id = ? order BY p.p_tm DESC";
				sql = "SELECT P.P_NO, P.P_ID, P.P_TITLE, P.P_CONTENT, P.P_TM, P.P_VIEW, P.P_LIKECOUNT, P.P_BLINDYN, (SELECT C_NAME FROM CODES WHERE C_CODE = P.P_CODE) AS P_NAME, S.S_DELIVERYYN, S.S_FOLLOWLIMYN, (SELECT C_NAME FROM CODES WHERE C_CODE = S.S_CODE) AS S_NAME, N.NS_PR, (SELECT C_NAME FROM CODES WHERE C_CODE = N.NS_CODE) AS NS_NAME, I.I_NEWNAME, LPAD((SELECT U_ADDR FROM USERINFO WHERE U_ID = P.P_ID), 20, ' ') AS U_ADDR FROM POST P, SALE S, N_SALE N, IMG I WHERE P.P_NO=S.P_NO AND S.P_NO=N.P_NO AND N.P_NO=I.P_NO AND p.p_id = ? and n.ns_code = 'NS_003' and p.p_code = 'P002' order BY p.p_tm DESC";

			} else if (listhowaline == 1) {// 좋아요많은쪽 -desc
				// sql= "select * FROM post p,N_Sale n where n.ns_code = 'NS_003' and p.p_code =
				// 'P002' and p.p_no = n.p_no and p.p_id = ? order BY p.P_likeCount DESC";
				sql = "SELECT P.P_NO, P.P_ID, P.P_TITLE, P.P_CONTENT, P.P_TM, P.P_VIEW, P.P_LIKECOUNT, P.P_BLINDYN, (SELECT C_NAME FROM CODES WHERE C_CODE = P.P_CODE) AS P_NAME, S.S_DELIVERYYN, S.S_FOLLOWLIMYN, (SELECT C_NAME FROM CODES WHERE C_CODE = S.S_CODE) AS S_NAME, N.NS_PR, (SELECT C_NAME FROM CODES WHERE C_CODE = N.NS_CODE) AS NS_NAME, I.I_NEWNAME, LPAD((SELECT U_ADDR FROM USERINFO WHERE U_ID = P.P_ID), 20, ' ') AS U_ADDR FROM POST P, SALE S, N_SALE N, IMG I WHERE P.P_NO=S.P_NO AND S.P_NO=N.P_NO AND N.P_NO=I.P_NO AND p.p_id = ? and n.ns_code = 'NS_003' and p.p_code = 'P002' order BY p.P_likeCount DESC";

			}
		}

		ArrayList<GGDto> soldlist = new ArrayList<GGDto>();

		System.out.println("soldlist:" + soldlist);

		ps = conn.prepareStatement(sql);

		System.out.println("daouserID:" + userid);
		ps.setString(1, userid);
		// System.out.println("ps:"+ps);
		rs = ps.executeQuery();
		// System.out.println("rs:"+rs);

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
		System.out.println("soldlist:" + soldlist);
		return soldlist;
	}

	public ArrayList<GGDto> auction_list(String userid, int listwhatadd) throws SQLException {
		String sql = "";
		if (listwhatadd == 0) {// 전체 Au001 Au003
			sql = "SELECT  DISTINCT P.P_NO, P.P_ID, P.P_TITLE, a.au_endTm, H.HA_BIDUSR,a.au_count ,HM.TOPPR,I.I_NEWNAME,A.Au_startPr,A.Au_instantPr,P.P_TM FROM POST P, AUCTION A,IMG I,HIS_AUCTION H,(SELECT P_NO, MAX(HA_BIDPR) TOPPR FROM HIS_AUCTION GROUP BY P_NO) HM WHERE P.P_NO = A.P_NO AND A.P_NO = HM.P_NO AND HM.P_NO = H.P_NO AND a.p_no = i.p_no AND H.HA_BIDPR = HM.TOPPR AND  p.p_code ='P001' and (a.Au_code = 'Au001' or a.Au_code = 'Au003') and P.P_ID = ? ";
		} else if (listwhatadd == 1) {// 경매중 Au001
			sql = "SELECT  DISTINCT P.P_NO, P.P_ID, P.P_TITLE, a.au_endTm,H.HA_BIDUSR,a.au_count ,HM.TOPPR,I.I_NEWNAME,A.Au_startPr,A.Au_instantPr,P.P_TM FROM POST P, AUCTION A,IMG I,HIS_AUCTION H,(SELECT P_NO, MAX(HA_BIDPR) TOPPR FROM HIS_AUCTION GROUP BY P_NO) HM WHERE P.P_NO = A.P_NO AND A.P_NO = HM.P_NO AND HM.P_NO = H.P_NO AND a.p_no = i.p_no AND H.HA_BIDPR = HM.TOPPR AND  p.p_code ='P001' and a.Au_code = 'Au001' and P.P_ID = ? ";
		} else if (listwhatadd == 2) {// 경매완료 Au003
			sql = "SELECT  DISTINCT P.P_NO, P.P_ID, P.P_TITLE, a.au_endTm,H.HA_BIDUSR,a.au_count ,HM.TOPPR,I.I_NEWNAME,A.Au_startPr,A.Au_instantPr,P.P_TM FROM POST P, AUCTION A,IMG I,HIS_AUCTION H,(SELECT P_NO, MAX(HA_BIDPR) TOPPR FROM HIS_AUCTION GROUP BY P_NO) HM WHERE P.P_NO = A.P_NO AND A.P_NO = HM.P_NO AND HM.P_NO = H.P_NO AND a.p_no = i.p_no AND H.HA_BIDPR = HM.TOPPR  and  p.p_code ='P001' and a.Au_code = 'Au003' and P.P_ID = ? ";
		}

		ArrayList<GGDto> auctionlist = new ArrayList<GGDto>();

		System.out.println("auctionlist:" + auctionlist);

		ps = conn.prepareStatement(sql);

		System.out.println("daouserID:" + userid);

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
		System.out.println("actionlist:" + auctionlist);
		return auctionlist;
	}

	public ArrayList<GGDto> maide_list(String userid) throws SQLException {

		String sql = "select p.p_no,p.p_title,pi.pnt_point,pi.pnt_tm,i.i_newname,pi.pnt_otherid,c.c_name,pi.PNT_otherId from post p,point pi,img i,codes c where (p.p_code='P002' or p.p_code='P001') and p.p_code = c.c_code and pi.pnt_code='PNT003' and p.p_no = pi.p_no and p.p_no = i.p_no and p.p_id = pi.PNT_id and pi.PNT_id = ?";

		ArrayList<GGDto> maidelist = new ArrayList<GGDto>();

		System.out.println("maidelist:" + maidelist);

		ps = conn.prepareStatement(sql);

		System.out.println("daouserID:" + userid);
		ps.setString(1, userid);
		rs = ps.executeQuery();

		while (rs.next()) {
			GGDto dto = new GGDto();
			dto.setP_no(rs.getInt("p_no"));
			dto.setP_title(rs.getString("P_title"));
			dto.setPnt_point(rs.getInt("pnt_point"));
			dto.setPnt_tm(rs.getDate("pnt_tm"));
			dto.setI_newName(rs.getString("I_newName"));
			dto.setC_name(rs.getString("c_name"));
			dto.setPnt_otherId(rs.getString("pnt_otherid"));
			maidelist.add(dto);
		}
		System.out.println("maidelist:" + maidelist);
		return maidelist;
	}

	public ArrayList<GGDto> community_list(String userid) throws SQLException {

		String sql = "SELECT DISTINCT p.p_no,pc.p_catename,p.p_title,p.p_tm,p.P_view FROM post p,Post_codes pc,Codes c where pc.p_cate = p.p_cate and p.p_code = c.c_code and p.p_id = ?";

		ArrayList<GGDto> communitylist = new ArrayList<GGDto>();

		System.out.println("communitylist:" + communitylist);

		ps = conn.prepareStatement(sql);

		System.out.println("daouserID:" + userid);
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
		System.out.println("communitylist:" + communitylist);
		return communitylist;
	}

	public ArrayList<GGDto> flowlist(String userid, int flowORflowing) throws SQLException {
		String sql = "";
		if (flowORflowing == 0) {// 나를 팔로우 한
			sql = "SELECT f.f_receiveid,f.f_sendid,u.u_id,u.u_newname,u.u_nname,NVL(C.COUNT,0) COUNT FROM follow f,(SELECT F_RECEIVEID, COUNT(*) COUNT FROM FOLLOW GROUP BY F_RECEIVEID) C,userinfo u where F.F_SENDID = C.F_RECEIVEID(+) AND f.f_receiveid = ? and f.f_sendid = u.u_id";
		} else if (flowORflowing == 1) {// 내가 팔로잉한
			sql = "SELECT f.f_receiveid,f.f_sendid,u.u_id,u.u_newname,u.u_nname,NVL(C.COUNT,0) COUNT FROM follow f,(SELECT F_RECEIVEID, COUNT(*) COUNT FROM FOLLOW GROUP BY F_RECEIVEID) C,userinfo u where F.F_SENDID = C.F_RECEIVEID(+) and f.f_sendid = ? and f.f_receiveid = u.u_id";
		}

		ArrayList<GGDto> flowlist = new ArrayList<GGDto>();

		System.out.println("flowlist:" + flowlist);

		ps = conn.prepareStatement(sql);

		System.out.println("daouserID:" + userid);

		ps.setString(1, userid);
		rs = ps.executeQuery();
		System.out.println("rs:" + rs);

		while (rs.next()) {
			GGDto dto = new GGDto();
			dto.setU_id(rs.getString("U_id"));
			dto.setF_receiveid(rs.getString("f_receiveid"));
			dto.setF_sendid(rs.getString("f_sendid"));
			dto.setU_newName(rs.getString("u_newname"));
			dto.setU_nname(rs.getString("u_nname"));
			dto.setFlow_count(rs.getInt("COUNT"));

			String u_id = dto.getU_id();
			String reseveid = dto.getF_receiveid();
			String sendid = dto.getF_sendid();

			// 유저가 만약 어떤유저에게 팔로잉을 했을때의 여부
			if (userid.equals(reseveid)) {
				dto.setThisuserFlowingYN("<button class='hellow'>+팔로우</button>");// N
			} else if (userid.equals(sendid)) {
				dto.setThisuserFlowingYN("<button class='unhellow'>-팔로우</button>");// Y
			}
			flowlist.add(dto);
		}
		System.out.println("flowlist:" + flowlist);
		return flowlist;
	}

	// delect or update
	public int flowbut(String userid, String btntext, String nick) throws SQLException {
		System.out.println("flowbut start");
		String sql = "";
		int success = 0;
		System.out.println("useriddao:" + userid);
		System.out.println("btntext:" + btntext);

		System.out.println("ninkdao:" + nick);
		String wordplus = "+팔로우";
		String wordminus = "-팔로우";

		System.out.println("btntext.equals(wordplus) : " + btntext.equals(wordplus));
		System.out.println("btntext.equals(wordminus) : " + btntext.equals(wordminus));

		if (btntext.equals(wordplus)) {// 나를 팔로잉 한사람 팔로워 추가
			System.out.println("+팔로잉 실행");
			sql = "insert into follow VALUES ((select u_id from userinfo where u_nname = ?),?,sysdate)";

			System.out.println("useriddao:" + userid);
			System.out.println("ninkdao:" + nick);

			ps = conn.prepareStatement(sql);
			ps.setString(1, nick);
			ps.setString(2, userid);
			success = ps.executeUpdate();
			// 팔로우 알람 보내기
			if (success > 0) {
				String u_id = nickToId(nick);
				AlarmDAO Adao = new AlarmDAO();
				PointDAO Pdao = new PointDAO();
				String u_nname = Pdao.getNname(userid);
				Adao.insertAlarm(u_id, "A003", u_nname + "님이 팔로우하였습니다.", "N", "./myPage?" + userid);
				Adao.resClose();
				Pdao.resClose();
			}

		} else if (btntext.equals(wordminus)) {// 내가 팔로잉 한사람 팔로워 취소
			System.out.println("-팔로잉 실행");
			sql = "DELETE FROM follow WHERE f_sendid = ?  and f_receiveid = (select u_id from userinfo where u_nname = ?)";

			System.out.println("ninkdao:" + nick);
			System.out.println("useriddao:" + userid);

			ps = conn.prepareStatement(sql);
			ps.setString(1, userid);
			ps.setString(2, nick);
			success = ps.executeUpdate();

		}
		System.out.println("flowbut end");
		return success;
	}

	// 구매요청
	public ArrayList<GGDto> reqlist(String userid, int reqindex) throws SQLException {
		String sql = "";
		String sid;
		String rid;

		ArrayList<GGDto> reqlist = new ArrayList<GGDto>();

		System.out.println("reqlist:" + reqlist);
		System.out.println("daouserID:" + userid);

		if (reqindex == 0) {// 전체
			sql = "select u.u_id,s.S_saler,p.P_no,r.rq_no,p.p_title,r.RQ_id,r.rq_tm,r.rq_yn from userinfo u,post p,sale s,N_sale ns,request r where  u.u_id = p.p_id and p.p_no = s.p_no and s.p_no = ns.p_no and p.p_no = ns.p_no and r.p_no = ns.p_no and r.p_no = s.p_no and r.p_no = p.p_no and (  s.s_saler = ? or r.rq_id = ? ) and r.rq_yn is null";
			ps = conn.prepareStatement(sql);
			ps.setString(1, userid);
			ps.setString(2, userid);
		} else if (reqindex == 1) {// 수신만
			sql = "select u.u_id,s.S_saler,p.P_no,r.rq_no,p.p_title,r.RQ_id,r.rq_tm,r.rq_yn from userinfo u,post p,sale s,N_sale ns,request r where  u.u_id = p.p_id and p.p_no = s.p_no and s.p_no = ns.p_no and p.p_no = ns.p_no and r.p_no = ns.p_no and r.p_no = s.p_no and r.p_no = p.p_no and  s.s_saler = ? and r.rq_yn is null";
			ps = conn.prepareStatement(sql);
			ps.setString(1, userid);
		} else if (reqindex == 2) {// 발신만
			sql = "select u.u_id,s.S_saler,p.P_no,r.rq_no,p.p_title,r.RQ_id,r.rq_tm,r.rq_yn from userinfo u,post p,sale s,N_sale ns,request r where  u.u_id = p.p_id and p.p_no = s.p_no and s.p_no = ns.p_no and p.p_no = ns.p_no and r.p_no = ns.p_no and r.p_no = s.p_no and r.p_no = p.p_no and r.rq_id = ? and r.rq_yn is null";
			ps = conn.prepareStatement(sql);
			ps.setString(1, userid);
		}

		rs = ps.executeQuery();
		System.out.println("rs:" + rs);
		while (rs.next()) {
			GGDto dto = new GGDto();
			dto.setU_id(rs.getString("u_id"));
			dto.setS_saler(rs.getString("S_saler"));
			dto.setP_no(rs.getInt("P_no"));
			dto.setRq_no(rs.getInt("rq_no"));
			dto.setP_title(rs.getString("p_title"));
			dto.setRq_id(rs.getString("rq_id"));
			dto.setRq_tm(rs.getDate("rq_tm"));

			sid = dto.getS_saler();
			rid = dto.getRq_id();

			if (userid.equals(sid)) {
				System.out.println("수신");
				dto.setSered("수신");
				dto.setButtonORtext("<div class='buttonarea'><button value =" + dto.getRq_no()
						+ ">수락</button><button value =" + dto.getRq_no() + ">거절</button></div>");
			} else if (userid.equals(rid)) {
				System.out.println("발신");
				dto.setSered("발신");
				dto.setButtonORtext("<div>대기중</div>");

			}

			reqlist.add(dto);
		}
		System.out.println("reqlist:" + reqlist);
		return reqlist;
	}

	// 좋아요
	public ArrayList<GGDto> lovelist(String userid, int index1, int index2) throws SQLException {
		String sql = "";
		if (index1 == 0) {// 판매
			if (index2 == 0) {
				sql = "SELECT  DISTINCT p.p_id,P.P_NO, P.P_TITLE,i.i_newname, P.P_TM, P.P_LIKECOUNT, p.p_code,l.l_id,n.ns_pr,c.c_name from post p, n_sale n, love l,img i,codes c where p.p_no = n.p_no and p.p_no = l.p_no and p.p_no = i.p_no and p.p_id != l.l_id and l.l_id = ? and p.p_code = 'P002' and p.p_code = c.c_code order BY p.p_tm DESC";
			} else if (index2 == 1) {
				sql = "SELECT  DISTINCT p.p_id,P.P_NO, P.P_TITLE,i.i_newname, P.P_TM, P.P_LIKECOUNT, p.p_code,l.l_id,n.ns_pr,c.c_name from post p, n_sale n, love l,img i,codes c where p.p_no = n.p_no and p.p_no = l.p_no and p.p_no = i.p_no and p.p_id != l.l_id and l.l_id = ? and p.p_code = 'P002'and p.p_code = c.c_code order BY p.P_likeCount DESC";
			}
		} else if (index1 == 1) {// 경매
			if (index2 == 0) {
				sql = "SELECT  DISTINCT p.p_id,P.P_NO, P.P_TITLE,i.i_newname,P.P_TM, P.P_LIKECOUNT, p.p_code,l.l_id,a.au_instantpr,c.c_name from post p, auction a, love l ,img i,codes c where  p.p_no = a.p_no and p.p_no = l.p_no and p.p_no = i.p_no and p.p_id != l.l_id and l.l_id = ? and p.p_code = 'P001' and p.p_code = c.c_code order BY p.p_tm DESC";
			} else if (index2 == 1) {
				sql = "SELECT  DISTINCT p.p_id,P.P_NO, P.P_TITLE,i.i_newname,P.P_TM, P.P_LIKECOUNT, p.p_code,l.l_id,a.au_instantpr,c.c_name from post p, auction a, love l ,img i,codes c where  p.p_no = a.p_no and p.p_no = l.p_no and p.p_no = i.p_no and p.p_id != l.l_id and l.l_id = ? and p.p_code = 'P001' and p.p_code = c.c_code order BY p.P_likeCount DESC";
			}

		}
		// System.out.println("success love");

		ArrayList<GGDto> lovelist = new ArrayList<GGDto>();

		System.out.println("lovelist:" + lovelist);

		ps = conn.prepareStatement(sql);

		System.out.println("daouserID:" + userid);

		ps.setString(1, userid);
		rs = ps.executeQuery();
		System.out.println("rs:" + rs);

		while (rs.next()) {
			GGDto dto = new GGDto();
			dto.setP_no(rs.getInt("P_no"));
			dto.setP_title(rs.getString("P_title"));
			dto.setP_tm(rs.getDate("p_tm"));
			dto.setP_likeCount(rs.getInt("p_likecount"));
			dto.setI_newName(rs.getString("I_newName"));
			dto.setP_code(rs.getString("p_code"));

			String code = dto.getP_code();

			System.out.println("code:" + code);

			if (code.equals("P001")) {
				dto.setAu_instantPr(rs.getInt("au_instantpr"));
				dto.setC_name(rs.getString("c_name"));
			} else if (code.equals("P002")) {
				dto.setNs_pr(rs.getInt("ns_pr"));
				dto.setC_name(rs.getString("c_name"));
			}

			lovelist.add(dto);
		}

		System.out.println("lovelist:" + lovelist);
		return lovelist;
	}

	public ArrayList<GGDto> reportlist(String userid) throws SQLException {

		String sql = "select n.N_sendId,n1.N1_name,n.N_content,hn.HN_adminId,hn.HN_tm,c.C_name from notify n,his_notify hn,n1_code n1,codes c where n.n_no = hn.n_no and n1.n1_code = n.n1_code and c.c_code = hn.hn_code and n.n_receiveid = ?";

		ArrayList<GGDto> reportlist = new ArrayList<GGDto>();
		System.out.println("reportlist:" + reportlist);
		ps = conn.prepareStatement(sql);
		ps.setString(1, userid);
		rs = ps.executeQuery();
		System.out.println("rs:" + rs);

		while (rs.next()) {
			GGDto dto = new GGDto();
			dto.setN_sendId(rs.getString("N_sendId"));
			dto.setN1_name(rs.getString("N1_name"));
			dto.setN_content(rs.getString("N_content"));
			dto.setHn_adminid(rs.getString("HN_adminId"));
			dto.setHn_tm(rs.getString("HN_tm"));
			dto.setC_name(rs.getString("C_name"));
			reportlist.add(dto);
		}

		System.out.println("reportlist:" + reportlist);
		return reportlist;
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
			if (checker == 1) {
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

				if (checker == 2) {
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
				if (checker == 3) {
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

		// 공지사항
		if (dto.getU_adminYN().equals("Y")) {
			String sql = "INSERT INTO post(p_no,p_id,p_title,p_content,p_TM,p_view,p_likecount,p_blindYN,p_code) VALUES(p_no_seq.NEXTVAL,?,?,?,SYSDATE,0,0,?,?)";
			ps = conn.prepareStatement(sql, new String[] { "p_no" });
			ps.setString(1, dto.getP_id());
			ps.setString(2, dto.getP_title());
			ps.setString(3, dto.getP_content());
			ps.setString(4, "N");
			ps.setString(5, dto.getP_code());
			checker = ps.executeUpdate();
			rs = ps.getGeneratedKeys();
			if (checker > 0) {
				rs.next();
				success = true;
				p_no = rs.getInt(1);
				System.out.println("글 작성 번호 : " + p_no);
				System.out.println("글 작성 성공 여부 :" + success);
			}
		} else { // 커뮤니티
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
				System.out.println("글 작성 성공 여부 :" + success);
			}
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
			if (checker > 0) {
				success = true;
				System.out.println("게시글 테이블 진입 여부 : " + success);
			}
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

			if (checker == 2) {
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
			if (checker == 3) {
				success = true;
				System.out.println("경매 테이블 작성 성공: " + success);
				System.out.println("경매글 작성 번호 : " + p_no);
				System.out.println("경매글 작성 성공");
			}
		}

		return p_no;
	}

	public GGDto auctionDetail(int p_no) throws SQLException {

		// 경매 상세보기(경매 히스토리 테이블 제외)
		String sql = "select p.p_no, p.p_id, p.p_title, p.p_content, p.p_view, p.p_likeCount, p.p_blindYN, p.p_code,(select c_name from codes where c_code = p.p_code) as p_name ,(select u.u_nname from userinfo u where u.u_id = p_id) as u_nname,(select u.u_addr from userinfo u where u.u_id= p_id) as u_addr, s.s_deliveryyn, s.s_followlimyn, s.s_code,(select c_name from codes where c_code=s.s_code) as s_name ,a.au_code ,(select c.c_name from codes c where c.c_code = a.au_code) as au_c_name, a.au_startpr,a.au_instantpr,a.au_starttm,a.au_endtm ,a.au_count, i.i_newname from post p, sale s, auction a, img i where p.p_no=s.p_no and p.p_no= i.p_no and s.p_no = a.p_no and p.p_no=?";

		GGDto dto = new GGDto();
		ps = conn.prepareStatement(sql);
		ps.setInt(1, p_no);
		rs = ps.executeQuery();

		if (rs.next()) {
			dto.setP_no(rs.getInt("p_no")); // 글번호
			dto.setP_id(rs.getString("p_id")); // 글작성자
			dto.setP_title(rs.getString("p_title")); // 글제목
			dto.setP_content(rs.getString("p_content")); // 글내용
			dto.setP_view(rs.getInt("p_view")); // 조회수
			dto.setP_likeCount(rs.getInt("p_likeCount")); // 좋아요수
			dto.setP_blindYN(rs.getString("p_blindYN")); // 블라인드 여부
			dto.setP_code(rs.getString("p_code")); // 게시글 카테고리

			dto.setP_name(rs.getString("p_name"));

			dto.setU_nname(rs.getString("u_nname"));// 판매자 닉네임
			dto.setU_addr(rs.getString(("u_addr"))); // 간편주소
			dto.setS_DeliveryYN(rs.getString("s_deliveryyn")); // 택배여부
			dto.setS_followLimYN(rs.getString("s_followlimyn")); // 팔로워한정판매여부
			dto.setS_code(rs.getString("s_code")); // 판매, 경매 카테고리

			dto.setS_name(rs.getString("s_name"));// 판매,경매 카테고리(한글)

			dto.setAu_code(rs.getString("au_code")); // 경매상태(코드)
			dto.setC_name(rs.getString("au_c_name")); // 경매상태(한글)
			dto.setAu_startPr(rs.getInt("au_startpr")); // 경매 시작 가격
			dto.setAu_instantPr(rs.getInt("au_instantpr")); // 경매 즉결 가격
			dto.setAu_startTm(rs.getDate("au_starttm")); // 경매 시작 시간
			dto.setAu_endTm(rs.getDate("au_endtm")); // 경매 종료 시간
			dto.setAu_count(rs.getInt("au_count")); // 입찰횟수
			// dto.setHa_bidPr(rs.getInt("ha_bidpr"));
			// dto.setHa_bidUsr(rs.getString("ha_bidusr"));
			dto.setI_newName(rs.getString("i_newname")); // 사진명

			System.out.println(dto.getAu_count());
			System.out.println(rs.getString("i_newname"));
			System.out.println(dto.getP_title());
			System.out.println(dto.getU_addr());
			System.out.println("경매 상태: " + dto.getAu_code());
			System.out.println(dto.getP_code());
			System.out.println(dto.getAu_endTm());
		}

		// 경매 상세보기 (히스토리 테이블)
		sql = "SELECT (select u_nname from userinfo where u_id = ha_bidusr) u_nname, haum.toppr toppr FROM his_auction hau, (SELECT P_NO, MAX(HA_BIDPR) TOPPR FROM HIS_AUCTION GROUP BY P_NO) haum WHERE hau.p_no = haum.p_no and hau.ha_bidpr = haum.toppr and hau.p_no=?";

		ps = conn.prepareStatement(sql);
		ps.setInt(1, p_no);
		rs = ps.executeQuery();
		if (rs.next()) {// 입찰기록이 있을 경우
			dto.setHa_bidPr(rs.getInt("toppr")); // 최고 입찰가
			dto.setHa_bidUsr(rs.getString("u_nname"));// 최고 입찰자
		} else {// 입찰기록이 없을 경우
			dto.setHa_bidPr(0);
			dto.setHa_bidUsr("-");
		}

		return dto;

	}

	public GGDto commDetail(String p_no) {
		String sql = "SELECT u.u_nname,u.u_newName,p.p_no,p_title,p.p_content,p.p_tm,p.p_view,i.i_newname,c_name,u_id,p_cate FROM "
				+ "    UserInfo u INNER JOIN Post p ON u.u_id = p.p_id"
				+ "    INNER JOIN codes c ON p.p_cate = c.c_code" + "    LEFT OUTER JOIN Img i ON p.p_no = i.p_no"
				+ "    LEFT OUTER JOIN Post_Comment pc ON p.p_no = pc.p_no"
				+ "    WHERE p.p_code = 'P004' AND p.p_blindyn = 'N' AND p.p_no=?";

		GGDto dto = new GGDto();
		try {
			ps = conn.prepareStatement(sql);
			ps.setString(1, p_no);
			rs = ps.executeQuery();
			if (rs.next()) {
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
				dto.setP_cate(rs.getString("p_cate"));
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		System.out.println("dto:" + dto);
		return dto;
	}

	public GGDto noticeDetail(String p_no) {
		String sql = "SELECT u.u_nname,u.u_newName,p.p_no,p_title,p.p_content,p.p_tm,p.p_view,i.i_newname,u_id FROM UserInfo u "
				+ "INNER JOIN Post p ON u.u_id = p.p_id LEFT OUTER JOIN Img i ON p.p_no = i.p_no WHERE p.p_code = 'P003' AND p.p_blindyn = 'N' AND p.p_no=?";

		GGDto dto = new GGDto();
		try {
			ps = conn.prepareStatement(sql);
			ps.setString(1, p_no);
			rs = ps.executeQuery();
			if (rs.next()) {

				dto.setU_nname(rs.getString("u_nname"));
				System.out.println("공지사항 u_nname : " + dto.getU_nname());
				dto.setU_newName(rs.getString("u_newName"));
				System.out.println("공지사항 u_newName : " + dto.getU_newName());
				dto.setP_no(rs.getInt("p_no"));
				System.out.println("공지사항 p_no : " + dto.getP_no());
				dto.setP_title(rs.getString("p_title"));
				System.out.println("공지사항 p_title : " + dto.getP_title());
				dto.setP_content(rs.getString("p_content"));
				System.out.println("공지사항 p_content : " + dto.getP_content());
				dto.setP_tm(rs.getDate("p_tm"));
				System.out.println("공지사항 p_tm : " + dto.getP_tm());
				dto.setP_view(rs.getInt("p_view"));
				System.out.println("공지사항 p_view : " + dto.getP_view());
				dto.setI_newName(rs.getString("i_newName"));
				System.out.println("공지사항 i_newName : " + dto.getI_newName());
				dto.setU_id(rs.getString("u_id"));
				System.out.println("공지사항  u_id : " + dto.getU_id());
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		System.out.println("공지사항 dto:" + dto);
		return dto;
	}

	/* 글 수정 */
	public int commUpdate(int p_no, String title, String content, String category, String deliveryYN, String price,
			String followLimYN, String instantPr, String startPr, String startTm, String endTm) {

		System.out.println("테스트 category" + category);
		int sucP_no = 0;
		String sql = "";

		/* ==== 판매글 수정 ==== */
		if (price != null) {
			// post 테이블 업데이트
			sql = "UPDATE post SET p_title=?, p_content=? WHERE p_no=?";
			try {
				ps = conn.prepareStatement(sql);
				ps.setString(1, title);
				ps.setString(2, content);
				ps.setInt(3, p_no);
				int success = ps.executeUpdate();
				if (success > 0) {
					sucP_no = p_no;
					System.out.println("post테이블 업데이트 성공");
				}
			} catch (SQLException e) {
				e.printStackTrace();
			}

			// sale 테이블 업데이트
			sql = "UPDATE sale SET s_code=?, s_deliveryyn=?, s_followlimyn=? WHERE p_no=?";
			try {
				ps = conn.prepareStatement(sql);
				ps.setString(1, category);
				ps.setString(2, deliveryYN);
				ps.setString(3, followLimYN);
				ps.setInt(4, p_no);
				int success = ps.executeUpdate();
				if (success > 0) {
					sucP_no = p_no;
					System.out.println("sale테이블 업데이트 성공");
				}
			} catch (SQLException e) {
				e.printStackTrace();
			}

			// n_sale 테이블 업데이트
			sql = "UPDATE n_sale SET ns_pr=? WHERE p_no=?";
			try {
				ps = conn.prepareStatement(sql);
				ps.setString(1, price);
				ps.setInt(2, p_no);
				int success = ps.executeUpdate();
				if (success > 0) {
					sucP_no = p_no;
					System.out.println("n_sale 테이블 업데이트 성공");
				}
			} catch (SQLException e) {
				e.printStackTrace();
			}

			/* ==== 경매글 수정 ==== */
		} else if (startPr != null) {
			// post 테이블 업데이트
			sql = "UPDATE post SET p_title=?, p_content=? WHERE p_no=?";
			try {
				ps = conn.prepareStatement(sql);
				ps.setString(1, title);
				ps.setString(2, content);
				ps.setInt(3, p_no);
				int success = ps.executeUpdate();
				if (success > 0) {
					sucP_no = p_no;
					System.out.println("post테이블 업데이트 성공");
				}
			} catch (SQLException e) {
				e.printStackTrace();
			}

			// sale 테이블 업데이트
			sql = "UPDATE sale SET s_code=?, s_deliveryyn=?, s_followlimyn=? WHERE p_no=?";
			try {
				ps = conn.prepareStatement(sql);
				ps.setString(1, category);
				ps.setString(2, deliveryYN);
				ps.setString(3, followLimYN);
				ps.setInt(4, p_no);
				int success = ps.executeUpdate();
				if (success > 0) {
					sucP_no = p_no;
					System.out.println("sale테이블 업데이트 성공");
				}
			} catch (SQLException e) {
				e.printStackTrace();
			}

			// auction 테이블 업데이트
			sql = "UPDATE auction SET au_startTm=?, au_endTm=?, au_startPr=?, au_instantPr=? WHERE p_no=?";
			try {
				ps = conn.prepareStatement(sql);
				ps.setString(1, startTm);
				ps.setString(2, endTm);
				ps.setString(3, startPr);
				ps.setString(4, instantPr);
				ps.setInt(5, p_no);
				int success = ps.executeUpdate();
				if (success > 0) {
					sucP_no = p_no;
					System.out.println("auction 테이블 업데이트 성공");
				}
			} catch (SQLException e) {
				e.printStackTrace();
			}

			/* ==== 커뮤니티 글 수정 ==== */
		} else {
			sql = "UPDATE post SET p_title=?, p_content=?, p_cate=? WHERE p_no=?";

			try {
				ps = conn.prepareStatement(sql);
				ps.setString(1, title);
				ps.setString(2, content);
				ps.setString(3, category);
				ps.setInt(4, p_no);
				int success = ps.executeUpdate();
				if (success > 0) {
					sucP_no = p_no;
				}
			} catch (SQLException e) {
				e.printStackTrace();
			}

		}
		return sucP_no;

	}

///////////////////////////////////////////////////////

	public ArrayList<GGDto> auction_main_list(String auctionmainlistwhatadd, int auctionmainlisthowaline)
			throws SQLException {// 경매목록
		String sql = "";

		if (auctionmainlisthowaline == 0) {// 신규등록 순
			sql = "SELECT DISTINCT P.P_NO, P.P_ID, P.P_TITLE, a.au_endTm, H.HA_BIDUSR,a.au_count ,HM.TOPPR,I.I_NEWNAME,A.Au_startPr,A.Au_instantPr,P.P_TM,c.c_name FROM POST P, AUCTION A,IMG I,HIS_AUCTION H,codes c,(SELECT P_NO, MAX(HA_BIDPR) TOPPR FROM HIS_AUCTION GROUP BY P_NO) HM WHERE P.P_NO = A.P_NO AND A.P_NO = HM.P_NO AND HM.P_NO = H.P_NO AND a.p_no = i.p_no AND H.HA_BIDPR = HM.TOPPR and p.p_code ='P001' and c.c_name = ? order by p.p_tm desc";
		} else if (auctionmainlisthowaline == 1) {// 마감 임박순
			sql = "SELECT DISTINCT P.P_NO, P.P_ID, P.P_TITLE, a.au_endTm, H.HA_BIDUSR,a.au_count ,HM.TOPPR,I.I_NEWNAME,A.Au_startPr,A.Au_instantPr,P.P_TM,c.c_name FROM POST P, AUCTION A,IMG I,HIS_AUCTION H,codes c,(SELECT P_NO, MAX(HA_BIDPR) TOPPR FROM HIS_AUCTION GROUP BY P_NO) HM WHERE P.P_NO = A.P_NO AND A.P_NO = HM.P_NO AND HM.P_NO = H.P_NO AND a.p_no = i.p_no AND H.HA_BIDPR = HM.TOPPR and p.p_code ='P001' and c.c_name = ? order by a.au_endTm desc";
		}

		ArrayList<GGDto> auctionmainlist = new ArrayList<GGDto>();

		System.out.println("DAOauctionmainlist:" + auctionmainlistwhatadd);
		System.out.println("DAOauctionmainlist:" + auctionmainlisthowaline);

		ps = conn.prepareStatement(sql);

		ps.setString(1, auctionmainlistwhatadd);

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
			auctionmainlist.add(dto);
		}
		System.out.println("auctionmainlist:" + auctionmainlist);
		return auctionmainlist;

	}

	public ArrayList<GGDto> sold_main_list(String soldmainlistwhatadd) throws SQLException {
		String sql = "";

		sql = "SELECT P.P_NO, P.P_ID, P.P_TITLE, P.P_CONTENT, P.P_TM, P.P_VIEW, P.P_LIKECOUNT, P.P_BLINDYN, (SELECT C_NAME FROM CODES WHERE C_CODE = P.P_CODE) AS P_NAME, S.S_DELIVERYYN, S.S_FOLLOWLIMYN, (SELECT C_NAME FROM CODES WHERE C_CODE = S.S_CODE) AS S_NAME, N.NS_PR, (SELECT C_NAME FROM CODES WHERE C_CODE = N.NS_CODE) AS NS_NAME, I.I_NEWNAME, LPAD((SELECT U_ADDR FROM USERINFO WHERE U_ID = P.P_ID), 20, ' ') AS U_ADDR FROM POST P, SALE S, N_SALE N, IMG I,codes c WHERE P.P_NO=S.P_NO AND S.P_NO=N.P_NO AND N.P_NO=I.P_NO  and p.p_code = 'P002' and c.c_code = s.s_code and c.c_name = ?";

		ArrayList<GGDto> soldmainlist = new ArrayList<GGDto>();

		System.out.println("DAOsoldmainlist:" + soldmainlistwhatadd);

		ps = conn.prepareStatement(sql);

		ps.setString(1, soldmainlistwhatadd);

		rs = ps.executeQuery();
		System.out.println("rs:" + rs);

		while (rs.next()) {
			GGDto dto = new GGDto();
			dto.setP_no(rs.getInt("P_no"));
			dto.setP_title(rs.getString("P_title"));
			dto.setP_tm(rs.getDate("p_tm"));
			dto.setP_likeCount(rs.getInt("p_likecount"));
			dto.setNs_pr(rs.getInt("NS_pr"));
			dto.setI_newName(rs.getString("I_newName"));
			soldmainlist.add(dto);
		}
		System.out.println("soldmainlist:" + soldmainlist);
		return soldmainlist;

	}

	public ArrayList<GGDto> commList(String[] categorys) {

		String sql = "SELECT * FROM post p INNER JOIN codes c ON p.p_cate = c.c_code "
				+ "INNER JOIN userinfo u on p.p_id = u.u_id " + "LEFT OUTER JOIN love l ON p.p_no = l.p_no "
				+ "LEFT OUTER JOIN img i ON p.p_no = i.p_no "
				+ "WHERE p.p_code = 'P004' AND p.p_blindyn = 'N' AND p.p_cate = ?";
		ArrayList<GGDto> list = new ArrayList<GGDto>();
		GGDto dto = null;

		try {
			ps = conn.prepareStatement(sql);
			for (String a : categorys) {
				ps.setString(1, a);
				rs = ps.executeQuery();
				while (rs.next()) {
					dto = new GGDto();
					dto.setC_name(rs.getString("c_name"));
					dto.setP_title(rs.getString("p_title"));
					dto.setU_id(rs.getString("p_id"));
					dto.setU_nname(rs.getString("u_nname"));
					dto.setP_tm(rs.getDate("p_tm"));
					dto.setP_view(rs.getInt("p_view"));
					dto.setP_likeCount(rs.getInt("p_likecount"));
					dto.setP_no(rs.getInt("p_no"));
					list.add(dto);
				}
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			resClose();
		}
		System.out.println(list.size());
		return list;

	}

	public String details(int p_no, String id) throws SQLException {
		String code = "";

		String sql = "SELECT p_code FROM post WHERE p_no=?";
		ps = conn.prepareStatement(sql);
		ps.setInt(1, p_no);

		rs = ps.executeQuery();
		if (rs.next()) {
			code = rs.getString(1);
		}

		return code;
	}

	public boolean postDel(String p_no) {
		String sql = "UPDATE post SET p_blindyn = 'Y' WHERE p_no=?";
		boolean success = false;
		try {
			ps = conn.prepareStatement(sql);
			ps.setString(1, p_no);
			if (ps.executeUpdate() > 0) {
				success = true;
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}finally {
			resClose();
		}
		return success;
	}

	public ArrayList<GGDto> noticeList(int paging, int currPageNum) {

		String sql = "SELECT rnum,p_no, p_title, p_id, p_tm, p_view, p_code, (select u_nname from userinfo where u_id = p_id) as u_nname FROM "
				+ "(SELECT ROW_NUMBER() OVER(ORDER BY p_no DESC) AS rnum,p_no, p_title, p_id, p_tm, p_view, p_code FROM post WHERE p_code='P003' AND P_BLINDYN='N') WHERE rnum BETWEEN ? AND ? ";

		ArrayList<GGDto> noticeList = null;
		GGDto dto = null;
		int pageNumCnt = 5; // 보여주는 개시글 목록의 수
		int currPageStart = (currPageNum - 1) * 5 + 1;
		if (currPageStart > paging) {
			paging = currPageStart;
		}
		int currPageEnd = currPageNum * pageNumCnt;
		int pagePerCnt = 15; // 한페이지에 들어가는 개시글의 수
		int end = paging * pagePerCnt;
		int start = (end - pagePerCnt) + 1;

		try {
			ps = conn.prepareStatement(sql);
			ps.setInt(1, start);
			ps.setInt(2, end);
			rs = ps.executeQuery();
			noticeList = new ArrayList<GGDto>();
			while (rs.next()) {
				dto = new GGDto();
				dto.setP_no(rs.getInt("p_no"));
				dto.setP_title(rs.getString("p_title"));
				dto.setP_id(rs.getString("p_id"));
				dto.setP_tm(rs.getDate("p_tm"));
				dto.setP_view(rs.getInt("p_view"));
				dto.setU_nname(rs.getString("u_nname"));
				noticeList.add(dto);
			}

			int total = noticeCount();
			noticeList.get(0).setTotalPost(total);
			noticeList.get(0).setCurrPage(paging);
			int pages = (int) Math.ceil((double) total / (double) pagePerCnt);
			if (pages < currPageEnd) {
				currPageNum = (int) Math.ceil((double) pages / (double) pageNumCnt);
				currPageStart = (currPageNum - 1) * 5 + 1;
				currPageEnd = pages;
			}
			noticeList.get(0).setTotalPage(pages);
			noticeList.get(0).setCurrPageNum(currPageNum);
			noticeList.get(0).setCurrPageStart(currPageStart);
			noticeList.get(0).setCurrPageEnd(currPageEnd);
		} catch (SQLException e) {
			e.printStackTrace();
		}

		return noticeList;
	}

	public int noticeCount() throws SQLException {

		String sql = "SELECT COUNT(p_no) FROM post where p_code='P003'";
		ps = conn.prepareStatement(sql);
		rs = ps.executeQuery();

		int total = 0;

		if (rs.next()) {
			total = rs.getInt(1); // 받아온 컬럼이 어차피 한개니까 1을 넣어도된다.
			System.out.println("total : " + total);
		}

		return total;
	}
	// 메서드 통합으로 인하여 주석처리
	/*
	 * public String auctionDelete(int p_no) throws SQLException {
	 * 
	 * //경매글 삭제의 경우 //post 테이블 블라인드 여부 Y로 바꾸고 //auctionDetail 불러올시 블라인드여부가 Y이면서
	 * session loginId 값이 p_id와 같으면(=판매자 본인) 보여지게하고 //같지 않으면 보여지지 않게 한다. String
	 * delMsg = "경매글 삭제 실패";
	 * 
	 * String sql = "update post set p_blindyn = 'Y' where p_no=?";
	 * 
	 * ps = conn.prepareStatement(sql); ps.setInt(1, p_no); int success =
	 * ps.executeUpdate(); System.out.println("경매글 삭제 성공여부(블라인드 처리 여부) : "+success);
	 * 
	 * if(success>0) { delMsg = "경매글 삭제 성공"; }
	 * 
	 * return delMsg;
	 * 
	 * 
	 * }
	 */

	public String getTitle(int p_no) throws SQLException {
		String p_title = null;
		String sql = "select p_title from post where p_no=?";
		ps = conn.prepareStatement(sql);
		ps.setInt(1, p_no);

		rs = ps.executeQuery();

		if (rs.next()) {
			p_title = rs.getString("p_title");
		}

		return p_title;

	}

	public void updatereqlist(int rqno) {
		System.out.println("DAO loveCountMinus");
		String sql = "UPDATE request SET rq_yn = 'Y' WHERE RQ_NO = ?";
		int success = 0;
		try {
			ps = conn.prepareStatement(sql);
			ps.setInt(1, rqno);
			success = ps.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		}
		System.out.println("update_succes:" + success);
		resClose();
	}

	public GGDto urllist(String rqno) {
		String sql = "select r.rq_no,p.p_no,r.rq_id,r.rq_yn from request r,post p where  r.RQ_NO = ? and p.p_no = r.p_no ";
		GGDto dto = null;

		try {
			ps = conn.prepareStatement(sql);
			ps.setString(1, rqno);
			rs = ps.executeQuery();

			if (rs.next()) {
				dto = new GGDto();
				dto.setRq_no(rs.getInt("rq_no"));
				dto.setP_no(rs.getInt("p_no"));
				dto.setRq_id(rs.getString("rq_id"));
				dto.setRq_YN(rs.getString("rq_yn"));
			}

			System.out.println("rq_no:" + dto.getRq_no());
			System.out.println("p_no:" + dto.getP_no());
			System.out.println("rq_id:" + dto.getRq_id());
			System.out.println("rq_yn:" + dto.getRq_YN());

		} catch (SQLException e) {
			e.printStackTrace();
		}

		return dto;
	}

	public String nickToId(String u_nname) {
		String u_id = null;
		String sql = "select u_id from userinfo where u_nname = ?";
		try {
			ps = conn.prepareStatement(sql);
			ps.setString(1, u_nname);
			rs = ps.executeQuery();
			if (rs.next()) {
				u_id = rs.getString("u_id");
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

		return u_id;

	}

	

}
