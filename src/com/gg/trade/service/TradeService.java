package com.gg.trade.service;

import java.io.UnsupportedEncodingException;
import java.sql.SQLException;
import java.util.HashMap;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.gg.trade.dao.TradeDAO;



public class TradeService {

	HttpServletRequest req = null;
	HttpServletResponse resp = null;
	
	public TradeService(HttpServletRequest req,HttpServletResponse resp) {
		this.req = req;
		this.resp = resp;
		
		try {
			req.setCharacterEncoding("UTF-8");
		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
		}
	}
	
	public boolean buyRequest() {
		int p_no = Integer.parseInt(req.getParameter("p_no"));
		String u_id = (String) req.getSession().getAttribute("loginId");
		//String u_id = "user1"; //임시로 저장
		TradeDAO dao = new TradeDAO();
		boolean buyRequest = dao.buyRequest(p_no, u_id);
		System.out.println("buyRequest : "+buyRequest);
		dao.resClose();
		return buyRequest;
	}

	public boolean buyRequestCancel() {
		int p_no = Integer.parseInt(req.getParameter("p_no"));
		String u_id = (String) req.getSession().getAttribute("loginId");
		//String u_id = "user1"; //임시로 저장
		TradeDAO dao = new TradeDAO();
		boolean buyRequestCancel = dao.buyRequestCancel(p_no, u_id);
		System.out.println("buyRequestCancel : "+buyRequestCancel);
		dao.resClose();
		return buyRequestCancel;
	}
	
public HashMap<String,Object> auctionBid() {
		
		//boolean success = false;
		HashMap<String,Object> map = new HashMap<String,Object>();
		int p_no = Integer.parseInt(req.getParameter("p_no"));
		int ha_bidPr = Integer.parseInt(req.getParameter("ha_bidPr"));
		String ha_bidUsr =(String) req.getSession().getAttribute("loginId");
		System.out.println("경매글 입찰 글번호 : "+p_no);
		System.out.println("경매글 입찰 가격 : "+ ha_bidPr);
		System.out.println("경매 입찰자 : "+ ha_bidUsr);
		
		TradeDAO dao = new TradeDAO();
		try {
			dao.conn.setAutoCommit(false);
			int upAucCnt = dao.upAucCnt(p_no);
			System.out.println("입찰횟수 올리기 : "+upAucCnt);
			if(upAucCnt >0) {//입찰수 올리기 성공시 
				map = dao.auctionBid(p_no,ha_bidPr,ha_bidUsr); //경매입찰시
			}
			//((Boolean) yourObject).booleanValue();
			if(!((Boolean) map.get("success")).booleanValue()) {
				dao.conn.rollback();
			}else {
				dao.conn.commit();
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}finally {
			dao.resClose();
		}
		
		return map;
		
	}


}
