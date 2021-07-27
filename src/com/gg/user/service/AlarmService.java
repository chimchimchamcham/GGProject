package com.gg.user.service;

import javax.servlet.http.HttpServletRequest;

public class AlarmService {
	
	HttpServletRequest req = null;

	public AlarmService(HttpServletRequest req) {
		this.req = req;
	}

}
