package com.gg.trade.service;

import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.sql.SQLException;
import java.util.HashMap;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.gg.trade.dao.TradeDAO;
import com.google.gson.Gson;



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
public void buyNow(){
	
	boolean success = false;
	String msg = null;
	HashMap<String, Object> map = new HashMap<String, Object>();
	
	int p_no = Integer.parseInt(req.getParameter("p_no"));
	String u_id = (String) req.getSession().getAttribute("loginId");
	int ha_bidPr = Integer.parseInt(req.getParameter("au_instantpr"));
	
	System.out.println("p_no: "+p_no+" / u_id:"+u_id+" / bidPr: "+ha_bidPr);
	
	TradeDAO dao = new TradeDAO();
	success = dao.buyNow(p_no, u_id, ha_bidPr);
	System.out.println("즉결구매 성공 여부 :"+success);
	if(success) {
		msg = "즉결구매에 성공하였습니다.";
	}else {
		msg = "즉결구매에 실패하였습니다.";
	}
	
	map.put("success", success);
	map.put("msg", msg);
	
	
	try {
		resp.setCharacterEncoding("UTF-8");
		resp.setContentType("text/html charset= UTF-8");
		resp.setHeader("Access-Control-Allow-origin", "*"); // view가 같은 서버에 있으면 생략 가능
		resp.getWriter().println(new Gson().toJson(map));
	} catch (IOException e) {
		// TODO Auto-generated catch block
		e.printStackTrace();
	}
	

	
}

}
