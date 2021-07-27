package com.gg.user.dto;

import java.util.Date;

public class UserDTO {
	
	//회원정보
	private String U_id; //아이디
	private String U_nname; //닉네임
	private String U_pw; //패스워드
	private String U_email; //이메일
	private String U_name; //이름
	private String U_addr; //주소
	private String U_phone; //전화번호
	private Date U_joinTm; //가입날짜
	private String U_imgLink; //사진링크
	private String U_intro; //자기소개
	private char U_adminYN; //관리자여부
	private char U_followYN; //팔로워공개여부
	private String U_newName; //새사진 이름 
	
	//쪽지함
	private Date M_sendTm; //보낸시간
	private String M_sendId;//보낸아이디
	private String M_receiveId;//받은아이디
	private String M_content;//쪽지내용
	
	//알람 (잘모르겠어...)
	private int A_no; //알람번호
	private Date A_sendTm; //알람보낸날짜
	private Date A_checkTm;//알람확인날짜
	private String A_content;//알람내용
	private char A_readYN;//읽음여부 (없어도 될듯)
	private char A_delYN; //삭제여부 (없어도 될듯)
	private char A_impoYN;//중요여부
	private String A_path; //알람경로
	
	//포인트
	private int PNT_point; //포인트 값 
	private Date PNT_tm; //날짜
	private String PNT_otherId; //상대 ID 
	
	//신고
	private int N_no;//신고번호
	private String N_receivedId; //신고 받은 아이디
	private String N_sendId; //신고한 아이디
	private String N_content; //신고내용
	private String N1_code; //대분류코드
	private String N2_code; //중분류코드
	
	//블랙리스트
	private Date B_startTm; //블랙리스트 등록날짜
	private Date B_endTm; //블랙리스트 등록날짜
	private String D_adminId; //관리자ID
	private String B_content; //등록사유

	
	public String getU_id() {
		return U_id;
	}
	public void setU_id(String u_id) {
		U_id = u_id;
	}
	public String getU_nname() {
		return U_nname;
	}
	public void setU_nname(String u_nname) {
		U_nname = u_nname;
	}
	public String getU_pw() {
		return U_pw;
	}
	public void setU_pw(String u_pw) {
		U_pw = u_pw;
	}
	public String getU_email() {
		return U_email;
	}
	public void setU_email(String u_email) {
		U_email = u_email;
	}
	public String getU_name() {
		return U_name;
	}
	public void setU_name(String u_name) {
		U_name = u_name;
	}
	public String getU_addr() {
		return U_addr;
	}
	public void setU_addr(String u_addr) {
		U_addr = u_addr;
	}
	public String getU_phone() {
		return U_phone;
	}
	public void setU_phone(String u_phone) {
		U_phone = u_phone;
	}
	public Date getU_joinTm() {
		return U_joinTm;
	}
	public void setU_joinTm(Date u_joinTm) {
		U_joinTm = u_joinTm;
	}
	public String getU_imgLink() {
		return U_imgLink;
	}
	public void setU_imgLink(String u_imgLink) {
		U_imgLink = u_imgLink;
	}
	public String getU_intro() {
		return U_intro;
	}
	public void setU_intro(String u_intro) {
		U_intro = u_intro;
	}
	public char getU_adminYN() {
		return U_adminYN;
	}
	public void setU_adminYN(char u_adminYN) {
		U_adminYN = u_adminYN;
	}
	public char getU_followYN() {
		return U_followYN;
	}
	public void setU_followYN(char u_followYN) {
		U_followYN = u_followYN;
	}
	public String getU_newName() {
		return U_newName;
	}
	public void setU_newName(String u_newName) {
		U_newName = u_newName;
	}
	public Date getM_sendTm() {
		return M_sendTm;
	}
	public void setM_sendTm(Date m_sendTm) {
		M_sendTm = m_sendTm;
	}
	public String getM_sendId() {
		return M_sendId;
	}
	public void setM_sendId(String m_sendId) {
		M_sendId = m_sendId;
	}
	public String getM_receiveId() {
		return M_receiveId;
	}
	public void setM_receiveId(String m_receiveId) {
		M_receiveId = m_receiveId;
	}
	public String getM_content() {
		return M_content;
	}
	public void setM_content(String m_content) {
		M_content = m_content;
	}
	public int getA_no() {
		return A_no;
	}
	public void setA_no(int a_no) {
		A_no = a_no;
	}
	public Date getA_sendTm() {
		return A_sendTm;
	}
	public void setA_sendTm(Date a_sendTm) {
		A_sendTm = a_sendTm;
	}
	public Date getA_checkTm() {
		return A_checkTm;
	}
	public void setA_checkTm(Date a_checkTm) {
		A_checkTm = a_checkTm;
	}
	public String getA_content() {
		return A_content;
	}
	public void setA_content(String a_content) {
		A_content = a_content;
	}
	public char getA_readYN() {
		return A_readYN;
	}
	public void setA_readYN(char a_readYN) {
		A_readYN = a_readYN;
	}
	public char getA_delYN() {
		return A_delYN;
	}
	public void setA_delYN(char a_delYN) {
		A_delYN = a_delYN;
	}
	public char getA_impoYN() {
		return A_impoYN;
	}
	public void setA_impoYN(char a_impoYN) {
		A_impoYN = a_impoYN;
	}
	public String getA_path() {
		return A_path;
	}
	public void setA_path(String a_path) {
		A_path = a_path;
	}
	public int getPNT_point() {
		return PNT_point;
	}
	public void setPNT_point(int pNT_point) {
		PNT_point = pNT_point;
	}
	public Date getPNT_tm() {
		return PNT_tm;
	}
	public void setPNT_tm(Date pNT_tm) {
		PNT_tm = pNT_tm;
	}
	public String getPNT_otherId() {
		return PNT_otherId;
	}
	public void setPNT_otherId(String pNT_otherId) {
		PNT_otherId = pNT_otherId;
	}
	public int getN_no() {
		return N_no;
	}
	public void setN_no(int n_no) {
		N_no = n_no;
	}
	public String getN_receivedId() {
		return N_receivedId;
	}
	public void setN_receivedId(String n_receivedId) {
		N_receivedId = n_receivedId;
	}
	public String getN_sendId() {
		return N_sendId;
	}
	public void setN_sendId(String n_sendId) {
		N_sendId = n_sendId;
	}
	public String getN_content() {
		return N_content;
	}
	public void setN_content(String n_content) {
		N_content = n_content;
	}
	public String getN1_code() {
		return N1_code;
	}
	public void setN1_code(String n1_code) {
		N1_code = n1_code;
	}
	public String getN2_code() {
		return N2_code;
	}
	public void setN2_code(String n2_code) {
		N2_code = n2_code;
	}
	public Date getB_startTm() {
		return B_startTm;
	}
	public void setB_startTm(Date b_startTm) {
		B_startTm = b_startTm;
	}
	public Date getB_endTm() {
		return B_endTm;
	}
	public void setB_endTm(Date b_endTm) {
		B_endTm = b_endTm;
	}
	public String getD_adminId() {
		return D_adminId;
	}
	public void setD_adminId(String d_adminId) {
		D_adminId = d_adminId;
	}
	public String getB_content() {
		return B_content;
	}
	public void setB_content(String b_content) {
		B_content = b_content;
	}
	
}
