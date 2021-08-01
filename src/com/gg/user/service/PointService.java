package com.gg.user.service;


import java.sql.SQLException;

import javax.servlet.http.HttpServletRequest;

import com.gg.user.dao.PointDAO;

public class PointService {
	
	HttpServletRequest req = null;
	
	public PointService(HttpServletRequest req) {
		this.req = req;
	}

	public int pointPop() {
		System.out.println("팝업 정보 서비스 진입");
		int myPoint = 0;
		String id = req.getParameter("id");
		System.out.println("아이디 : " + id);
		PointDAO dao = new PointDAO();
		try {
			myPoint = dao.pointPop(id);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}finally {
			dao.resClose();
		}
		
		
		return myPoint;
	}

	public boolean charge(int chargePoint, String id) {
		System.out.println("포인트 충전 서비스 진입 : " + chargePoint);
		System.out.println("포인트 충전 서비스 진입 : " + id);
		PointDAO dao = new PointDAO();
		boolean success = false;
		try {
			success = dao.chargePoint(chargePoint,id);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}finally {
			dao.resClose();
		}
		
		
		return success;
	}
	
	
	

}
