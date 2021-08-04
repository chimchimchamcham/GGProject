package com.gg.board.service;

import java.io.IOException;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.gg.board.dao.CommentDAO;
import com.gg.dto.GGDto;
import com.google.gson.Gson;

public class CommentService {
	HttpServletRequest req= null;
	HttpServletResponse resp = null;
	public CommentService(HttpServletRequest req, HttpServletResponse resp) {
		this.req = req;
		this.resp = resp;
	}
	
	
	
	public void sale_commentlist(String p_id, int p_no)throws IOException {
		System.out.println("p_id:"+p_id);
		System.out.println("p_no:"+p_no);
		
		HashMap<String, Object> map = new HashMap<String, Object>();
		
		CommentDAO dao = new CommentDAO();
		ArrayList<GGDto> list = null;
		
		try {
			list = dao.sale_commentlist(p_id,p_no);
		} catch (SQLException e) {
			e.printStackTrace();
		}finally {
			dao.resClose();
			map.put("sold_board_list", list);
		}
		System.out.println("auc_map:"+map);
		
		resp.setContentType("text/html; charset=UTF-8");		
		resp.getWriter().println(new Gson().toJson(map));
		map.clear();
	}



	public GGDto pushComment(GGDto dto) {
		System.out.println("리스트 진입 완료.");
		ArrayList<GGDto> list = null;
		CommentDAO dao = new CommentDAO();
		
		try {
			dto = dao.pushComment(dto);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}finally {
			dao.resClose();
		}
		
		return dto;
	}

}
