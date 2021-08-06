package com.gg.board.controller;

import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.gg.board.service.BoardService;
import com.gg.board.service.CommentService;
import com.gg.dto.GGDto;
import com.gg.trade.controller.PostCommentController;
import com.gg.trade.service.PostCommentService;
import com.google.gson.Gson;

@WebServlet({"/commentlist","/pushComment","/commentListCall","/comm_del","/comm_update","/re_comment","/showReComment"})
public class CommentController extends HttpServlet {

	
	private static final long serialVersionUID = 1L;

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		dual(req,resp);
	}

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		dual(req,resp);
	}

	private void dual(HttpServletRequest req, HttpServletResponse resp) throws IOException {
		String uri = req.getRequestURI();
		String ctx = req.getContextPath();
		String addr = uri.substring(ctx.length());
		System.out.println("addr : " + addr);

		RequestDispatcher dis = null;
		CommentService service = new CommentService(req, resp);
		GGDto dto = null;
		boolean success = false;
		int p_no;
		String p_id;
		
		resp.setContentType("text/html; charset=UTF-8");
		resp.setCharacterEncoding("UTF-8");
		
		
		switch (addr) {
		
		case "/commentlist":
			System.out.println("댓글 리스트 요청");
			
			p_id = req.getParameter("p_id");
			System.out.println("댓글 다는 아이디."+p_id);
			p_no = Integer.parseInt(req.getParameter("p_no"));
			System.out.println("댓글 달리는 게시글"+p_no);
			service.sale_commentlist(p_id,p_no);

			break;
		case "/pushComment":
			System.out.println("댓글 등록 요청");
			String pc_id = req.getParameter("id");
			p_no = Integer.parseInt(req.getParameter("p_no"));
			String pc_content = req.getParameter("pc_content");
			int pc_parentno = Integer.parseInt(req.getParameter("pc_parentno"));
			
			System.out.println("댓글 요청 컨트롤러에서 확인");
			System.out.println(pc_id+"/"+p_no+"/"+pc_content+"/"+pc_parentno);
			dto = new GGDto();
			dto.setPc_id(pc_id);
			dto.setP_no(p_no);
			dto.setPc_content(pc_content);
			dto.setPc_parentno(pc_parentno);
					
			
			dto = service.pushComment(dto);
			HashMap<String, Object> map = new HashMap<String, Object>();
			map.put("comment", dto);
			resp.getWriter().println(new Gson().toJson(map));
			break;
		
		case "/commentListCall":
			System.out.println("댓글 리스트 불러오기");
			p_no = Integer.parseInt(req.getParameter("p_no"));
			System.out.println("댓글 리스트 불러올 글 번호 : "+p_no);
			
			ArrayList<GGDto> list = service.commentListCall(p_no);
			map = new HashMap<String, Object>();
			map.put("list", list);
			resp.getWriter().println(new Gson().toJson(map));
			
			break;
			
		case "/comm_del":
			System.out.println("댓글 삭제 컨트롤러 진입");
			int pc_no = Integer.parseInt(req.getParameter("pc_no"));
			System.out.println(pc_no);
			
			success = service.comm_del(pc_no);
			
			map = new HashMap<String, Object>();
			map.put("success", success);
			resp.getWriter().println(new Gson().toJson(map));
			
			break;
			
		case "/comm_update":
			System.out.println("댓글 수정 진입");
			pc_no = Integer.parseInt(req.getParameter("pc_no"));
			System.out.println(pc_no);
			String pc_context = req.getParameter("context");
			success = service.comm_update(pc_no,pc_context);
			
			
			map = new HashMap<String, Object>();
			map.put("success", success);
			resp.getWriter().println(new Gson().toJson(map));
			
			
			break;
		case "/re_comment":
			System.out.println("대댓글 달기 시작");
			
			
			break;
		case "/showReComment":
			System.out.println("대댓글 리스트 보여주기.");
			pc_parentno = Integer.parseInt(req.getParameter("pc_parentno"));
			p_no = Integer.parseInt(req.getParameter("p_no"));
			System.out.println("글 번호 :"+p_no+" 부모 댓글 번호 : " +pc_parentno);
			list = service.showReComment(p_no,pc_parentno);
			
			map = new HashMap<String, Object>();
			map.put("list", list);
			resp.getWriter().println(new Gson().toJson(map));
			
			break;
		}
		
	}
}
