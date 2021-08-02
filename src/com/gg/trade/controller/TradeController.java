package com.gg.trade.controller;

import java.io.IOException;
import java.util.HashMap;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.gg.dto.GGDto;
import com.gg.trade.service.TradeService;
import com.google.gson.Gson;

@WebServlet({"/buyRequest","/buyRequestCancel","/bid","/buyNow"})
public class TradeController extends HttpServlet {
	
	
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
		System.out.println("addr : " + addr);

		RequestDispatcher dis = null;
		String page = "";
		String msg = "";
		TradeService service = new TradeService(req, resp);
		GGDto bdto = null;
		boolean success = false;
		int p_no;
		String userid;
		
		switch (addr) {
		case "/buyRequest":
			System.out.println("구매요청");
			success = service.buyRequest();
			System.out.println("Controller buyRequest success : " + success);
			p_no = Integer.parseInt(req.getParameter("p_no"));
			dis = req.getRequestDispatcher("/salesDetail?p_no=" + p_no);
			dis.forward(req, resp);
			break;

		case "/buyRequestCancel":
			System.out.println("구매요청 취소");
			success = service.buyRequestCancel();
			System.out.println("Controller buyRequest success : " + success);
			p_no = Integer.parseInt(req.getParameter("p_no"));
			dis = req.getRequestDispatcher("/salesDetail?p_no=" + p_no);
			dis.forward(req, resp);
			break;

		case "/bid":
			System.out.println("입찰 요청");
			HashMap<String, Object> sue_map = null;
			sue_map = service.auctionBid();
			resp.setCharacterEncoding("UTF-8");
			resp.setContentType("text/html charset=UTF-8");
			resp.setHeader("Access-Control-Allow-origin", "*"); // view가 같은 서버에 있으면 생략 가능
			resp.getWriter().println(new Gson().toJson(sue_map));

			break;	
			
		case "/buyNow":
			System.out.println("즉결 구매 요청");
			service.buyNow();
		}
		
	}
}
