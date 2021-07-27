package com.gg.trade.dto;

import java.util.Date;

public class TradeDTO {
	
	//분류코드의 경우 변수를 하나로 잡아야하는지 (하나로 잡아서 가져와도 될것같은데)
	//분류해주면 좀 구분이 쉽게 되긴하니까 이건 TradeDTO 보는사람이 생각좀해서 알려주셈
	//다들 너무 열심히해서 못물어보겠음;;;
	
	//판매관련
	private char S_DeliveryYN; //택배여부
	private char S_followLimYN; //팔로우 한정 판매여부
	//판매자 아이디의 경우 작성자 ID와 동일 하기 때문에 추가하지 않음
	private String S_code; //분류코드 (경매, 판매)
	
	//일반판매관련
	private int NS_pr; //판매가격
	//분류코드(판매중, 거래중, 거래완료)
	
	//구매요청
	private int RQ_no; //구매요청 번호
	private String RQ_id; //구매요청 아이디
	private char RQ_YN; //구매요청 수락 거절
	private Date RQ_tm;//구매요청 날짜

	//경매글 
	//분류코드(경매중, 거래중, 거래완료)
	private int Au_startPr; // 시작가격
	private int Au_instantPr; // 즉결가격
	private Date Au_startTm;//경매시작시간
	private Date Au_endTm; //경매 마감시간
	private Date Au_sucTm; //경매 낙찰시간
	private int Au_count; //입찰횟수
	private String Au_successer; //낙찰자
	
	//경매히스토리관련
	private int HA_bidPr; //입찰가격
	private String HA_bidUsr; //입찰자
	
	
	//거래
	private int T_no; //거래번호
	private String T_saler; //판매자ID
	private String T_buyer; //구매자ID
	//거래취소ID의 경우 불러올일이 없을거같아서 안넣음
	//관리자 접근 가능여부 .... 안넣었음 
	
	//거래 히스토리 
	private int HT_point; //포인트값 
	
	//거래댓글
	private String TC_content; //거래 댓글 내용

	//후기
	private String RV_id; //후기 작성자ID
	private int RV_score; //후기 평점
	private String RV_content; //후기 내용
	private char RV_SellerYN; //판매자 여부
	
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

	public String getS_code() {
		return S_code;
	}

	public void setS_code(String s_code) {
		S_code = s_code;
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
	
	
	
	
}
