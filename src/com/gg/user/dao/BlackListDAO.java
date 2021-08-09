package com.gg.user.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;
import com.gg.dto.GGDto;

public class BlackListDAO {
	Connection conn = null;
	PreparedStatement ps = null;
	ResultSet rs = null;
	public BlackListDAO() {
		try {
			Context ctx = new InitialContext();
			DataSource ds = (DataSource)ctx.lookup("java:/comp/env/jdbc/Oracle");
			conn = ds.getConnection();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	public boolean notifyUser(GGDto dto) {
		String sql = "INSERT INTO notify VALUES(n_no_seq.NEXTVAL,?,?,?,?,?)";
		boolean success = false;
		System.out.println(dto.getN_sendId());
		try {
			ps = conn.prepareStatement(sql, new String[] { "n_no" });
			ps.setString(1, dto.getN_receiveId());
			ps.setString(2, dto.getN_sendId());
			ps.setString(3, dto.getN_content());
			ps.setString(4, dto.getN1_code());
			ps.setString(5, dto.getN2_code());
			ps.executeUpdate();
			rs = ps.getGeneratedKeys();
			if(ps.executeUpdate()>0) {
				if (rs.next()) {
					sql = "INSERT INTO his_notify(n_no,HN_tm,HN_code) VALUES(?,SYSDATE,'HN_001')";
					ps = conn.prepareStatement(sql);
					int pk = rs.getInt(1);
					ps.setInt(1, pk);
					if(ps.executeUpdate()>0) {
						success = true;
					}
				}
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}finally {
			resClose();
		}
		return success;
	}
	
	public void resClose() {
		try {
			if(conn != null && !conn.isClosed()) {conn.close();}
			if(ps != null && !ps.isClosed()) {ps.close();}
			if(rs != null && !rs.isClosed()) {rs.close();}
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}
}
