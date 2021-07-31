package com.gg.board.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

import com.gg.dto.GGDto;

public class UploadDAO {
	
	public Connection conn = null;
	public ResultSet rs = null;
	public PreparedStatement ps = null;


	public UploadDAO() {
		Context ctx;
		try {
			ctx = new InitialContext();
			DataSource ds = (DataSource) ctx.lookup("java:comp/env/jdbc/Oracle");
			conn = ds.getConnection();

		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	
	public void resClose() {
		try {
			if (conn != null && !conn.isClosed()) {
				conn.close();
			}
			if (rs != null && !rs.isClosed()) {
				rs.close();
			}
			if (ps != null && !ps.isClosed()) {
				ps.close();
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

	public int PhotoUpload(GGDto dto) {
		String sql = "INSERT INTO Img VALUES(?,?)";
		int success = 0;
		try {
			ps = conn.prepareStatement(sql);
			ps.setInt(1, dto.getP_no());
			ps.setString(2, dto.getI_newName());
			success = ps.executeUpdate();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}finally {
			resClose();
		}
		if(success>0) {
			System.out.println("글 쓰기 사진 업로드 성공");
		}
		return success;
		
	}

}
