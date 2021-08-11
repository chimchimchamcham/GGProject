package com.gg.board.dao;

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
import com.gg.user.dao.AlarmDAO;
import com.gg.user.dao.PointDAO;

public class CommentDAO {
	public Connection conn = null;
	public ResultSet rs = null;
	public PreparedStatement ps = null;
	
	public CommentDAO() {
		try {
			Context ctx = new InitialContext();
			DataSource ds = (DataSource) ctx.lookup("java:comp/env/jdbc/Oracle");
			conn = ds.getConnection();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	public void resClose() {
		try {
			if (rs != null && !rs.isClosed()) {
				rs.close();
			}
			if (ps != null && !ps.isClosed()) {
				ps.close();
			}
			if (conn != null && !conn.isClosed()) {
				conn.close();
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		
	}
	
	public ArrayList<GGDto> sale_commentlist(String p_id, int p_no)throws SQLException {
		System.out.println("DAO salesDetail의 댓글들 호출");
		ArrayList<GGDto> list = new ArrayList<GGDto>();
		
		System.out.println("p_id:"+p_id);
		System.out.println("p_no:"+p_no);
		
		String sql = "SELECT DISTINCT p.p_no,u.u_nname,pc.pc_content,pc_tm,pc.pc_parentno FROM post p,post_comment pc ,UserInfo u where u.u_id = p.p_id and pc.p_no = p.p_no and pc.p_no = ? and pc.pc_blindyn = 'N' and pc.pc_parentno = 0";
		try {
			ps = conn.prepareStatement(sql);
			ps.setInt(1, p_no);
			rs = ps.executeQuery();
			while(rs.next()){
				GGDto dto = new GGDto();
				dto.setP_no(rs.getInt("p_no"));
				dto.setU_nname(rs.getString("u_nname"));
				dto.setPc_content(rs.getString("pc_content"));
				dto.setPc_tm(rs.getDate("pc_tm"));
				dto.setPc_parentno(rs.getInt("pc_parentno"));
				list.add(dto);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}

		return list;
	}

	public GGDto pushComment(GGDto dto) throws Exception {
		
		
		String sql = "INSERT INTO post_comment VALUES(pc_no_seq.NEXTVAL,?,?,SYSDATE,?,'N',?)";
		
		//pc_no,p_no,pc_content,pc_tm,pc_parentno,pc_blindYN,pc_id;
		
		String pc_id = dto.getPc_id();
		int p_no = dto.getP_no();
		
		ps = conn.prepareStatement(sql);
		ps.setInt(1, p_no);
		ps.setString(2, dto.getPc_content());
		ps.setInt(3, dto.getPc_parentno());
		ps.setString(4, pc_id);
		
		int success = ps.executeUpdate();
		if(success>0) {
			System.out.println("댓글 등록 성공.");
			pushCommentAlarm(p_no, pc_id,true,-100);//댓글등록알람보내기
		}
		
		return dto;
	}

	public ArrayList<GGDto> commentListCall(GGDto dto) throws Exception {
		ArrayList<GGDto> list = new ArrayList<GGDto>();
		
		// 부모댓글이 없는 것들만 가져온다!
		String sql ="SELECT u.u_nname,pc.pc_id,pc.pc_content, u.u_newname, pc.pc_tm, pc.pc_no FROM post_comment pc " + 
				"LEFT OUTER JOIN userinfo u ON (u.u_id = pc.pc_id) " + 
				"WHERE pc.p_no= ? AND pc.pc_parentno=0 AND pc.pc_blindyn ='N' " + 
				"ORDER BY pc_no ASC";
		
		ps = conn.prepareStatement(sql);
		ps.setInt(1, dto.getP_no());
		rs = ps.executeQuery();
		while(rs.next()) {
			dto = new GGDto();
			dto.setPc_no(rs.getInt("pc_no"));
			dto.setPc_id(rs.getString("pc_id"));
			dto.setU_nname(rs.getString("u_nname"));
			dto.setPc_content(rs.getString("pc_content"));
			dto.setU_newName(rs.getString("u_newname"));
			dto.setPc_tm(rs.getDate("pc_tm"));
			
			list.add(dto);
		}
		
		
		
		return list;
	}

	public boolean comm_del(int pc_no) throws SQLException {
		boolean success = false;
		int checker = 0;
		
		String sql = "UPDATE post_comment SET pc_blindYN='Y' WHERE pc_no=?";
		ps = conn.prepareStatement(sql);
		ps.setInt(1, pc_no);
		checker = ps.executeUpdate();
		
		if(checker >0) {
			System.out.println("삭제 성공");
			success = true;
		}
		
		
		return success;
	}

	public boolean comm_update(int pc_no, String pc_context) throws Exception {
		boolean success =false;
		
		int checker=  0;
		
		String sql = "UPDATE post_comment SET pc_content=? WHERE pc_no=?";
		ps = conn.prepareStatement(sql);
		ps.setString(1, pc_context);
		ps.setInt(2, pc_no);
		checker = ps.executeUpdate();
		if(checker >0) {
			success = true;
		}

		
		return success;
	}

	public ArrayList<GGDto> showReComment(GGDto dto) throws Exception {
		ArrayList<GGDto> list = new ArrayList<GGDto>();
		String sql = "SELECT u.u_nname,pc.pc_id,pc.pc_content, u.u_newname, pc.pc_tm, pc.pc_no, pc.pc_parentno " + 
				"FROM post_comment pc " + 
				"LEFT OUTER JOIN userinfo u ON (u.u_id = pc.pc_id) " + 
				"WHERE pc.p_no= ? AND pc.pc_parentno=? AND pc.pc_blindyn ='N' " + 
				"ORDER BY pc_no ASC";
		ps = conn.prepareStatement(sql);
		ps.setInt(1, dto.getP_no());
		ps.setInt(2, dto.getPc_parentno());
		rs = ps.executeQuery();

		while(rs.next()) {
			dto = new GGDto();
			dto.setU_nname(rs.getString("u_nname"));
			dto.setPc_id(rs.getString("pc_id"));
			dto.setPc_content(rs.getString("pc_content"));
			dto.setU_newName(rs.getString("u_newname"));
			dto.setPc_tm(rs.getDate("pc_tm"));
			dto.setPc_no(rs.getInt("pc_no"));
			
			list.add(dto);
			
		}
		
		return list;
	}

	public int re_comment(String pc_content, int pc_parentno, int p_no, String pc_id) throws Exception {
		
		int check = 0;
		String sql ="INSERT INTO post_comment VALUES(pc_no_seq.nextval,?,?,SYSDATE,?,'N',?)";		
		ps = conn.prepareStatement(sql);
		ps.setInt(1, p_no);
		ps.setString(2, pc_content);
		ps.setInt(3, pc_parentno);
		ps.setString(4, pc_id);
		check = ps.executeUpdate();
		
		//대댓글등록알람보내기
		if(check > 0) {
			pushCommentAlarm(p_no, pc_id, false,pc_parentno);
		}
		
		
		return check;
	}
	
	//댓글 등록과 등시에 댓글 등록 알람을 게시글 작성자에게 보냄
	//commentYN=true일경우 댓글알람 
	//commentYN=false일경우 대댓글알람
	public void pushCommentAlarm(int p_no,String pc_id,boolean commentYN,int pc_parentno) {
		
		TradeDAO Tdao = new TradeDAO();
		AlarmDAO Adao = new AlarmDAO();
		PointDAO Pdao = new PointDAO();
		BoardDAO Bdao = new BoardDAO();
		
		try {
			String p_id = Tdao.selectPostP_id(p_no);//댓글이 작성된 게시글 작성자
			String pc_nname = Pdao.getNname(pc_id);//댓글작성자 닉네임 
			String p_title = Bdao.getTitle(p_no);//댓글이 작성된 게시글 제목
			p_title = Adao.cutTitle(p_title);//제목 자르기
			String p_code = Tdao.selectPostP_code(p_no);
			System.out.println("게시글 ");
			String path = null;
			String pc_parentId = null;
			//댓글이 달린 글이 경매글인지 판매글인지 구분
			if(p_code.equals("P001")) {//경매글
				path="./auctionDetail?p_no="+p_no;
			}else if(p_code.equals("P002")) {//판매글
				path="./salesDetail?p_no="+p_no;
			}else if(p_code.equals("P004")) {//커뮤니티글
				path="./commDetail?p_no="+p_no;
			}
			System.out.println("알람경로 : "+path);
			//댓글인지 대댓글인지에 따라 알람 구분
			if(commentYN) {//댓글알람
				Adao.insertAlarm(p_id, "A001", "["+p_title+"]"+pc_nname+"이 댓글을 달았습니다.", "N", path);
			}else {//대댓글알람
				pc_parentId = getParentCommentId(pc_parentno);
				Adao.insertAlarm(pc_parentId, "A001", "["+p_title+"]"+pc_nname+"이 대댓글을 달았습니다.", "N", path);
			}
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}finally {
			Tdao.resClose();
			Adao.resClose();
			Pdao.resClose();
			Bdao.resClose();
		}
		
		
	}
	
	//부모댓글 아이디 가져오는 쿼리
	public String getParentCommentId(int pc_parentno) {
		
		String pc_parentId = null;
		
		String sql = "select pc_id from post_comment where pc_no=?";
		try {
			ps = conn.prepareStatement(sql);
			ps.setInt(1, pc_parentno);
			rs = ps.executeQuery();
			if(rs.next()) {
				pc_parentId = rs.getString("pc_id");
				System.out.println("부모 댓글 아이디 : "+pc_parentId);
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return pc_parentId;
		
	}
	
	

	public HashMap<String, Object> auctionCommentList(int page, int p_no) throws Exception {
		System.out.println("DAO page : " + page);
		int start = 0;
		int end = 0;
		int pagePerCnt = 10;
		HashMap<String,Object> map = new HashMap<String, Object>();
		ArrayList<GGDto> list = new ArrayList<GGDto>();
		GGDto dto = null;
		String sql = "SELECT rnum,p_no,u.u_nname,pc.pc_id,pc.pc_content, u.u_newname, pc.pc_tm, pc.pc_no, pc.pc_parentno " + 
				"FROM (SELECT ROW_NUMBER() OVER(ORDER BY pc_no ASC) AS rnum,pc_no,p_no, pc_content, pc_tm, pc_parentno, pc_blindyn,pc_id " + 
				"FROM post_comment PC lEFT OUTER JOIN userinfo u ON (u.u_id = PC.pc_id) WHERE p_no= ? AND pc_parentno=0 AND pc_blindyn ='N') pc LEFT OUTER JOIN userinfo u ON (u.u_id = pc.pc_id) " + 
				"WHERE p_no= ? AND pc_parentno=0 AND pc_blindyn ='N' AND rnum BETWEEN ? AND ? "+
				"ORDER BY pc_no ASC";
		end = page*pagePerCnt;
		start = (end - pagePerCnt) +1;
		System.out.println("시작 : " + start + " 끝 " + end);
		
		ps = conn.prepareStatement(sql);
		ps.setInt(1, p_no);
		ps.setInt(2, p_no);
		ps.setInt(3, start);
		ps.setInt(4, end);
		rs = ps.executeQuery();
		while(rs.next()) {
			dto = new GGDto();
			dto.setP_no(rs.getInt("p_no"));
			dto.setU_nname(rs.getString("u_nname"));
			dto.setPc_id(rs.getString("pc_id"));
			dto.setPc_content(rs.getString("pc_content"));
			dto.setU_newName(rs.getString("u_newname"));
			dto.setPc_tm(rs.getDate("pc_tm"));
			dto.setPc_no(rs.getInt("pc_no"));
			dto.setPc_parentno(rs.getInt("pc_parentno"));
			list.add(dto);
		}
		int total = totalCount(p_no,0); // 총 게시글 수 계산하는 메소드 2번 째 매개변수는 부모 댓글 0인 순수 댓글만 불러온다는 의미
		int pages = total/pagePerCnt ==0 ? total/pagePerCnt : total/pagePerCnt +1;
		map.put("list", list);
		map.put("totalPage", pages);
		System.out.println("여기가 문제인가? :"+ page);
		map.put("currPage", page);

		return map;
	}

	// 댓글 페이지 총 수를 구하는 메소드.
	private int totalCount(int pc_no, int pc_parentno) throws SQLException {
		
		String sql = "SELECT COUNT(pc_no) FROM post_comment WHERE p_no = ? AND pc_parentno= ? AND pc_blindyn ='N'";
		ps = conn.prepareStatement(sql);
		ps.setInt(1, pc_no);
		ps.setInt(2, pc_parentno);
		rs = ps.executeQuery();
		int total = 0;
		if(rs.next()) {
			total = rs.getInt(1);
		}
		
		
		return total;
	}

}
