package com.gg.user.service;

import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.util.ArrayList;
import java.util.HashMap;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import com.gg.dto.GGDto;
import com.gg.user.dao.UserDAO;
import com.google.gson.Gson;

public class UserService {

	HttpServletRequest req = null;
	HttpServletResponse resp = null;
	boolean success;

	public UserService(HttpServletRequest req, HttpServletResponse resp) {
		try {
			req.setCharacterEncoding("UTF-8");
			this.req = req;
			this.resp = resp;
		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
		}

	}

	public boolean join() {
		success = false;
		System.out.println("회원 가입 요청 확인");
		String u_id = req.getParameter("id"); // 아이디
		String u_pw = req.getParameter("pw"); // 비밀번호
		String u_name = req.getParameter("name"); // 이름
		String u_nname = req.getParameter("nname"); // 닉네임
		String u_phone = req.getParameter("phone1"); // 핸드폰 앞번호
		String u_phone2 = req.getParameter("phone2"); // 핸드폰 중간번호
		String u_phone3 = req.getParameter("phone3"); // 핸드폰 끝번호
		String u_email = req.getParameter("email"); // 메일 앞부분
		String u_mail = req.getParameter("mail"); // 메일 뒷부분(ex]naver.com)
		String u_addr = req.getParameter("addr"); // 대략적 주소
		String u_detailAddr = req.getParameter("detailAddr"); // 상세 주소

		System.out.println("들어온 인자 값 확인!");
		System.out.println(u_id + "/" + u_pw + "/" + u_name + "/" + u_nname + "/" + u_phone + "/" + u_phone2 + "/"
				+ u_phone3 + "/" + u_email + "/" + u_mail + "/" + u_addr + "/" + u_detailAddr);

		// 메일 합치기
		u_email += "@" + u_mail;
		System.out.println("이메일 확인 : " + u_email);
		// 핸드폰 번호 합치기
		u_phone += "-" + u_phone2 + "-" + u_phone3;
		System.out.println("핸드폰 번호 확인 : " + u_phone);

		GGDto dto = new GGDto();
		// DTO에 값을 넣어주기.
		dto.setU_id(u_id);
		dto.setU_pw(u_pw);
		dto.setU_name(u_name);
		dto.setU_nname(u_nname);
		dto.setU_phone(u_phone);
		dto.setU_email(u_email);
		dto.setU_addr(u_addr);
		dto.setU_detailAddr(u_detailAddr);

		UserDAO dao = new UserDAO();
		Gson gson = null;

		try {
			HashMap<String, Object> map = new HashMap<String, Object>();
			success = dao.join(dto);
			map.put("success", success);
			gson = new Gson();
			String obj = gson.toJson(map);

			resp.getWriter().println(obj);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			dao.resClose();
		}

		return success;
	}

