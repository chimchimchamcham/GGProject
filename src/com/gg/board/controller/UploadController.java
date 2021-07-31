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
import com.google.gson.Gson;

@WebServlet({"/upload"})
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
				
			}else 
			
			
			break;
		}
		
	}
}
