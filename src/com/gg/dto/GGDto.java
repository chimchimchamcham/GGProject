package com.gg.dto;

import java.sql.Date;

public class GGDto {
   // 회원정보
   private String u_id; // 아이디
   private String u_nname; // 닉네임
   private String u_pw; // 패스워드
   private String u_email; // 이메일
   private String u_name; // 이름
   private String u_addr; // 주소
   private String u_phone; // 전화번호
   private Date u_joinTm; // 가입날짜
   private String u_intro; // 자기소개
   private String u_adminYN; // 관리자여부
   private String u_followYN; // 팔로워공개여부
   private String u_newName; // 새사진 이름
   private String u_detailAddr; // 상세 주소
   private boolean u_isFollow;

   // 쪽지함
   private Date m_sendTm; // 보낸시간
   private String m_sendId;// 보낸아이디
   private String m_receiveId;// 받은아이디
   private String m_content;// 쪽지내용
   private Date m_readTm;
   private String m_receiveDelYN;
   private String m_sendDelYN;

   // 알람 (잘모르겠어...)
   private int a_no; // 알람번호
   private Date a_sendTm; // 알람보낸날짜
   private Date a_checkTm;// 알람확인날짜
   private String a_content;// 알람내용
   private String a_readYN;// 읽음여부 (없어도 될듯)
   private String a_delYN; // 삭제여부 (없어도 될듯)
   private String a_impoYN;// 중요여부
   private String a_path; // 알람경로
   private String a_code;//알람코드
   
   // 포인트
   private int pnt_point; // 포인트 값
   private Date pnt_tm; // 날짜
   private String pnt_otherId; // 상대 ID

   // 신고
   private int n_no;// 신고번호
   private String n_receiveId; // 신고 받은 아이디
   private String n_sendId; // 신고한 아이디
   private String n_content; // 신고내용
   private String n1_code; // 대분류코드
   private String n1_name;//대분류코드 한글이름
   private String n2_code; // 중분류코드
   private String n2_name; // 중분류코드 한글이름
   private String Pntcode;// 분류코드
   private String n_tm; //신고 접수 날짜
   
   //신고 히스토리
   private String hn_tm; //신고 시간
   private String hn_code; //신고 처리 상태
   private String hn_adminid; //신고 담당자

   
  

   // 블랙리스트
   private Date b_startTm; // 블랙리스트 등록날짜
   private Date b_endTm; // 블랙리스트 등록날짜
   private String b_adminId; // 관리자ID
   private String b_content; // 등록사유
   private String b_id;//블랙리스트 등록ID
   private String b_code;//블랙리스트 코드
   private int b_no;//블랙리스트 번호
   private String b_endhr;
   private String b_starthr;


   // 판매관련
   private String s_DeliveryYN; // 택배여부
   private String s_followLimYN; // 팔로우 한정 판매여부
   // 판매자 아이디의 경우 작성자 ID와 동일 하기 때문에 추가하지 않음
   
   private String s_name; //!!추가 필요
   private String s_code; //일반 판매 카테고리
   
   private String S_saler; // 판매자 id 
   private String sered;//수신인지 발신인지
   private String buttonORtext;//버튼으로 줄지 대기중이라고 그냥 text로 줄지
  
   // 일반판매관련
   private int ns_pr; // 판매가격
   // 분류코드(판매중, 거래중, 거래완료)
   private String ns_name; //!!추가 필요
   private String ns_code;
   

   // 구매요청
   private int rq_no; // 구매요청 번호
   private String rq_id; // 구매요청 아이디
   private String rq_YN; // 구매요청 수락 거절
   private Date rq_tm;// 구매요청 날짜

   // 경매글
   // 분류코드(경매중, 거래중, 거래완료)
   private String au_code;//경매상태코드
   private int au_startPr; // 시작가격
   private int au_instantPr; // 즉결가격
   private Date au_startTm;// 경매시작시간
   private Date au_endTm; // 경매 마감시간
   private Date au_sucTm; // 경매 낙찰시간
   private int au_count; // 입찰횟수
   private String au_successer; // 낙찰자
   
   
   
   // 경매히스토리관련
   private long ha_bidPr; // 입찰가격

   private long hm;
   


   private String ha_bidUsr; // 입찰자

