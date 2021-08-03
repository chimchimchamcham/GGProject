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

@WebServlet({"/saleboardlist"})
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
		BoardService boardservice = new BoardService(req, resp);
		CommentService commentservice = new CommentService(req, resp);
		GGDto bdto = null;
		boolean success = false;
		int p_no;
		String p_id;
		switch (addr) {
		
		case "/saleboardlist":
			System.out.println("댓글 리스트 요청");
			
			p_id = req.getParameter("p_id");
			p_no = Integer.parseInt(req.getParameter("p_no"));


			break;
		
		
		}
		
	}
}
