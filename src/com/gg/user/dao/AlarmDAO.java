package com.gg.user.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

import com.gg.dto.GGDto;

public class AlarmDAO {
	
	public Connection conn = null;
	public ResultSet rs = null;
	public PreparedStatement ps = null;
	String sql = null;
	

	public AlarmDAO() {
		try {
			Context ctx = new InitialContext();
			DataSource ds = (DataSource)ctx.lookup("java:comp/env/jdbc/Oracle");
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

	public GGDto allALlst(String u_id) {
		sql = "SELECT a_no,u_id,a_code,a_sendtm,a_checktm,a_content,a_readyn,a_delyn,a_impoyn,a_path from ALARM where u_id=?";
		return null;
	}

	public GGDto impALlst(String u_id) throws SQLException {
		GGDto dto = null;
		sql = "SELECT a_no,u_id,a_code,a_sendtm,a_checktm,a_content,a_readyn,a_delyn,a_impoyn,a_path from ALARM where u_id=? and where a_impoYN='Y'";
		ps = conn.prepareStatement(sql);
		ps.setString(1, u_id);
		rs = ps.executeQuery();
		
		while(rs.next()) {
			dto = new GGDto();
			dto.setA_no(rs.getInt("a_no"));
			dto.setU_id(rs.getString("u_id"));
			dto.setA_code(rs.getString("a_code"));
			dto.setA_sendTm(rs.getDate("a_sendtm"));
			dto.setA_checkTm(rs.getDate("a_checktm"));
			dto.setA_content(rs.getString("a_content"));
		}
		
		return null;
	}
	

}