   // 거래
   private int t_no; // 거래번호
   private String t_saler; // 판매자ID
   private String t_buyer; // 구매자ID
   private String t_cancleId; //거래취소ID
   private String t_admAcc; //관리자 접근가능 여부
   private int t_point; //구매자의 보유포인트
   // 거래취소ID의 경우 불러올일이 없을거같아서 안넣음
   // 관리자 접근 가능여부 .... 안넣었음
   // 관리자 접근 가능여부 .... 안넣었음
	private String t_saler_newName;//판매자 프로필사진 경로
	private String t_buyer_newName;//구매자 프로필사진 경로
	private String t_saler_nname;//판매자 닉네임
	private String t_buyer_nname;//구매자 닉네임


   // 거래 히스토리
   private int ht_point; // 포인트값
   private String ht_code; //분류코드
   private String ht_name; //분류이름
   private Date ht_date; //거래히스토리 날짜
   

   // 거래댓글
   private String tc_content; // 거래 댓글 내용
	private Date tc_tm; //댓글 작성 날짜
	private String tc_id; //댓글 작성자
	private String tc_nname; //댓글 작성자의 닉네임
   


// 후기
   private String rv_id; // 후기 작성자ID
   private int rv_score; // 후기 평점
   private String rv_content; // 후기 내용
   private String rv_SellerYN; // 판매자 여부

   // 게시글
   private int p_no; // 글번호
   private String p_id; // 작성자ID
   private String p_title; // 제목
   private String p_content; // 글 내용
   private Date p_tm; // 등록날짜
   private int p_view; // 조회수
   private int p_likeCount; // 좋아요 횟수
   private String p_blindYN; // 블라인드 여부 !!변경
   private String p_code; // 분류코드 (경매,판매,공지사항,커뮤니티)
   
   private String p_name; //!! 추가 필요
   
   private int p_registCnt;//해당 작성자가 등록한 게시물의 총 갯수
   
   private String p_path;//해당 게시글의 상세경로
   
   // 사진
   private String i_newName;
   
   //게시글 카테고리
   private String p_cate;
   private String p_cateName;
   
   
   
   //코드분류
   private String c_code;
   private String c_name;
   private boolean myYN;
   
   //게시판 댓글
   private int pc_no;//댓글 번호.
   private String pc_content;//내용
   private Date pc_tm;//작성날짜
   private int pc_parentno;// 나중에 물어봐야함 무엇이 댓글 대댓글인지
   private String pc_id;// 댓글 등록한 아이디.
   private String pc_session_id;
   
   //팔로워
   private String f_receiveid;
   private String f_sendid;
   private Date f_tm; 
   private int flow_count;//자신,타인이 팔로잉 한사람들의 수
   private String thisuserFlowingYN;
   
