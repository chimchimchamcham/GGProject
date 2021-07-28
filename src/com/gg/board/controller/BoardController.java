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
import com.gg.dto.GGDto;
<<<<<<< HEAD

@WebServlet({"/salesDetail"})
public class BoardController extends HttpServlet {

	private static final long serialVersionUID = 1L;
=======

@WebServlet({"/salesDetail"})
public class BoardController extends HttpServlet {
>>>>>>> 493563b1c95430b4ecf8fdf0d23b7f4807895876

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		dual(req,resp);
	}

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		dual(req,resp);
	}

	private void dual(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		String uri = req.getRequestURI();
		String ctx = req.getContextPath();
		String addr = uri.substring(ctx.length());
		System.out.println("addr : "+addr);
		
		RequestDispatcher dis = null;
		String page = "";
		String msg = "";
		BoardService service = new BoardService(req);
		GGDto bdto = null;
		boolean success = false;
		
		switch(addr) {
		case "/salesDetail" : 
			System.out.println("판매글 상세보기");
			GGDto dto = service.salesDetail();
			
			//String U_id = (String) req.getSession().getAttribute("loginId");
			String U_id = "user1"; //임시로 저장
			int P_no = Integer.parseInt(req.getParameter("P_no"));
			boolean isLiked = false;
			isLiked = service.isLiked(U_id, P_no);
			req.setAttribute("dto", dto);
			req.setAttribute("isLiked", isLiked);
			dis = req.getRequestDispatcher("salesDetail.jsp");
			dis.forward(req, resp);
			break;
		
		case "/lovePlus" : 
			System.out.println("찜 +1 추가");
			success = service.lovePlus();
			System.out.println("[Controller ] lovePluse success : "+success);
			
		
			break;
		case "/loveMinus" : 
			System.out.println("찜 -1 추가");
			success = service.loveMinus();
			System.out.println("[Controller ] loveMinus success : "+success);
			break;
		}
		
		
	}
	
}
