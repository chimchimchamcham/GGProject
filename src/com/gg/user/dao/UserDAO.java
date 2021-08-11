package com.gg.user.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

import com.gg.dto.GGDto;
import com.gg.trade.dao.TradeDAO;

public class UserDAO {

	public Connection conn = null;
	public PreparedStatement ps = null;
	public ResultSet rs = null;
	String sql = "";

	public UserDAO() {
		try {
			Context ctx = new InitialContext();
			DataSource ds = (DataSource) ctx.lookup("java:comp/env/jdbc/Oracle");
			conn = ds.getConnection();

		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

	}

	public void resClose() {
		try {
			if (rs != null && !rs.isClosed()) {
				rs.close();
			}
			if (conn != null && !conn.isClosed()) {
				conn.close();
			}
			if (ps != null && !ps.isClosed()) {
				ps.close();
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

	public boolean idOverlay(String id) {
		boolean success = false;

		sql = "SELECT u_id FROM userInfo WHERE u_id = ?";
		try {
			ps = conn.prepareStatement(sql);
			ps.setString(1, id);
			rs = ps.executeQuery();

			success = rs.next();
		} catch (SQLException e) {

			e.printStackTrace();
		} finally {
			System.out.println("중복 여부 : " + success);
			// resClose()는 service에서 실행한다.
		}
		return success;
	}

	public boolean nNameOverlay(String nname) {
		boolean success = false;

		sql = "SELECT u_nname FROM userInfo WHERE u_nname = ?";
		try {
			ps = conn.prepareStatement(sql);
			ps.setString(1, nname);
			rs = ps.executeQuery();

			success = rs.next();
		} catch (SQLException e) {

			e.printStackTrace();
		} finally {
			System.out.println("중복 여부 : " + success);
			// resClose()는 service에서 실행한다.
		}
		return success;
	}

	public boolean join(GGDto dto) throws Exception {

		boolean success = false;
		// u_id, u_nname,u_pw, u_email,u_name, u_addr, u_phone, u_joinTM,
		// u_newName,U_INTRO, u_AdminYN, u_FollowYN, u_detailAddr
		sql = "INSERT INTO userInfo VALUES(?,?,?,?,?,?,?,SYSDATE,'./img/default-profile.png','안녕하세요" + dto.getU_nname()
				+ "입니다','N','N',?)";
		//
		ps = conn.prepareStatement(sql);
		ps.setString(1, dto.getU_id());
		ps.setString(2, dto.getU_nname());
		ps.setString(3, dto.getU_pw());
		ps.setString(4, dto.getU_email());
		ps.setString(5, dto.getU_name());
		ps.setString(6, dto.getU_addr());
		ps.setString(7, dto.getU_phone());
		ps.setString(8, dto.getU_detailAddr());

		int checker = ps.executeUpdate();
		if (checker > 0) {
			success = true;
		}
		sql = "INSERT INTO point(pnt_id,pnt_point,pnt_tm) VALUES(?,?,SYSDATE)";

		ps = conn.prepareStatement(sql);
		ps.setString(1, dto.getU_id());
		ps.setInt(2, 10);

		ps.executeUpdate();
		System.out.println("회원가입 포인트 10원 지급.");

		return success;
	}

	public ArrayList<String> login(String loginId, String loginPw) {
		ArrayList<String> idYN = new ArrayList<String>();
		String sql = "SELECT U_id,U_adminYN  FROM UserInfo WHERE U_id=? AND U_pw=?";
		try {
			ps = conn.prepareStatement(sql);
			ps.setString(1, loginId);
			ps.setString(2, loginPw);
			rs = ps.executeQuery();
			if (rs.next()) {
				idYN.add(rs.getString(1)); // id값 저장
				idYN.add(rs.getString(2)); // 관리자 여부 저장
				
				//블랙리스트 등록여부 판단
				BlackListDAO BLstDAO = new BlackListDAO();
				ArrayList<String> BLst = new ArrayList<String>();
				BLst=BLstDAO.checkBLstYN(loginId);
				System.out.println("블랙리스트 등록 여부 : "+BLst.size());
				if(BLst.size() > 0) {
					String b_content = BLst.get(0);
					String b_endToStr = BLst.get(1);
					String u_nname = BLst.get(2);
					idYN.add(b_content);
					idYN.add(b_endToStr);
					idYN.add(u_nname);
				}
				BLstDAO.resClose();
				
				
			}
			
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			resClose();
		}
		return idYN;
	}

	public String idsearch(String name, String email) {
		String id = null;
		String sql = "SELECT U_id FROM UserInfo WHERE U_name=? AND U_email=?";
		try {
			ps = conn.prepareStatement(sql);
			ps.setString(1, name);
			ps.setString(2, email);
			rs = ps.executeQuery();
			if (rs.next()) {
				id = rs.getString(1);
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			resClose();
		}
		return id;
	}

	public GGDto myPage(String id) {

		GGDto dto = null;
		sql = "SELECT * FROM userInfo WHERE u_id = ?";
		try {
			dto = new GGDto();
			ps = conn.prepareStatement(sql);
			ps.setString(1, id);
			rs = ps.executeQuery();

			if (rs.next()) {
				dto.setU_id(rs.getString("u_id"));
				dto.setU_pw(rs.getString("u_pw"));
				dto.setU_nname(rs.getString("u_nname"));
				dto.setU_name(rs.getString("u_name"));
				dto.setU_intro(rs.getString("u_intro"));
				dto.setU_addr(rs.getString("u_addr"));
				dto.setU_detailAddr(rs.getString("u_detailAddr"));
				dto.setU_newName(rs.getString("u_newName"));
				dto.setU_phone(rs.getString("u_phone"));
				dto.setU_email(rs.getString("u_email"));
			}
			System.out.println("닉네임 : " + dto.getU_nname());
			System.out.println("비번 : " + dto.getU_pw());
			System.out.println("이름 : " + dto.getU_name());
			System.out.println("자기소개 : " + dto.getU_intro());
			System.out.println("주소 : " + dto.getU_addr());
			System.out.println("상세주소 : " + dto.getU_detailAddr());
			System.out.println("사진경로 : " + dto.getU_newName());
			System.out.println("전화번호 : " + dto.getU_phone());
			System.out.println("이메일 : " + dto.getU_email());

			int myPoint = 0;
			int plusPoint = 0; // 수입
			int minusPoint = 0; // 지출
			// 지출 코드
			sql = "SELECT SUM(pnt_point) FROM point WHERE pnt_id= ?" + "    AND ( pnt_code != 'PNT001'"
					+ "    AND pnt_code != 'PNT004'" + "    AND pnt_code !='PNT005'" + "    AND pnt_code != 'PNT007'"
					+ "    AND pnt_code != 'PNT008'" + "    AND pnt_code != 'PNT010')";
			ps = conn.prepareStatement(sql);
			ps.setString(1, id);
			rs = ps.executeQuery();
			if (rs.next()) {
				minusPoint = rs.getInt(1);
			} else {
				minusPoint = 0;
			}
			// 수입 코드
			sql = "SELECT SUM(pnt_point) FROM point" + "    WHERE pnt_id=?" + "    AND ( pnt_code = 'PNT001'"
					+ "    OR pnt_code = 'PNT004'" + "    OR pnt_code = 'PNT005'" + "    OR pnt_code = 'PNT007'"
					+ "    OR pnt_code = 'PNT008'" + "    OR pnt_code = 'PNT010')";
			ps = conn.prepareStatement(sql);
			ps.setString(1, id);
			rs = ps.executeQuery();
			if (rs.next()) {
				plusPoint = rs.getInt(1);
			} else {
				plusPoint = 0;
			}
			myPoint = plusPoint - minusPoint;
			dto.setPnt_point(myPoint);
			System.out.println("포인트 : " + dto.getPnt_point());
		} catch (SQLException e) {
			e.printStackTrace();
		}

		return dto;
	}

	public String chkpw(GGDto dto) {
		String sql = "SELECT u_pw FROM UserInfo WHERE u_id=? AND u_name=? AND u_email=?";
		String pw = "";
		try {
			ps = conn.prepareStatement(sql);
			ps.setString(1, dto.getU_id());
			ps.setString(2, dto.getU_name());
			ps.setString(3, dto.getU_email());
			rs = ps.executeQuery();
			if (rs.next()) {
				pw = rs.getString(1);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			resClose();
		}
		return pw;
	}

	/* 회원정보 수정 (사진제외) */
	public int userUpdate(GGDto dto) {

		int success = 0;
		String sql = "UPDATE userinfo SET u_pw=?, u_name=?, u_nname=?, u_phone=?,u_email=?,u_addr=?,u_detailAddr=?,u_intro=? WHERE u_id=?";
		try {
			ps = conn.prepareStatement(sql);
			ps.setString(1, dto.getU_pw());
			ps.setString(2, dto.getU_name());
			ps.setString(3, dto.getU_nname());
			ps.setString(4, dto.getU_phone());
			ps.setString(5, dto.getU_email());
			ps.setString(6, dto.getU_addr());
			ps.setString(7, dto.getU_detailAddr());
			ps.setString(8, dto.getU_intro());
			ps.setString(9, dto.getU_id());

			success = ps.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
		}
		System.out.println("success : " + success);
		return success;
	}

	/* 기존 프로필 사진 가져오기 */
	public GGDto getFileName(String id) {
		GGDto dto = null;
		String sql = "SELECT u_newName FROM userinfo WHERE u_id=?";
		try {
			ps = conn.prepareStatement(sql);
			ps.setString(1, id);
			rs = ps.executeQuery();

			if (rs.next()) {
				dto = new GGDto();
				dto.setU_newName(rs.getString(1));
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}

		return dto;
	}

	/* 프로필 사진 수정 */
	public void updateFileName(String delFileName, GGDto dto) {
		String sql = "UPDATE userinfo SET u_newName=? WHERE u_id=?";

		try {
			// dto에는 변경할 사진의 파일명, db에는 기존 사진의 파일명이 있다.
			ps = conn.prepareStatement(sql);
			ps.setString(1, dto.getU_newName());
			ps.setString(2, dto.getU_id());

			int success = ps.executeUpdate();
			System.out.println("사진 변경 성공 : " + success);
		} catch (SQLException e) {
			e.printStackTrace();
		}finally {
			resClose();
		}
	}

	public int changePw(String id, String pw) {
		String sql = "UPDATE UserInfo SET u_pw= ? WHERE u_id=?";
		int success = 0;
		try {
			ps = conn.prepareStatement(sql);
			ps.setString(1, pw);
			ps.setString(2, id);
			success = ps.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			resClose();
		}
		System.out.println("success : " + success);
		return success;
	}

	public ArrayList<GGDto> userList() {
		String sql = "SELECT u_id,u_nname,u_name,u_email,u_phone,u_joinTm FROM userinfo";
		ArrayList<GGDto> userList = new ArrayList<GGDto>();
		GGDto dto = null;

		try {
			ps = conn.prepareStatement(sql);
			rs = ps.executeQuery();
			while (rs.next()) {
				dto = new GGDto();
				dto.setU_id(rs.getString("u_id"));
				dto.setU_nname(rs.getString("u_nname"));
				dto.setU_name(rs.getString("u_name"));
				dto.setU_email(rs.getString("u_email"));
				dto.setU_phone(rs.getString("u_phone"));
				dto.setU_joinTm(rs.getDate("u_joinTm"));
				userList.add(dto);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			resClose();
		}

		return userList;
	}

	public HashMap<String, ArrayList<GGDto>> category() {

		/* ==신고상태 카테고리== */
		String sql = "select * from codes where c_code like 'HN%'";
		HashMap<String, ArrayList<GGDto>> categoryMap = new HashMap<String, ArrayList<GGDto>>();
		ArrayList<GGDto> list1 = new ArrayList<GGDto>();
		ArrayList<GGDto> list2 = new ArrayList<GGDto>();
		try {
			ps = conn.prepareStatement(sql);
			rs = ps.executeQuery();
			while (rs.next()) {
				GGDto dto = new GGDto();
				dto.setC_code(rs.getString("c_code"));
				dto.setC_name(rs.getString("c_name"));
				list1.add(dto);
			}
			categoryMap.put("n_stateCat", list1);
		} catch (SQLException e) {
			e.printStackTrace();
		}

		/* ==신고 대분류 카테고리== */
		sql = "select * from n1_code";
		try {
			ps = conn.prepareStatement(sql);
			rs = ps.executeQuery();
			while (rs.next()) {
				GGDto dto = new GGDto();
				dto.setN1_code(rs.getString("n1_code"));
				dto.setN1_name(rs.getString("n1_name"));
				list2.add(dto);
			}
			categoryMap.put("n1_code", list2);
		} catch (SQLException e) {
			e.printStackTrace();
		}

		return categoryMap;
	}

	public ArrayList<GGDto> notifyList() {

		String sql = "SELECT n.n_no, n.n_receiveid, n.n_sendid, n.n_content, n.n1_code, n.n2_code, TO_CHAR(n.n_tm, 'YYYY-MM-DD HH24:MI:SS')as n_tm, " + 
				"       TO_CHAR(hn.hn_tm, 'YYYY-MM-DD HH24:MI:SS')as hn_tm, hn.hn_code, hn.hn_adminid, " + 
				"       (SELECT N1_NAME FROM N1_CODE N1 WHERE N1.N1_CODE = N.N1_CODE) AS N1_NAME, " + 
				"       (SELECT N2_NAME FROM N2_CODE N2 WHERE N2.N2_CODE = N.N2_CODE) AS N2_NAME, " + 
				"       (SELECT C_NAME FROM CODES WHERE C_CODE = HN_CODE) AS C_NAME " + 
				"FROM   NOTIFY N, HIS_NOTIFY HN, (SELECT N_NO, MAX(HN_TM) HN_TM FROM HIS_NOTIFY GROUP BY N_NO) HNM " + 
				"WHERE N.N_NO = HN.N_NO AND HN.N_NO = HNM.N_NO AND HN.HN_TM = HNM.HN_TM";
		ArrayList<GGDto> notifyList = new ArrayList<GGDto>();
		GGDto dto = null;

		try {
			ps = conn.prepareStatement(sql);
			rs = ps.executeQuery();
			while (rs.next()) {
				dto = new GGDto();
				dto.setN_no(rs.getInt("n_no"));
				dto.setN_receiveId(rs.getString("n_receiveId"));
				dto.setN_sendId(rs.getString("n_sendId"));
				dto.setN1_code(rs.getString("n1_code"));
				dto.setN1_name(rs.getString("n1_name"));
				dto.setN_tm(rs.getString("n_tm"));
				dto.setHn_tm(rs.getString("hn_tm"));
				dto.setHn_code(rs.getString("hn_code"));
				if(rs.getString("hn_adminId") == null){
					dto.setHn_adminid("-");
				}else {
					dto.setHn_adminid(rs.getString("hn_adminId"));
				}
				dto.setC_name(rs.getString("c_name"));
				System.out.println(dto.getHn_adminid());
				System.out.println(dto.getN_tm());
				notifyList.add(dto);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			resClose();
		}
		System.out.println(notifyList);
		return notifyList;
	}

	public ArrayList<GGDto> n_stateCatSel(String n_stateCatSel) {

			String sql = "SELECT n.n_no, n.n_receiveid, n.n_sendid, n.n1_code, n1.n1_name,hn.hn_tm, hn.hn_code, hn.hn_adminid, c.c_name " + 
					"FROM notify n LEFT OUTER JOIN his_notify hn ON n.n_no = hn.n_no " + 
					"INNER JOIN n1_code n1 ON n.n1_code = n1.n1_code " + 
					"LEFT OUTER JOIN codes c ON (hn.hn_code = c.c_code)"+
					"WHERE hn.hn_code=? ORDER BY n_no DESC";
			ArrayList<GGDto> notifyList = new ArrayList<GGDto>();
			GGDto dto = null;

			try {
				ps = conn.prepareStatement(sql);
				ps.setString(1, n_stateCatSel);
				rs = ps.executeQuery();
				while (rs.next()) {
					dto = new GGDto();
					dto.setN_no(rs.getInt("n_no"));
					dto.setN_receiveId(rs.getString("n_receiveId"));
					dto.setN_sendId(rs.getString("n_sendId"));
					dto.setN1_code(rs.getString("n1_code"));
					dto.setN1_name(rs.getString("n1_name"));
					dto.setHn_tm(rs.getString("hn_tm"));
					dto.setHn_code(rs.getString("hn_code"));
					if(rs.getString("hn_adminId") == null){
						dto.setHn_adminid("-");
					}else {
						dto.setHn_adminid(rs.getString("hn_adminId"));
					}
					dto.setC_name(rs.getString("c_name"));
					
					System.out.println(dto.getHn_adminid());
					notifyList.add(dto);
				}
			} catch (SQLException e) {
				e.printStackTrace();
			}finally {
				resClose();
			}

			System.out.println(n_stateCatSel+notifyList);
		return notifyList;
	}

	
	//검색처리
	public HashMap<String,ArrayList<GGDto>> search(String search) throws SQLException {
		HashMap<String,ArrayList<GGDto>> map = new HashMap<String, ArrayList<GGDto>>();
		ArrayList<GGDto> list = null;
		ArrayList<GGDto> list1 = null;
		ArrayList<GGDto> list2 = null;
		GGDto dto = null;
		TradeDAO Tdao = null;
		
		String sql = "select  u_id, u_nname, u_intro, (select count(*) from post where p_id=u_id) as count_p, u_newname, (select count(*) from follow where f_receiveid = u_id) as f_cnt from userinfo where  u_nname like '%"+search+"%' ";
		String sql1 ="select p.p_no, p.p_title, p.p_code, p.p_content, p.p_likecount, p.p_view, p.p_tm, (select i.i_newname from img i  where i.p_no = p.p_no) i_newname from post p where p.p_content like '%"+search+"%'";
		String sql2 ="select p.p_no, p.p_title, p.p_code, p.p_content, p.p_likecount, p.p_view , p.p_tm, (select i.i_newname from img i  where i.p_no = p.p_no) i_newname from post p where p.p_title like '%"+search+"%'"; 
		
		//회원정보 테이블에서 조회
		ps = conn.prepareStatement(sql);
		rs = ps.executeQuery();
		list = new ArrayList<GGDto>();
		while(rs.next()) {
			dto = new GGDto();
			dto.setU_id(rs.getString("u_id")); 
			dto.setU_nname(rs.getString("u_nname"));
			dto.setU_intro(rs.getString("u_intro"));
			dto.setP_registCnt(rs.getInt("count_p"));//등록한 게시물의 총 갯수
			dto.setU_newName(rs.getString("u_newname"));
			dto.setFlow_count(rs.getInt("f_cnt"));
			list.add(dto);
		}
		System.out.println("[검색]사용자 포함여부 검색 결과 : "+list.size());
		map.put("f_ui", list);
		
		//게시글 내용에서 조회
		ps = conn.prepareStatement(sql1);
		rs = ps.executeQuery();
		list1 = new ArrayList<GGDto>();
		while(rs.next()) {
			dto = new GGDto();
			String p_code = rs.getString("p_code");
			int p_no = rs.getInt("p_no");
			
			String p_path = getPath(p_code, p_no);
			
			dto.setP_no(p_no);
			dto.setP_title(rs.getString("p_title"));
			dto.setP_content(rs.getString("p_content"));
			dto.setP_likeCount(rs.getInt("p_likecount"));
			dto.setP_view(rs.getInt("p_view"));
			dto.setP_tm(rs.getDate("p_tm"));
			dto.setI_newName(rs.getString("i_newname"));
			dto.setP_path(p_path);
			list1.add(dto);
		}
		System.out.println("[검색]게시글 내용 포함여부 검색 결과 : "+list1.size());
		map.put("f_pc", list1);
		
		//게시글 제목 조회
		ps = conn.prepareStatement(sql2);
		rs = ps.executeQuery();
		list2 = new ArrayList<GGDto>();
		while(rs.next()) {
			dto = new GGDto();
			String p_code = rs.getString("p_code");
			int p_no = rs.getInt("p_no");
			
			String p_path = getPath(p_code, p_no);
			
			dto.setP_no(p_no);
			dto.setP_title(rs.getString("p_title"));
			dto.setP_content(rs.getString("p_content"));
			dto.setP_likeCount(rs.getInt("p_likecount"));
			dto.setP_view(rs.getInt("p_view"));
			dto.setP_tm(rs.getDate("p_tm"));
			dto.setI_newName(rs.getString("i_newname"));
			dto.setP_path(p_path);
			list2.add(dto);
		}
		System.out.println("[검색]게시글 제목 포함여부 검색 결과 : "+list2.size());
		map.put("f_pt", list2);
		
		return map;
		
		
	}
	
	public String getPath(String p_code,int p_no) {
		String p_path = null;
		if(p_code.equals("P001")) {
			p_path="./auctionDetail?p_no="+p_no;
		}else if(p_code.equals("P002")) {
			p_path = "./salesDetail?p_no="+p_no;
		}else if(p_code.equals("P003")) {
			p_path = "./commDetail?p_no="+p_no;
		}else {
			p_path = "./noticeDetail?p_no="+p_no;
		}
		
		return p_path;
		
	}

	
	public GGDto notifyDetail(String n_no) {

		String sql = "SELECT n.n_no, n.n_receiveid, n.n_sendid, n.n_content, n.n1_code, n.n2_code, TO_CHAR(n.n_tm, 'YYYY-MM-DD HH24:MI:SS')as n_tm, " + 
				"       TO_CHAR(hn.hn_tm, 'YYYY-MM-DD HH24:MI:SS')as hn_tm, hn.hn_code, hn.hn_adminid, " + 
				"       (SELECT N1_NAME FROM N1_CODE WHERE N1_CODE = N.N1_CODE) N1_NAME, " + 
				"       (SELECT N2_NAME FROM N2_CODE WHERE N2_CODE = N.N2_CODE) N2_NAME, " + 
				"       (SELECT C_NAME FROM CODES WHERE C_CODE = HN_CODE) HN_NAME " + 
				"FROM   NOTIFY N, HIS_NOTIFY HN, (SELECT N_NO, MAX(HN_TM) HN_TM FROM HIS_NOTIFY GROUP BY N_NO) HNM " + 
				"WHERE N.N_NO = HN.N_NO AND HN.N_NO = HNM.N_NO AND HN.HN_TM = HNM.HN_TM AND N.N_NO=?";
		GGDto dto = new GGDto();
		
		try {
			ps = conn.prepareStatement(sql);
			ps.setString(1, n_no);
			rs = ps.executeQuery();

			if (rs.next()) {
				dto.setN_no(rs.getInt("n_no"));
				dto.setN_receiveId(rs.getString("n_receiveId"));
				dto.setN_sendId(rs.getString("n_sendId"));
				dto.setN_content(rs.getString("n_content"));
				dto.setN1_code(rs.getString("n1_code"));
				dto.setN2_code(rs.getString("n2_code"));
				dto.setN_tm(rs.getString("n_tm"));
				dto.setN1_name(rs.getString("n1_name"));
				dto.setHn_tm(rs.getString("hn_tm"));
				dto.setHn_code(rs.getString("hn_code"));
				dto.setHn_adminid(rs.getString("hn_adminid"));
				dto.setN2_name(rs.getString("n2_name"));
			}

		} catch (SQLException e) {
			e.printStackTrace();
		}finally {
			resClose();
		}

		return dto;
	}

	public String notifyHistory(String n_no, String hn_code, String hn_admin) {
		String sql = "INSERT INTO his_notify VALUES (?,sysdate,?,?)";
		String sucHn_code = null;
		try {
			ps = conn.prepareStatement(sql);
			ps.setString(1, n_no);
			ps.setString(2, hn_admin);
			ps.setString(3, hn_code);
			
			
			if(ps.executeUpdate()>0) {
				sucHn_code = hn_code;
				System.out.println("신고 히스토리 성공 hn_code : "+sucHn_code);
				}

		} catch (SQLException e) {
			e.printStackTrace();
		}

		return sucHn_code;
	}

	public ArrayList<GGDto> blackList() {
		String sql = "SELECT b_id, b_starttm, b_endtm, b_adminid, b_no FROM blackList";
		ArrayList<GGDto> blackList = new ArrayList<GGDto>();
		GGDto dto = null;

		try {
			ps = conn.prepareStatement(sql);
			rs = ps.executeQuery();
			while (rs.next()) {
				dto = new GGDto();
				dto.setB_id(rs.getString("b_id"));
				dto.setB_startTm(rs.getDate("b_starttm"));
				dto.setB_endTm(rs.getDate("b_endtm"));
				dto.setB_adminId(rs.getString("b_adminid"));
				dto.setB_no(rs.getInt("b_no"));
				blackList.add(dto);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			resClose();
		}

		return blackList;
	}

	public ArrayList<GGDto> postList(String adminId) {
		String sql = "SELECT rnum,p_no, p_title, p_id, p_tm, p_view, p_code, (select u_nname from userinfo where u_id = p_id) as u_nname FROM "
				+ "(SELECT ROW_NUMBER() OVER(ORDER BY p_no DESC) AS rnum,p_no, p_title, p_id, p_tm, p_view, p_code FROM post WHERE p_code='P003' AND P_BLINDYN='N') AND p_id = ?";
		ArrayList<GGDto> list = new ArrayList<GGDto>();
		GGDto dto = null;
		try {
			ps = conn.prepareStatement(sql);
			ps.setString(1, adminId);
			rs = ps.executeQuery();
			while(rs.next()) {
				dto = new GGDto();
				dto.setP_no(rs.getInt("p_no"));
				dto.setP_title(rs.getString("p_title"));
				dto.setP_id(rs.getString("p_id"));
				dto.setP_tm(rs.getDate("p_tm"));
				dto.setP_view(rs.getInt("p_view"));
				dto.setU_nname(rs.getString("u_nname"));
				list.add(dto);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}finally {
			resClose();
		}
		
		return list;
	}
}