   // 페이징 처리시 전체 페이지수
   private int totalPage;
   private int currPage;
   private int currPageEnd;
   private int currPageStart;
   private int totalPost;
   private int currPageNum;
   

public String getU_id() {
	return u_id;
}

public void setU_id(String u_id) {
	this.u_id = u_id;
}

public String getU_nname() {
	return u_nname;
}

public void setU_nname(String u_nname) {
	this.u_nname = u_nname;
}

public String getU_pw() {
	return u_pw;
}

public void setU_pw(String u_pw) {
	this.u_pw = u_pw;
}

public String getU_email() {
	return u_email;
}

public void setU_email(String u_email) {
	this.u_email = u_email;
}

public String getU_name() {
	return u_name;
}

public void setU_name(String u_name) {
	this.u_name = u_name;
}

public String getU_addr() {
	return u_addr;
}

public void setU_addr(String u_addr) {
	this.u_addr = u_addr;
}

public String getU_phone() {
	return u_phone;
}

public void setU_phone(String u_phone) {
	this.u_phone = u_phone;
}

public Date getU_joinTm() {
	return u_joinTm;
}

public void setU_joinTm(Date u_joinTm) {
	this.u_joinTm = u_joinTm;
}

public String getU_intro() {
	return u_intro;
}

public void setU_intro(String u_intro) {
	this.u_intro = u_intro;
}

public String getU_adminYN() {
	return u_adminYN;
}

public void setU_adminYN(String u_adminYN) {
	this.u_adminYN = u_adminYN;
}

public String getU_followYN() {
	return u_followYN;
}

public void setU_followYN(String u_followYN) {
	this.u_followYN = u_followYN;
}

public String getU_newName() {
	return u_newName;
}

public void setU_newName(String u_newName) {
	this.u_newName = u_newName;
}

public String getU_detailAddr() {
	return u_detailAddr;
}

public void setU_detailAddr(String u_detailAddr) {
	this.u_detailAddr = u_detailAddr;
}

public Date getM_sendTm() {
	return m_sendTm;
}

public void setM_sendTm(Date m_sendTm) {
	this.m_sendTm = m_sendTm;
}

public String getM_sendId() {
	return m_sendId;
}

public void setM_sendId(String m_sendId) {
	this.m_sendId = m_sendId;
}

public String getM_receiveId() {
	return m_receiveId;
}

public void setM_receiveId(String m_receiveId) {
	this.m_receiveId = m_receiveId;
}

public String getM_content() {
	return m_content;
}

public void setM_content(String m_content) {
	this.m_content = m_content;
}

public int getA_no() {
	return a_no;
}

public void setA_no(int a_no) {
	this.a_no = a_no;
}

public Date getA_sendTm() {
	return a_sendTm;
}

public void setA_sendTm(Date a_sendTm) {
	this.a_sendTm = a_sendTm;
}

public Date getA_checkTm() {
	return a_checkTm;
}

public void setA_checkTm(Date a_checkTm) {
	this.a_checkTm = a_checkTm;
}

public String getA_content() {
	return a_content;
}

public void setA_content(String a_content) {
	this.a_content = a_content;
}

public String getA_readYN() {
	return a_readYN;
}

public void setA_readYN(String a_readYN) {
	this.a_readYN = a_readYN;
}

public String getA_delYN() {
	return a_delYN;
}

public void setA_delYN(String a_delYN) {
	this.a_delYN = a_delYN;
}

public String getA_impoYN() {
	return a_impoYN;
}

public void setA_impoYN(String a_impoYN) {
	this.a_impoYN = a_impoYN;
}

public String getA_path() {
	return a_path;
}

public void setA_path(String a_path) {
	this.a_path = a_path;
}

public String getA_code() {
	return a_code;
}

public void setA_code(String a_code) {
	this.a_code = a_code;
}

public int getPnt_point() {
	return pnt_point;
}

public void setPnt_point(int pnt_point) {
	this.pnt_point = pnt_point;
}

public Date getPnt_tm() {
	return pnt_tm;
}

public void setPnt_tm(Date pnt_tm) {
	this.pnt_tm = pnt_tm;
}

public String getPnt_otherId() {
	return pnt_otherId;
}

public void setPnt_otherId(String pnt_otherId) {
	this.pnt_otherId = pnt_otherId;
}

public int getN_no() {
	return n_no;
}

public void setN_no(int n_no) {
	this.n_no = n_no;
}

public String getN_receiveId() {
	return n_receiveId;
}

public void setN_receiveId(String n_receiveId) {
	this.n_receiveId = n_receiveId;
}

public String getN_sendId() {
	return n_sendId;
}

public void setN_sendId(String n_sendId) {
	this.n_sendId = n_sendId;
}

public String getN_content() {
	return n_content;
}

public void setN_content(String n_content) {
	this.n_content = n_content;
}

public String getN1_code() {
	return n1_code;
}

public void setN1_code(String n1_code) {
	this.n1_code = n1_code;
}

public String getN1_name() {
	return n1_name;
}

public void setN1_name(String n1_name) {
	this.n1_name = n1_name;
}

public String getN2_code() {
	return n2_code;
}

public void setN2_code(String n2_code) {
	this.n2_code = n2_code;
}

public String getN_tm() {
	return n_tm;
}

public void setN_tm(String n_tm) {
	this.n_tm = n_tm;
}

public String getN2_name() {
	return n2_name;
}

public void setN2_name(String n2_name) {
	this.n2_name = n2_name;
}

public String getHn_tm() {
	return hn_tm;
}

public void setHn_tm(String hn_tm) {
	this.hn_tm = hn_tm;
}

public String getHn_code() {
	return hn_code;
}

public void setHn_code(String hn_code) {
	this.hn_code = hn_code;
}

public String getHn_adminid() {
	return hn_adminid;
}

public void setHn_adminid(String hn_adminid) {
	this.hn_adminid = hn_adminid;
}

public Date getB_startTm() {
	return b_startTm;
}

public void setB_startTm(Date b_startTm) {
	this.b_startTm = b_startTm;
}

public Date getB_endTm() {
	return b_endTm;
}

public void setB_endTm(Date b_endTm) {
	this.b_endTm = b_endTm;
}

public String getB_adminId() {
	return b_adminId;
}

public void setB_adminId(String b_adminId) {
	this.b_adminId = b_adminId;
}

public String getB_content() {
	return b_content;
}

public void setB_content(String b_content) {
	this.b_content = b_content;
}

public String getS_DeliveryYN() {
	return s_DeliveryYN;
}

public void setS_DeliveryYN(String s_DeliveryYN) {
	this.s_DeliveryYN = s_DeliveryYN;
}

public String getS_followLimYN() {
	return s_followLimYN;
}

public void setS_followLimYN(String s_followLimYN) {
	this.s_followLimYN = s_followLimYN;
}

public String getS_name() {
	return s_name;
}

public void setS_name(String s_name) {
	this.s_name = s_name;
}

public String getS_code() {
	return s_code;
}

public void setS_code(String s_code) {
	this.s_code = s_code;
}

public String getS_saler() {
	return S_saler;
}

public void setS_saler(String s_saler) {
	S_saler = s_saler;
}

public String getSered() {
	return sered;
}

public void setSered(String sered) {
	this.sered = sered;
}

public String getButtonORtext() {
	return buttonORtext;
}

public void setButtonORtext(String buttonORtext) {
	this.buttonORtext = buttonORtext;
}

public int getNs_pr() {
	return ns_pr;
}

public void setNs_pr(int ns_pr) {
	this.ns_pr = ns_pr;
}

public String getNs_name() {
	return ns_name;
}

public void setNs_name(String ns_name) {
	this.ns_name = ns_name;
}

public String getNs_code() {
	return ns_code;
}

public void setNs_code(String ns_code) {
	this.ns_code = ns_code;
}

public int getRq_no() {
	return rq_no;
}

public void setRq_no(int rq_no) {
	this.rq_no = rq_no;
}

public String getRq_id() {
	return rq_id;
}

public void setRq_id(String rq_id) {
	this.rq_id = rq_id;
}

public String getRq_YN() {
	return rq_YN;
}

public void setRq_YN(String rq_YN) {
	this.rq_YN = rq_YN;
}

public Date getRq_tm() {
	return rq_tm;
}

public void setRq_tm(Date rq_tm) {
	this.rq_tm = rq_tm;
}

public String getAu_code() {
	return au_code;
}

public void setAu_code(String au_code) {
	this.au_code = au_code;
}

public int getAu_startPr() {
	return au_startPr;
}

public void setAu_startPr(int au_startPr) {
	this.au_startPr = au_startPr;
}

public int getAu_instantPr() {
	return au_instantPr;
}

public void setAu_instantPr(int au_instantPr) {
	this.au_instantPr = au_instantPr;
}

public Date getAu_startTm() {
	return au_startTm;
}

public void setAu_startTm(Date au_startTm) {
	this.au_startTm = au_startTm;
}

public Date getAu_endTm() {
	return au_endTm;
}

public void setAu_endTm(Date au_endTm) {
	this.au_endTm = au_endTm;
}

public Date getAu_sucTm() {
	return au_sucTm;
}

public void setAu_sucTm(Date au_sucTm) {
	this.au_sucTm = au_sucTm;
}

public int getAu_count() {
	return au_count;
}

public void setAu_count(int au_count) {
	this.au_count = au_count;
}

public String getAu_successer() {
	return au_successer;
}

public void setAu_successer(String au_successer) {
	this.au_successer = au_successer;
}

public long getHa_bidPr() {
	return ha_bidPr;
}

public void setHa_bidPr(long ha_bidPr) {
	this.ha_bidPr = ha_bidPr;
}

public long getHm() {
	return hm;
}

public void setHm(long hm) {
	this.hm = hm;
}

public String getHa_bidUsr() {
	return ha_bidUsr;
}

public void setHa_bidUsr(String ha_bidUsr) {
	this.ha_bidUsr = ha_bidUsr;
}

public int getT_no() {
	return t_no;
}

public void setT_no(int t_no) {
	this.t_no = t_no;
}

public String getT_saler() {
	return t_saler;
}

public void setT_saler(String t_saler) {
	this.t_saler = t_saler;
}

public String getT_buyer() {
	return t_buyer;
}

public void setT_buyer(String t_buyer) {
	this.t_buyer = t_buyer;
}

public String getT_cancleId() {
	return t_cancleId;
}

public void setT_cancleId(String t_cancleId) {
	this.t_cancleId = t_cancleId;
}

public String getT_admAcc() {
	return t_admAcc;
}

public void setT_admAcc(String t_admAcc) {
	this.t_admAcc = t_admAcc;
}

public int getT_point() {
	return t_point;
}

public void setT_point(int t_point) {
	this.t_point = t_point;
}

public String getT_saler_newName() {
	return t_saler_newName;
}

public void setT_saler_newName(String t_saler_newName) {
	this.t_saler_newName = t_saler_newName;
}

public String getT_buyer_newName() {
	return t_buyer_newName;
}

public void setT_buyer_newName(String t_buyer_newName) {
	this.t_buyer_newName = t_buyer_newName;
}

public String getT_saler_nname() {
	return t_saler_nname;
}

public void setT_saler_nname(String t_saler_nname) {
	this.t_saler_nname = t_saler_nname;
}

public String getT_buyer_nname() {
	return t_buyer_nname;
}

public void setT_buyer_nname(String t_buyer_nname) {
	this.t_buyer_nname = t_buyer_nname;
}

public int getHt_point() {
	return ht_point;
}

public void setHt_point(int ht_point) {
	this.ht_point = ht_point;
}

public String getHt_code() {
	return ht_code;
}

public void setHt_code(String ht_code) {
	this.ht_code = ht_code;
}

public String getHt_name() {
	return ht_name;
}

public void setHt_name(String ht_name) {
	this.ht_name = ht_name;
}

public Date getHt_date() {
	return ht_date;
}

public void setHt_date(Date ht_date) {
	this.ht_date = ht_date;
}

public String getTc_content() {
	return tc_content;
}

public void setTc_content(String tc_content) {
	this.tc_content = tc_content;
}

public Date getTc_tm() {
	return tc_tm;
}

public void setTc_tm(Date tc_tm) {
	this.tc_tm = tc_tm;
}

public String getTc_id() {
	return tc_id;
}

public void setTc_id(String tc_id) {
	this.tc_id = tc_id;
}

public String getRv_id() {
	return rv_id;
}

public void setRv_id(String rv_id) {
	this.rv_id = rv_id;
}

public int getRv_score() {
	return rv_score;
}

public void setRv_score(int rv_score) {
	this.rv_score = rv_score;
}

public String getRv_content() {
	return rv_content;
}

public void setRv_content(String rv_content) {
	this.rv_content = rv_content;
}

public String getRv_SellerYN() {
	return rv_SellerYN;
}

public void setRv_SellerYN(String rv_SellerYN) {
	this.rv_SellerYN = rv_SellerYN;
}

public int getP_no() {
	return p_no;
}

public void setP_no(int p_no) {
	this.p_no = p_no;
}

public String getP_id() {
	return p_id;
}

public void setP_id(String p_id) {
	this.p_id = p_id;
}

public String getP_title() {
	return p_title;
}

public void setP_title(String p_title) {
	this.p_title = p_title;
}

public String getP_content() {
	return p_content;
}

public void setP_content(String p_content) {
	this.p_content = p_content;
}

public Date getP_tm() {
	return p_tm;
}

public void setP_tm(Date p_tm) {
	this.p_tm = p_tm;
}

public int getP_view() {
	return p_view;
}

public void setP_view(int p_view) {
	this.p_view = p_view;
}

public int getP_likeCount() {
	return p_likeCount;
}

public void setP_likeCount(int p_likeCount) {
	this.p_likeCount = p_likeCount;
}

public String getP_blindYN() {
	return p_blindYN;
}

public void setP_blindYN(String p_blindYN) {
	this.p_blindYN = p_blindYN;
}

public String getP_code() {
	return p_code;
}

public void setP_code(String p_code) {
	this.p_code = p_code;
}

public String getP_name() {
	return p_name;
}

public void setP_name(String p_name) {
	this.p_name = p_name;
}

public String getI_newName() {
	return i_newName;
}

public void setI_newName(String i_newName) {
	this.i_newName = i_newName;
}

public String getP_cate() {
	return p_cate;
}

public void setP_cate(String p_cate) {
	this.p_cate = p_cate;
}

public String getP_cateName() {
	return p_cateName;
}

public void setP_cateName(String p_cateName) {
	this.p_cateName = p_cateName;
}

public String getC_code() {
	return c_code;
}

public void setC_code(String c_code) {
	this.c_code = c_code;
}

public String getC_name() {
	return c_name;
}

public void setC_name(String c_name) {
	this.c_name = c_name;
}

public boolean isMyYN() {
	return myYN;
}

public void setMyYN(boolean myYN) {
	this.myYN = myYN;
}

public int getPc_no() {
	return pc_no;
}

public void setPc_no(int pc_no) {
	this.pc_no = pc_no;
}

public String getPc_content() {
	return pc_content;
}

public void setPc_content(String pc_content) {
	this.pc_content = pc_content;
}

public Date getPc_tm() {
	return pc_tm;
}

public void setPc_tm(Date pc_tm) {
	this.pc_tm = pc_tm;
}

public int getPc_parentno() {
	return pc_parentno;
}

public void setPc_parentno(int pc_parentno) {
	this.pc_parentno = pc_parentno;
}

public String getPc_id() {
	return pc_id;
}

public void setPc_id(String pc_id) {
	this.pc_id = pc_id;
}

public String getF_receiveid() {
	return f_receiveid;
}

public void setF_receiveid(String f_receiveid) {
	this.f_receiveid = f_receiveid;
}

public String getF_sendid() {
	return f_sendid;
}

public void setF_sendid(String f_sendid) {
	this.f_sendid = f_sendid;
}

public Date getF_tm() {
	return f_tm;
}

public void setF_tm(Date f_tm) {
	this.f_tm = f_tm;
}

public int getFlow_count() {
	return flow_count;
}

public void setFlow_count(int flow_count) {
	this.flow_count = flow_count;
}

public String getThisuserFlowingYN() {
	return thisuserFlowingYN;
}

public void setThisuserFlowingYN(String thisuserFlowingYN) {
	this.thisuserFlowingYN = thisuserFlowingYN;
}

public int getTotalPage() {
	return totalPage;
}

public void setTotalPage(int totalPage) {
	this.totalPage = totalPage;
}

public int getCurrPage() {
	return currPage;
}

public void setCurrPage(int currPage) {
	this.currPage = currPage;
}

public int getCurrPageEnd() {
	return currPageEnd;
}

public void setCurrPageEnd(int currPageEnd) {
	this.currPageEnd = currPageEnd;
}

public int getCurrPageStart() {
	return currPageStart;
}

public int getCurrPageNum() {
	return currPageNum;
}

public void setCurrPageNum(int currPageNum) {
	this.currPageNum = currPageNum;
}

public void setCurrPageStart(int currPageStart) {
	this.currPageStart = currPageStart;
}

public int getTotalPost() {
	return totalPost;
}

public void setTotalPost(int totalPost) {
	this.totalPost = totalPost;
}
public String getPntcode() {
    return Pntcode;
 }

