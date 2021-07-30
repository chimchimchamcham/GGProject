package com.gg.user.service;

import java.io.File;
import java.io.IOException;

import javax.servlet.http.HttpServletRequest;

import com.gg.dto.GGDto;
import com.gg.user.dao.UserDAO;
import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

public class UserUploadService {

	HttpServletRequest req = null;

	public UserUploadService(HttpServletRequest req) {
		this.req = req;
	}

	public GGDto PhotoUpload() {
		String savePath = "C:/photo/";// 1.저장경로 저장
		int maxSize = 10 * 1024 * 1024;// 2.용량제한(10MB)

		GGDto dto = null;

		// 업로드
		try {

			// 폴더 없을 경우 폴더 생성
			File dir = new File(savePath);
			if (!dir.exists()) {
				dir.mkdir();
			}

			MultipartRequest multi = new MultipartRequest(req, savePath, maxSize, "UTF-8",
					new DefaultFileRenamePolicy());

			dto = new GGDto();

			String u_id = (String) req.getSession().getAttribute("loginId"); // 세션아이디
			String u_pw = multi.getParameter("pw"); // 비밀번호
			String u_name = multi.getParameter("name"); // 이름
			String u_nname = multi.getParameter("nname"); // 닉네임
			String u_phone = multi.getParameter("phone1"); // 핸드폰 앞번호
			String u_phone2 = multi.getParameter("phone2"); // 핸드폰 중간번호
			String u_phone3 = multi.getParameter("phone3"); // 핸드폰 끝번호
			String u_email = multi.getParameter("email"); // 메일 앞부분
			String u_mail = multi.getParameter("mail"); // 메일 뒷부분(ex]naver.com)
			String u_addr = multi.getParameter("addr"); // 대략적 주소
			String u_detailAddr = multi.getParameter("detailAddr"); // 상세 주소
			String u_intro = multi.getParameter("intro"); //자기소개

			System.out.println("회원정보 수정값 확인");
			System.out.println(u_id + "/" + u_pw + "/" + u_name + "/" + u_nname + "/" + u_phone + "/" + u_phone2 + "/"
					+ u_phone3 + "/" + u_email + "/" + u_mail + "/" + u_addr + "/" + u_detailAddr+"/"+u_intro);

			// 메일 합치기
			u_email += "@" + u_mail;
			System.out.println("이메일 확인 : " + u_email);
			// 핸드폰 번호 합치기
			u_phone += "-" + u_phone2 + "-" + u_phone3;
			System.out.println("핸드폰 번호 확인 : " + u_phone);

			// DTO에 값을 넣어주기
			dto.setU_id(u_id);
			dto.setU_pw(u_pw);
			dto.setU_name(u_name);
			dto.setU_nname(u_nname);
			dto.setU_phone(u_phone);
			dto.setU_email(u_email);
			dto.setU_addr(u_addr);
			dto.setU_detailAddr(u_detailAddr);
			dto.setU_intro(u_intro);
			
			// 4.이름 변경
			UserDAO dao = new UserDAO();
			//새로운 사진 원래 파일명
			String oriFileName = multi.getFilesystemName("photo"); //새로운 사진 파일명 변경 전
			System.out.println("기존파일 : " + oriFileName);
			
			/*새로들어온 사진이 있을 때만*/
			if (oriFileName != null) {
				// 확장자 잘라내기
				String ext = oriFileName.substring(oriFileName.lastIndexOf("."));
				// 새로운 파일명 지정하기
				String newFileName = System.currentTimeMillis() + ext;
				System.out.println("변경된 파일 명 : " + newFileName);
				
				//u_newname이랑 orifilename이랑 같으면 삭제x / 다르면 삭제되도록
				File oldName = new File(savePath + oriFileName);
				File newName = new File(savePath + newFileName);
				oldName.renameTo(newName);
				
				dto.setU_newName(newFileName);
			}

		} catch (IOException e) {

			e.printStackTrace();

		}
		return dto;

	}

	public boolean del(String delFileName) {

		boolean success = false;
		
		// 기존파일이름
		File file = new File("C:/photo/" + delFileName);
		
		// 파일이 존재한다면 삭제해라
		if (file.exists()) {
			if(!delFileName.equals("default-profile.png")) {
				success = file.delete();
				System.out.println("기존 파일 삭제 성공 여부 : " + success);
			}
		}

		return success;

	}

}
