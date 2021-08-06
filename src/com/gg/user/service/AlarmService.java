package com.gg.user.service;

import java.sql.SQLException;

import javax.servlet.http.HttpServletRequest;

import com.gg.dto.GGDto;
import com.gg.user.dao.AlarmDAO;

public class AlarmService {
	
	HttpServletRequest req = null;
	AlarmDAO dao = null;
	public AlarmService(HttpServletRequest req) {
		this.req = req;
	}

	public GGDto ALlist() {
		String u_id = (String) req.getSession().getAttribute("loginId");
		String a_impoyn =req.getParameter("a_impoyn");
		dao = new AlarmDAO();
		GGDto dto = new GGDto();
		try {
			dto = dao.ALlist(u_id,a_impoyn);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}finally {
			dao.resClose();
		}
		return dto;
		
		
	}

	
}
