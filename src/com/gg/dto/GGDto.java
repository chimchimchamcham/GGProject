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
   

   // 쪽지함
   private Date m_sendTm; // 보낸시간
   private String m_sendId;// 보낸아이디
   private String m_receiveId;// 받은아이디
   private String m_content;// 쪽지내용

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
   private String n_receivedId; // 신고 받은 아이디
   private String n_sendId; // 신고한 아이디
   private String n_content; // 신고내용
   private String n1_code; // 대분류코드
   private String n2_code; // 중분류코드
   private String Pntcode;// 분류코드
   
   
   public String getPntcode() {
      return Pntcode;
   }

   public void setPntcode(String pntcode) {
      Pntcode = pntcode;
   }

   // 블랙리스트
   private Date b_startTm; // 블랙리스트 등록날짜
   private Date b_endTm; // 블랙리스트 등록날짜
   private String b_adminId; // 관리자ID
   private String b_content; // 등록사유

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
   private int ha_bidPr; // 입찰가격

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
}