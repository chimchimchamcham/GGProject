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

import com.gg.board.dao.UploadDAO;
import com.gg.board.service.BoardService;
import com.gg.board.service.UploadService;
import com.gg.dto.GGDto;
import com.google.gson.Gson;


@WebServlet({"/salesDetail","/loveMinus","/lovePlus","/loveMinus2","/lovePlus2","/buyRequest","/buyRequestCancel","/soldlist","/auction_list","/writeForm","/writeSale","/writeTrade","/writeCommunity","/auctionDetail"})

public class BoardController extends HttpServlet {

	private static final long serialVersionUID = 1L;

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		dual(req,resp);
	}

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		dual(req,resp);
	}

	private void dual(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		String uri = req.getRequestURI();
		String ctx = req.getContextPath();
		String addr = uri.substring(ctx.length());
		System.out.println("addr : "+addr);
		
		RequestDispatcher dis = null;
		String page = "";
		String msg = "";
		BoardService service = new BoardService(req,resp);
		GGDto bdto = null;
		boolean success = false;
		int p_no;
		
		switch(addr) {
		case "/salesDetail" : 
			System.out.println("판매글 상세보기");
			GGDto dto = service.salesDetail();

			//좋아요를 눌렀는지 확인
			boolean isLiked = false;
			isLiked = service.isLiked();
			
			//구매요청을 눌렀는지 확인
			boolean isBuyRequested = false;
			isBuyRequested = service.isBuyRequested();
			
			//판매자의 판매목록 3개를 가져오기
			String p_id = dto.getP_id();
			System.out.println("p_id : "+p_id);
			ArrayList<GGDto> sale3List = service.sale3List(p_id);
			System.out.println("sale3List size"+sale3List.size());
			
			req.setAttribute("dto", dto);
			req.setAttribute("isLiked", isLiked);
			req.setAttribute("isBuyRequested", isBuyRequested);
			req.setAttribute("sale3List", sale3List);
			
			dis = req.getRequestDispatcher("salesDetail.jsp");
			dis.forward(req, resp);
			break;
		
		case "/lovePlus" : 
			System.out.println("찜 +1 추가");
			success = service.lovePlus();
			System.out.println("[Controller ] lovePluse success : "+success);
			p_no = Integer.parseInt(req.getParameter("p_no"));
			dis = req.getRequestDispatcher("/salesDetail?p_no="+p_no);
			dis.forward(req, resp);
			break;
			
		case "/loveMinus" : 
			System.out.println("찜 -1 제거");
			success = service.loveMinus();
			System.out.println("[Controller ] loveMinus success : "+success);
			p_no = Integer.parseInt(req.getParameter("p_no"));
			//resp.sendRedirect("./salesDetail?p_no="+p_no);
			dis = req.getRequestDispatcher("/salesDetail?p_no="+p_no);
			dis.forward(req, resp);
			break;
			
		//Ajax를 사용한 lovePlus	
		case "/lovePlus2" :
			System.out.println("찜 +1 추가");
			service.lovePlus2();
			break;
		//Ajax를 사용함 loveMinus
		case "/loveMinus2" :
			System.out.println("찜 -1 추가");
			service.loveMinus2();
			break;
			
		case "/buyRequest" :
			System.out.println("구매요청");
			success = service.buyRequest();
			System.out.println("Controller buyRequest success : "+success);
			p_no = Integer.parseInt(req.getParameter("p_no"));
			dis = req.getRequestDispatcher("/salesDetail?p_no="+p_no);
			dis.forward(req, resp);
			break;
			
		case "/buyRequestCancel" : 
			System.out.println("구매요청 취소");
			success = service.buyRequestCancel();
			System.out.println("Controller buyRequest success : "+success);
			p_no = Integer.parseInt(req.getParameter("p_no"));
			dis = req.getRequestDispatcher("/salesDetail?p_no="+p_no);
			dis.forward(req, resp);
			break;	
			
		/* ===========================================================================*/	
		case "/soldlist":
			System.out.println("판매 리스트 요청");	
			String userid = (String) req.getSession().getAttribute("loginId");
			int listwhatadd = Integer.parseInt(req.getParameter("index1"));
			int listhowaline = Integer.parseInt(req.getParameter("index2"));
			
			
			System.out.println("listwhatadd:"+listwhatadd);
			System.out.println("listhowaline:"+listhowaline);

			service.list(userid,listwhatadd,listhowaline);
			
			break;
			
		case "/auction_list":
			System.out.println("경매 리스트 요청");
			
			userid = (String) req.getSession().getAttribute("loginId");
			int auctionlistwhatadd = Integer.parseInt(req.getParameter("index1"));
			
			
			System.out.println("listwhatadd:"+auctionlistwhatadd);

			service.list(userid,auctionlistwhatadd);
			
			break;
			
		case "/writeForm":
			System.out.println("글쓰기 폼 요청");
			HashMap<String,ArrayList<GGDto>>map = service.category();
			System.out.println("[Controller ] category success : "+map);
			ArrayList<GGDto> commuCat =map.get("commuCat");
			ArrayList<GGDto> saleCat =map.get("saleCat");
			System.out.println("saleCat list size : "+saleCat.size());
			System.out.println("commuCat list size : "+commuCat.size());
			req.setAttribute("saleCat", saleCat);
			req.setAttribute("commuCat", commuCat);
			dis = req.getRequestDispatcher("writeForm.jsp");
			dis.forward(req, resp);
			 break;
			 
		case "/writeSale":
			System.out.println("판매글 쓰기 요청");
			p_no = service.writeSale();
			HashMap<String, Object> sue_map = new HashMap<String,Object>();
			sue_map.put("p_no", p_no);
			resp.getWriter().println(new Gson().toJson(sue_map));
			
			
			break;
			
		case "/writeTrade":
			System.out.println("경매글 쓰기 요청");
			p_no = service.writeTrade();
			
			HashMap<String, Object> jo_map = new HashMap<String, Object>();
			jo_map.put("p_no", p_no);
			resp.getWriter().println(new Gson().toJson(jo_map));
			
			
		
			break;
			
		case "/writeCommunity":
			System.out.println("커뮤니티글 쓰기 요청");
			p_no = service.writeCommu();
			jo_map = new  HashMap<String, Object>();
			
			jo_map.put("p_no",p_no);
			resp.getWriter().println(new Gson().toJson(jo_map));
			
			break;
			
		case "/upload":
			System.out.println("글 쓰기 파일 업로드 요청");
			UploadService uploadSer = new UploadService(req);
			dto = uploadSer.PhotoUpload();
			int uploadSuccess = 0;
			sue_map = new HashMap<String,Object>();

			
			UploadDAO uploadDAO = new UploadDAO();
			uploadSuccess = uploadDAO.PhotoUpload(dto);
			sue_map.put("success", uploadSuccess);
			resp.getWriter().println(new Gson().toJson(sue_map));
			break;
			
		case "/auctionDetail":
			System.out.println("경매글 상세보기 요청");
			dto = service.auctionDetail(); //경매글 해당 글번호 내용 dto로 반환
			//System.out.println("Controller 경매 상세 사진명 : "+dto.getI_newName());

			//좋아요를 눌렀는지 확인
			isLiked = false;
			isLiked = service.isLiked();
			
			//구매요청을 눌렀는지 확인
			isBuyRequested = false;
			isBuyRequested = service.isBuyRequested();
			
			req.setAttribute("dto", dto);
			dis = req.getRequestDispatcher("auctionDetail.jsp");
			dis.forward(req, resp);
		}
		
		
	}
	
}
