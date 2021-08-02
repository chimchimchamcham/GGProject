package com.gg.user.controller;

import java.io.IOException;
import java.util.HashMap;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.gg.dto.GGDto;
import com.gg.user.service.PointService;
import com.google.gson.Gson;

@WebServlet({ "/charge", "/test", "/pointPop", "/pointList" })
public class PointController extends HttpServlet {

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
		System.out.println("addr : " + addr);

		PointService service = null;
		RequestDispatcher dis = null;
		String page = "";
		String msg = "";

		switch (addr) {

		case "/pointPop":
			System.out.println("포인트 충전 팝업 진입 완료");
			boolean success = false;
			service = new PointService(req);
			int myPoint = service.pointPop();
			HashMap<String, Object> map = new HashMap<String, Object>();
			if (myPoint > -1000000) { // 포인트가 음수가 될 순 없다.
				success = true;
			}
			map.put("success", success);
			map.put("myPoint", myPoint);

			resp.getWriter().println(new Gson().toJson(map));
			break;

		case "/charge":
			System.out.println("포인트 충전 요청");
			String id = req.getParameter("id");
			int chargePoint = Integer.parseInt(req.getParameter("chargePoint"));
			System.out.println("충전 아이디  : " + req.getParameter("id"));
			System.out.println("충전 요청 금액 : " + chargePoint);
			success = false;
			service = new PointService(req);
			success = service.charge(chargePoint, id);
			System.out.println("충전 성공 여부 : " + success);
			map = new HashMap<String, Object>();
			map.put("success", success);
			String nname = service.getNname(id);
			map.put("nickname", nname);
			resp.getWriter().println(new Gson().toJson(map));
			break;

		case "/pointList":
			System.out.println("포인트 리스트 진입.");

			service = new PointService(req);
			map = new HashMap<String, Object>();
			map.put("list", service.pointList());
			resp.getWriter().println(new Gson().toJson(map));

			break;

		}

	}
}
