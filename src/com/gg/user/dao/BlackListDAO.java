package com.gg.user.dao;

import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;
import com.gg.dto.GGDto;

public class BlackListDAO {
	Connection conn = null;
	PreparedStatement ps = null;
	ResultSet rs = null;
	public BlackListDAO() {
		try {
			Context ctx = new InitialContext();
			DataSource ds = (DataSource)ctx.lookup("java:/comp/env/jdbc/Oracle");
			conn = ds.getConnection();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	public boolean notifyUser(GGDto dto) {
		String sql = "INSERT INTO notify VALUES(n_no_seq.NEXTVAL,?,?,?,?,?,SYSDATE)";
		boolean success = false;
		System.out.println(dto.getN_sendId());
		try {
			ps = conn.prepareStatement(sql, new String[] { "N_no" });
			ps.setString(1, dto.getN_receiveId());
			ps.setString(2, dto.getN_sendId());
			ps.setString(3, dto.getN_content());
			ps.setString(4, dto.getN1_code());
			ps.setString(5, dto.getN2_code());
			if(ps.executeUpdate()>0) {
				rs = ps.getGeneratedKeys();
				if (rs.next()) {
					sql = "INSERT INTO his_notify(N_no,HN_tm,HN_code) VALUES(?,SYSDATE,'HN_001')";
					ps = conn.prepareStatement(sql);
					int pk = rs.getInt(1);
					ps.setInt(1, pk);
					if(ps.executeUpdate()>0) {
						success = true;
					}
				}
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}finally {
			resClose();
		}
		return success;
	}
	
	public void resClose() {
		try {
			if(conn != null && !conn.isClosed()) {conn.close();}
			if(ps != null && !ps.isClosed()) {ps.close();}
			if(rs != null && !rs.isClosed()) {rs.close();}
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}

	public ArrayList<Object> blackLstPr(GGDto dto) throws SQLException {
		String msg = "블랙리스트 등록 실패하였습니다.";
		boolean success= false;
		int checker = 0;
		int pk = -10;
		ArrayList<Object> list = new ArrayList<Object>();
		String sql = "INSERT INTO blacklist(b_id,b_starttm,b_endtm,b_adminid,b_content,b_code,b_no) VALUES(?,SYSDATE,?,?,?,?,b_no_seq.nextval)";
		
		String b_id = dto.getB_id();
		String b_code = dto.getB_code();
		Date b_endtm = dto.getB_endTm();
		String b_adminId = dto.getB_adminId();
		String b_content = dto.getB_content();
		
		ps = conn.prepareStatement(sql, new String[] {"b_no"});
		ps.setString(1,b_id);
		ps.setDate(2, b_endtm);
		ps.setString(3, b_adminId);
		ps.setString(4, b_content);
		ps.setString(5, b_code);
		
		checker = ps.executeUpdate();
		rs = ps.getGeneratedKeys();
		if(rs.next()) {
			pk = rs.getInt(1);
		}
		
		if(checker>0) {
			msg = "블랙리스트 등록 성공하였습니다.";
			success = true;
		}
		
		list.add(msg);
		list.add(success);
		list.add(pk);
		return list;
		
		
		
	}
	
	//로그인 창에서 블랙리스트에 들어가 있는 아이디 인지 확인
	public GGDto checkBLstYN(String u_id) {
		GGDto dto = new GGDto();
		String sql = "SELECT b_id, b_endtm,b_content,b_code from blacklist where b_id = ? order by b_endtm desc";
		try {
			ps = conn.prepareStatement(sql);
			ps.setString(1, u_id);
			rs = ps.executeQuery();
			if(rs.next()) {
				dto.setB_content(rs.getString("b_content"));
				dto.setB_code(rs.getString("b_code"));
				dto.setB_endTm(rs.getDate("b_endtm"));
				
				PointDAO Pdao = new PointDAO();
				String u_nname = Pdao.getNname(u_id);
				dto.setU_nname(u_nname);
				
				Pdao.resClose();
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		
		return dto;
		
	}
	public GGDto blackLstDetail(int b_no) throws SQLException {
		GGDto dto = new GGDto();
		String sql = "SELECT b_id,TO_CHAR(b_starttm, 'YYYY-MM-DD HH24:MI:SS') as b_starthr, TO_CHAR(b_endtm, 'YYYY-MM-DD HH24:MI:SS')as b_endhr,b_adminid,b_content,b_code,b_no from blacklist where b_no=?";
		ps = conn.prepareStatement(sql);
		ps.setInt(1, b_no);
		rs = ps.executeQuery();
		
		if(rs.next()) {
			dto.setB_id(rs.getString("b_id"));
			dto.setB_starthr(rs.getString("b_starthr"));
			dto.setB_endhr(rs.getString("b_endhr"));
			dto.setB_adminId(rs.getString("b_adminId"));
			dto.setB_content(rs.getString("b_content"));
			dto.setB_no(rs.getInt("b_no"));
		}
		
		
		
		return dto;
		
	}
	
}
