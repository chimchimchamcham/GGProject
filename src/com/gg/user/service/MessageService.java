package com.gg.user.service;

import javax.servlet.http.HttpServletRequest;

public class MessageService {

	HttpServletRequest req = null;
	
	public MessageService(HttpServletRequest req) {
		this.req = req;
	}

}
