package com.gg.user.controller;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet({"/charge","/test"})
public class PointController extends HttpServlet {

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
		System.out.println("addr : "+addr);
		
		RequestDispatcher dis = null;
		String page = "";
		String msg = "";
		
		switch (addr) {
		case "/charge":
			System.out.println("포인트 충전 요청");
			int chargePoint = Integer.parseInt(req.getParameter("chargePoint"));
			System.out.println("충전 요청 금액 : "+ chargePoint);
			
			break;

		}
		
	}
}
