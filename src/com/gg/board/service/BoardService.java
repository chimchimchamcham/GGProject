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
	
	public BoardService(HttpServletRequest req,HttpServletResponse resp) {
		this.req = req;
		this.resp = resp;
		
		try {
			req.setCharacterEncoding("UTF-8");
		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
		}
	}

	public GGDto salesDetail() {
		int p_no = Integer.parseInt(req.getParameter("p_no"));
		System.out.println("p_no : "+p_no);
		BoardDAO dao = new BoardDAO();
		GGDto dto = null;	
		try {
			dao.conn.setAutoCommit(false);
			if(dao.upP_view(p_no)>0) {
				dto = dao.salesDetail(p_no);
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

	//찜을 눌렀는지 확인
	public boolean isLiked(String u_id, int p_no) {
		System.out.println("service isLiked");
		boolean isLiked = false;
		BoardDAO dao = new BoardDAO();
		isLiked = dao.isLiked(u_id, p_no);
		System.out.println("[DAO] isLiked : "+isLiked);
		dao.resClose();
		return isLiked;
	}

	//찜 테이블에 정보 추가 + 게시글에 좋아요 수 추가
	public boolean lovePlus() {
		int p_no = Integer.parseInt(req.getParameter("p_no"));
		String u_id = (String) req.getSession().getAttribute("loginId");
		//String u_id = "user1"; //임시로 저장
		BoardDAO dao = new BoardDAO();
		boolean success = false;
		int result = 0;
		try {
			dao.conn.setAutoCommit(false);
			if(dao.lovePlus(u_id, p_no)) {
				result = dao.loveCountPlus(p_no);
				System.out.println("[DAO] loveCountPlus result : "+result);
			}
			if(result>0) {
				dao.conn.commit();
				success = true;
			}else {
				dao.conn.rollback();
			}
		}catch(Exception e) {
			e.printStackTrace();
		}
		dao.resClose();
		return success;
	}
	
	//찜 테이블에 정보 제거 + 게시글에 좋아요 수 제거
	public boolean loveMinus() {
		int p_no = Integer.parseInt(req.getParameter("p_no"));
		String u_id = (String) req.getSession().getAttribute("loginId");
		//String u_id = "user1"; //임시로 저장
		BoardDAO dao = new BoardDAO();
		boolean success = false;
		int result = 0;
		try {
			dao.conn.setAutoCommit(false);
			if(dao.loveMinus(u_id, p_no)) {
				result = dao.loveCountMinus(p_no);
				System.out.println("[DAO] loveCountMinus result : "+result);
			}
			if(result>0) {
				dao.conn.commit();
				success = true;
			}else {
				dao.conn.rollback();
			}
		}catch(Exception e) {
			e.printStackTrace();
		}
		dao.resClose();
		return success;
	}

	//ajax로 lovePlus2 처리
		public void lovePlus2() throws IOException{
			System.out.println("service lovePlus2");
			int p_no = Integer.parseInt(req.getParameter("p_no"));
			String u_id = (String) req.getSession().getAttribute("loginId");
			//String u_id = "user1"; //임시로 저장
			BoardDAO dao = new BoardDAO();
			boolean success = false;
			int result = 0;
			try {
				dao.conn.setAutoCommit(false);
				if(dao.lovePlus(u_id, p_no)) {
					result = dao.loveCountPlus(p_no);
					System.out.println("[DAO] loveCountPlus result : "+result);
				}
				if(result>0) {
					dao.conn.commit();
					success = true;
				}else {
					dao.conn.rollback();
				}
			}catch(Exception e) {
				e.printStackTrace();
			}
			dao.resClose();
			
			//여기서 Ajax로 데이터를 던져줌
			HashMap<String, Object> map = new HashMap<String, Object>();
			map.put("success", success);
			//resp.setContextType("text/html" charset=UTF-8"); //한글 없으면 생략 가능
			//resp.setHeader("Access-Control-Allow-origin", "*"); //View 가 같으면 서버에 있으면 생략 가능
			resp.getWriter().println(new Gson().toJson(map));
			
		}
		
	//ajax로 lovePlus2 처리
	public void loveMinus2() throws IOException{
		System.out.println("service loveMinus2");
		int p_no = Integer.parseInt(req.getParameter("p_no"));
		String u_id = (String) req.getSession().getAttribute("loginId");
		//String u_id = "user1"; //임시로 저장
		BoardDAO dao = new BoardDAO();
		boolean success = false;
		int result = 0;
		try {
			dao.conn.setAutoCommit(false);
			if(dao.loveMinus(u_id, p_no)) {
				result = dao.loveCountMinus(p_no);
				System.out.println("[DAO] loveCountPlus result : "+result);
			}
			if(result>0) {
				dao.conn.commit();
				success = true;
			}else {
				dao.conn.rollback();
			}
		}catch(Exception e) {
			e.printStackTrace();
		}
		dao.resClose();
		
		//여기서 Ajax로 데이터를 던져줌
		HashMap<String, Object> map = new HashMap<String, Object>();
		map.put("success", success);
		//resp.setContextType("text/html" charset=UTF-8"); //한글 없으면 생략 가능
		//resp.setHeader("Access-Control-Allow-origin", "*"); //View 가 같으면 서버에 있으면 생략 가능
		resp.getWriter().println(new Gson().toJson(map));	
			
	}
	/* ====================================================== */
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

	public boolean writeCommu() {
		
		return false;
	}

	public boolean writeTrade() {

		return false;
	}

	public int writeSale() {
		BoardDAO dao = new BoardDAO();
		
		String p_title = req.getParameter("title");
		String p_content = req.getParameter("content");
		String s_deliveryYN = req.getParameter("deliveryYN");
		String s_followLimYN = req.getParameter("followLimYN");
		String s_code=req.getParameter("category");
		String ns_pr = req.getParameter("price");
		String p_code = req.getParameter("p_code");
		

		System.out.println(p_title+"/"+p_content+"/"+s_deliveryYN+"/"+s_code+"/"+ns_pr+"/"+p_code);
		
		GGDto dto = new GGDto();
		dto.setP_id((String)req.getSession().getAttribute("loginId"));
		dto.setP_title(p_title);
		dto.setP_content(p_content);
		dto.setS_DeliveryYN(s_deliveryYN);
		dto.setS_followLimYN(s_followLimYN);
		dto.setS_code(s_code);
		dto.setNs_pr(Integer.parseInt(ns_pr));
		dto.setP_code(p_code);
		
		
		
		 int success = dao.writeSale(dto);
		 
		 
		return success;
	}

	
	
}
