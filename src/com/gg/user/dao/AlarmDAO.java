package com.gg.user.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

import com.gg.dto.GGDto;

public class AlarmDAO {
	
	public Connection conn = null;
	public ResultSet rs = null;
	public PreparedStatement ps = null;
	
	

	public AlarmDAO() {
		try {
			Context ctx = new InitialContext();
			DataSource ds = (DataSource)ctx.lookup("java:comp/env/jdbc/Oracle");
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

	public ArrayList<GGDto> ALlist(String u_id, String a_impoyn) throws SQLException {
		GGDto dto = null;
		String insert =null;
		ArrayList<GGDto>list = null;
		String sql = "SELECT a_no,u_id,a_code,a_sendtm,a_checktm,a_content,a_readyn,a_delyn,a_impoyn,a_path from ALARM where u_id=?";
		String sql2 = "SELECT a_no,u_id,a_code,a_sendtm,a_checktm,a_content,a_readyn,a_delyn,a_impoyn,a_path from ALARM where u_id=? and a_impoYN='Y'";
		
		System.out.println("넘어온 a_impoyn : "+a_impoyn);
		
		if(a_impoyn.equals("N")) {
			insert = sql;	
		}else {
			insert = sql2;	
		}
		
		System.out.println("선택된 sql:"+insert);
		
		ps = conn.prepareStatement(insert);
		ps.setString(1, u_id);
		rs = ps.executeQuery();
		list = new ArrayList<GGDto>();
		while(rs.next()) {
			dto = new GGDto();
			dto.setA_no(rs.getInt("a_no"));
			dto.setU_id(rs.getString("u_id"));
			dto.setA_code(rs.getString("a_code"));
			dto.setA_sendTm(rs.getDate("a_sendtm"));
			dto.setA_checkTm(rs.getDate("a_checktm"));
			dto.setA_content(rs.getString("a_content"));
			dto.setA_readYN(rs.getString("a_readyn"));
			dto.setA_delYN(rs.getString("a_delyn"));
			dto.setA_impoYN(rs.getString("a_impoyn"));
			dto.setA_path(rs.getString("a_path"));
			list.add(dto);
		}
		
		System.out.println("알람번호 : "+dto.getA_no());
		System.out.println("알람받은 아이디 : "+dto.getU_id());
		System.out.println("알람코드 : "+dto.getA_code());
		System.out.println("알람보낸 시간 : "+dto.getA_sendTm());
		System.out.println("알람읽은 시간 : "+dto.getA_checkTm());
		System.out.println("알람 읽음 여부 :"+dto.getA_readYN());
		System.out.println("알람 삭제 여부 : "+dto.getA_delYN());
		System.out.println("알람 중요 여부 : "+dto.getA_impoYN());
		System.out.println("알람 경로 : "+dto.getA_path());
		
		return list;
	}
	
	public void insertAlarm(String u_id,String a_code,String a_content,String a_impoyn,String a_path) throws SQLException {
		String sql = "INSERT INTO alarm(a_no,u_id,a_code,a_sendtm,a_content,a_impoyn,a_path) VALUES(a_no_seq.NEXTVAL,?,?,SYSDATE,?,?,?)";
		ps=conn.prepareStatement(sql);
		ps.setString(1,u_id);
		ps.setString(2,a_code);
		ps.setString(3,a_content);
		ps.setString(4,a_impoyn);
		ps.setString(5,a_path);
		int success = ps.executeUpdate();
		if(success>0) {
			System.out.println("-----알람이 전송 되었습니다.-----");
			System.out.println("알람내용 : "+a_content);
			System.out.println("------------------------------");
		}
	}
	
	public boolean readAlarm(int a_no) throws SQLException {
		boolean success = false;
		int checker = 0;
		String sql = "UPDATE alarm SET a_checktm=SYSDATE where a_no=?";
		ps = conn.prepareStatement(sql);
		ps.setInt(1, a_no);
		checker = ps.executeUpdate();
		if(checker >0) {
			success=true;
		}
		
		return success;
	}

	

	

}
