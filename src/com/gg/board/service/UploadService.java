package com.gg.board.service;

import java.io.File;
import java.io.IOException;

import javax.servlet.http.HttpServletRequest;

import com.gg.dto.GGDto;
import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

public class UploadService {

	HttpServletRequest req=null;
	
	public UploadService(HttpServletRequest req) {
		this.req = req;
	}

	public GGDto PhotoUpload() {
		String savePath = "C:/photo/";// 1.저장경로 저장
		int maxSize = 10 * 1024 * 1024;// 2.용량제한(10MB)
		GGDto dto = null;

		//업로드
		try {
			
			//폴더 없을 경우 폴더 생성
			File dir = new File(savePath);
			if (!dir.exists()) {
				dir.mkdir();
			}
			
			MultipartRequest multi = new MultipartRequest(req, savePath, maxSize, "UTF-8",
					new DefaultFileRenamePolicy());
			
			dto = new GGDto();
			
			String p_no = multi.getParameter("p_no");
			if (p_no != null) {
				System.out.println("p_no : " + p_no);
				dto.setP_no(Integer.parseInt(p_no));
			}
			
			String oriFileName = multi.getFilesystemName("imgFile");
			System.out.println("oriFileName : "+oriFileName);
			if(oriFileName != null) {
				String ext = oriFileName.substring(oriFileName.lastIndexOf("."));
				String i_newName = System.currentTimeMillis() + ext;
				System.out.println("i_newName:"+i_newName);
				File oldName = new File(savePath + oriFileName);
				File newName = new File(savePath + i_newName);
				oldName.renameTo(newName);
				dto.setI_newName(i_newName);
			}
			
		} catch (IOException e) {

			e.printStackTrace();
		}
		
		return dto;
	}

	
}
