package com.gg.board.service;

import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.sql.Date;
import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import javax.naming.NamingException;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import com.gg.board.dao.BoardDAO;
import com.gg.dto.GGDto;
import com.gg.trade.dao.TradeDAO;
import com.gg.user.dao.AlarmDAO;
import com.google.gson.Gson;

public class BoardService {

	HttpServletRequest req = null;
	HttpServletResponse resp = null;

	public BoardService(HttpServletRequest req, HttpServletResponse resp) {
		this.req = req;
		this.resp = resp;

		try {
			req.setCharacterEncoding("UTF-8");
		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
		}
	}

	public void main_list() throws IOException     {
		
		HashMap<String, Object> map = new HashMap<String, Object>();

		BoardDAO dao = new BoardDAO();
		ArrayList<GGDto> mainpage_sold_list = null;
		ArrayList<GGDto> mainpage_auc_list = null;
		ArrayList<GGDto> mainpage_communiti_list = null;

		try {
			mainpage_sold_list = dao.mainpage_list_sold();
			mainpage_auc_list = dao.mainpage_list_auction();
			mainpage_communiti_list = dao.mainpage_list_communiti();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			dao.resClose();
			map.put("mainpage_sold_list", mainpage_sold_list);
			map.put("mainpage_auc_list", mainpage_auc_list);
			map.put("mainpage_communiti_list", mainpage_communiti_list);
		}
		System.out.println(map);
		resp.setContentType("text/html; charset=UTF-8");
		resp.getWriter().println(new Gson().toJson(map));
		map.clear();
		dao.resClose();
		
	}
	
