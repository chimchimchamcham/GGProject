package com.gg.board.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

import com.gg.dto.GGDto;

public class CommentDAO {
	public Connection conn = null;
	public ResultSet rs = null;
	public PreparedStatement ps = null;
	public CommentDAO() {
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
	
	public ArrayList<GGDto> sold_board_dao(String p_id, int p_no)throws SQLException {
		System.out.println("DAO salesDetail의 댓글들 호출");
		ArrayList<GGDto> sale_board_list = new ArrayList<GGDto>();
		
		String sql = "SELECT P.P_NO, P.P_ID, P.P_TITLE, P.P_CONTENT, P.P_TM, P.P_VIEW, P.P_LIKECOUNT, P.P_BLINDYN, (SELECT C_NAME FROM CODES WHERE C_CODE = P.P_CODE) AS P_NAME, S.S_DELIVERYYN, S.S_FOLLOWLIMYN, (SELECT C_NAME FROM CODES WHERE C_CODE = S.S_CODE) AS S_NAME, N.NS_PR, (SELECT C_NAME FROM CODES WHERE C_CODE = N.NS_CODE) AS NS_NAME, I.I_NEWNAME, LPAD((SELECT U_ADDR FROM USERINFO WHERE U_ID = P.P_ID), 20, ' ') AS U_ADDR , (SELECT U_NNAME FROM USERINFO WHERE U_ID = P_ID) AS U_NNAME FROM POST P, SALE S, N_SALE N, IMG I WHERE P.P_NO=S.P_NO AND S.P_NO=N.P_NO AND N.P_NO=I.P_NO AND P.P_NO = ?";
		try {
			ps = conn.prepareStatement(sql);
			ps.setString(1, p_id);
			ps.setInt(2, p_no);
			rs = ps.executeQuery();
			if (rs.next()) {
				GGDto dto = new GGDto();
				dto.setP_no(rs.getInt("P_no"));
				dto.setP_id(rs.getString("P_id"));
				
				
				sale_board_list.add(dto);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}

		return sale_board_list;
	}

}
