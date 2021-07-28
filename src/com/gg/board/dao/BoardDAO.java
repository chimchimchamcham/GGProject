package com.gg.board.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

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
		}catch(Exception e) {
			e.printStackTrace();
		}
	}
	
	public void resClose() {
		try {
			if(rs != null && !rs.isClosed()) {rs.close();}
			if(ps != null && !ps.isClosed()) {ps.close();}
			if(conn != null && !conn.isClosed()) {conn.close();}
		}catch(Exception e) {
			e.printStackTrace();
		}
	}

	public GGDto salesDetail(int P_no) {
		GGDto dto = null;
		/*String sql = "SELECT P.P_NO, P.P_ID, P.P_TITLE, P.P_CONTENT, P.P_TM, P.P_VIEW, P.P_LIKECOUNT, P.P_BLINDYN, (SELECT C_NAME FROM CODES WHERE C_CODE = P.P_CODE) AS P_NAME,"+
			    	 "S.S_DELIVERYYN, S.S_FOLLOWLIMYN, (SELECT C_NAME FROM CODES WHERE C_CODE = S.S_CODE) AS S_NAME,"+
			    	 "N.NS_PR, (SELECT C_NAME FROM CODES WHERE C_CODE = N.NS_CODE) AS NS_NAME,"+
			    	 "I.I_NEWNAME,"+
			    	 "LPAD((SELECT U_ADDR FROM USERINFO WHERE U_ID = P.P_ID), 20, ' ') AS U_ADDR"+
			    	 "FROM POST P, SALE S, N_SALE N, IMG I WHERE P.P_NO=S.P_NO AND S.P_NO=N.P_NO AND N.P_NO=I.P_NO AND P.P_NO = ?";*/
		String sql = "SELECT P.P_NO, P.P_ID, P.P_TITLE, P.P_CONTENT, P.P_TM, P.P_VIEW, P.P_LIKECOUNT, P.P_BLINDYN, (SELECT C_NAME FROM CODES WHERE C_CODE = P.P_CODE) AS P_NAME, S.S_DELIVERYYN, S.S_FOLLOWLIMYN, (SELECT C_NAME FROM CODES WHERE C_CODE = S.S_CODE) AS S_NAME, N.NS_PR, (SELECT C_NAME FROM CODES WHERE C_CODE = N.NS_CODE) AS NS_NAME, I.I_NEWNAME, LPAD((SELECT U_ADDR FROM USERINFO WHERE U_ID = P.P_ID), 20, ' ') AS U_ADDR FROM POST P, SALE S, N_SALE N, IMG I WHERE P.P_NO=S.P_NO AND S.P_NO=N.P_NO AND N.P_NO=I.P_NO AND P.P_NO = ?";
		try {
			ps = conn.prepareStatement(sql);
			ps.setInt(1, P_no);
			rs = ps.executeQuery();
			if(rs.next()) {
				dto = new GGDto();
				dto.setP_no(rs.getInt("P_no"));
				dto.setP_id(rs.getString("P_id"));
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
				System.out.println("u_addr : "+dto.getU_addr());
			}
		}catch(Exception e) {
			e.printStackTrace();
		}
		
		return dto;
	}

	public int upP_view(int P_no) {
		String sql = "UPDATE POST SET P_VIEW = P_VIEW + 1 WHERE P_NO = ?";
		int success = 0;
		try {
			ps = conn.prepareStatement(sql);
			ps.setInt(1,P_no);
			success = ps.executeUpdate();
		}catch(Exception e) {
			e.printStackTrace();
		}
		return success;
	}

	public boolean isLiked(String u_id, int P_no) {
		String sql = "SELECT * FROM LOVE WHERE L_ID = ? AND P_NO = ?";
		boolean isLiked = false;
		try {
			ps = conn.prepareStatement(sql);
			ps.setString(1,u_id);
			ps.setInt(2,P_no);
			rs = ps.executeQuery();
			isLiked = rs.next();
		}catch(Exception e) {
			e.printStackTrace();
		}
		return isLiked;
	}

	public boolean lovePlus(String u_id, int P_no) {
		String sql = "INSERT INTO LOVE VALUES(?,?,SYSDATE)";
		boolean success = false;
		try {
			ps = conn.prepareStatement(sql);
			ps.setString(1,u_id);
			ps.setInt(2,P_no);
			rs = ps.executeQuery();
			success = rs.next();
		}catch(Exception e) {
			e.printStackTrace();
		}
		return success;

	}
	
	public boolean loveMinus(String u_id, int P_no) {
		String sql = "DELETE FROM LOVE WHERE L_ID = ? AND P_NO = ?";
		boolean success = false;
		try {
			ps = conn.prepareStatement(sql);
			ps.setString(1,u_id);
			ps.setInt(2,P_no);
			rs = ps.executeQuery();
			success = rs.next();
		}catch(Exception e) {
			e.printStackTrace();
		}
		return success;

	}
}