	public GGDto salesDetail() {
		int p_no = Integer.parseInt(req.getParameter("p_no"));
		System.out.println("p_no : " + p_no);
		BoardDAO dao = new BoardDAO();
		GGDto dto = null;
		try {
			dao.conn.setAutoCommit(false);
			if (dao.upP_view(p_no) > 0) {
				dto = dao.salesDetail(p_no);
			}
			if (dto == null) {
				dao.conn.rollback();
			} else {
				dao.conn.commit();
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		dao.resClose();
		return dto;
	}

	// ?????? ???????????? ??????
	public boolean isLiked() {
		int p_no = Integer.parseInt(req.getParameter("p_no"));
		String u_id = (String) req.getSession().getAttribute("loginId");
		// String u_id = "user1"; //????????? ??????
		System.out.println("service isLiked");
		boolean isLiked = false;
		BoardDAO dao = new BoardDAO();
		isLiked = dao.isLiked(u_id, p_no);
		System.out.println("[DAO] isLiked : " + isLiked);
		dao.resClose();
		return isLiked;
	}

	// ???????????? ???????????? ??????
	public boolean isFollowed() {
		int p_no = Integer.parseInt(req.getParameter("p_no"));
		String u_id = (String) req.getSession().getAttribute("loginId");
		System.out.println("service isFollowed");
		boolean isFollowed = false;
		BoardDAO dao = new BoardDAO();
		isFollowed = dao.isFollowed(u_id, p_no);
		System.out.println("[DAO] isFollowed : " + isFollowed);
		dao.resClose();
		return isFollowed;
	}

	// ??? ???????????? ?????? ?????? + ???????????? ????????? ??? ??????
	public boolean lovePlus() {
		int p_no = Integer.parseInt(req.getParameter("p_no"));
		String u_id = (String) req.getSession().getAttribute("loginId");
		// String u_id = "user1"; //????????? ??????
		BoardDAO dao = new BoardDAO();
		boolean success = false;
		int result = 0;
		try {
			dao.conn.setAutoCommit(false);
			if (dao.lovePlus(u_id, p_no)) {
				result = dao.loveCountPlus(p_no);
				System.out.println("[DAO] loveCountPlus result : " + result);
			}
			if (result > 0) {
				dao.conn.commit();
				success = true;
			} else {
				dao.conn.rollback();
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		dao.resClose();
		return success;
	}

	// ??? ???????????? ?????? ?????? + ???????????? ????????? ??? ??????
	public boolean loveMinus() {
		int p_no = Integer.parseInt(req.getParameter("p_no"));
		String u_id = (String) req.getSession().getAttribute("loginId");
		// String u_id = "user1"; //????????? ??????
		BoardDAO dao = new BoardDAO();
		boolean success = false;
		int result = 0;
		try {
			dao.conn.setAutoCommit(false);
			if (dao.loveMinus(u_id, p_no)) {
				result = dao.loveCountMinus(p_no);
				System.out.println("[DAO] loveCountMinus result : " + result);
			}
			if (result > 0) {
				dao.conn.commit();
				success = true;
			} else {
				dao.conn.rollback();
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		dao.resClose();
		return success;
	}

	// ajax??? lovePlus2 ??????
	public void lovePlus2() throws IOException {
		System.out.println("service lovePlus2");
		int p_no = Integer.parseInt(req.getParameter("p_no"));
		String u_id = (String) req.getSession().getAttribute("loginId");
		// String u_id = "user1"; //????????? ??????
		BoardDAO dao = new BoardDAO();
		boolean success = false;
		int result = 0;
		try {
			dao.conn.setAutoCommit(false);
			if (dao.lovePlus(u_id, p_no)) {
				result = dao.loveCountPlus(p_no);
				System.out.println("[DAO] loveCountPlus result : " + result);
			}
			if (result > 0) {
				dao.conn.commit();
				success = true;
			} else {
				dao.conn.rollback();
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		dao.resClose();

		// ????????? Ajax??? ???????????? ?????????
		HashMap<String, Object> map = new HashMap<String, Object>();
		map.put("success", success);
		// resp.setContextType("text/html" charset=UTF-8"); //?????? ????????? ?????? ??????
		// resp.setHeader("Access-Control-Allow-origin", "*"); //View ??? ????????? ????????? ????????? ??????
		// ??????
		resp.getWriter().println(new Gson().toJson(map));

	}

	// ajax??? lovePlus2 ??????
	public void loveMinus2() throws IOException {
		System.out.println("service loveMinus2");
		int p_no = Integer.parseInt(req.getParameter("p_no"));
		String u_id = (String) req.getSession().getAttribute("loginId");
		// String u_id = "user1"; //????????? ??????
		BoardDAO dao = new BoardDAO();
		boolean success = false;
		int result = 0;
		try {
			dao.conn.setAutoCommit(false);
			if (dao.loveMinus(u_id, p_no)) {
				result = dao.loveCountMinus(p_no);
				System.out.println("[DAO] loveCountPlus result : " + result);
			}
			if (result > 0) {
				dao.conn.commit();
				success = true;
			} else {
				dao.conn.rollback();
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		dao.resClose();

		// ????????? Ajax??? ???????????? ?????????
		HashMap<String, Object> map = new HashMap<String, Object>();
		map.put("success", success);
		// resp.setContextType("text/html" charset=UTF-8"); //?????? ????????? ?????? ??????
		// resp.setHeader("Access-Control-Allow-origin", "*"); //View ??? ????????? ????????? ????????? ??????
		// ??????
		resp.getWriter().println(new Gson().toJson(map));

	}

	public boolean isBuyRequested() {
		int p_no = Integer.parseInt(req.getParameter("p_no"));
		String u_id = (String) req.getSession().getAttribute("loginId");
		// String u_id = "user1";
		BoardDAO dao = new BoardDAO();
		boolean isBuyRequested = dao.isBuyRequested(p_no, u_id);
		System.out.println("isBuyRequested : " + isBuyRequested);
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
	public void sold_list(String userid, int listwhatadd, int listhowaline) throws IOException {

		HashMap<String, Object> map = new HashMap<String, Object>();

		BoardDAO dao = new BoardDAO();
		ArrayList<GGDto> soldlist = null;

		try {
			soldlist = dao.sold_list(userid, listwhatadd, listhowaline);
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
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
			auctionlist = dao.auction_list(userid, listwhatadd);
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			dao.resClose();
			map.put("auctionlist", auctionlist);
		}
		System.out.println("auc_map:" + map);

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
		} finally {
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
		} finally {
			dao.resClose();
			map.put("communitylist", communitylist);
		}
		System.out.println(map);
		resp.setContentType("text/html; charset=UTF-8");
		resp.getWriter().println(new Gson().toJson(map));
		map.clear();
		dao.resClose();

	}

//????????? ????????? ?????????
	public void flow_list(String userid, int flowORflowing) throws IOException {

		HashMap<String, Object> map = new HashMap<String, Object>();

		BoardDAO dao = new BoardDAO();
		ArrayList<GGDto> flowlist = null;

		try {
			flowlist = dao.flowlist(userid, flowORflowing);
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			dao.resClose();
			map.put("flowlist", flowlist);
		}
		System.out.println("auc_map:" + map);
		resp.setContentType("text/html; charset=UTF-8");
		resp.getWriter().println(new Gson().toJson(map));
		map.clear();
		dao.resClose();
	}

	// ????????? ?????? +,- ??????
	public void flow_button(String userid, String btntext, String nick) throws IOException {

		System.out.println("userid_service:" + userid);
		System.out.println("btntext:" + btntext);
		System.out.println("nick_service:" + nick);

		if (btntext != null) {
			BoardDAO dao = new BoardDAO();
			int intSuccess;
			boolean success = false;
			try {
				intSuccess = dao.flowbut(userid, btntext, nick);
				System.out.println("intSuccess:" + intSuccess);
				success = true;
			} catch (SQLException e) {
				e.printStackTrace();
			} finally {
				dao.resClose();

				HashMap<String, Object> map = new HashMap<>();
				map.put("success", success);

				resp.setCharacterEncoding("UTF-8");
				resp.setContentType("text/html; charset=UTF-8");
				resp.getWriter().println(new Gson().toJson(map));
			}
		} else {
			System.out.println("null???");
		}

	}

//?????????????????????
	public void req_list(String userid, int reqindex) throws IOException {

		HashMap<String, Object> map = new HashMap<String, Object>();

		BoardDAO dao = new BoardDAO();
		ArrayList<GGDto> reqlist = null;

		try {
			reqlist = dao.reqlist(userid, reqindex);
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			dao.resClose();
			map.put("reqlist", reqlist);
		}
		System.out.println("auc_map:" + map);

		resp.setContentType("text/html; charset=UTF-8");
		resp.getWriter().println(new Gson().toJson(map));
		map.clear();
		dao.resClose();

	}

	public void updatereqlist(String rqno) throws IOException {

		BoardDAO dao = new BoardDAO();
		GGDto dto = null;
		HashMap<String, Object> map = new HashMap<String, Object>();
		boolean success = false;
		try {
			dto = dao.urllist(rqno);
			success = true;
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			dao.resClose();
			System.out.println("????????? ?????? ?????? : " + dto.getP_no());
			System.out.println("????????? ????????? ?????? : " + dto.getRq_no());
			System.out.println("????????? ????????? ????????? id : " + dto.getRq_id());
			System.out.println("????????? ????????? y/n?????? : " + dto.getRq_YN());

			map.put("info", dto);
			map.put("success", success);

			resp.setContentType("text/html; charset=UTF-8");
			resp.getWriter().print(new Gson().toJson(map));

		}
	}

//??????????????????
	public void love_list(String userid, int index1, int index2) throws IOException {

		HashMap<String, Object> map = new HashMap<String, Object>();

		BoardDAO dao = new BoardDAO();
		ArrayList<GGDto> lovelist = null;

		try {
			lovelist = dao.lovelist(userid, index1, index2);
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			map.put("lovelist", lovelist);
			dao.resClose();
		}
		System.out.println("auc_map:" + map);

		resp.setContentType("text/html; charset=UTF-8");
		resp.getWriter().println(new Gson().toJson(map));
		map.clear();
		dao.resClose();

	}

	public void report_list(String userid) throws IOException {
		HashMap<String, Object> map = new HashMap<String, Object>();

		BoardDAO dao = new BoardDAO();
		ArrayList<GGDto> reportlist = null;

		try {
			reportlist = dao.reportlist(userid);
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			map.put("reportlist", reportlist);
			dao.resClose();
		}
		System.out.println("auc_map:" + map);

		resp.setContentType("text/html; charset=UTF-8");
		resp.getWriter().println(new Gson().toJson(map));
		map.clear();
		dao.resClose();

	}

///////////////////////////////////////////////////////////////////////////////
	public HashMap<String, ArrayList<GGDto>> category() {
		BoardDAO dao = new BoardDAO();
		HashMap<String, ArrayList<GGDto>> map = dao.category();
		System.out.println("[Service ] category success : " + map);
		dao.resClose();
		return map;

	}

	public int writeCommu() {
		int p_no = -123;

		String p_id = (String) req.getSession().getAttribute("loginId");
		String p_title = req.getParameter("title");
		String p_content = req.getParameter("content");
		String p_cate = req.getParameter("category");
		String p_code = req.getParameter("select");

		// ????????????
		String adminYN = (String) req.getSession().getAttribute("adminYN");

		BoardDAO dao = new BoardDAO();
		GGDto dto = new GGDto();

		// ????????????
		if (adminYN.equals("Y")) {
			System.out.println("????????? : " + p_id);
			System.out.println("???????????? ????????? ?????? : " + p_title + " / ?????? : " + p_content + " / ??????????????? :" + adminYN
					+ " / ???????????? :" + p_code);

			dto.setP_id(p_id);
			dto.setP_title(p_title);
			dto.setP_content(p_content);
			dto.setU_adminYN(adminYN);
			dto.setP_code(p_code);

		} else { // ????????????
			System.out.println(
					"????????????????????? ?????? : " + p_title + " ?????? : " + p_content + " ???????????? :" + p_cate + " ???????????? :" + p_code);
			System.out.println("????????? : " + p_id);
			System.out.println("p_code : " + p_code);

			dto.setP_id(p_id);
			dto.setP_title(p_title);
			dto.setP_content(p_content);
			dto.setP_cate(p_cate);
			dto.setP_code(p_code);
			dto.setU_adminYN(adminYN);
		}

		try {
			p_no = dao.writeCommu(dto);
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
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

		System.out.println("Service ?????? ????????? ??????");
		System.out.println(p_id + "\n" + p_title + "\n" + p_content + "\n" + p_code);
		System.out.println(s_deliveryYN + "\n" + s_followLimYN + "\n" + s_code + "\n" + au_startPr);
		System.out.println(au_startTm + "\n" + au_instantPr + "\n" + au_endTm);

		if (au_instantPr == null) {
			au_instantPr = "999999999999";
			System.out.println("????????? ?????? ????????? : " + au_startPr);
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
			if (success > 0) {
				System.out.println("?????? ????????? ??????");
			}
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			dao.resClose();
		}
		// ?????? success ??? ???????????????.

		return success;
	}

	public int writeSale() {
		BoardDAO dao = new BoardDAO();

		String p_title = req.getParameter("title");
		String p_content = req.getParameter("content");
		String s_deliveryYN = req.getParameter("deliveryYN");
		String s_followLimYN = req.getParameter("disclosure");
		String s_code = req.getParameter("category");
		String ns_pr = req.getParameter("price");
		String p_code = req.getParameter("select");

		System.out.println(p_title + "/" + p_content + "/" + s_deliveryYN + "/" + s_followLimYN + "/" + s_code + "/"
				+ ns_pr + "/" + p_code);

		GGDto dto = new GGDto();
		dto.setP_id((String) req.getSession().getAttribute("loginId"));
		dto.setP_title(p_title);
		dto.setP_content(p_content);
		dto.setS_DeliveryYN(s_deliveryYN);
		dto.setS_followLimYN(s_followLimYN);
		dto.setS_code(s_code);
		dto.setNs_pr(Integer.parseInt(ns_pr));
		dto.setP_code(p_code);

		int p_no = dao.writeSale(dto);

		dao.resClose();
		
		return p_no;
	}

	// ?????? ????????????
	public GGDto auctionDetail() {
		int p_no = Integer.parseInt(req.getParameter("p_no"));
		System.out.println("????????? ???????????? ????????? : " + p_no);
		BoardDAO dao = new BoardDAO();
		TradeDAO t_dao = new TradeDAO();
		AlarmDAO Aldao = new AlarmDAO();

		GGDto dto = null;
		GGDto dto2 = null;
		try {
			dao.conn.setAutoCommit(false);
			int up = dao.upP_view(p_no);
			System.out.println("????????? ????????? :" + up);
			if (up > 0) { // ????????? ????????? ??????
				dto = dao.auctionDetail(p_no);
				System.out.println("???????????? dto : " + dto);

				Date endTm = dto.getAu_endTm();// ??????????????????
				String au_code = dto.getAu_code();// ????????????
				String ha_bidusr = dto.getHa_bidUsr();// ???????????????

				System.out.println("?????????????????? : " + endTm);
				System.out.println("???????????? : " + au_code);
				System.out.println("????????????????????? : " + ha_bidusr);

				java.util.Date nowDate = new java.util.Date();
				System.out.println("?????? ?????? : " + nowDate);

				SimpleDateFormat dateFormat = new SimpleDateFormat("yyyyMMddHHmmss");
				String endDateToStr = dateFormat.format(endTm);
				String nowDateToStr = dateFormat.format(nowDate);

				System.out.println("???????????? ??????????????????: " + endDateToStr);
				System.out.println("???????????? ????????????: " + nowDateToStr);

				// >0 : ???????????? ???

				Double result = Double.parseDouble(endDateToStr) - Double.parseDouble(nowDateToStr);
				System.out.println("???????????? - ???????????? = " + result);

				if (ha_bidusr.equals("-")) {
					System.out.println("????????? ??????x");
				} else {

					// ???????????? > ?????? ???????????? and ???????????? = '?????????'
					if (result < 0 && au_code.equals("Au001")) {

						System.out.println("????????? ??????o / ???????????? ????????? ?????? ");

						// ?????????????????? ????????? ??????
						dto2 = t_dao.endAuction(p_no, au_code, ha_bidusr);
						String successer = dto2.getAu_successer();// ?????? ????????? ????????????
						String p_id = dto2.getP_id();
						String p_title = dao.getTitle(p_no);
						int t_no = dto2.getT_no();
						// ???????????????
						Aldao.insertAlarm(successer, "A004", "[" + p_title + "..]???????????? ?????????????????????.", "Y",
								"./tradeDetail?t_no=" + t_no);// ????????? ?????????
						Aldao.insertAlarm(p_id, "A011", "[" + p_title + "..]????????? ?????? ???????????????.", "Y",
								"./auctionD?t_no=" + t_no);// ????????? ?????????
						Aldao.insertAlarm(p_id, "A004", "[" + p_title + "]" + successer + "?????? ???????????? ?????????????????????.", "Y",
								"./tradeDetail?t_no=" + t_no);// ????????? ?????????

						// dto ?????? ?????? dto.setAu_code(dto2.getAu_code());
						dto.setAu_sucTm(dto2.getAu_sucTm());
						dto.setAu_code(dto2.getAu_code());
						dto.setAu_successer(dto2.getAu_successer());

					} else {
						System.out.println("?????? ?????? ??? ??????");
					}
					////////////////////////////////////////////////
				}
			}
			if (dto == null) {
				dao.conn.rollback();
			} else {
				dao.conn.commit();
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			dao.resClose();
			t_dao.resClose();
			Aldao.resClose();
		}
		return dto;
	}

	/* ??? ?????? */
	public int commUpdate(int p_no) {

		int sucP_no = 0;

		String title = req.getParameter("title");
		String content = req.getParameter("content");
		String category = req.getParameter("category");
		// ????????? ??????
		String deliveryYN = req.getParameter("deliveryYN");
		String price = req.getParameter("price");
		String followLimYN = req.getParameter("followLimYN");
		// ????????? ??????
		String instantPr = req.getParameter("instantPr");
		String startPr = req.getParameter("startPr");
		String startTm = req.getParameter("startTm");
		String endTm = req.getParameter("endTm");

		BoardDAO dao = new BoardDAO();

		if (price != null) { // ????????? ??????
			System.out.println("?????? ??? ?????? ??? : " + title + "/" + content + "/" + category + "/ ???????????? : " + deliveryYN
					+ "/ ?????? : " + price + "/ ???????????? : " + followLimYN);
		} else if (startPr != null) { // ????????? ??????
			System.out.println("?????? ??? ?????? ??? : " + title + "/" + content + "/" + category + "/ ???????????? : " + deliveryYN
					+ "/ ?????? : " + price + "/ ???????????? : " + followLimYN + "/ ????????? : " + instantPr + "/ ????????? : " + startPr
					+ "/ ???????????? : " + startTm + "/ ???????????? : " + endTm);
		} else {// ???????????? ??????
			System.out.println("???????????? ?????? ??? : " + title + "/" + content + "/" + category);
		}

		sucP_no = dao.commUpdate(p_no, title, content, category, deliveryYN, price, followLimYN, instantPr, startPr,
				startTm, endTm);

		dao.resClose();
		return sucP_no;
	}

	public GGDto commUpdateForm() {
		String p_no = req.getParameter("p_no");
		System.out.println("?????? ?????? ??? ?????? : " + p_no);
		BoardDAO dao = new BoardDAO();
		GGDto dto = dao.commDetail(p_no);
		System.out.println("???????????? ??? dto : " + dto);
		dao.resClose();

		return dto;
	}

	public GGDto commDetail() {
		String p_no = req.getParameter("p_no");
		System.out.println("???????????? p_no : " + p_no);
		BoardDAO dao = new BoardDAO();
		GGDto dto = null;
		try {
			dao.conn.setAutoCommit(false);
			if (0 < dao.upP_view(Integer.parseInt(p_no))) {
				dto = dao.commDetail(p_no);
			}
			if (dto == null) {
				dao.conn.rollback();
			} else {
				dao.conn.commit();
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			dao.resClose();
		}
		return dto;
	}

	public GGDto noticeDetail() {
		String p_no = req.getParameter("p_no");
		System.out.println("???????????? ???????????? p_no : " + p_no);
		BoardDAO dao = new BoardDAO();
		GGDto dto = null;
		try {
			dao.conn.setAutoCommit(false);
			if (0 < dao.upP_view(Integer.parseInt(p_no))) {
				dto = dao.noticeDetail(p_no);
			}
			if (dto == null) {
				dao.conn.rollback();
			} else {
				dao.conn.commit();
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			dao.resClose();
		}
		return dto;
	}

	public void mainauc_list(String auctionmainlistwhatadd, int auctionmainlisthowaline) throws IOException {// ?????? ??????
		HashMap<String, Object> map = new HashMap<String, Object>();

		BoardDAO dao = new BoardDAO();
		ArrayList<GGDto> auctionmainlist = null;

		try {
			auctionmainlist = dao.auction_main_list(auctionmainlistwhatadd, auctionmainlisthowaline);
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			dao.resClose();
			map.put("auctionmainlist", auctionmainlist);
		}
		System.out.println("auc_main_map:" + map);

		resp.setContentType("text/html; charset=UTF-8");
		resp.getWriter().println(new Gson().toJson(map));
		map.clear();
		dao.resClose();

	}

	public void mainsold_list(String soldmainlistwhatadd) throws IOException {
		HashMap<String, Object> map = new HashMap<String, Object>();

		BoardDAO dao = new BoardDAO();
		ArrayList<GGDto> soldmainlist = null;

		try {
			soldmainlist = dao.sold_main_list(soldmainlistwhatadd);
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			dao.resClose();
			map.put("soldmainlist", soldmainlist);
		}
		System.out.println("sold_main_map:" + map);

		resp.setContentType("text/html; charset=UTF-8");
		resp.getWriter().println(new Gson().toJson(map));
		map.clear();

		dao.resClose();

	}

	public ArrayList<GGDto> commList(String[] categorys) {
		int pagePerCnt = 14;
		BoardDAO dao = new BoardDAO();
		ArrayList<GGDto> arrayList = new ArrayList<GGDto>();
		ArrayList<GGDto> commList = dao.commList(categorys);
		int totalPage = (int) Math.ceil((double) commList.size() / (double) pagePerCnt); // ?????? ????????? ????????? ??????. -????????? ?????????
																							// double?????? ???????????? ????????? ????????? ??????
																							// ??????
		int currPageNum = Integer.parseInt(req.getParameter("currPageNum")); // ???????????? ????????? ?????????.
		if (currPageNum * 5 > totalPage) { // ????????? ????????? ????????? ????????? ?????? ???????????? ??????
			currPageNum = (int) Math.ceil((double) totalPage / (double) 5);
		} else if (currPageNum < 0) {
			currPageNum = 1;
		}
		int currPageEnd = currPageNum * 5;
		if (currPageEnd > totalPage) {
			currPageEnd = totalPage; // ????????? ????????? ???????????? ????????? ??????????????? ????????? ???????????? ???????????? ??????
		}
		int currPageStart = (currPageNum - 1) * 5 + 1;
		int currPage = Integer.parseInt(req.getParameter("currPage"));
		if (currPage > currPageEnd || currPageStart > currPage) { // ????????? ?????? ???????????? ????????? ????????? ????????? ?????? ????????? ????????? ?????? ??????????????? ??????
			currPage = currPageStart;
		}
		// ???????????? ???????????? ????????? dto????????? ArrayList(commList)??? ?????????.
		int end = currPage * pagePerCnt;
		int start = end - pagePerCnt + 1;
		if (commList.size() <= end) {
			end = commList.size(); // 14????????? ?????? ????????? ???????????? ???????????? ????????? ???????????? ?????????
		}
		if(commList.size()!=0) { // commList??? ???????????? 0??? ?????? list??? ????????? ???????????? ????????? ??????????????? ????????? ?????????
			// ?????? ArrayList?????? ?????? ???????????? ???????????? ???????????? ?????? (ArrayList?????? ?????????) - ?????? List??? ?????????.
			List<GGDto> list = commList.subList(start - 1, end); // 14?????? ???????????? ????????? ????????? ??????.
			// List??? ArrayList??? ??????.
			arrayList.addAll(list);
			arrayList.get(0).setTotalPage(totalPage); // 0?????? dto??? totalPage??? ?????????.
			if (currPage > currPageEnd) {
				currPageEnd = currPage;
			}
			arrayList.get(0).setCurrPage(currPage);
			System.out.println("currPage : " + currPage);
			arrayList.get(0).setCurrPageEnd(currPageEnd); // 0?????? dto??? currPage??? ?????????.
			arrayList.get(0).setCurrPageStart(currPageStart);
		}
		return arrayList;
	}

	/* ?????? ??? ?????? */
	public GGDto salesUpdateForm() {
		int SalesP_no = Integer.parseInt(req.getParameter("p_no"));
		System.out.println("?????? ?????? ??? ?????? : " + SalesP_no);
		BoardDAO dao = new BoardDAO();
		GGDto dto = dao.salesDetail(SalesP_no);
		System.out.println("???????????? dto : " + dto);
		dao.resClose();
		return dto;
	}

	/* ?????? ??? ?????? */
	public GGDto auctionUpdateForm() {
		int AuctionP_no = Integer.parseInt(req.getParameter("p_no"));
		System.out.println("?????? ?????? ??? ?????? : " + AuctionP_no);
		BoardDAO dao = new BoardDAO();
		GGDto dto = new GGDto();

		try {
			dto = dao.auctionDetail(AuctionP_no);
			System.out.println("???????????? dto : " + dto);

		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			dao.resClose();
		}

		return dto;
	}

	public String details(int p_no, String id) {
		System.out.println("???????????? ??? ??? ?????? : " + p_no);
		BoardDAO dao = new BoardDAO();
		String des = "";
		try {
			String code = dao.details(p_no, id);
			System.out.println("code : " + code);
			if (code.equals("P001")) {
				des = "auctionDetail.jsp?p_no=" + p_no;
			} else if (code.equals("P002")) {
				des = "salesDetail.jsp?p_no=" + p_no;
			} else if (code.equals("P004")) {
				des = "commDetailForm.jsp?p_no=" + p_no;
			} else {
				des = "noticeDetail.jsp?p_no="+p_no;
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			dao.resClose();
		}
		return des;
	}

	public boolean postDel() {
		String p_no = req.getParameter("p_no");
		BoardDAO dao = new BoardDAO();
		return dao.postDel(p_no);
	}

	public ArrayList<GGDto> noticeList(int paging, int currPageNum) {

		BoardDAO dao = new BoardDAO();
		ArrayList<GGDto> noticeList = dao.noticeList(paging, currPageNum);
		dao.resClose();

		return noticeList;
	}




	// ????????? ???????????? ????????? ????????????
	/*
	 * public String auctionDelete() { String delMsg = null; int p_no =
	 * Integer.parseInt(req.getParameter("p_no"));
	 * System.out.println("????????? ?????? ??? ??????:"+p_no); BoardDAO dao = new BoardDAO();
	 * TradeDAO tdao = new TradeDAO(); boolean success = false; try {
	 * dao.conn.setAutoCommit(false); tdao.conn.setAutoCommit(false); delMsg =
	 * dao.auctionDelete(p_no);
	 * System.out.println("[BoardDAO]/actionDelete delMsg : "+delMsg);
	 * if(!delMsg.equals("")) { success = tdao.updateAuctionAu_code(p_no, "Au003");
	 * } if(success) { dao.conn.commit(); tdao.conn.commit(); } } catch
	 * (SQLException e) { e.printStackTrace(); } dao.resClose(); tdao.resClose();
	 * 
	 * return delMsg; }
	 */

}
