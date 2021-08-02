package com.gg.user.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

import com.gg.dto.GGDto;

public class PointDAO {

	ResultSet rs = null;
	PreparedStatement ps = null;
	Connection conn = null;
	String sql = "";

	public PointDAO() {
		try {
			Context ctx = new InitialContext();
			DataSource ds = (DataSource) ctx.lookup("java:comp/env/jdbc/Oracle");
			conn = ds.getConnection();
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

	}

	public int pointPop(String id) throws SQLException {
		System.out.println("DB 진입");
		int myPoint = 0;
		int plusPoint = 0; // 수입
		int minusPoint = 0; // 지출
		// 지출 코드
		sql = "SELECT SUM(pnt_point) FROM point WHERE pnt_id= ?" + "    AND ( pnt_code != 'PNT001'"
				+ "    AND pnt_code != 'PNT004'" + "    AND pnt_code !='PNT005'" + "    AND pnt_code != 'PNT007'"
				+ "    AND pnt_code != 'PNT008'" + "    AND pnt_code != 'PNT010')";
		ps = conn.prepareStatement(sql);
		ps.setString(1, id);
		rs = ps.executeQuery();
		if (rs.next()) {
			minusPoint = rs.getInt(1);
		} else {
			minusPoint = 0;
		}
		// 수입 코드
		sql = "SELECT SUM(pnt_point) FROM point" + "    WHERE pnt_id=?" + "    AND ( pnt_code = 'PNT001'"
				+ "    OR pnt_code = 'PNT004'" + "    OR pnt_code = 'PNT005'" + "    OR pnt_code = 'PNT007'"
				+ "    OR pnt_code = 'PNT008'" + "    OR pnt_code = 'PNT010')";
		ps = conn.prepareStatement(sql);
		ps.setString(1, id);
		rs = ps.executeQuery();

		if (rs.next()) {
			plusPoint = rs.getInt(1);
		} else {
			plusPoint = 0;
		}
		myPoint = plusPoint - minusPoint;
		
		
		
		return myPoint;
	}

	public boolean chargePoint(int chargePoint, String id) throws SQLException {
		sql = "INSERT INTO point(pnt_id,pnt_point,pnt_tm,pnt_otherid,pnt_code) VALUES(?,?,SYSDATE,'SYSTEM','PNT001')";
		boolean success = false;
		ps = conn.prepareStatement(sql);
		ps.setString(1, id);
		ps.setInt(2, chargePoint);
		int checker = ps.executeUpdate();
		if (checker > 0) {
			success = true;
		}

		return success;
	}

	public GGDto pointList(String id) {
		sql="";

		return null;
	}

	public String getNname(String id) throws SQLException {
		String nname ="";
		// 닉네임 가져오기
		sql = "SELECT u_nname FROM userInfo WHERE u_id=?";
		ps = conn.prepareStatement(sql);
		ps.setString(1, id);
		rs = ps.executeQuery();
		
		if(rs.next()) {
			nname = rs.getString(1);
			System.out.println("nname : " + nname);
		}
		return nname;
	}
	
	public void resClose() {
		try {
			if (rs != null && !rs.isClosed()) {
				rs.close();
			}
			if (conn != null && !conn.isClosed()) {
				conn.close();
			}
			if (ps != null && !ps.isClosed()) {
				ps.close();
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

	

}
