package com.gg.user.controller;

import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.gg.user.service.UserService;
import com.google.gson.Gson;

@WebServlet({ "/id_overlay", "/nname_overlay", "/join", "/login", "/logout", "/idsearch", "/myPage","/userUpdate","/userUpdateForm","/chkpw","/changePw"})
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

	private void dual(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

		String uri = req.getRequestURI();
		String ctx = req.getContextPath();
		String addr = uri.substring(ctx.length());
		req.setCharacterEncoding("UTF-8");
		resp.setContentType("text/html charset=UTF-8"); // 한글 설정.
		UserService service = new UserService(req, resp);
		RequestDispatcher dis;

		switch (addr) {

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
			ArrayList<String> idYN = service.login();
			String msg = "아이디 또는 비밀번호를 확인 하세요";
			String page = "login.jsp";
			if (idYN.get(1) != null) {
				req.getSession().setAttribute("loginId", idYN.get(0));
				req.getSession().setAttribute("adminYN", idYN.get(1));
				msg = null;
				System.out.println(idYN.get(1));
				page = "index.jsp";
			}
			req.setAttribute("msg", msg);
			dis = req.getRequestDispatcher(page);
			dis.forward(req, resp);
			break;

		case "/logout":
			msg = "";
			success = service.logout();
			System.out.println("로그아웃 요청");
			if (success) {
				msg = "로그아웃 되었습니다.";
				req.setAttribute("msg", msg);
				dis = req.getRequestDispatcher("index.jsp");
				dis.forward(req, resp);
			}
			break;

		case "/idsearch":
			System.out.println("아이디 찾기 요청");
			service.idsearch();
			
			break;

		case "/myPage":
			System.out.println("마이페이지 요청");

			req.getSession().setAttribute("myPageInfo", service.myPage());
			dis = req.getRequestDispatcher("myPage.jsp");
			dis.forward(req, resp);
			break;
			
		case "/userUpdateForm":
			System.out.println("회원정보 수정 폼 요청");
			req.setAttribute("userUpdate", service.userUpdateForm());
			dis = req.getRequestDispatcher("userUpdate.jsp");
			dis.forward(req, resp);
			break;
			
		case "/userUpdate":
			System.out.println("수정 요청");

			String id = (String)req.getSession().getAttribute("loginId");
			msg = "회원정보 수정에 실패 했습니다.";
			page = "userUpdateForm?id="+id;
			if(service.userUpdate(id) >0) {
				msg="회원정보 수정에 성공 했습니다.";
				page = "myPage?id="+id;
			} 
			req.setAttribute("msg", msg);
			dis = req.getRequestDispatcher(page);
			dis.forward(req, resp);
			
			break;		

		
		case "/chkPw":
			HashMap<String, Object> map = new HashMap<String, Object>();
			map.put("success", service.chkpw());
			String obj = new Gson().toJson(map);
			resp.getWriter().println(obj);
			break;
		
		case "/changePw":
			success = service.changePw();
			break;

		}
		
	

	}


}
