package com.gg.user.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

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
			ps = conn.prepareStatement(sql);
			ps.setString(1, dto.getM_sendId());
			ps.setString(2, dto.getM_receiveId());
			ps.setString(3, dto.getM_content());
			if (ps.executeUpdate() > 0) {
				success = true;
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}

		return success;
	}

	public ArrayList<GGDto> msgList(String u_id, String rORs) {
		GGDto dto = null;
		String sql = "";
		if(rORs == null) {
			// 보낸 메세지와 받은 메세지 모두 불러오기.
			sql = "SELECT m.m_content, m.m_readtm, m.m_receivedelyn, m.m_receiveid, m.m_senddelyn, m.m_sendid, m.m_sendtm, u.u_newName, u.u_nname, u.u_id"+
				    "FROM message m INNER JOIN userinfo u ON (m.m_receiveid = u.u_id) "+
				    "WHERE m.m_sendid =? AND m.m_senddelyn = 'N' "+
				    "UNION SELECT m.m_content, m.m_readtm, m.m_receivedelyn, m.m_receiveid, m.m_senddelyn, m.m_sendid, m.m_sendtm, u.u_newName, u.u_nname, u.u_id"+
				    "FROM message m INNER JOIN userinfo u ON (m.m_sendid = u.u_id)" +
				    "WHERE m.m_receiveid =? AND m.m_receivedelyn = 'N' ORDER BY m_sendtm DESC, m_receivedelyn DESC";
			try {
				conn.prepareStatement(sql);
				ps.setString(1, u_id);
				ps.setString(2, u_id);
				rs = ps.executeQuery();
				while (rs.next()) {
					dto = new GGDto();
					dto.set
					
				}
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}else if(rORs == "s") {
			
		}
		return null;
	}

}
