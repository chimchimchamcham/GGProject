package com.gg.trade.service;

import javax.servlet.http.HttpServletRequest;

public class PostCommentService {
	
	HttpServletRequest req = null;
	
	public PostCommentService(HttpServletRequest req) {
		this.req=req;
	}

}
