package com.gg.user.service;

import javax.servlet.http.HttpServletRequest;

public class UserService {

	HttpServletRequest req = null;
	
	public UserService(HttpServletRequest req) {
		this.req = req;
	}

}
