package com.gg.user.service;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;

import javax.servlet.http.HttpServletRequest;

import com.gg.dto.GGDto;
import com.gg.user.dao.AlarmDAO;

public class AlarmService {
	
	HttpServletRequest req = null;
	AlarmDAO dao = null;
	public AlarmService(HttpServletRequest req) {
		this.req = req;
	}

	public ArrayList<GGDto> ALlist() {
		String u_id = (String) req.getSession().getAttribute("loginId");
		String a_impoyn =req.getParameter("a_impoyn");
		
		System.out.println("u_id : "+u_id);
		System.out.println("a_impoyn : "+a_impoyn);
		
		ArrayList<GGDto> list = new ArrayList<GGDto>();
		dao = new AlarmDAO();
		try {
			list = dao.ALlist(u_id,a_impoyn);
		} catch (SQLException e) {
			e.printStackTrace();
		}finally {
			dao.resClose();
		}
		return list;
		
		
	}

	public void readAlarm() {
		
		boolean success = false;
		HashMap<String, Object>map = new HashMap<String,Object>();
		int a_no = Integer.parseInt(req.getParameter("a_no"));
		dao = new AlarmDAO();
		try {
			success = dao.readAlarm(a_no);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}finally {
			dao.resClose();
			map.put("success", success);
		}
		
	}

	
}
