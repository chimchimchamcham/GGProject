package com.gg.user.service;

import java.sql.Date;
import java.sql.SQLException;
import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;

import com.gg.dto.GGDto;
import com.gg.user.dao.BlackListDAO;

public class BlackListService {

	HttpServletRequest req = null;
	BlackListDAO dao = new BlackListDAO();
	public BlackListService(HttpServletRequest req) {
		this.req = req;
	}

	public boolean notifyUser() {
		GGDto dto = new GGDto();
		boolean success = false;
		dto.setN_receiveId(req.getParameter("N_receiveId"));
		dto.setN_sendId((String)req.getSession().getAttribute("loginId"));
		dto.setN_content(req.getParameter("N_content"));
		dto.setN1_code(req.getParameter("N1_code"));
		dto.setN2_code(req.getParameter("N2_code"));
		success = dao.notifyUser(dto);
		
		return success;
	}

	public ArrayList<Object> blackLstPr() {
		GGDto dto = new GGDto();
		ArrayList<Object>list = new ArrayList<Object>();
		
		String b_Id = req.getParameter("b_Id");
		String b_code = req.getParameter("b_code");
		Date b_endtm = Date.valueOf(req.getParameter("b_endtm"));
		String b_adminId = (String) req.getSession().getAttribute("loginId");
		String b_content = req.getParameter("b_content");
		
		System.out.println(b_Id+" / "+b_code+" / "+" / "+b_endtm+" / "+b_adminId+" / "+b_content);
		
		dto.setB_id(b_Id);
		dto.setB_code(b_code);
		dto.setB_endTm(b_endtm);
		dto.setB_adminId(b_adminId);
		dto.setB_content(b_content);
		
		try {
			list = dao.blackLstPr(dto);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}finally {
			dao.resClose();
		}
		
		return list;
	}
	
	
}
