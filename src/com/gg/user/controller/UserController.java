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

import com.gg.dto.GGDto;
import com.gg.user.service.UserService;
import com.google.gson.Gson;
import sun.misc.Contended;

@WebServlet({ "/id_overlay", "/nname_overlay", "/join", "/login", "/logout", "/idsearch", "/myPage", "/userUpdate",
		"/userUpdateForm", "/chkpw", "/changePw", "/chkinfo", "/manageList", "/search", "/n_stateCatSel" })

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
		resp.setContentType("text/html charset=UTF-8"); // 한글 설정
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
			if (!idYN.isEmpty()) {
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

			req.setAttribute("myPageInfo", service.myPage());
			//req.setAttribute("allurl", "'./auctionlist'");
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

			resp.setContentType("text/html; charset=UTF-8");
			req.setCharacterEncoding("UTF-8");
			String id = (String) req.getSession().getAttribute("loginId");
			int result = service.userUpdate(id);
			System.out.println("수정 성공 여부 : " + result);

			msg = "회원정보 수정에 실패 했습니다. 다시 시도해 주세요";
			page = "userUpdateForm?id=" + id; // 실패하면 수정폼 그대로
			if (result > 0) {
				msg = "회원정보 수정에 성공 했습니다.";
				page = "myPage?id=" + id; // 성공하면 마이페이지로
			}

			req.setAttribute("msg", msg);
			dis = req.getRequestDispatcher(page);
			dis.forward(req, resp);

			break;

		case "/chkpw":
			HashMap<String, Object> map = new HashMap<String, Object>();
			map.put("pw", service.chkpw());
			String obj = new Gson().toJson(map);
			resp.getWriter().println(obj);
			System.out.println(map.get("pw"));
			break;

		case "/changePw":
			System.out.println("비밀번호 변경요청");
			if (service.changePw() > 0) {
				System.out.println("비밀번호 성공");
				resp.sendRedirect("login.jsp");
			} else {
				resp.sendRedirect("insearch.jsp");
			}
			break;

		case "/manageList":
			System.out.println("관리페이지 목록 요청");

			resp.setContentType("text/html; charset=UTF-8");
			req.setCharacterEncoding("UTF-8");

			// 회원목록
			ArrayList<GGDto> userList = service.userList();
			System.out.println("userList size : " + userList.size());
			req.setAttribute("userList", userList);

			/* ==신고목록== */
			// 접수중,처리중,처리완료 카테고리
			HashMap<String, ArrayList<GGDto>> categoryMap = service.category();
			System.out.println("카테고리 성공 : " + categoryMap);
			ArrayList<GGDto> n_stateCat = categoryMap.get("n_stateCat");
			System.out.println("n_stateCat list size : " + n_stateCat.size());
			req.setAttribute("n_stateCat", n_stateCat);

			// 게시글,댓글,사용자 카테고리
			ArrayList<GGDto> n1_code = categoryMap.get("n1_code");
			System.out.println("n1_code list size : " + n1_code.size());
			req.setAttribute("n1_code", n1_code);

			// 신고 목록
			ArrayList<GGDto> notifyList = service.notifyList();
			System.out.println("notifyList size : " + notifyList.size());
			req.setAttribute("notifyList", notifyList);

			/* ====경로지정==== */
			dis = req.getRequestDispatcher("managePage.jsp");
			dis.forward(req, resp);

			break;

		case "/n_stateCatSel":
			System.out.println("신고 상태 필터 요청");
			ArrayList<GGDto> n_stateCatSel = service.n_stateCatSel();
			HashMap<String, Object>n_stateSelMap = new HashMap<String, Object>();

			n_stateSelMap.put("n_stateCatSel", n_stateCatSel);
			resp.setContentType("text/html; charset=UTF-8");
			resp.getWriter().println(new Gson().toJson(n_stateSelMap));
			
			break;

		case "/search":
			System.out.println("검색결과 요청");
			HashMap<String,ArrayList<GGDto>> searchmap = new HashMap<String, ArrayList<GGDto>>();
			ArrayList<GGDto> f_ui = null;
			ArrayList<GGDto> f_pc = null;
			ArrayList<GGDto> f_pt = null;
			searchmap = service.search();
			f_ui = searchmap.get("f_ui");
			System.out.println("f_ui : "+f_ui.size());
			f_pc = searchmap.get("f_pc");
			System.out.println("f_ui : "+f_pc.size());
			f_pt = searchmap.get("f_pt");
			System.out.println("f_ui : "+f_pt.size());
			req.setAttribute("f_ui", f_ui);
			req.setAttribute("f_pc", f_pc);
			req.setAttribute("f_pt", f_pt);
			dis=req.getRequestDispatcher("search.jsp");
			dis.forward(req, resp);
			break;

		}

	}

}
