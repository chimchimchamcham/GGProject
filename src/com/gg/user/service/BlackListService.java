package com.gg.user.service;

import javax.servlet.http.HttpServletRequest;

public class BlackListService {

	HttpServletRequest req = null;
	
	public BlackListService(HttpServletRequest req) {
		this.req = req;
	}

}
