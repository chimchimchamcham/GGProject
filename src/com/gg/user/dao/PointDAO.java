package com.gg.user.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

import com.gg.dto.GGDto;

public class PointDAO {

	public ResultSet rs = null;
	public PreparedStatement ps = null;
	public Connection conn = null;
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
	public ArrayList<GGDto> pointList(String id) throws SQLException {
		System.out.println("포인트 리스트 보여주기.");
		GGDto dto = null;
		ArrayList<GGDto> list = new ArrayList<GGDto>();
		sql = "SELECT pnt.pnt_code, pnt.pnt_point,i.i_newname, p.p_title, pnt.pnt_tm, p.p_no,pnt.pnt_id FROM point pnt " + 
				"LEFT OUTER JOIN post p " + 
				"ON (p.p_no = pnt.p_no) " + 
				"LEFT OUTER JOIN img i " + 
				"ON (p.p_no = i.p_no) " + 
				"WHERE pnt.pnt_id = ? " + 
				"ORDER BY pnt.pnt_tm DESC";
		
		ps = conn.prepareStatement(sql);
		ps.setString(1, id);
		rs = ps.executeQuery();
		while(rs.next()) {
			dto = new GGDto();
			dto.setPntcode(rs.getString("pnt_code"));
			dto.setPnt_point(rs.getInt("pnt_point"));
			dto.setI_newName(rs.getString("i_newname"));
			dto.setP_title(rs.getString("p_title"));
			dto.setPnt_tm(rs.getDate("pnt_tm"));
			dto.setP_no(rs.getInt("p_no"));
			list.add(dto);
		}
	
		return list;
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

	public boolean outPoint(int outPoint, String id) throws SQLException {
		sql = "INSERT INTO point(pnt_id,pnt_point,pnt_tm,pnt_otherid,pnt_code) VALUES(?,?,SYSDATE,'SYSTEM','PNT002')";
		boolean success = false;
		ps = conn.prepareStatement(sql);
		ps.setString(1, id);
		ps.setInt(2, outPoint);
		int checker = ps.executeUpdate();
		if (checker > 0) {
			success = true;
		}
		return success;
	}

	// 아이디, 포인트, 상대방아이디, 분류코드, 글번호를 받아서 포인트 테이블에 전송해주는 메서드
	public boolean insertPoint(String pnt_id, int pnt_point, String pnt_otherId, String pnt_code, int p_no) throws SQLException {
		sql = "INSERT INTO point(pnt_id,pnt_point,pnt_tm,pnt_otherid,pnt_code,p_no) VALUES(?,?,SYSDATE,?,?,?)";
		boolean success = false;
		ps = conn.prepareStatement(sql);
		ps.setString(1, pnt_id);
		ps.setInt(2, pnt_point);
		ps.setString(3, pnt_otherId);
		ps.setString(4, pnt_code);
		ps.setInt(5, p_no);
		
		int checker = ps.executeUpdate();
		if (checker > 0) {
			success = true;
		}

		return success;
	}

}
