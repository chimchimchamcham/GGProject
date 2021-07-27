package com.gg.dto;

import java.util.Date;

public class GGDto {

	// 회원정보
	private String U_id; // 아이디
	private String U_nname; // 닉네임
	private String U_pw; // 패스워드
	private String U_email; // 이메일
	private String U_name; // 이름
	private String U_addr; // 주소
	private String U_phone; // 전화번호
	private Date U_joinTm; // 가입날짜
	private String U_imgLink; // 사진링크
	private String U_intro; // 자기소개
	private char U_adminYN; // 관리자여부
	private char U_followYN; // 팔로워공개여부
	private String U_newName; // 새사진 이름

	// 쪽지함
	private Date M_sendTm; // 보낸시간
	private String M_sendId;// 보낸아이디
	private String M_receiveId;// 받은아이디
	private String M_content;// 쪽지내용

	// 알람 (잘모르겠어...)
	private int A_no; // 알람번호
	private Date A_sendTm; // 알람보낸날짜
	private Date A_checkTm;// 알람확인날짜
	private String A_content;// 알람내용
	private char A_readYN;// 읽음여부 (없어도 될듯)
	private char A_delYN; // 삭제여부 (없어도 될듯)
	private char A_impoYN;// 중요여부
	private String A_path; // 알람경로

	// 포인트
	private int PNT_point; // 포인트 값
	private Date PNT_tm; // 날짜
	private String PNT_otherId; // 상대 ID

	// 신고
	private int N_no;// 신고번호
	private String N_receivedId; // 신고 받은 아이디
	private String N_sendId; // 신고한 아이디
	private String N_content; // 신고내용
	private String N1_code; // 대분류코드
	private String N2_code; // 중분류코드

	// 블랙리스트
	private Date B_startTm; // 블랙리스트 등록날짜
	private Date B_endTm; // 블랙리스트 등록날짜
	private String D_adminId; // 관리자ID
	private String B_content; // 등록사유

	// 판매관련
	private char S_DeliveryYN; // 택배여부
	private char S_followLimYN; // 팔로우 한정 판매여부
	// 판매자 아이디의 경우 작성자 ID와 동일 하기 때문에 추가하지 않음

	// 일반판매관련
	private int NS_pr; // 판매가격
	// 분류코드(판매중, 거래중, 거래완료)

	// 구매요청
	private int RQ_no; // 구매요청 번호
	private String RQ_id; // 구매요청 아이디
	private char RQ_YN; // 구매요청 수락 거절
	private Date RQ_tm;// 구매요청 날짜

	// 경매글
	// 분류코드(경매중, 거래중, 거래완료)
	private int Au_startPr; // 시작가격
	private int Au_instantPr; // 즉결가격
	private Date Au_startTm;// 경매시작시간
	private Date Au_endTm; // 경매 마감시간
	private Date Au_sucTm; // 경매 낙찰시간
	private int Au_count; // 입찰횟수
	private String Au_successer; // 낙찰자

	// 경매히스토리관련
	private int HA_bidPr; // 입찰가격
	private String HA_bidUsr; // 입찰자

	// 거래
	private int T_no; // 거래번호
	private String T_saler; // 판매자ID
	private String T_buyer; // 구매자ID
	// 거래취소ID의 경우 불러올일이 없을거같아서 안넣음
	// 관리자 접근 가능여부 .... 안넣었음

	// 거래 히스토리
	private int HT_point; // 포인트값

	// 거래댓글
	private String TC_content; // 거래 댓글 내용

	// 후기
	private String RV_id; // 후기 작성자ID
	private int RV_score; // 후기 평점
	private String RV_content; // 후기 내용
	private char RV_SellerYN; // 판매자 여부

	// 게시글
	private int P_no; // 글번호
	private String P_id; // 작성자ID
	private String P_title; // 제목
	private String P_content; // 글 내용
	private Date P_tm; // 등록날짜
	private int P_view; // 조회수
	private int P_likeCount; // 좋아요 횟수
	private char P_blindYN; // 블라인드 여부
	private String C_code; // 분류코드 (경매,판매,공지사항,커뮤니티)

