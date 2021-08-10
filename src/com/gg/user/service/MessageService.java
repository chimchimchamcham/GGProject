package com.gg.user.service;

import javax.servlet.http.HttpServletRequest;
import com.gg.dto.GGDto;
import com.gg.user.dao.MessageDAO;

public class MessageService {

	HttpServletRequest req = null;
	MessageDAO dao;
	GGDto dto;
	
	public MessageService(HttpServletRequest req) {
		this.req = req;
	}

	public boolean sendMsg() {
		boolean success = false;
		dto = new GGDto();
		dto.setM_receiveId(req.getParameter("M_receiveId"));
		dto.setM_content(req.getParameter("M_content"));
		dto.setM_sendId((String)req.getSession().getAttribute("loginId"));
		
		dao = new MessageDAO();
		success = dao.sendMsg(dto);
		dao.resClose();
		return success;
		
	}
	
}
