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
				System.out.println("사진 p_no : " + p_no);
				dto.setP_no(Integer.parseInt(p_no));
			}

			String oriFileName = multi.getFilesystemName("imgFile");
			System.out.println("oriFileName : "+oriFileName);
			
			//orifilename이 있다면 파일이름을 바꿔라
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

	
	public boolean del(String delFileName) {

		boolean success = false;
		
		// 기존파일이름
		File file = new File("C:/photo/" + delFileName);
		
		// 파일이 존재한다면 삭제해라
		if (file.exists()) {
				success = file.delete();
				System.out.println("기존 파일 삭제 성공 여부 : " + success);
		}

		return success;

	}
	
}