	// 사진
	private String I_newName;// 새파일 이름

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

	public char getS_DeliveryYN() {
		return S_DeliveryYN;
	}

	public void setS_DeliveryYN(char s_DeliveryYN) {
		S_DeliveryYN = s_DeliveryYN;
	}

	public char getS_followLimYN() {
		return S_followLimYN;
	}

	public void setS_followLimYN(char s_followLimYN) {
		S_followLimYN = s_followLimYN;
	}

	public int getNS_pr() {
		return NS_pr;
	}

	public void setNS_pr(int nS_pr) {
		NS_pr = nS_pr;
	}

	public int getRQ_no() {
		return RQ_no;
	}

	public void setRQ_no(int rQ_no) {
		RQ_no = rQ_no;
	}

	public String getRQ_id() {
		return RQ_id;
	}

	public void setRQ_id(String rQ_id) {
		RQ_id = rQ_id;
	}

	public char getRQ_YN() {
		return RQ_YN;
	}

	public void setRQ_YN(char rQ_YN) {
		RQ_YN = rQ_YN;
	}

	public Date getRQ_tm() {
		return RQ_tm;
	}

	public void setRQ_tm(Date rQ_tm) {
		RQ_tm = rQ_tm;
	}

	public int getAu_startPr() {
		return Au_startPr;
	}

	public void setAu_startPr(int au_startPr) {
		Au_startPr = au_startPr;
	}

	public int getAu_instantPr() {
		return Au_instantPr;
	}

	public void setAu_instantPr(int au_instantPr) {
		Au_instantPr = au_instantPr;
	}

	public Date getAu_startTm() {
		return Au_startTm;
	}

	public void setAu_startTm(Date au_startTm) {
		Au_startTm = au_startTm;
	}

	public Date getAu_endTm() {
		return Au_endTm;
	}

	public void setAu_endTm(Date au_endTm) {
		Au_endTm = au_endTm;
	}

	public Date getAu_sucTm() {
		return Au_sucTm;
	}

	public void setAu_sucTm(Date au_sucTm) {
		Au_sucTm = au_sucTm;
	}

	public int getAu_count() {
		return Au_count;
	}

	public void setAu_count(int au_count) {
		Au_count = au_count;
	}

	public String getAu_successer() {
		return Au_successer;
	}

	public void setAu_successer(String au_successer) {
		Au_successer = au_successer;
	}

	public int getHA_bidPr() {
		return HA_bidPr;
	}

	public void setHA_bidPr(int hA_bidPr) {
		HA_bidPr = hA_bidPr;
	}

	public String getHA_bidUsr() {
		return HA_bidUsr;
	}

	public void setHA_bidUsr(String hA_bidUsr) {
		HA_bidUsr = hA_bidUsr;
	}

	public int getT_no() {
		return T_no;
	}

	public void setT_no(int t_no) {
		T_no = t_no;
	}

	public String getT_saler() {
		return T_saler;
	}

	public void setT_saler(String t_saler) {
		T_saler = t_saler;
	}

	public String getT_buyer() {
		return T_buyer;
	}

	public void setT_buyer(String t_buyer) {
		T_buyer = t_buyer;
	}

	public int getHT_point() {
		return HT_point;
	}

	public void setHT_point(int hT_point) {
		HT_point = hT_point;
	}

	public String getTC_content() {
		return TC_content;
	}

	public void setTC_content(String tC_content) {
		TC_content = tC_content;
	}

	public String getRV_id() {
		return RV_id;
	}

	public void setRV_id(String rV_id) {
		RV_id = rV_id;
	}

	public int getRV_score() {
		return RV_score;
	}

	public void setRV_score(int rV_score) {
		RV_score = rV_score;
	}

	public String getRV_content() {
		return RV_content;
	}

	public void setRV_content(String rV_content) {
		RV_content = rV_content;
	}

	public char getRV_SellerYN() {
		return RV_SellerYN;
	}

	public void setRV_SellerYN(char rV_SellerYN) {
		RV_SellerYN = rV_SellerYN;
	}

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
