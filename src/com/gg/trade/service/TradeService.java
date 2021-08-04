package com.gg.trade.service;

import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.sql.SQLException;
import java.util.HashMap;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.gg.trade.dao.TradeDAO;
import com.gg.user.dao.PointDAO;
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
	try {
		success = dao.buyNow(p_no, u_id, ha_bidPr);
	} catch (SQLException e1) {
		// TODO Auto-generated catch block
		e1.printStackTrace();
	}
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
	}finally {
		dao.resClose();
	}
	

	
}

	//====================구매 요청 수락, 거절=====================
	//구매요청을 수락하면 거래페이지 생성, 거절하면 끝
	public boolean buyRequestProcess() {
		System.out.println("[TRADESERVICE]/BUYREQUESTPROCESS START");
		int rq_no = Integer.parseInt(req.getParameter("rq_no"));
		String rq_YN = req.getParameter("rq_YN");
		int p_no = Integer.parseInt(req.getParameter("p_no"));
		String t_saler = (String) req.getSession().getAttribute("loginId");
		String t_buyer = req.getParameter("t_buyer");
		
		boolean success = false;
		TradeDAO dao = new TradeDAO();
		
		success = dao.buyRequestProcess(rq_no, rq_YN, p_no, t_saler, t_buyer);
		System.out.println("[TRADESERVICE]/BUYREQUESTPROCESS success : "+success);
		
		dao.resClose();
		System.out.println("[TRADESERVICE]/BUYREQUESTPROCESS END");
		return success;
	}
	//====================거래 페이지============================
	//구매자가 송금
	public boolean sendPoint() {
		System.out.println("[TRADESERVICE]/SENDPOINT START");
		String t_buyer = req.getParameter("t_buyer");
		int ht_point = Integer.parseInt(req.getParameter("ht_point"));
		String t_saler = req.getParameter("t_saler");
		int p_no = Integer.parseInt(req.getParameter("p_no"));
		int t_no = Integer.parseInt(req.getParameter("t_no"));
		
		boolean insertPointSuccess = false;
		boolean insertHisTradeSuccess = false;
		TradeDAO dao = new TradeDAO();
		PointDAO pdao = new PointDAO();
		
		try {
			pdao.conn.setAutoCommit(false);
			insertPointSuccess = pdao.insertPoint(t_buyer, ht_point, "SYSTEM", "PNT003", p_no);
			System.out.println("[TRADESERVICE]/SENDPOINT INSERTPOINTSUCCESS : "+insertPointSuccess);
			if(insertPointSuccess) {
				insertHisTradeSuccess = dao.insertHisTrade(t_no,ht_point,"HT002");
				System.out.println("[TRADESERVICE]/SENDPOINT INSERTHISTRADESUCCESS : "+insertHisTradeSuccess);
				if(insertHisTradeSuccess) {
					pdao.conn.commit();
					dao.conn.commit();
					System.out.println("[TRADESERVICE]/SENDPOINT INSERTPOINTSUCCESS COMMIT");
				}else {
					pdao.conn.rollback();
					dao.conn.rollback();
					System.out.println("[TRADESERVICE]/SENDPOINT INSERTPOINTSUCCESS ROLLBACK");
				}
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		dao.resClose();
		pdao.resClose();
		System.out.println("[TRADESERVICE]/SENDPOINT END");
		return insertHisTradeSuccess;
	}
	
	//판매자가 승인
	public boolean pointApproval() {
		System.out.println("[TRADESERVICE]/POINTAPPROVAL START");
		int ht_point = Integer.parseInt(req.getParameter("ht_point"));
		int t_no = Integer.parseInt(req.getParameter("t_no"));
		
		boolean insertHisTradeSuccess = false;
		TradeDAO dao = new TradeDAO();
		
		insertHisTradeSuccess = dao.insertHisTrade(t_no,ht_point,"HT004");
		System.out.println("[TRADESERVICE]/POINTAPPROVAL INSERTHISTRADESUCCESS : "+insertHisTradeSuccess);
				
		dao.resClose();
		System.out.println("[TRADESERVICE]/POINTAPPROVAL END");
		return insertHisTradeSuccess;
	}
	
	//판매자가 거부
	public boolean pointDeny() {
		System.out.println("[TRADESERVICE]/POINTDENY START");
		String t_buyer = req.getParameter("t_buyer");
		int ht_point = Integer.parseInt(req.getParameter("ht_point"));
		String t_saler = req.getParameter("t_saler");
		int p_no = Integer.parseInt(req.getParameter("p_no"));
		int t_no = Integer.parseInt(req.getParameter("t_no"));
		
		boolean insertPointSuccess = false;
		boolean insertHisTradeSuccess = false;
		TradeDAO dao = new TradeDAO();
		PointDAO pdao = new PointDAO();
		
		try {
			pdao.conn.setAutoCommit(false);
			insertPointSuccess = pdao.insertPoint(t_buyer, ht_point, "SYSTEM", "PNT008", p_no);
			System.out.println("[TRADESERVICE]/POINTDENY INSERTPOINTSUCCESS : "+insertPointSuccess);
			if(insertPointSuccess) {
				insertHisTradeSuccess = dao.insertHisTrade(t_no,ht_point,"HT003");
				System.out.println("[TRADESERVICE]/POINTDENY INSERTHISTRADESUCCESS : "+insertHisTradeSuccess);
				if(insertHisTradeSuccess) {
					pdao.conn.commit();
					dao.conn.commit();
					System.out.println("[TRADESERVICE]/POINTDENY INSERTPOINTSUCCESS COMMIT");
				}else {
					pdao.conn.rollback();
					dao.conn.rollback();
					System.out.println("[TRADESERVICE]/POINTDENY INSERTPOINTSUCCESS ROLLBACK");
				}
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		dao.resClose();
		pdao.resClose();
		System.out.println("[TRADESERVICE]/POINTDENY END");
		return insertHisTradeSuccess;
	}
	
	//판매자가 배송
	public boolean productShipping() {
		System.out.println("[TRADESERVICE]/PRODUCTSHIPPING START");
		int ht_point = Integer.parseInt(req.getParameter("ht_point"));
		int t_no = Integer.parseInt(req.getParameter("t_no"));
		
		boolean insertHisTradeSuccess = false;
		TradeDAO dao = new TradeDAO();
		
		insertHisTradeSuccess = dao.insertHisTrade(t_no,ht_point,"HT005");
		System.out.println("[TRADESERVICE]/PRODUCTSHIPPING INSERTHISTRADESUCCESS : "+insertHisTradeSuccess);
				
		dao.resClose();
		System.out.println("[TRADESERVICE]/PRODUCTSHIPPING END");
		return insertHisTradeSuccess;
	}
	
	//구매자가 수취확인
	public boolean productReceive() {
		System.out.println("[TRADESERVICE]/PRODUCTRECEIVE START");
		int t_no = Integer.parseInt(req.getParameter("t_no"));
		
		boolean insertHisTradeSuccess = false;
		TradeDAO dao = new TradeDAO();
		
		insertHisTradeSuccess = dao.insertHisTrade(t_no,0,"HT006");
		System.out.println("[TRADESERVICE]/PRODUCTRECEIVE INSERTHISTRADESUCCESS : "+insertHisTradeSuccess);
				
		dao.resClose();
		System.out.println("[TRADESERVICE]/PRODUCTRECEIVE END");
		return insertHisTradeSuccess;
	}
	
	//판매자 또는 구매자가 거래취소
	public boolean cancelTrade() {
		System.out.println("[TRADESERVICE]/CANCELTRADE START");
		String t_buyer = req.getParameter("t_buyer");
		int ht_point = Integer.parseInt(req.getParameter("ht_point"));
		int p_no = Integer.parseInt(req.getParameter("p_no"));
		int t_no = Integer.parseInt(req.getParameter("t_no"));
		String t_cancleId = (String) req.getSession().getAttribute("loginId");
		
		boolean insertPointSuccess = false;
		boolean insertHisTradeSuccess = false;
		boolean updateTradeT_cancleIdSuccess = false;
		TradeDAO dao = new TradeDAO();
		PointDAO pdao = new PointDAO();
		
		try {
			pdao.conn.setAutoCommit(false);
			insertPointSuccess = pdao.insertPoint(t_buyer, ht_point, "SYSTEM", "PNT005", p_no);
			System.out.println("[TRADESERVICE]/CANCELTRADE INSERTPOINTSUCCESS : "+insertPointSuccess);
			if(insertPointSuccess) {
				insertHisTradeSuccess = dao.insertHisTrade(t_no,0,"HT007");
				System.out.println("[TRADESERVICE]/CANCELTRADE INSERTHISTRADESUCCESS : "+insertHisTradeSuccess);
				if(insertHisTradeSuccess) {
					updateTradeT_cancleIdSuccess = dao.updateTradeT_cancleId(t_cancleId, t_no);
					System.out.println("[TRADESERVICE]/CANCELTRADE UPDATETRADET_CANCLEIDSUCCESS : "+updateTradeT_cancleIdSuccess);
					if(updateTradeT_cancleIdSuccess) {
						pdao.conn.commit();
						dao.conn.commit();
						System.out.println("[TRADESERVICE]/CANCELTRADE INSERTPOINTSUCCESS COMMIT");
					}else {
						pdao.conn.rollback();
						dao.conn.rollback();
						System.out.println("[TRADESERVICE]/CANCELTRADE INSERTPOINTSUCCESS ROLLBACK");
					}
				}
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		dao.resClose();
		pdao.resClose();
		System.out.println("[TRADESERVICE]/CANCELTRADE END");
		return updateTradeT_cancleIdSuccess;
	}
}
