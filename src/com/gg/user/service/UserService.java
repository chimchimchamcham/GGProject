package com.gg.user.service;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class UserService {

	HttpServletRequest req = null;
	HttpServletResponse resp = null;
	boolean success;
	
	
	
	public UserService(HttpServletRequest req, HttpServletResponse resp) {
		this.req = req;
		this.resp = resp;
	}

	public boolean join() {
		success = false;
		System.out.println("회원 가입 요청 확인");
		String id = req.getParameter("id");
		String pw = req.getParameter("pw");
		String name = req.getParameter("name");
		String nname = req.getParameter("nname");
		String age = req.getParameter("age");
		String email = req.getParameter("email");
		String mail = req.getParameter("mail");
		String detailAddr = req.getParameter("detailAddr");
		System.out.println("들어온 인자 값 확인!");
		System.out.println(id+"/"+pw+"/"+name+"/"+nname+"/"+age+"/"+email+"/"+mail+"/"+detailAddr);
		
		return success;
	}

	public void idOverlay() {
		// TODO Auto-generated method stub
		
	}

	public void nNameOverlay() {
		// TODO Auto-generated method stub
		
	}

	
	
	
	
}
