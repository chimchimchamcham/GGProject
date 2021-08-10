package com.gg.user.dao;

import java.sql.Connection;
import java.sql.Date;
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
		String sql = "INSERT INTO notify VALUES(n_no_seq.NEXTVAL,?,?,?,?,?,SYSDATE)";
		boolean success = false;
		System.out.println(dto.getN_sendId());
		try {
			ps = conn.prepareStatement(sql, new String[] { "N_no" });
			ps.setString(1, dto.getN_receiveId());
			ps.setString(2, dto.getN_sendId());
			ps.setString(3, dto.getN_content());
			ps.setString(4, dto.getN1_code());
			ps.setString(5, dto.getN2_code());
			if(ps.executeUpdate()>0) {
				rs = ps.getGeneratedKeys();
				if (rs.next()) {
					sql = "INSERT INTO his_notify(N_no,HN_tm,HN_code) VALUES(?,SYSDATE,'HN_001')";
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

	public void blackLstPr(GGDto dto) throws SQLException {
		String sql = "INSERT INTO blacklist(b_id,b_starttm,b_endtm,b_adminid,b_content,b_code) VALUES(?,SYSDATE,?,?,?,?)";
		
		String b_id = dto.getB_id();
		String b_code = dto.getB_code();
		Date b_endtm = dto.getB_endTm();
		String b_adminId = dto.getB_adminId();
		String b_content = dto.getB_content();
		
		ps = conn.prepareStatement(sql);
		ps.setString(1,b_id);
		ps.setDate(2, b_endtm);
		ps.setString(3, b_adminId);
		ps.setString(4, b_content);
		ps.setString(5, b_code);
		
		int success = ps.executeUpdate();
		
		System.out.println("블랙리스트 등록 갯수 : "+success);
		
		
	}
}
