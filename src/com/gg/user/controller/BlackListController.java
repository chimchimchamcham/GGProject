package com.gg.user.controller;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.gg.dto.GGDto;
import com.gg.user.service.BlackListService;

@WebServlet({"/notify","/blackLstPr","/blackLstDet"})
public class BlackListController extends HttpServlet {
	
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
		req.setCharacterEncoding("UTF-8");
		resp.setContentType("text/html charset=UTF-8"); // 한글 설정
		RequestDispatcher dis;
		BlackListService service = new BlackListService(req);
		switch (addr) {
		
		case "/notify":
			String msg ="";
			if(service.notifyUser()) {
				msg = "신고가 접수되었습니다.";
				req.setAttribute("msg", msg);
				dis = req.getRequestDispatcher("popup/notifyPopup.jsp");
				dis.forward(req, resp);
			}
			break;
			
		case "/blackLstPr":
			System.out.println("블랙리스트 등록 요청 ");
			ArrayList<Object>list = new ArrayList<Object>();
			list=service.blackLstPr();
			msg = (String) list.get(0);
			boolean success = (boolean) list.get(1);
			req.setAttribute("msg", msg);
			req.setAttribute("success", success);
			dis = req.getRequestDispatcher("./popup/blackListPr.jsp");
			dis.forward(req, resp);
			
			break;
			
		case "/blackLstDet":
			System.out.println("블랙리스트 상세보기 요청");
			GGDto dto = new GGDto();
			dto = service.blackLstDetail();
			req.setAttribute("dto", dto);
			dis = req.getRequestDispatcher("./popup/blackLstDetail.jsp");
			dis.forward(req,resp);
			break;
		}
	}
}
