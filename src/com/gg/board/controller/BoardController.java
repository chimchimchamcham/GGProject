package com.gg.board.controller;

import java.io.IOException;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.gg.board.service.BoardService;
import com.gg.dto.GGDto;
import com.google.gson.Gson;


@WebServlet({ "/salesDetail", "/loveMinus", "/lovePlus", "/loveMinus2", "/lovePlus2", "/soldlist", "/auctionlist",
		"/maidelist", "/writeForm", "/writeSale", "/writeTrade", "/postDel", "/writeCommunity", "/auctionDetail",
		"/commDetail", "/commUpdateForm", "/commUpdate", "/communitylist", "/auctionmainlist", "/commList",
		"/salesUpdateForm", "/salesUpdate", "/details", "/auctionUpdateForm", "/auctionUpdate", "/flowlist",
		"/requestlist", "/lovelist", "/delAuction", "/flowadddelect","/noticeDetail","/applyreqlist","/noticeList"})


public class BoardController extends HttpServlet {

	private static final long serialVersionUID = 1L;

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
			dual(req, resp);

	}

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
			dual(req, resp);

	}

	private void dual(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		String uri = req.getRequestURI();
		String ctx = req.getContextPath();
		String addr = uri.substring(ctx.length());
		System.out.println("addr : " + addr);

		RequestDispatcher dis = null;
		String page = "";
		String msg = "";
		BoardService service = new BoardService(req, resp);
		GGDto bdto = null;
		boolean success = false;
		int p_no;
		String userid;
		switch (addr) {

		case "/salesDetail":
			System.out.println("판매글 상세보기");
			GGDto dto = service.salesDetail();

			// 좋아요를 눌렀는지 확인
			boolean isLiked = false;
			isLiked = service.isLiked();

			// 구매요청을 눌렀는지 확인
			boolean isBuyRequested = false;
			isBuyRequested = service.isBuyRequested();

			// 팔로우를 했는지 안했는지 확인
			boolean isFollowed = false;
			//isFollowed = service.isFollowed();
			
			// 판매자의 판매목록 3개를 가져오기
			String p_id = dto.getP_id();
			System.out.println("p_id : " + p_id);
			ArrayList<GGDto> sale3List = service.sale3List(p_id);
			System.out.println("sale3List size" + sale3List.size());

			req.setAttribute("dto", dto);
			req.setAttribute("isLiked", isLiked);
			req.setAttribute("isBuyRequested", isBuyRequested);
			//req.setAttribute("isFollowed", isFollowed);
			req.setAttribute("sale3List", sale3List);

			dis = req.getRequestDispatcher("salesDetail.jsp");
			dis.forward(req, resp);
			break;

		case "/lovePlus":
			System.out.println("찜 +1 추가");
			success = service.lovePlus();
			System.out.println("[Controller ] lovePluse success : " + success);
			p_no = Integer.parseInt(req.getParameter("p_no"));
			dis = req.getRequestDispatcher("/salesDetail?p_no=" + p_no);
			dis.forward(req, resp);
			break;

		case "/loveMinus":
			System.out.println("찜 -1 제거");
			success = service.loveMinus();
			System.out.println("[Controller ] loveMinus success : " + success);
			p_no = Integer.parseInt(req.getParameter("p_no"));
			// resp.sendRedirect("./salesDetail?p_no="+p_no);
			dis = req.getRequestDispatcher("/salesDetail?p_no=" + p_no);
			dis.forward(req, resp);
			break;

		// Ajax를 사용한 lovePlus
		case "/lovePlus2":
			System.out.println("찜 +1 추가");
			service.lovePlus2();
			break;
		// Ajax를 사용함 loveMinus
		case "/loveMinus2":
			System.out.println("찜 -1 추가");
			service.loveMinus2();
			break;

		/*
		 * ===========================================================================
		 */
		case "/soldlist":
			System.out.println("판매 리스트 요청");
			userid = (String) req.getSession().getAttribute("loginId");

			int listwhatadd = Integer.parseInt(req.getParameter("index1"));
			int listhowaline = Integer.parseInt(req.getParameter("index2"));

			System.out.println("listwhatadd:" + listwhatadd);
			System.out.println("listhowaline:" + listhowaline);

			service.sold_list(userid, listwhatadd, listhowaline);

			break;

		case "/auctionlist":
			System.out.println("경매 리스트 요청");

			String userid1 = (String) req.getSession().getAttribute("loginId");

			int auctionlistwhatadd = Integer.parseInt(req.getParameter("index1"));
			int auctionlisthowaline = Integer.parseInt(req.getParameter("index2"));

			System.out.println("listwhatadd:" + auctionlistwhatadd);
			service.auc_list(userid1, auctionlistwhatadd);

			break;

		case "/auctionmainlist":
			System.out.println("경매 매인 리스트 요청");

			// String userid1 = (String) req.getSession().getAttribute("loginId");

			String auctionmainlistwhatadd = req.getParameter("index_button_auction");
			int auctionmainlisthowaline = Integer.parseInt(req.getParameter("index2"));

			System.out.println("auctionmainlisthowaline:" + auctionmainlistwhatadd);
			System.out.println("auctionmainlisthowaline:" + auctionmainlisthowaline);

			service.mainauc_list(auctionmainlistwhatadd, auctionmainlisthowaline);

			break;

		case "/maidelist":
			System.out.println("판매 리스트 요청");
			userid = (String) req.getSession().getAttribute("loginId");

			service.maide_list(userid);

			break;

		case "/communitylist":
			System.out.println("커뮤니티 리스트 요청");
			userid = (String) req.getSession().getAttribute("loginId");

			service.community_list(userid);

			break;
		case "/flowlist":
			System.out.println("팔로잉리스트 리스트 요청");
			userid = (String) req.getSession().getAttribute("loginId");
			int flowORflowing = Integer.parseInt(req.getParameter("index1"));		
			service.flow_list(userid,flowORflowing);
			
		case "/flowadddelect":
            System.out.println("팔로워 버튼 처리 요청");
            req.setCharacterEncoding("utf-8");
            userid = (String) req.getSession().getAttribute("loginId");
            String btntext = req.getParameter("btntext");
            String nick = req.getParameter("nick");
            
            /*
             * System.out.println("userid:"+userid);
             * System.out.println("flow_addordelect:"+flow_addordelect);
             * System.out.println("nick:"+nick);
             */
            
            
            service.flow_button(userid,btntext,nick);

            break;
			
		case "/requestlist":
			System.out.println("거래요청리스트 요청");
			userid = (String) req.getSession().getAttribute("loginId");
			int reqindex = Integer.parseInt(req.getParameter("index1"));

			service.req_list(userid, reqindex);

			break;
			
		case "/applyreqlist":
			System.out.println("거래수락 or 거절 요청");
			String rqnoval = req.getParameter("rqno_val");
			String rqnotext = req.getParameter("rqno_text");
			
			System.out.println("rqnoval:"+rqnoval);
			System.out.println("rqnotext:"+rqnotext);
			service.updatereqlist(rqnoval);
			break;
			
		case "/lovelist":
			System.out.println("좋아요리스트 리스트 요청");
			userid = (String) req.getSession().getAttribute("loginId");
			int index1 = Integer.parseInt(req.getParameter("index1"));
			int index2 = Integer.parseInt(req.getParameter("index1"));
			service.love_list(userid, index1, index2);

			break;
		/* ====== 글쓰기 ====== */

		case "/writeForm":
			System.out.println("글쓰기 폼 요청");
			HashMap<String, ArrayList<GGDto>> map = service.category();
			System.out.println("[Controller ] category success : " + map);
			ArrayList<GGDto> commuCat = map.get("commuCat");
			ArrayList<GGDto> saleCat = map.get("saleCat");
			System.out.println("saleCat list size : " + saleCat.size());
			System.out.println("commuCat list size : " + commuCat.size());
			req.setAttribute("saleCat", saleCat);
			req.setAttribute("commuCat", commuCat);
			dis = req.getRequestDispatcher("writeForm.jsp");
			dis.forward(req, resp);
			break;

		case "/writeSale":
			System.out.println("판매글 쓰기 요청");
			p_no = service.writeSale();
			HashMap<String, Object> sue_map = new HashMap<String, Object>();
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
			jo_map = new HashMap<String, Object>();

			jo_map.put("p_no", p_no);
			resp.getWriter().println(new Gson().toJson(jo_map));
			break;

		/*
		 * case "/upload": System.out.println("글 쓰기 파일 업로드 요청"); UploadService uploadSer
		 * = new UploadService(req); dto = uploadSer.PhotoUpload(); int uploadSuccess =
		 * 0; sue_map = new HashMap<String, Object>();
		 * 
		 * UploadDAO uploadDAO = new UploadDAO(); uploadSuccess =
		 * uploadDAO.PhotoUpload(dto); sue_map.put("success", uploadSuccess);
		 * resp.getWriter().println(new Gson().toJson(sue_map)); break;
		 */

		/* ====== 커뮤니티 글수정 ====== */
		case "/commUpdateForm":
			System.out.println("커뮤니티 수정 폼 요청");
			// 카테고리
			map = service.category();
			System.out.println("[Controller ] category success : " + map);
			commuCat = map.get("commuCat");
			req.setAttribute("commuCat", commuCat);

			// 글 내용
			req.setAttribute("commUpdate", service.commUpdateForm());
			dis = req.getRequestDispatcher("commUpdate.jsp");
			dis.forward(req, resp);
			break;

		case "/commUpdate":
			System.out.println("커뮤니티 수정 요청");
			p_no = Integer.parseInt(req.getParameter("p_no"));
			System.out.println("수정요청 글 번호 : " + p_no);
			int sucP_no = service.commUpdate(p_no);
			System.out.println("수정 성공 글 번호 : " + sucP_no);

			HashMap<String, Object> commUpdateMap = new HashMap<String, Object>();
			commUpdateMap.put("sucP_no", sucP_no);
			resp.setContentType("text/html; charset=UTF-8");
			resp.getWriter().println(new Gson().toJson(commUpdateMap));

			break;

		/* ====== 판매 글수정 ====== */
		case "/salesUpdateForm":
			System.out.println("판매글 수정 요청");

			// 카테고리
			map = service.category();
			System.out.println("[Controller ] category success : " + map);

			saleCat = map.get("saleCat");
			System.out.println("saleCat list size : " + saleCat.size());
			req.setAttribute("saleCat", saleCat);

			// 글 내용
			req.setAttribute("salesUpdate", service.salesUpdateForm());
			dis = req.getRequestDispatcher("salesUpdate.jsp");
			dis.forward(req, resp);

			break;

		case "/salesUpdate":
			System.out.println("판매 글 수정 요청");
			p_no = Integer.parseInt(req.getParameter("p_no"));
			System.out.println("수정요청 글 번호 : " + p_no);
			sucP_no = service.commUpdate(p_no);
			System.out.println("수정 성공 글 번호 : " + sucP_no);

			HashMap<String, Object> salesUpdateMap = new HashMap<String, Object>();
			salesUpdateMap.put("sucP_no", sucP_no);
			resp.setContentType("text/html; charset=UTF-8");
			resp.getWriter().println(new Gson().toJson(salesUpdateMap));

			break;

		/* ====== 경매 글수정 ====== */
		case "/auctionUpdateForm":
			System.out.println("경매 수정 폼 요청");

			// 카테고리
			map = service.category();
			System.out.println("[Controller ] category success : " + map);

			saleCat = map.get("saleCat");
			System.out.println("saleCat list size : " + saleCat.size());
			req.setAttribute("saleCat", saleCat);

			// 글 내용
			req.setAttribute("auctionUpdate", service.auctionUpdateForm());
			dis = req.getRequestDispatcher("auctionUpdate.jsp");
			dis.forward(req, resp);

			break;

		case "/auctionUpdate":
			System.out.println("경매 글 수정 요청");
			p_no = Integer.parseInt(req.getParameter("p_no"));
			System.out.println("수정요청 글 번호 : " + p_no);
			sucP_no = service.commUpdate(p_no);
			System.out.println("수정 성공 글 번호 : " + sucP_no);

			HashMap<String, Object> auctionUpdateMap = new HashMap<String, Object>();
			auctionUpdateMap.put("sucP_no", sucP_no);
			resp.setContentType("text/html; charset=UTF-8");
			resp.getWriter().println(new Gson().toJson(auctionUpdateMap));

			break;

		/* ========================= */
		case "/details":

			System.out.println("걸러주는 디테일즈");
			p_no = Integer.parseInt(req.getParameter("p_no"));
			String id = req.getParameter("id");
			System.out.println("이것이 번호다 : " + p_no);
			System.out.println("이것이 아이디다 : " + id);
			service = new BoardService(req, resp);
			String des = service.details(p_no, id);
			if (des.equals("auctionDetail.jsp?p_no=" + p_no)) {
				System.out.println("경매글 상세보기 요청");
				dto = service.auctionDetail(); // 경매글 해당 글번호 내용 dto로 반환
				// System.out.println("[Controller] 경매글 상세보기 반환:"+dto);
				// System.out.println("[Controller] 경매 내용 : "+dto.getP_content());
				// System.out.println("[Controller] 경매 제목 : "+dto.getP_title());

				//// 시작 시간, 종료시간 형식 변환/////
				DateFormat dateFormat = new SimpleDateFormat("yyyyMMddHHmmss");
				Date au_endTm = dto.getAu_endTm();
				Date au_startTm = dto.getAu_startTm();

				System.out.println("au_endTm : " + au_endTm);
				System.out.println("au_startTm : " + au_startTm);

				String endTm = dateFormat.format(au_endTm);
				String startTm = dateFormat.format(au_startTm);
				///////////////

				// 좋아요를 눌렀는지 확인
				isLiked = false;
				isLiked = service.isLiked();

				// 구매요청을 눌렀는지 확인
				isBuyRequested = false;
				isBuyRequested = service.isBuyRequested();

				req.setAttribute("dto", dto);
				req.setAttribute("isLiked", isLiked); // 좋아요여부

				req.setAttribute("endTm", endTm);
				req.setAttribute("startTm", startTm);

				dis = req.getRequestDispatcher("auctionDetail.jsp");
				dis.forward(req, resp);
			} else if (des.equals("salesDetail.jsp?p_no=" + p_no)) {
				System.out.println("판매글 상세보기");
				dto = service.salesDetail();

				// 좋아요를 눌렀는지 확인
				isLiked = false;
				isLiked = service.isLiked();

				// 구매요청을 눌렀는지 확인
				isBuyRequested = false;
				isBuyRequested = service.isBuyRequested();

				// 판매자의 판매목록 3개를 가져오기
				p_id = dto.getP_id();
				System.out.println("p_id : " + p_id);
				sale3List = service.sale3List(p_id);
				System.out.println("sale3List size" + sale3List.size());

				req.setAttribute("dto", dto);
				req.setAttribute("isLiked", isLiked);
				req.setAttribute("isBuyRequested", isBuyRequested);
				req.setAttribute("sale3List", sale3List);

				dis = req.getRequestDispatcher("salesDetail.jsp");
				dis.forward(req, resp);

			} else if (des.equals("commDetailForm.jsp?p_no=" + p_no)) {
				System.out.println("커뮤니티 상세보기 요청");
				dto = service.commDetail();
				req.setAttribute("dto", dto);
				dis = req.getRequestDispatcher("commDetailForm.jsp");
				dis.forward(req, resp);
			} else {
				dis = req.getRequestDispatcher("index.jsp");
				dis.forward(req, resp);
			}

			break;

		/* ======================== */
		case "/auctionDetail":
			System.out.println("경매글 상세보기 요청");
			dto = service.auctionDetail(); // 경매글 해당 글번호 내용 dto로 반환
			// System.out.println("[Controller] 경매글 상세보기 반환:"+dto);
			// System.out.println("[Controller] 경매 내용 : "+dto.getP_content());
			// System.out.println("[Controller] 경매 제목 : "+dto.getP_title());

			//// 시작 시간, 종료시간 형식 변환/////
			DateFormat dateFormat = new SimpleDateFormat("yyyyMMddHHmmss");
			Date au_endTm = dto.getAu_endTm();
			Date au_startTm = dto.getAu_startTm();

			System.out.println("au_endTm : " + au_endTm);
			System.out.println("au_startTm : " + au_startTm);

			String endTm = dateFormat.format(au_endTm);
			String startTm = dateFormat.format(au_startTm);
			///////////////

			// 좋아요를 눌렀는지 확인
			isLiked = false;
			isLiked = service.isLiked();

			// 구매요청을 눌렀는지 확인
			isBuyRequested = false;
			isBuyRequested = service.isBuyRequested();

			req.setAttribute("dto", dto);
			req.setAttribute("isLiked", isLiked); // 좋아요여부

			req.setAttribute("endTm", endTm);
			req.setAttribute("startTm", startTm);

			dis = req.getRequestDispatcher("auctionDetail.jsp");
			dis.forward(req, resp);

			break;

		case "/commDetail":
			System.out.println("커뮤니티 상세보기 요청");
			dto = service.commDetail();

			req.setAttribute("dto", dto);
			dis = req.getRequestDispatcher("commDetailForm.jsp");
			dis.forward(req, resp);
			break;

		case "/noticeDetail":
			System.out.println("공지사항 상세보기 요청");
			dto = service.noticeDetail();
			req.setAttribute("dto", dto);
			dis = req.getRequestDispatcher("noticeDetail.jsp");
			dis.forward(req, resp);
			break;

		case "/commList":
	         resp.setCharacterEncoding("UTF-8");
	         ArrayList<GGDto> list = service.commList();
	         HashMap<String, ArrayList<GGDto>> list_map = new HashMap<String, ArrayList<GGDto>>();
	         list_map.put("list", list);
	         resp.setContentType("text/html; charset=UTF-8");
	         resp.getWriter().println(new Gson().toJson(list_map));
	         break;
			
		case "/postDel":
			System.out.println("게시글 삭제 요청");
			success = false;
			msg = null;
			success = service.postDel();
			if (success) {
				msg = "삭제에 성공했습니다.";
			}
			req.setAttribute("msg", msg);
			dis = req.getRequestDispatcher("index.jsp");
			dis.forward(req, resp);
			break;
			
			
		//공지사항 목록
		case "/noticeList":
			System.out.println("공지사항 리스트 요청");
			
			/* int paging = 0; */
			String currPageNum = req.getParameter("currPageNum");
			System.out.println("currPageNum : "+currPageNum);
			String paging = req.getParameter("paging");
			if(paging == null) {
				paging = "1";
			}
			System.out.println("paging : "+paging);
			
			/* HashMap<String, Object> map = service. */
			
			req.setAttribute("noticeList", service.noticeList(Integer.parseInt(paging)));
			req.setAttribute("noticeListSize", service.noticeList(Integer.parseInt(paging)).get(0).getTotalPost());
			dis = req.getRequestDispatcher("noticeList.jsp");
			dis.forward(req, resp);

			break;

		// 메서드 통합으로 인하여 주석처리
		/*
		 * case "/delAuction":
		 * 
		 * System.out.println("경매글 삭제 요청"); p_no =
		 * Integer.parseInt(req.getParameter("p_no")); req.setAttribute("delMsg",
		 * service.auctionDelete()); dis =
		 * req.getRequestDispatcher("/auctionDetail?p_no="+p_no); dis.forward(req,
		 * resp); break;
		 */
		}

	}

}
