package com.gg.user.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;

import com.gg.dto.GGDto;

public class MessageDAO {
	Connection conn;
	PreparedStatement ps;
	ResultSet rs;

	public MessageDAO() {
		try {
			Context ctx = new InitialContext();
			DataSource ds = (DataSource) ctx.lookup("java:comp/env/jdbc/Oracle");
			conn = ds.getConnection();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	public boolean sendMsg(GGDto dto) {
		boolean success = false;
		String sql = "INSERT INTO message VALUES(SYSDATE,SYSDATE,?,?,?,'N','N')";
		try {
			ps = conn.prepareStatement(sql, new String[] {"M_receiveId"});
			ps.setString(1, dto.getM_sendId());
			ps.setString(2, dto.getM_receiveId());
			ps.setString(3, dto.getM_content());
			ps.executeUpdate();
			rs = ps.getGeneratedKeys();			
			if(rs.next()) {
				sql = "SELECT U_newName FROM userinfo WHERE u_id =?";
				String pk = rs.getString(1);
				ps.setString(1, pk);
				rs = ps.executeQuery();
				if(rs.next()) {
					dto.setI_newName(rs.getString(1));
					success = true;
				}
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} 
		
		return success;
	}

}
