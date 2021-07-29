package com.gg.mypageList.service;

import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.gg.dto.GGDto;
import com.gg.mypageList.dao.BoardDAO;
import com.google.gson.Gson;

public class BoardService {

	private HttpServletRequest req = null;
	private HttpServletResponse resp = null;

	public BoardService(HttpServletRequest req, HttpServletResponse resp) {
		this.req = req;
		this.resp = resp;
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

	

	
	
}
