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
      sql ="INSERT INTO userInfo VALUES(?,?,?,?,?,?,?,SYSDATE,'./img/default-profile.png','안녕하세요"+dto.getU_nname()+"입니다','N','N',?)";
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
      if(checker>0) {
         success =true;
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
	         if(rs.next()) {
	        	 idYN.add(rs.getString(1)); // id값 저장
	        	 idYN.add(rs.getString(2)); // 관리자 여부 저장
	         }
	      } catch (SQLException e) {
	         // TODO Auto-generated catch block
	         e.printStackTrace();
	      }finally {
	         resClose();
	      }
	      return idYN;
	   }

public String idsearch(String name, String email) {
	String id=null;
	String sql = "SELECT U_id FROM UserInfo WHERE U_name=? AND U_email=?";
	try {
		ps = conn.prepareStatement(sql);
		ps.setString(1, name);
		ps.setString(2, email);
		rs = ps.executeQuery();
		if(rs.next()) {
			id = rs.getString(1);
		}
	} catch (SQLException e) {
		// TODO Auto-generated catch block
		e.printStackTrace();
	}finally {
		resClose();
	}
	return id;
}

public GGDto myPage(String id) {
	
	GGDto dto = null;
	sql ="SELECT * FROM userInfo WHERE u_id = ?"; 
	try {
		dto = new GGDto();
		ps = conn.prepareStatement(sql);
		ps.setString(1, id);
		rs = ps.executeQuery();
		
		if(rs.next()) {
			dto.setU_id(rs.getString("u_id"));
			dto.setU_nname(rs.getString("u_nname"));
			dto.setU_intro(rs.getString("u_intro"));
			dto.setU_addr(rs.getString("u_addr"));
			dto.setU_newName(rs.getString("u_newName"));
		}
		System.out.println("닉네임 : " + dto.getU_nname());
		System.out.println("자기소개 : " + dto.getU_intro());
		System.out.println("주소 : " + dto.getU_addr());
		System.out.println("사진경로 : " + dto.getU_newName());
		
		sql = "SELECT pnt_point FROM point WHERE pnt_id =?";
		ps = conn.prepareStatement(sql);
		ps.setString(1, id);
		rs = ps.executeQuery();
		if(rs.next()) {
			dto.setPnt_point(rs.getInt("pnt_point"));
		}
		System.out.println("포인트 : " + dto.getPnt_point());
	} catch (SQLException e) {
		e.printStackTrace();
	}
	
	return dto;
}

}