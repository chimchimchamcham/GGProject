package com.gg.board.service;

import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.sql.Date;
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
	public boolean isLiked() {
		int p_no = Integer.parseInt(req.getParameter("p_no"));
		String u_id = (String) req.getSession().getAttribute("loginId");
		//String u_id = "user1"; //임시로 저장
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
	

	public boolean isBuyRequested() {
		int p_no = Integer.parseInt(req.getParameter("p_no"));
		String u_id = (String) req.getSession().getAttribute("loginId");
		//String u_id = "user1";
		BoardDAO dao = new BoardDAO();
		boolean isBuyRequested = dao.isBuyRequested(p_no, u_id);
		System.out.println("isBuyRequested : "+isBuyRequested);
		dao.resClose();
		return isBuyRequested;
	}
	
	public ArrayList<GGDto> sale3List(String p_id) {
		System.out.println("service sale3List");
		BoardDAO dao = new BoardDAO();
		ArrayList<GGDto> sale3List = dao.sale3List(p_id);
		System.out.println("dao sale3List");
		dao.resClose();
		return sale3List;
	}
	/* ====================================================== */
public void sold_list(String userid, int listwhatadd, int listhowaline)	throws IOException {
		
		HashMap<String, Object> map = new HashMap<String, Object>();
		
		BoardDAO dao = new BoardDAO();
		ArrayList<GGDto> soldlist = null;
		
		try {
			soldlist = dao.sold_list(userid,listwhatadd,listhowaline);
		} catch (SQLException e) {
			e.printStackTrace();
		}finally {
			dao.resClose();
			map.put("soldlist", soldlist);
		}
		System.out.println(map);
	resp.setContentType("text/html; charset=UTF-8");		
	resp.getWriter().println(new Gson().toJson(map));
	map.clear();
	dao.resClose();
}
	
public void auc_list(String userid, int listwhatadd) throws IOException {
	
	HashMap<String, Object> map = new HashMap<String, Object>();
	
	BoardDAO dao = new BoardDAO();
	ArrayList<GGDto> auctionlist = null;
	
	try {
		auctionlist = dao.auction_list(userid,listwhatadd);
	} catch (SQLException e) {
		e.printStackTrace();
	}finally {
		dao.resClose();
		map.put("auctionlist", auctionlist);
	}
	System.out.println("auc_map:"+map);
	
	resp.setContentType("text/html; charset=UTF-8");		
	resp.getWriter().println(new Gson().toJson(map));
	map.clear();
	dao.resClose();
}

public void maide_list(String userid) throws IOException {
	HashMap<String, Object> map = new HashMap<String, Object>();
	
	BoardDAO dao = new BoardDAO();
	ArrayList<GGDto> maidelist = null;
	
	try {
		maidelist = dao.maide_list(userid);
	} catch (SQLException e) {
		e.printStackTrace();
	}finally {
		dao.resClose();
		map.put("maidelist", maidelist);
	}
	System.out.println(map);
resp.setContentType("text/html; charset=UTF-8");		
resp.getWriter().println(new Gson().toJson(map));
map.clear();
dao.resClose();
	
}

public void community_list(String userid) throws IOException {
	HashMap<String, Object> map = new HashMap<String, Object>();
	
	BoardDAO dao = new BoardDAO();
	ArrayList<GGDto> communitylist = null;
	
	try {
		communitylist = dao.community_list(userid);
	} catch (SQLException e) {
		e.printStackTrace();
	}finally {
		dao.resClose();
		map.put("communitylist", communitylist);
	}
	System.out.println(map);
resp.setContentType("text/html; charset=UTF-8");		
resp.getWriter().println(new Gson().toJson(map));
map.clear();
dao.resClose();
	
}
///////////////////////////////////////////////////////////////////////////////
	public HashMap<String, ArrayList<GGDto>> category() {
		BoardDAO dao = new BoardDAO();
		HashMap<String, ArrayList<GGDto>> map = dao.category();
		System.out.println("[Service ] category success : "+map);
		dao.resClose();
		return map;
		
		
	}

	public int writeCommu() {
		int p_no= -123;
		
		String p_id = (String)req.getSession().getAttribute("loginId");
		String p_title = req.getParameter("title");
		String p_content = req.getParameter("content");
		String p_cate = req.getParameter("category");
		String p_code = req.getParameter("select");
		System.out.println("아이디 : " + p_id);
		System.out.println("p_code : " + p_code);
		System.out.println("커뮤니티글쓰기 제목 : " + p_title + " 내용 : " + p_content + " 카테고리 :" + p_cate);
		BoardDAO dao = new BoardDAO();
		GGDto dto = new GGDto();
		dto.setP_id(p_id);
		dto.setP_title(p_title);
		dto.setP_content(p_content);
		dto.setP_cate(p_cate);
		dto.setP_code(p_code);
		
		try {
			 p_no =  dao.writeCommu(dto);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}finally {
			dao.resClose();
		}
		
		
		return p_no;
	}

	public int writeTrade() {

		int success = -123; 
		
		GGDto dto = new GGDto();
		String p_id = req.getParameter("userId");
		String p_title = req.getParameter("title");
		String p_content = req.getParameter("content");
		String p_code = req.getParameter("select");
		String s_deliveryYN = req.getParameter("deliveryYN");
		String s_followLimYN = req.getParameter("followYN");
		String s_code = req.getParameter("category");
		String au_startPr = req.getParameter("startPr");
		String au_instantPr = req.getParameter("instantPr");
		Date au_startTm = Date.valueOf(req.getParameter("startTm"));
		Date au_endTm = Date.valueOf(req.getParameter("endTm"));
		
		System.out.println("Service 경매 데이터 확인");
		System.out.println(p_id+"\n"+p_title+"\n"+p_content+"\n"+p_code);
		System.out.println(s_deliveryYN+"\n"+s_followLimYN+"\n"+s_code+"\n"+au_startPr);
		System.out.println(au_startTm+"\n"+au_instantPr+"\n"+au_endTm);
		
		if(au_instantPr ==null) {
			au_instantPr = "999999999999";
			System.out.println("변경된 즉결 구매가 : "+au_startPr);
		}
		
		dto.setP_id(p_id);
		dto.setP_title(p_title);
		dto.setP_content(p_content);
		dto.setP_title(p_title);
		dto.setP_code(p_code);
		dto.setS_DeliveryYN(s_deliveryYN);
		dto.setS_followLimYN(s_followLimYN);
		dto.setS_code(s_code);
		dto.setAu_startPr(Integer.parseInt(au_startPr));
		dto.setAu_instantPr(Integer.parseInt(au_instantPr));
		dto.setAu_startTm(au_startTm);
		dto.setAu_endTm(au_endTm);
		
		BoardDAO dao = new BoardDAO();
		try {
			success = dao.writeTrade(dto);
			if(success > 0) {System.out.println("경매 글쓰기 완료");}
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}finally {
			dao.resClose();
		}
		// 사실 success 는 글번호이다.
		
		
		return success;
	}

	public int writeSale() {
		BoardDAO dao = new BoardDAO();
		
		String p_title = req.getParameter("title");
		String p_content = req.getParameter("content");
		String s_deliveryYN = req.getParameter("deliveryYN");
		String s_followLimYN = req.getParameter("disclosure");
		String s_code=req.getParameter("category");
		String ns_pr = req.getParameter("price");
		String p_code = req.getParameter("select");
		

		System.out.println(p_title+"/"+p_content+"/"+s_deliveryYN+"/"+s_followLimYN+"/"+s_code+"/"+ns_pr+"/"+p_code);
		
		GGDto dto = new GGDto();
		dto.setP_id((String)req.getSession().getAttribute("loginId"));
		dto.setP_title(p_title);
		dto.setP_content(p_content);
		dto.setS_DeliveryYN(s_deliveryYN);
		dto.setS_followLimYN(s_followLimYN);
		dto.setS_code(s_code);
		dto.setNs_pr(Integer.parseInt(ns_pr));
		dto.setP_code(p_code);

		int p_no = dao.writeSale(dto);
		 
		return p_no;
	}

	//경매 상세보기
	public GGDto auctionDetail() {
		int p_no = Integer.parseInt(req.getParameter("p_no"));
		System.out.println("경매글 상세보기 글번호 : "+p_no);
		BoardDAO dao = new BoardDAO();
		GGDto dto = new GGDto();
		try {
			dao.conn.setAutoCommit(false);
			int up = dao.upP_view(p_no);
			System.out.println("조회수 올리기 :"+up);
			if(up>0) {
				dto = dao.auctionDetail(p_no);
				System.out.println("상세보기 dto : "+dto);
			}
			if(dto == null) {
				dao.conn.rollback();
			}else {
				dao.conn.commit();
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}finally {
			dao.resClose();
		}
		return dto;
	}



	/*커뮤니티 수정*/
	public int commUpdate(int p_no) {
		String title=req.getParameter("title");
		String content=req.getParameter("content");
		String category=req.getParameter("category");
		System.out.println("카테고리 수정 : "+title+"/"+content+"/"+category);
		
		BoardDAO dao = new BoardDAO();
		int sucP_no = dao.commUpdate(p_no, title,content,category);
		dao.resClose();
		return sucP_no;
	}
	
	
	/*판매글 수정*/
	/*public Object salesUpdateForm() {
		int p_no = Integer.parseInt(req.getParameter("P_no"));
		System.out.println("수정 요청 글 번호 : "+p_no);
		BoardDAO dao = new BoardDAO();
		
		return null;
	}*/

	/*커뮤니티 글 수정*/
	public Object commUpdateForm() {
		String p_no = req.getParameter("P_no");
		System.out.println("수정 요청 글 번호 : "+p_no);
		BoardDAO dao = new BoardDAO();
		GGDto dto = dao.commDetail(p_no);
		System.out.println("수정요청 글 dto : "+ dto);
		dao.resClose();
		
		return dto;
	}


	public GGDto commDetail() {
		String P_no = req.getParameter("P_no");
		BoardDAO dao = new BoardDAO();
		return dao.commDetail(P_no);
	}

	
}
