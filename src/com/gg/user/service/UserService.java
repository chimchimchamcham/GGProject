package com.gg.user.service;

import java.io.IOException;
import java.util.HashMap;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.gg.user.dao.UserDAO;
import com.google.gson.Gson;

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
		String id = req.getParameter("id"); //아이디
		String pw = req.getParameter("pw"); // 비밀번호
		String name = req.getParameter("name"); //이름 
		String nname = req.getParameter("nname"); // 닉네임
		String age = req.getParameter("age"); // 나이
		String email = req.getParameter("email"); //메일 앞부분
		String mail = req.getParameter("mail"); // 메일 뒷부분(ex]naver.com)
		String addr = req.getParameter("addr"); // 대략적 주소
		String detailAddr = req.getParameter("detailAddr"); // 상세 주소
		
		System.out.println("들어온 인자 값 확인!");
		System.out.println(id+"/"+pw+"/"+name+"/"+nname+"/"+age+"/"+email+"/"+mail+"/"+addr+"/"+detailAddr);
		
		return success;
	}

	public void idOverlay() {
		String id = req.getParameter("id");
		System.out.println("중복체크 아이디 : " + id);
		UserDAO dao = new UserDAO();
		boolean overlay = false; // 중복 체크용
		success = false; //  DB 접속 성공 여부 => true면 안된다.  
		
		overlay = dao.idOverlay(id);
		if(overlay == true || overlay == false) { //뭐가 됐든 접속 성공한다면...
			success = true; //접속 성공여부 반환
		}
		
		dao.resClose();
		Gson gson = new Gson();
		HashMap<String, Object> map = new HashMap<String, Object>();
		map.put("success", success);
		map.put("overlay", overlay);
		
		String obj = gson.toJson(map);
		//아이디는 영어만 들어간다.
		try {
			resp.getWriter().println(obj);
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
	}

	public void nNameOverlay() {
		String nname = req.getParameter("nname");
		System.out.println("중복 체크 닉네임 : " + nname);
		UserDAO dao = new UserDAO();
		boolean overlay = false; // 중복 체크용
		success = false; //  DB 접속 성공 여부 => true면 안된다.  
		
		overlay = dao.nNameOverlay(nname);
		if(overlay == true || overlay == false) { //뭐가 됐든 접속 성공한다면...
			success = true; //접속 성공여부 반환
		}
		
		dao.resClose();
		Gson gson = new Gson();
		HashMap<String, Object> map = new HashMap<String, Object>();
		map.put("success", success);
		map.put("overlay", overlay);
		
		String obj = gson.toJson(map);
		//아이디는 영어만 들어간다.
		try {
			resp.getWriter().println(obj);
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
	}

	public String login() {
		String loginId = req.getParameter("loginId");
		String loginPw = req.getParameter("loginPw");
		System.out.println("loginId : "+loginId+"loginPw : "+loginPw);
		UserDAO dao = new UserDAO();
		return dao.login(loginId,loginPw);
	}

	
	
	
	
}
