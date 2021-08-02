package com.gg.user.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;

public class BlackListDAO {
	Connection conn;
	PreparedStatement ps;
	ResultSet rs;
	public BlackListDAO() {
		try {
			Context ctx = new InitialContext();
			DataSource ds = (DataSource)ctx.lookup("java:/comp/env/jdbc/Oracle");
			
		} catch (NamingException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

	public boolean notifyUser() {
		String sql = "INSERT INTO notify VALUES(n_no_seq.NEXTVAL(),?,?,?,?,?)";
		
		return false;
	}

}
