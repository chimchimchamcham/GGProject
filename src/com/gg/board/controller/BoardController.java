package com.gg.board.controller;

import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.gg.board.service.BoardService;
import com.gg.dto.GGDto;

@WebServlet({"/salesDetail","/loveMinus","/lovePlus","/loveMinus2","/lovePlus2"})
public class BoardController extends HttpServlet {

	private static final long serialVersionUID = 1L;

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
		int p_no;
		
		switch(addr) {
		case "/salesDetail" : 
			System.out.println("판매글 상세보기");
			GGDto dto = service.salesDetail();
			System.out.println("Controller salesDetail dto : "+dto);
			String u_id = (String) req.getSession().getAttribute("loginId");
			//String u_id = "user1"; //임시로 저장
			p_no = Integer.parseInt(req.getParameter("p_no"));
			boolean isLiked = false;
			isLiked = service.isLiked(u_id, p_no);
			req.setAttribute("dto", dto);
			req.setAttribute("isLiked", isLiked);
			dis = req.getRequestDispatcher("salesDetail.jsp");
			dis.forward(req, resp);
			break;
		
		case "/lovePlus" : 
			System.out.println("찜 +1 추가");
			success = service.lovePlus();
			System.out.println("[Controller ] lovePluse success : "+success);
			p_no = Integer.parseInt(req.getParameter("p_no"));
			dis = req.getRequestDispatcher("/salesDetail?p_no="+p_no);
			dis.forward(req, resp);
			break;
			
		case "/loveMinus" : 
			System.out.println("찜 -1 제거");
			success = service.loveMinus();
			System.out.println("[Controller ] loveMinus success : "+success);
			p_no = Integer.parseInt(req.getParameter("p_no"));
			//resp.sendRedirect("./salesDetail?p_no="+p_no);
			dis = req.getRequestDispatcher("/salesDetail?p_no="+p_no);
			dis.forward(req, resp);
			break;
			
		//Ajax를 사용한 lovePlus	
		case "/lovePlus2" :
			System.out.println("찜 +1 추가");
			service.lovePlus2();
			break;
		//Ajax를 사용함 loveMinus
		case "/loveMinus2" :
			System.out.println("찜 -1 추가");
			service.loveMinus2();
			break;
			
		/* ===========================================================================*/	
		case "/sold":
			System.out.println("리스트 요청");				
			service.list();
			break;
			
		case "/writeForm":
			System.out.println("글쓰기 폼 요청");
			HashMap<String,ArrayList<GGDto>>map = service.category();
			System.out.println("[Controller ] category success : "+map);
			ArrayList<GGDto> commuCat =map.get("commuCat");
			ArrayList<GGDto> saleCat =map.get("saleCat");
			System.out.println("saleCat list size : "+saleCat.size());
			System.out.println("commuCat list size : "+commuCat.size());
			req.setAttribute("saleCat", saleCat);
			req.setAttribute("commuCat", commuCat);
			dis = req.getRequestDispatcher("writeForm.jsp");
			dis.forward(req, resp);
			 break;
			 
		case "/writeSale":
			System.out.println("판매글 쓰기 요청");
			break;
			
		case "/writeTrade":
			System.out.println("경매글 쓰기 요청");
			break;
			
		case "/writeCommunity":
			System.out.println("커뮤니티글 쓰기 요청");
			break;
			
		}
		
		
	}
	
}
