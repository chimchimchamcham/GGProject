package com.gg.mypageList.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

import com.gg.dto.GGDto;

public class BoardDAO {

	public Connection conn = null;
	public ResultSet rs = null;
	public PreparedStatement ps = null;

	public BoardDAO() {
		try {
			Context ctx = new InitialContext();
			DataSource ds = (DataSource) ctx.lookup("java:comp/env/jdbc/Oracle");
			conn = ds.getConnection();
		} catch (Exception e) {
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

	
	
	public ArrayList<GGDto> list() throws SQLException {
		String sql = "SELECT p.p_id,p.p_no,p.p_title,p.p_likecount,p.p_tm,n.ns_pr,n.ns_code,i.i_newname,p.p_code FROM  post p,N_Sale n,img i,userinfo u WHERE p.p_no = n.p_no and p.p_no = i.p_no and p.p_code = 'P002' and (n.ns_code = 'NS_001' or n.ns_code = 'NS_003') and p.p_id = u.u_id";
		ArrayList<GGDto> list = new ArrayList<GGDto>();
		System.out.println(list);
		ps = conn.prepareStatement(sql);
		//ps.setString(1, "");
		System.out.println("ps:"+ps);
		rs = ps.executeQuery();
		System.out.println("rs:"+rs);
		
		while (rs.next()) {
			GGDto dto = new GGDto();
			dto.setP_no(rs.getInt("P_no"));
			dto.setP_title(rs.getString("P_title"));
			dto.setP_tm(rs.getDate("p_tm"));
			dto.setP_likeCount(rs.getInt("p_likecount"));
			dto.setNs_pr(rs.getInt("NS_pr"));
			dto.setI_newName("i_newName");
			dto.setNs_code("ns_code");

			list.add(dto);
		}
		return list;
	}
}
