package com.gg.user.service;

import java.io.IOException;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.gg.dto.GGDto;
import com.gg.user.dao.AlarmDAO;
import com.google.gson.Gson;

public class AlarmService {
	
	HttpServletRequest req = null;
	HttpServletResponse resp = null;
	AlarmDAO dao = null;
	public AlarmService(HttpServletRequest req) {
		this.req = req;
	}
	public AlarmService(HttpServletRequest req,HttpServletResponse resp) {
		this.req = req;
		this.resp = resp;
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

	public void readAlarm() throws IOException {
		
		boolean success = false;
		HashMap<String, Object>map = new HashMap<String,Object>();
		int a_no = Integer.parseInt(req.getParameter("a_no"));
		System.out.println("읽은 알람 번호 : "+a_no);
		dao = new AlarmDAO();
		try {
			success = dao.readAlarm(a_no);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}finally {
			dao.resClose();
		}
		System.out.println("읽은 시간 insert 성공 여부 : "+success);
		map.put("success", success);
		resp.getWriter().println(new Gson().toJson(map));
	}

	
}
