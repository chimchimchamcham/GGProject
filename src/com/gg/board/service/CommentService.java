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
	
	
	
	public void sold_board_list(String p_id, int p_no)throws IOException {
		System.out.println("p_id:"+p_id);
		System.out.println("p_no:"+p_no);
		
		HashMap<String, Object> map = new HashMap<String, Object>();
		
		CommentDAO dao = new CommentDAO();
		ArrayList<GGDto> sold_board_list = null;
		
		try {
			sold_board_list = dao.sold_board_dao(p_id,p_no);
		} catch (SQLException e) {
			e.printStackTrace();
		}finally {
			dao.resClose();
			map.put("sold_board_list", sold_board_list);
		}
		System.out.println("auc_map:"+map);
		
		resp.setContentType("text/html; charset=UTF-8");		
		resp.getWriter().println(new Gson().toJson(map));
		map.clear();
	}

}
