package com.gg.board.service;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class CommentService {
	HttpServletRequest req= null;
	HttpServletResponse resp = null;
	public CommentService(HttpServletRequest req, HttpServletResponse resp) {
		this.req = req;
		this.resp = resp;
	}
	
	
	
	public void sold_board_list(String userid, int p_no) {
		System.out.println("userid:"+userid);
		System.out.println("p_no:"+p_no);
	}

}