 public void setPntcode(String pntcode) {
    Pntcode = pntcode;
 }

public int getP_registCnt() {
	return p_registCnt;
}

public void setP_registCnt(int p_registCnt) {
	this.p_registCnt = p_registCnt;
}

public String getP_path() {
	return p_path;
}

public void setP_path(String p_path) {
	this.p_path = p_path;
}
public String getTc_nname() {
	return tc_nname;
}

public void setTc_nname(String tc_nname) {
	this.tc_nname = tc_nname;
}

public String getB_id() {
	return b_id;
}

public void setB_id(String b_id) {
	this.b_id = b_id;
}

public String getB_code() {
	return b_code;
}

public void setB_code(String b_code) {
	this.b_code = b_code;
}

public int getB_no() {
	return b_no;
}

public void setB_no(int b_no) {
	this.b_no = b_no;
}

public Date getM_readTm() {
	return m_readTm;
}

public void setM_readTm(Date m_readTm) {
	this.m_readTm = m_readTm;
}

public String getM_receiveDelYN() {
	return m_receiveDelYN;
}

public void setM_receiveDelYN(String m_receiveDelYN) {
	this.m_receiveDelYN = m_receiveDelYN;
}

public String getM_sendDelYN() {
	return m_sendDelYN;
}

public void setM_sendDelYN(String m_sendDelYN) {
	this.m_sendDelYN = m_sendDelYN;
}

public String getB_endhr() {
	return b_endhr;
}

public void setB_endhr(String b_endhr) {
	this.b_endhr = b_endhr;
}

public String getB_starthr() {
	return b_starthr;
}

public void setB_starthr(String b_starthr) {
	this.b_starthr = b_starthr;
}

public boolean isU_isFollow() {
	return u_isFollow;
}

public void setU_isFollow(boolean u_isFollow) {
	this.u_isFollow = u_isFollow;
}

public String getPc_session_id() {
	return pc_session_id;
}

public void setPc_session_id(String pc_session_id) {
	this.pc_session_id = pc_session_id;
}

}