	public void idOverlay() {
		String id = req.getParameter("id");
		System.out.println("중복체크 아이디 : " + id);
		UserDAO dao = new UserDAO();
		boolean overlay = false; // 중복 체크용
		success = false; // DB 접속 성공 여부 => true면 안된다.

		overlay = dao.idOverlay(id);
		if (overlay == true || overlay == false) { // 뭐가 됐든 접속 성공한다면...
			success = true; // 접속 성공여부 반환
		}

		dao.resClose(); // DB 연결 종료.

		Gson gson = new Gson();
		HashMap<String, Object> map = new HashMap<String, Object>();
		map.put("success", success);
		map.put("overlay", overlay);

		String obj = gson.toJson(map);
		// 아이디는 영어만 들어간다.
		try {
			resp.getWriter().println(obj);
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

	}

	public void nNameOverlay() {
		String nname = req.getParameter("nname");
		System.out.println("중복 체크 닉네임 : " + nname);
		UserDAO dao = new UserDAO();
		boolean overlay = false; // 중복 체크용
		success = false; // DB 접속 성공 여부 => true면 안된다.

		overlay = dao.nNameOverlay(nname);
		if (overlay == true || overlay == false) { // 뭐가 됐든 접속 성공한다면...
			success = true; // 접속 성공여부 반환
		}

		dao.resClose();
		Gson gson = new Gson();
		HashMap<String, Object> map = new HashMap<String, Object>();
		map.put("success", success);
		map.put("overlay", overlay);

		String obj = gson.toJson(map);
		// 아이디는 영어만 들어간다.
		try {
			resp.getWriter().println(obj);
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

	}

	public ArrayList<String> login() {
		String loginId = req.getParameter("loginId");
		String loginPw = req.getParameter("loginPw");
		UserDAO dao = new UserDAO();
		return dao.login(loginId, loginPw);
	}

	public boolean logout() {
		success = false;
		if (req.getSession().getAttribute("loginId") != null) {
			req.getSession().removeAttribute("loginId");
			success = true;
		}
		return success;
	}

	public void idsearch() {
		String name = req.getParameter("name");
		String email = req.getParameter("email") + "@" + req.getParameter("mail");
		System.out.println("name : " + name + " email : " + email);
		UserDAO dao = new UserDAO();
		HashMap<String, Object> map = new HashMap<String, Object>();
		map.put("id", dao.idsearch(name, email));
		Gson gson = new Gson();

		String obj = gson.toJson(map);
		try {
			resp.getWriter().println(obj);
		} catch (IOException e) {
			e.printStackTrace();
		}
	}

	public GGDto myPage() {
		String id = (String) req.getSession().getAttribute("loginId");
		String oppId = req.getParameter("id");
		System.out.println("서비스 진입 : " + id);
		UserDAO dao = new UserDAO();
		GGDto dto = new GGDto();
		if (id != null) { // 로그인 했을 때
			if (id.equals(oppId) || oppId == null) { // 내글에서 내프로필 갈때 / 마이페이지
				dto = dao.myPage(id);
				dto.setMyYN(true);
				System.out.println("마이 프로필 여부 : " + dto.isMyYN());
			} else if (!id.equals(oppId)) { // 로그인했는데 타인프로필
				dto = dao.myPage(oppId);
				dto.setMyYN(false);
				System.out.println("마이 프로필 여부 : " + dto.isMyYN());
			}
		} else { // 로그인 안됐을 때 타인프로필
			dto = dao.myPage(oppId);
			dto.setMyYN(false);
			System.out.println(dto.isMyYN());
		}
		dao.resClose();
		return dto;
	}

	public Object userUpdateForm() {
		String id = (String) req.getSession().getAttribute("loginId");
		System.out.println("회원정보 수정 id : " + id);

		UserDAO dao = new UserDAO();
		GGDto dto = dao.myPage(id);
		System.out.println("회원정보 수정 dto : " + dto);
		dao.resClose();

		return dto;
	}

	public String chkpw() {
		UserDAO dao = new UserDAO();
		GGDto dto = new GGDto();
		dto.setU_id(req.getParameter("id"));
		dto.setU_name(req.getParameter("name"));
		dto.setU_email(req.getParameter("email"));
		return dao.chkpw(dto);
	}

	public int userUpdate(String id) {

		int success = 0;
		UserDAO dao = new UserDAO();

		UserUploadService upload = new UserUploadService(req);
		// 회원정보 받아옴 파라미터
		GGDto dto = upload.PhotoUpload(); // 새로운 사진 이름만 바꿔서 dto에 저장한거임
		success = dao.userUpdate(dto); // 회원정보 수정(사진제외)
		System.out.println("회원정보수정 요청 확인");
		String u_id = (String) req.getSession().getAttribute("loginId"); // 세션아이디

		String u_pw = req.getParameter("pw"); // 비밀번호
		String u_name = req.getParameter("name"); // 이름
		String u_nname = req.getParameter("nname"); // 닉네임
		String u_phone = req.getParameter("phone1"); // 핸드폰 앞번호
		String u_phone2 = req.getParameter("phone2"); // 핸드폰 중간번호
		String u_phone3 = req.getParameter("phone3"); // 핸드폰 끝번호
		String u_email = req.getParameter("email"); // 메일 앞부분
		String u_mail = req.getParameter("mail"); // 메일 뒷부분(ex]naver.com)
		String u_addr = req.getParameter("addr"); // 대략적 주소
		String u_detailAddr = req.getParameter("detailAddr"); // 상세 주소

		System.out.println("회원정보 수정값 확인");
		System.out.println(u_id + "/" + u_pw + "/" + u_name + "/" + u_nname + "/" + u_phone + "/" + u_phone2 + "/"
				+ u_phone3 + "/" + u_email + "/" + u_mail + "/" + u_addr + "/" + u_detailAddr);

		// 메일 합치기
		u_email += "@" + u_mail;
		System.out.println("이메일 확인 : " + u_email);
		// 핸드폰 번호 합치기
		u_phone += "-" + u_phone2 + "-" + u_phone3;
		System.out.println("핸드폰 번호 확인 : " + u_phone);

		// DTO에 값을 넣어주기.
		dto.setU_id(u_id);
		dto.setU_pw(u_pw);
		dto.setU_name(u_name);
		dto.setU_nname(u_nname);
		dto.setU_phone(u_phone);
		dto.setU_email(u_email);
		dto.setU_addr(u_addr);
		dto.setU_detailAddr(u_detailAddr);

		dao = new UserDAO();

		// 기존사진 이름 가져와서 delFileName에 넣음
		String delFileName = dao.getFileName(id).getU_newName();
		System.out.println("삭제할 사진 파일 : " + delFileName);

		// 새로 업로드한 파일을 photo에 업데이트
		if (dto.getU_newName() != null) {
			dao.updateFileName(delFileName, dto);

			// 기존 파일을 지우고
			upload.del(delFileName);
		}
		dao.resClose();
		return success;
	}

	public int changePw() {
		String id = req.getParameter("id");
		String pw = req.getParameter("newPw");
		System.out.println("id : " + id + "newPw : " + pw);
		UserDAO dao = new UserDAO();
		return dao.changePw(id, pw);
	}

//관리페이지 목록
	public ArrayList<GGDto> userList() {
		UserDAO dao = new UserDAO();
		return dao.userList();
	}

	public ArrayList<GGDto> notifyList() {
		UserDAO dao = new UserDAO();
		return dao.notifyList();
	}

	public void search() {

	}

	public HashMap<String, ArrayList<GGDto>> category() {
		UserDAO dao = new UserDAO();
		HashMap<String, ArrayList<GGDto>> categoryMap = dao.category();
		dao.resClose();

		return categoryMap;
	}

	/*
	 * public ArrayList<GGDto> n_firstCatSel() {
	 * 
	 * String n_firstCatSel = req.getParameter("n_firstCatSel");
	 * System.out.println("선택 대분류명 : " + n_firstCatSel);
	 * 
	 * UserDAO dao = new UserDAO();
	 * 
	 * return list; }
	 */

}
