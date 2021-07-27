package com.gg.board.service;

import javax.servlet.http.HttpServletRequest;

public class CommentService {
	HttpServletRequest req= null;
	public CommentService(HttpServletRequest req) {
		this.req = req;
	}

}
