package com.gg.user.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

import com.gg.dto.GGDto;

public class UserDAO {

	public Connection conn = null;
	public PreparedStatement ps = null;
	public ResultSet rs = null;
	String sql = "";

	public UserDAO() {
		try {
			Context ctx = new InitialContext();
			DataSource ds = (DataSource) ctx.lookup("java:comp/env/jdbc/Oracle");
			conn = ds.getConnection();

		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

	}

	public void resClose() {
		try {
			if (rs != null && !rs.isClosed()) {
				rs.close();
			}
			if (conn != null && !conn.isClosed()) {
				conn.close();
			}
			if (ps != null && !ps.isClosed()) {
				ps.close();
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

	public boolean idOverlay(String id) {
		boolean success = false;

		sql = "SELECT u_id FROM userInfo WHERE u_id = ?";
		try {
			ps = conn.prepareStatement(sql);
			ps.setString(1, id);
			rs = ps.executeQuery();

			success = rs.next();
		} catch (SQLException e) {

			e.printStackTrace();
		} finally {
			System.out.println("중복 여부 : " + success);
			// resClose()는 service에서 실행한다.
		}
		return success;
	}

	public boolean nNameOverlay(String nname) {
		boolean success = false;

		sql = "SELECT u_nname FROM userInfo WHERE u_nname = ?";
		try {
			ps = conn.prepareStatement(sql);
			ps.setString(1, nname);
			rs = ps.executeQuery();

			success = rs.next();
		} catch (SQLException e) {

			e.printStackTrace();
		} finally {
			System.out.println("중복 여부 : " + success);
			// resClose()는 service에서 실행한다.
		}
		return success;
	}

	public String login(String loginId, String loginPw) {
		String userId = null;
		String sql = "SELECT U_id FROM UserInfo WHERE U_id=? AND U_pw=?";
		try {
			ps = conn.prepareStatement(sql);
			ps.setString(1, loginId);
			ps.setString(2, loginPw);
			rs = ps.executeQuery();
			if(rs.next()) {
				userId = rs.getString(1);
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}finally {
			resClose();
		}
		return userId;
	}

	public boolean join(GGDto dto) throws Exception {
		
		boolean success = false;
		// u_id, u_nname,u_pw, u_email,u_name, u_addr, u_phone, u_joinTM, 
		// u_newName,U_INTRO, u_AdminYN, u_FollowYN, u_detailAddr 
		sql ="INSERT INTO userInfo VALUES(?,?,?,?,?,?,?,SYSDATE,'./img/default-profile.png','안녕하세요"+dto.getI_newName()+"입니다','N','N',?)";
		// 
		ps = conn.prepareStatement(sql);
		ps.setString(1, dto.getU_id());
		ps.setString(2, dto.getU_nname());
		ps.setString(3, dto.getU_pw());
		ps.setString(4, dto.getU_email());
		ps.setString(5, dto.getU_name());
		ps.setString(6, dto.getU_addr());
		ps.setString(7, dto.getU_phone());
		ps.setString(8, dto.getU_detailAddr());
		
		int checker = ps.executeUpdate();
		if(checker>0) {
			success =true;
		}
		
		
		return success;
	}


}
