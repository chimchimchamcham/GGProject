package com.gg.board.service;

import javax.servlet.http.HttpServletRequest;

public class BoardService {

	HttpServletRequest req = null;
	
	public BoardService(HttpServletRequest req) {
		this.req = req;
	}

}
