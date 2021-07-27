package com.gg.user.controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.gg.user.service.UserService;

@WebServlet({ "/id_overlay","/nname_overlay","/join" })
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
		UserService service = new UserService(req,resp);
		
		
		
		switch(addr) {
		
		case "/join":
			
			boolean success = service.join();
			
			
			
			break;
		}
		
		
	}

}
