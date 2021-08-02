package com.gg.user.service;

import javax.servlet.http.HttpServletRequest;

import com.gg.user.dao.BlackListDAO;

public class BlackListService {

	HttpServletRequest req = null;
	BlackListDAO dao = new BlackListDAO();
	public BlackListService(HttpServletRequest req) {
		this.req = req;
	}

	public boolean notifyUser() {
		String N_sendId = (String)req.getSession().getAttribute("loginId");
		String N_receiveId = req.getParameter("N_receiveId");
		String N1_code = req.getParameter("N1_code");
		String N2_code = req.getParameter("N2_code");
		String N_content = req.getParameter("N_content");
		boolean success = dao.notifyUser();
		return success;
	}
	
	
}
