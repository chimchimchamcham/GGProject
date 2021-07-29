package com.gg.board.service;

import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.gg.board.dao.BoardDAO;
import com.gg.dto.GGDto;
import com.google.gson.Gson;

public class BoardService {

	HttpServletRequest req = null;
	HttpServletResponse resp = null;
	
	public BoardService(HttpServletRequest req) {
		this.req = req;
		this.resp = resp;
		
		try {
			req.setCharacterEncoding("UTF-8");
		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
		}
	}

	public GGDto salesDetail() {
		int P_no = Integer.parseInt(req.getParameter("P_no"));
		System.out.println("P_no : "+P_no);
		BoardDAO dao = new BoardDAO();
		GGDto dto = null;		
		try {
			dao.conn.setAutoCommit(false);
			if(dao.upP_view(P_no)>0) {
				dto = dao.salesDetail(P_no);
			}
			if(dto == null) {
				dao.conn.rollback();
			}else {
				dao.conn.commit();
			}
		}catch(Exception e) {
			e.printStackTrace();
		}
		dao.resClose();
		return dto;
	}

	public boolean isLiked(String U_id, int P_no) {
		boolean isLiked = false;
		BoardDAO dao = new BoardDAO();
		isLiked = dao.isLiked(U_id, P_no);
		dao.resClose();
		return isLiked;
	}

	public boolean lovePlus() {
		int P_no = Integer.parseInt(req.getParameter("P_no"));
		//String U_id = (String) req.getSession().getAttribute("loginId");
		String U_id = "user1"; //임시로 저장
		BoardDAO dao = new BoardDAO();
		boolean success = false;
		success = dao.lovePlus(U_id, P_no);
		
		return success;
	}

	public boolean loveMinus() {
		int P_no = Integer.parseInt(req.getParameter("P_no"));
		//String U_id = (String) req.getSession().getAttribute("loginId");
		String U_id = "user1"; //임시로 저장
		BoardDAO dao = new BoardDAO();
		boolean success = false;
		success = dao.loveMinus(U_id, P_no);
		return success;
	}
	
	public void list()	throws IOException {
		
		HashMap<String, Object> map = new HashMap<String, Object>();
		
		BoardDAO dao = new BoardDAO();
		ArrayList<GGDto> list = null;
		
		try {
			list = dao.list();
		} catch (SQLException e) {
			e.printStackTrace();
		}finally {
			dao.resClose();
			map.put("list", list);
		}
		System.out.println(map);
	resp.setContentType("text/html; charset=UTF-8");		
	resp.getWriter().println(new Gson().toJson(map));
}
	
	public HashMap<String, ArrayList<GGDto>> category() {
		BoardDAO dao = new BoardDAO();
		HashMap<String, ArrayList<GGDto>> map = dao.category();
		System.out.println("[Service ] category success : "+map);
		return map;
		
		
	}

	
	
}
