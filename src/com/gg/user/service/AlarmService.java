package com.gg.user.service;

import javax.servlet.http.HttpServletRequest;

import com.gg.dto.GGDto;
import com.gg.user.dao.AlarmDAO;

public class AlarmService {
	
	HttpServletRequest req = null;
	AlarmDAO dao = null;
	public AlarmService(HttpServletRequest req) {
		this.req = req;
	}

	public GGDto allALlst() {
		String u_id = (String) req.getSession().getAttribute("loginId");
		dao = new AlarmDAO();
		GGDto dto = new GGDto();
		dto = dao.allALlst(u_id);
		return dto;
		
		
	}

	public GGDto impALlst() {
		String u_id = (String) req.getSession().getAttribute("loginId");
		dao = new AlarmDAO();
		GGDto dto = new GGDto();
		dto = dao.impALlst(u_id);
		return dto;
	}

}
