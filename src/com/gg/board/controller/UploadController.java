package com.gg.board.controller;

import java.io.IOException;
import java.util.HashMap;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.gg.board.dao.UploadDAO;
import com.gg.board.service.UploadService;
import com.gg.dto.GGDto;
import com.google.gson.Gson;

@WebServlet({"/upload","/update"})
public class UploadController extends HttpServlet {

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
		System.out.println("addr : "+addr);
		
		switch(addr) {
		
		case "/upload":
			boolean success = false;
			System.out.println("파일 업로드 요청");
			UploadService service = new UploadService(req);
			UploadDAO dao = new UploadDAO();
			int cheker = 0;
			cheker = dao.PhotoUpload(service.PhotoUpload());
			HashMap<String, Object> map = new HashMap<String, Object>();
			if(cheker>0) {
				success = true;
				map.put("success", success);
				resp.getWriter().println(new Gson().toJson(map));
				
			}
			
			break;
			
		case "/update":
			success = false;
			System.out.println("사진 수정 요청");
			service = new UploadService(req);
			dao = new UploadDAO();
			cheker = 0;
			// 새로올린 파일이 있는지 확인하고 그 이름을 dto의 I_newName()에 담음
			GGDto dto = service.PhotoUpload();
			
			//기존사진 이름 가져와서 delFileName에 넣음
			String delFileName = dao.getFileName(dto.getP_no());
			System.out.println("삭제할 사진 파일 : "+ delFileName);
			
			if(delFileName != null ) {
				// DB에 파일의 이름을 업데이트
				cheker = dao.PhotoUpdate(dto);
				//기존 파일을 지우고
				service.del(delFileName);
			}else {
				cheker = dao.PhotoUpload(dto);
			}
			
			map = new HashMap<String, Object>();
			if(cheker>0) {
				success = true;
				map.put("success", success);
				resp.getWriter().println(new Gson().toJson(map));
			}
			
			break;
			
		}
		
		
		
	}
}
