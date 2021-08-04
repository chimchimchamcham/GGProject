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

	/* 기존 사진 가져오기 */
	public GGDto getFileName(int p_no) {
		GGDto dto = null;
		String sql = "SELECT i_newName FROM img WHERE p_no=?";
		try {
			ps = conn.prepareStatement(sql);
			ps.setInt(1, p_no);
			rs = ps.executeQuery();

			if (rs.next()) {
				dto = new GGDto();
				dto.setI_newName(rs.getString(1));
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}

		return dto;
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

	public int PhotoUpdate(GGDto dto) {
		int success = 0;
		if(dto.getI_newName() != null) {
			String sql = "UPDATE img SET i_newName=? WHERE p_no=?";
			try {
				ps = conn.prepareStatement(sql);
				ps.setString(1, dto.getI_newName());
				ps.setInt(2, dto.getP_no());
				success = ps.executeUpdate();
			} catch (SQLException e) {
				e.printStackTrace();
			}finally {
				resClose();
			}
			if(success>0) {
				System.out.println("글 사진 수정 성공");
			}			
		}else {
			success = 1;
		}
	      
	      return success;
		
	}

	
}
