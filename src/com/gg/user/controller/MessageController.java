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
import com.gg.user.service.MessageService;

@WebServlet({"/sendMsg"})
public class MessageController extends HttpServlet {

	
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
		
		req.setCharacterEncoding("UTF-8");
		String uri = req.getRequestURI();
		String ctx = req.getContextPath();
		String addr = uri.substring(ctx.length());
		MessageService service = new MessageService(req);
		RequestDispatcher dis = null;
		
		switch (addr) {
		case "/sendMsg":
			String msg = "";
			boolean success = service.sendMsg();
			if(success) {
				msg = "쪽지를 전송하였습니다.";
				req.setAttribute("msg",msg);
				dis = req.getRequestDispatcher("/popup/sendMsgPop.jsp");
				dis.forward(req, resp);
			}
			
		case "/msgList":
			ArrayList<GGDto> list = new ArrayList<GGDto>();
			list = service.msgList();
			break;
	
		}
	}

}
