package com.gg.board.service;

import java.io.UnsupportedEncodingException;
import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;

import com.gg.board.dao.BoardDAO;
import com.gg.dto.GGDto;

public class BoardService {

	HttpServletRequest req = null;
	
	public BoardService(HttpServletRequest req) {
		this.req = req;
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
	

	
	
}
