package com.gg.user.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;


public class UserDAO {

	public Connection conn = null;
	public PreparedStatement ps = null;
	public ResultSet rs = null;
	String sql = "";
	
	public UserDAO() {
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
			if (rs!=null && !rs.isClosed()) { rs.close();}
			if (conn !=null && !conn.isClosed()) {conn.close();}
			if (ps !=null && !ps.isClosed()) {ps.close();}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	

}
