package com.gg.trade.service;

import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.gg.board.dao.CommentDAO;
import com.gg.dto.GGDto;
import com.gg.trade.dao.TradeDAO;
import com.gg.user.dao.AlarmDAO;
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
	dao.resClose();

	
}

	//====================구매 요청 수락, 거절=====================
	//구매요청을 수락하면 거래페이지 생성, 거절하면 끝
	public int buyRequestProcess() {
		System.out.println("[TRADESERVICE]/BUYREQUESTPROCESS START");
		int rq_no = Integer.parseInt(req.getParameter("rq_no"));
		//System.out.println(rq_no);
		String rq_YN = req.getParameter("Rq_YN");
		//System.out.println(rq_YN);
		int p_no = Integer.parseInt(req.getParameter("p_no"));
		String t_saler = (String) req.getSession().getAttribute("loginId");
		String t_buyer = req.getParameter("rq_id");
		
		int t_no = 0;
		TradeDAO dao = new TradeDAO();
		
		t_no = dao.buyRequestProcess(rq_no, rq_YN, p_no, t_saler, t_buyer);
		System.out.println("[TRADESERVICE]/BUYREQUESTPROCESS T_NO : "+t_no);
		
		dao.resClose();
		System.out.println("[TRADESERVICE]/BUYREQUESTPROCESS END");
		return t_no;
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
			dao.conn.setAutoCommit(false);
			pdao.conn.setAutoCommit(false);
			insertPointSuccess = pdao.insertPoint(t_buyer, ht_point, "SYSTEM", "PNT003", p_no);
			System.out.println("[TRADESERVICE]/SENDPOINT INSERTPOINTSUCCESS : "+insertPointSuccess);
			if(insertPointSuccess) {
				insertHisTradeSuccess = dao.insertHisTrade(t_no,ht_point,"HT002");
				System.out.println("[TRADESERVICE]/SENDPOINT INSERTHISTRADESUCCESS : "+insertHisTradeSuccess);	
			}
			if(insertHisTradeSuccess) {
				pdao.conn.commit();
				dao.conn.commit();
				System.out.println("[TRADESERVICE]/SENDPOINT INSERTPOINTSUCCESS COMMIT");
				
				/////////알람 보내기 (송금)
				AlarmDAO Aldao = new AlarmDAO();
				String p_title = dao.getTitleFromTno(t_no); //제목 가져오기
				p_title = Aldao.cutTitle(p_title);
							
				String t_bnname= null;
				try {
						t_bnname = pdao.getNname(t_buyer);
						//판매자한테만 알람
						Aldao.insertAlarm(t_saler, "A013", "["+p_title+"]"+t_bnname+"님이 송금하였습니다.", "Y", "./tradeDetail?t_no=" + t_no);
					} catch (SQLException e) {
						e.printStackTrace();
					}
				Aldao.resClose();
					
				////////////////////////////////
				
			}else {
				pdao.conn.rollback();
				dao.conn.rollback();
				System.out.println("[TRADESERVICE]/SENDPOINT INSERTPOINTSUCCESS ROLLBACK");
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
		/*		
		if(insertHisTradeSuccess) {
			/////////알람 보내기 (승인)
			AlarmDAO Aldao = new AlarmDAO();
			String p_title = dao.getTitleFromTno(t_no); //제목 가져오기
			p_title = Aldao.cutTitle(p_title);
			ArrayList<String> list = new ArrayList<String>();
			list = dao.selectSandB(t_no);
			
			String t_saler = list.get(0);
			String t_buyer = list.get(1);
			PointDAO pdao = new PointDAO();
			String t_snname;
			try {
				t_snname = pdao.getNname(t_saler);
				//구매자한테만 알람
				Aldao.insertAlarm(t_buyer, "A017", "["+p_title+"]"+t_snname+"님이 승인하였습니다.", "Y", "./tradeDetail?t_no=" + t_no);
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			pdao.resClose();
			Aldao.resClose();
			
			////////////////////////////////
		}
		*/
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
			dao.conn.setAutoCommit(false);
			pdao.conn.setAutoCommit(false);
			insertPointSuccess = pdao.insertPoint(t_buyer, ht_point, "SYSTEM", "PNT008", p_no);
			System.out.println("[TRADESERVICE]/POINTDENY INSERTPOINTSUCCESS : "+insertPointSuccess);
			if(insertPointSuccess) {
				insertHisTradeSuccess = dao.insertHisTrade(t_no,ht_point,"HT003");
				System.out.println("[TRADESERVICE]/POINTDENY INSERTHISTRADESUCCESS : "+insertHisTradeSuccess);
				if(insertHisTradeSuccess) {
					/*
					/////////알람 보내기 (송금거절)
					AlarmDAO Aldao = new AlarmDAO();
					String p_title = dao.getTitleFromTno(t_no); //제목 가져오기
					p_title = Aldao.cutTitle(p_title);
					
					String t_snname= null;
					try {
						t_snname = pdao.getNname(t_saler);
						//구매자한테만 알람
						Aldao.insertAlarm(t_buyer, "A016", "["+p_title+"]"+t_snname+"님이 승인거부하였습니다.", "Y", "./tradeDetail?t_no=" + t_no);
					} catch (SQLException e) {
						e.printStackTrace();
					}
					Aldao.resClose();
				
					////////////////////////////////
					 */
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
		/*
		if(insertHisTradeSuccess) {
			/////////알람 보내기 (배송)
			AlarmDAO Aldao = new AlarmDAO();
			String p_title = dao.getTitleFromTno(t_no); //제목 가져오기
			p_title = Aldao.cutTitle(p_title);
			ArrayList<String> list = new ArrayList<String>();
			list = dao.selectSandB(t_no);
			
			String t_saler = list.get(0);
			String t_buyer = list.get(1);
			PointDAO pdao = new PointDAO();
			String t_snname;
			try {
				t_snname = pdao.getNname(t_saler);
				//구매자한테만 알람
				Aldao.insertAlarm(t_buyer, "A014", "["+p_title+"]"+t_snname+"님이 배송하였습니다.", "Y", "./tradeDetail?t_no=" + t_no);
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			pdao.resClose();
			Aldao.resClose();
			
			////////////////////////////////
		}
		*/
		dao.resClose();
		System.out.println("[TRADESERVICE]/PRODUCTSHIPPING END");
		return insertHisTradeSuccess;
	}
	
	//구매자가 수취확인
	public boolean productReceive() {
		System.out.println("[TRADESERVICE]/PRODUCTRECEIVE START");
		String t_buyer = req.getParameter("t_buyer");
		int ht_point = Integer.parseInt(req.getParameter("ht_point"));
		String t_saler = req.getParameter("t_saler");
		int p_no = Integer.parseInt(req.getParameter("p_no"));
		int t_no = Integer.parseInt(req.getParameter("t_no"));
		//int ha_bidPr = Integer.parseInt(req.getParameter("ha_bidPr"));
		//int au_startPr = Integer.parseInt(req.getParameter("au_startPr"));
		String p_code = req.getParameter("p_code");
		
		boolean insertPointToBuyerSuccess = false;
		boolean insertPointToSalerSuccess = false;
		boolean insertHisTradeSuccess = false;
		boolean endTrade = false;
		TradeDAO dao = new TradeDAO();
		PointDAO pdao = new PointDAO();
		
		try {
			dao.conn.setAutoCommit(false);
			pdao.conn.setAutoCommit(false);
			//경매 거래일 경우 입찰금을 반환
			if(p_code.equals("P001")) {
				int au_startPr = dao.selectAuctionAu_startPr(p_no);//경매 시작가
				System.out.println("[TRADESERVICE]/PRODUCTRECEIVE AU_STARTPR : "+au_startPr);
				insertPointToBuyerSuccess = pdao.insertPoint(t_buyer, au_startPr, "SYSTEM", "PNT007", p_no);
				System.out.println("[TRADESERVICE]/PRODUCTRECEIVE INSERTPOINTBUYERSUCCESS : "+insertPointToBuyerSuccess);
			}
			//판매자에게 포인트를 송금
			insertPointToSalerSuccess = pdao.insertPoint(t_saler, ht_point, t_buyer, "PNT004", p_no);
			System.out.println("[TRADESERVICE]/PRODUCTRECEIVE INSERTPOINTSALERSUCCESS : "+insertPointToSalerSuccess);
			if(insertPointToSalerSuccess) {
				//거래히스토리에 수취확인 상태로 변경
				insertHisTradeSuccess = dao.insertHisTrade(t_no,0,"HT006");
				System.out.println("[TRADESERVICE]/PRODUCTRECEIVE INSERTHISTRADESUCCESS : "+insertHisTradeSuccess);
				if(insertHisTradeSuccess) {
					//판매 or 경매 판매종료로 변경
					if(p_code.equals("P001")) {
						endTrade = dao.updateAuctionAu_code(p_no, "Au003");
					}else {
						endTrade = dao.updateNsaleNscode(p_no, "NS_003");
					}
					System.out.println("[TRADESERVICE]/PRODUCTRECEIVE ENDTRADE : "+endTrade);
				}
			}
			
			if(endTrade) {
				/*
				//알람 보내기 (수취확인)
				AlarmDAO Aldao = new AlarmDAO();
				String p_title = dao.getTitleFromTno(t_no); //제목 가져오기
				p_title = Aldao.cutTitle(p_title);
				
				String t_bnname = pdao.getNname(t_buyer);
				//판매자한테만 알람
				Aldao.insertAlarm(t_saler, "A015", "["+p_title+"]"+t_bnname+"님 수취확인하였습니다.", "Y", "./tradeDetail?t_no=" + t_no);
				
				Aldao.resClose();
				////////////////////////////////
				*/
				pdao.conn.commit();
				dao.conn.commit();
				System.out.println("[TRADESERVICE]/PRODUCTRECEIVE INSERTPOINTSUCCESS COMMIT");
			}else {
				pdao.conn.rollback();
				dao.conn.rollback();
				System.out.println("[TRADESERVICE]/PRODUCTRECEIVE INSERTPOINTSUCCESS ROLLBACK");
			}	
		}catch(Exception e) {
			e.printStackTrace();
		}
		
		dao.resClose();
		pdao.resClose();
		System.out.println("[TRADESERVICE]/PRODUCTRECEIVE END");
		return endTrade;
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
			dao.conn.setAutoCommit(false);
			pdao.conn.setAutoCommit(false);
			insertPointSuccess = pdao.insertPoint(t_buyer, ht_point, "SYSTEM", "PNT005", p_no);
			System.out.println("[TRADESERVICE]/CANCELTRADE INSERTPOINTSUCCESS : "+insertPointSuccess);
			if(insertPointSuccess) {
				insertHisTradeSuccess = dao.insertHisTrade(t_no,0,"HT007");
				System.out.println("[TRADESERVICE]/CANCELTRADE INSERTHISTRADESUCCESS : "+insertHisTradeSuccess);
				if(insertHisTradeSuccess) {
					updateTradeT_cancleIdSuccess = dao.updateTradeT_cancleId(t_cancleId, t_no);
					System.out.println("[TRADESERVICE]/CANCELTRADE UPDATETRADET_CANCLEIDSUCCESS : "+updateTradeT_cancleIdSuccess);
				}
			}
			if(updateTradeT_cancleIdSuccess) {
				/*
				//알람 보내기 (거래취소)
				AlarmDAO Aldao = new AlarmDAO();
				String p_title = dao.getTitleFromTno(t_no); //제목 가져오기
				p_title = Aldao.cutTitle(p_title);
				ArrayList<String>list = new ArrayList<String>();
				list = dao.selectSandB(t_no);
				String t_saler = list.get(0);
				if(t_saler.equals(t_cancleId)) {//판매자가 취소한 경우
					String t_snname = pdao.getNname(t_saler);
					Aldao.insertAlarm(t_buyer, "A012", "["+p_title+"]"+t_snname+"님이 거래취소하였습니다.", "Y", "./tradeDetail?t_no=" + t_no);
					Aldao.insertAlarm(t_saler, "A012", "["+p_title+"]거래취소되었습니다.", "Y", "./tradeDetail?t_no=" + t_no);
				}else {//구매자가 취소한 경우
					String t_bnname = pdao.getNname(t_buyer);
					Aldao.insertAlarm(t_saler, "A012", "["+p_title+"]"+t_bnname+"님이 거래취소하였습니다.", "Y", "./tradeDetail?t_no=" + t_no);
					Aldao.insertAlarm(t_buyer, "A012", "["+p_title+"]거래취소되었습니다.", "Y", "./tradeDetail?t_no=" + t_no);
				}
				Aldao.resClose();
				////////////////////////////////
				*/
				pdao.conn.commit();
				dao.conn.commit();
				
				System.out.println("[TRADESERVICE]/CANCELTRADE INSERTPOINTSUCCESS COMMIT");
			}else {
				pdao.conn.rollback();
				dao.conn.rollback();
				System.out.println("[TRADESERVICE]/CANCELTRADE INSERTPOINTSUCCESS ROLLBACK");
			}	
		} catch (SQLException e) {
			e.printStackTrace();
		}
		dao.resClose();
		pdao.resClose();
		System.out.println("[TRADESERVICE]/CANCELTRADE END");
		return updateTradeT_cancleIdSuccess;
	}

	//거래페이지 상세보기
	public GGDto tradeDetail() {
		int t_no = Integer.parseInt(req.getParameter("t_no"));
		TradeDAO dao = new TradeDAO();
		GGDto dto = dao.tradeDetail(t_no);
		dao.resClose();
		return dto;
	}

	//거래페이지 목록보기
	public void tradeList() throws IOException{
		System.out.println("[TRADESERVICE]/TRADELIST START");
		String id = (String) req.getSession().getAttribute("loginId");
		String p_code = req.getParameter("p_code");
		int pageNum = Integer.parseInt(req.getParameter("pageNum"));
		TradeDAO dao = new TradeDAO();
		boolean success = false;
		HashMap<String, Object> map = dao.tradeList(id, p_code, pageNum);
		if(map != null) {
			success = true;
		}
		
		dao.resClose();
		map.put("success", success);
		System.out.println("[TRADESERVICE]/TRADELIST SUCCESS : "+success);
		resp.setCharacterEncoding("UTF-8");
		resp.setContentType("text/html; charset=UTF-8");		
		resp.getWriter().println(new Gson().toJson(map));
		
		System.out.println("[TRADESERVICE]/TRADELIST END");

	}
	
	//거래 댓글 목록 보기
	public HashMap<String, Object> tradeCommentList(int t_no){
		System.out.println("받아 온 거래 글 번호 :" + t_no);
		TradeDAO dao = new TradeDAO();
		HashMap<String, Object> map = null;
		try {
			map = dao.tradeCommentList(t_no);
			
			//로그인 한 사람의 닉네임 가져오기
			String id = (String)req.getSession().getAttribute("loginId");
			String u_nname = dao.selectUserinfoU_nname(id);
			map.put("loginNname", u_nname);
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			dao.resClose();
		}
		return map;
	}
	
	//거래댓글 추가
	public void insertTradeComment() {
		int t_no = Integer.parseInt(req.getParameter("t_no"));
		String id = (String) req.getSession().getAttribute("loginId");
		String tc_content = req.getParameter("tc_content");
		
		TradeDAO dao = new TradeDAO();
		boolean success = dao.insertTradeComment(t_no, tc_content, id);
		
		if(success) {
			System.out.println("댓글 추가 성공");
		}
		dao.resClose();
		
	}
}
