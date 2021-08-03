package com.gg.board.controller;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.gg.board.service.BoardService;
import com.gg.board.service.CommentService;
import com.gg.dto.GGDto;

@WebServlet({"/soldboardlist"})
public class CommentController extends HttpServlet {

	
	private static final long serialVersionUID = 1L;

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		dual(req,resp);
	}

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		dual(req,resp);
	}

	private void dual(HttpServletRequest req, HttpServletResponse resp) {
		String uri = req.getRequestURI();
		String ctx = req.getContextPath();
		String addr = uri.substring(ctx.length());
		System.out.println("addr : " + addr);

		RequestDispatcher dis = null;
		CommentService service = new CommentService(req, resp);
		GGDto bdto = null;
		boolean success = false;
		int p_no;
		String userid;
		switch (addr) {
		
		case "/soldboardlist":
			System.out.println("뎃글 리스트 요청");
			userid = (String) req.getSession().getAttribute("loginId");
			p_no = (int) req.getSession().getAttribute("p_no");
			
			service.sold_board_list(userid,p_no);

			break;
		
		
		}
		
	}
}
