package com.gg.board.dto;

import java.util.Date;

public class BoardDTO {
	
	//분류코드의 경우 변수를 하나로 잡아야하는지 (하나로 잡아서 가져와도 될것같은데)
	//분류해주면 좀 구분이 쉽게 되긴하니까 이건 BoardDTO 보는사람이 생각좀해서 알려주셈
	//다들 너무 열심히해서 못물어보겠음;;;
	
	//게시글
	private int P_no; //글번호
	private String P_id; //작성자ID
	private String P_title; //제목
	private String P_content; //글 내용
	private Date P_tm; //등록날짜
	private int P_view; //조회수
	private int P_likeCount; //좋아요 횟수
	private char P_blindYN; //블라인드 여부
	private String C_code; //분류코드 (경매,판매,공지사항,커뮤니티)
	
	//사진 
	private String I_newName;//새파일 이름 
	
	//좋아요
	//굳이 필요없을 거 같음..
	

	public int getP_no() {
		return P_no;
	}

	public void setP_no(int p_no) {
		P_no = p_no;
	}

	public String getP_id() {
		return P_id;
	}

	public void setP_id(String p_id) {
		P_id = p_id;
	}

	public String getP_title() {
		return P_title;
	}

	public void setP_title(String p_title) {
		P_title = p_title;
	}

	public String getP_content() {
		return P_content;
	}

	public void setP_content(String p_content) {
		P_content = p_content;
	}

	public Date getP_tm() {
		return P_tm;
	}

	public void setP_tm(Date p_tm) {
		P_tm = p_tm;
	}

	public int getP_view() {
		return P_view;
	}

	public void setP_view(int p_view) {
		P_view = p_view;
	}

	public int getP_likeCount() {
		return P_likeCount;
	}

	public void setP_likeCount(int p_likeCount) {
		P_likeCount = p_likeCount;
	}

	public char getP_blindYN() {
		return P_blindYN;
	}

	public void setP_blindYN(char p_blindYN) {
		P_blindYN = p_blindYN;
	}

	public String getC_code() {
		return C_code;
	}

	public void setC_code(String c_code) {
		C_code = c_code;
	}

	public String getI_newName() {
		return I_newName;
	}

	public void setI_newName(String i_newName) {
		I_newName = i_newName;
	}
	
	
	
	
	
	
	

	
}
