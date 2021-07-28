package com.gg.user.controller;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.gg.user.service.UserService;

@WebServlet({ "/id_overlay","/nname_overlay","/join","/login","/logout" })
public class UserController extends HttpServlet {

	private static final long serialVersionUID = 1L;

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		dual(req, resp);
	}

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		dual(req, resp);
	}

	private void dual(HttpServletRequest req, HttpServletResponse resp) 
			throws ServletException, IOException {
		
		
		String uri = req.getRequestURI();
		String ctx = req.getContextPath();
		String addr = uri.substring(ctx.length());
		req.setCharacterEncoding("UTF-8");
		resp.setContentType("text/html charset=UTF-8"); // 한글 설정.
		UserService service = new UserService(req,resp);
		RequestDispatcher dis;
		
		
		switch(addr) {
		
		case "/join":
			
			boolean success = service.join();
			
			
			
			break;
		case "/id_overlay":
			System.out.println("아이디 중복 체크 요청");
			service.idOverlay();
			
			break;
			
		
		case "/nname_overlay":
			System.out.println("닉네임 중복 체크 요청");
			service.nNameOverlay();
			
			break;
			
		case "/login":
			System.out.println("로그인 요청");
			String userId = service.login();
			System.out.println(userId);
			String msg = "아이디 또는 비밀번호를 확인 하세요";
			String page = "login.jsp";
			if(userId!=null) {
				req.getSession().setAttribute("loginId", userId);
				msg = null;
				page = "index.jsp";
			}
			req.setAttribute("msg", msg);
			dis = req.getRequestDispatcher(page);
			dis.forward(req, resp);
			break;
			
		case "/logout":
			msg = null;
			System.out.println("로그아웃 요청");
			success = service.logout();
			if(success) {
				msg="반가웠어요 잘가용♥";
				dis = req.getRequestDispatcher("index.jsp");
				dis.forward(req, resp);
			}
			System.out.println(req.getSession().getAttribute("ioginId"));
			break;
		}
		
	}

}
