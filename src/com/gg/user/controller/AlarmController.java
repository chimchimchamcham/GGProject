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
import com.gg.user.service.AlarmService;

@WebServlet({"/alarmlist","/readAlarm"})
public class AlarmController extends HttpServlet {

	
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
		
		String url = req.getRequestURI();
		String ctx = req.getContextPath();
		String addr =url.substring(ctx.length());
		AlarmService service = null;
		
		GGDto dto = null;
		RequestDispatcher dis = null;
		String page = null;
		
		System.out.println("addr : "+addr);
		
		switch(addr) {
		case "/alarmlist":
			System.out.println("알람 목록 조회");
			ArrayList<GGDto> list = new ArrayList<GGDto>();
			service = new AlarmService(req);
			list = service.ALlist();	
			
			page ="./popup/alarmPop.jsp"; 
			
			req.setAttribute("list", list);
			dis = req.getRequestDispatcher(page);
			dis.forward(req,resp);
			
			break;
			
		case "/readAlarm":
			System.out.println("알람 읽음 처리");
			service = new AlarmService(req,resp);
			service.readAlarm();
			
			break;
			
		}
	
	}
}
