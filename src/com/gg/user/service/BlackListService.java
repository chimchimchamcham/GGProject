package com.gg.user.service;

import javax.servlet.http.HttpServletRequest;

import com.gg.dto.GGDto;
import com.gg.user.dao.BlackListDAO;

public class BlackListService {

	HttpServletRequest req = null;
	BlackListDAO dao = new BlackListDAO();
	public BlackListService(HttpServletRequest req) {
		this.req = req;
	}

	public boolean notifyUser() {
		GGDto dto = new GGDto();
		
		dto.setN_receiveId(req.getParameter("N_receiveId"));
		dto.setN_sendId((String)req.getSession().getAttribute("loginId"));
		dto.setN_content(req.getParameter("N_content"));
		dto.setN1_code(req.getParameter("N1_code"));
		dto.setN2_code(req.getParameter("N2_code"));
		boolean success = dao.notifyUser(dto);
		
		return success;
	}
	
	
}
