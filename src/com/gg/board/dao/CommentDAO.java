package com.gg.board.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

import com.gg.dto.GGDto;

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
		ps = conn.prepareStatement(sql);
		ps.setInt(1, dto.getP_no());
		ps.setString(2, dto.getPc_content());
		ps.setInt(3, dto.getPc_parentno());
		ps.setString(4, dto.getPc_id());
		
		int success = ps.executeUpdate();
		if(success>0) {
			System.out.println("댓글 등록 성공.");
		}
		
		return dto;
	}

}
