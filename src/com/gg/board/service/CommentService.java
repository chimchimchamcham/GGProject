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



	public ArrayList<GGDto> commentListCall(int p_no) {
		System.out.println("댓글 리스트 불러오기 서비스 진입");
		ArrayList<GGDto> list = null;
		GGDto dto = new GGDto();
		dto.setP_no(p_no);
		CommentDAO dao = new CommentDAO();
		try {
			list = dao.commentListCall(dto);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}finally {
			dao.resClose();
		}
		
		
		return list;
	}



	public boolean comm_del(int pc_no) {
		System.out.println("서비스 진입");
		boolean success = false;
		CommentDAO dao = new CommentDAO();
		try {
			success = dao.comm_del(pc_no);
			System.out.println("삭제 성공 : "+success);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}finally {
			dao.resClose();
		}
		
		
		
		
		return success;
	}



	public boolean comm_update(int pc_no, String pc_context) {
		System.out.println("댓글 수정 서비스 진입");
		boolean success = false;
		CommentDAO dao = new CommentDAO();
		
		try {
			success = dao.comm_update(pc_no,pc_context);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}finally {
			dao.resClose();
		}
		
		
		
		return success;
	}



	public ArrayList<GGDto> showReComment(int p_no, int pc_parentno) {
		System.out.println("대댓글 보여주기 서비스 진입.");
		CommentDAO dao = new CommentDAO();
		GGDto dto = new GGDto();
		dto.setP_no(p_no);
		dto.setPc_parentno(pc_parentno);
		ArrayList<GGDto> list= null;
		try {
			list = dao.showReComment(dto);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}finally {
			dao.resClose();
		}
		
		
		
		return list;
	}



	public boolean re_comment(String pc_content, int pc_parentno, int p_no, String pc_id) {
		boolean success = false;
		
		CommentDAO dao = new CommentDAO();
		int check = 0 ;
		try {
			check = dao.re_comment(pc_content, pc_parentno, p_no,pc_id);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}finally {
			dao.resClose();
		}
		
		if(check >0) {
			success = true;
		}
		
		
		
		return success;
	}



	public HashMap<String, Object> auctionCommentList(int page, int p_no) {
		System.out.println("받아온 페이지 정보 : " +  page);
		System.out.println("받아 온 옥션 글 번호 :" + p_no);
		CommentDAO dao = new CommentDAO();
		HashMap<String, Object> map = dao.auctionCommentList(page,p_no);
		
		
		
		
		
		return map;
	}

}
