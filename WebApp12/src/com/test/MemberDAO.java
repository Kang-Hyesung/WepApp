/*=========================================
 	MemberDAO.java
 	- 데이터베이스 액션 처리 전용 클래스
  	  (TBL_MEMBER 테이블 전용 DAO)
 =========================================*/

package com.test;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;

import com.util.DBConn;

public class MemberDAO
{
	// 주요 속성 구성
	private Connection conn;
	
	// 데이터베이스 연결 담당 메소드
	public Connection connection() throws ClassNotFoundException, SQLException
	{
		conn = DBConn.getConnection();
		return conn;
	}
	
	// 데이터 입력 담당 메소드
	public int add(MemberDTO dto) throws ClassNotFoundException, SQLException
	{	
		int result = 0;
		
		String sql = "INSERT INTO TBL_MEMBER(SID, NAME, TEL) VALUES(MEMBERSEQ.NEXTVAL, ?, ?)";
		
		PreparedStatement pstmt = conn.prepareStatement(sql);
		
		pstmt.setString(1, dto.getName());
		pstmt.setString(2, dto.getTel());
		
		result = pstmt.executeUpdate();
		
		pstmt.close();
		
		return result;
	}
	
	// 회원 리스트 전체 출력 담당 메소드
	public ArrayList<MemberDTO> lists() throws SQLException
	{
		ArrayList<MemberDTO> list = new ArrayList<>();
		
		String sql = "SELECT SID, NAME, TEL FROM TBL_MEMBER ORDER BY SID";
		
		Statement stmt = conn.createStatement();
		
		ResultSet rs = stmt.executeQuery(sql);
		
		while(rs.next())
		{
			MemberDTO dto = new MemberDTO();
			
			dto.setSid(rs.getString(1));
			dto.setName(rs.getString(2));
			dto.setTel(rs.getString(3));
			
			list.add(dto);
		}
		rs.close();
		stmt.close();
		
		return list;
	}
	
	// 전체 회원 수 확인 담당 메소드
	public int count() throws SQLException
	{
		int result = 0;
		
		String sql = "SELECT COUNT(*) AS COUNT FROM TBL_MEMBER";
		
		PreparedStatement pstmt = conn.prepareStatement(sql);
		
		ResultSet rs = pstmt.executeQuery();
		
		while(rs.next())
		{
			result = rs.getInt(1);
		}
		rs.close();
		pstmt.close();
		
		return result;
	}
	
	// 데이터베이스 연결 종료(해제) 담당 메소드
	public void close() throws SQLException
	{
		DBConn.close();
	}
	
	// 메소드 추가
	// 번호 검색 담당 메소드(번호를 통해 회원 데이터 조회)
	// 현재 번호(sid)는 TBL_MEMBER 테이블에서 식별자의 역할을 수행하고 있으며
	// 이로 인해 번호를 통한 검색 결과는 한 명의 회원일 수 밖에 없기 때문에
	// 반환 자료형은 MemberDTO 형태로 구성한다.
	public MemberDTO searchMember(String sid) throws SQLException
	{
		MemberDTO member = new MemberDTO();
		
		String sql = "SELECT SID, NAME, TEL FROM TBL_MEMBER WHERE SID=?";
		
		PreparedStatement pstmt = conn.prepareStatement(sql);
		
		// pstmt.setString(1, sid);
		pstmt.setInt(1, Integer.parseInt(sid));
		
		ResultSet rs = pstmt.executeQuery();
		
		if(rs.next())
		{
			member.setSid(rs.getString(1));
			member.setName(rs.getString(2));
			member.setTel(rs.getString(3));
		}
		rs.close();
		pstmt.close();
		
		return member;
	}
	
	// 메소드 추가
	// 회원 데이터 수정 담당 메소드
	public int modify(MemberDTO member) throws SQLException
	{
		int result = 0;
		
		String sql = "UPDATE TBL_MEMBER SET NAME=?, TEL=? WHERE SID=?";
		
		PreparedStatement pstmt = conn.prepareStatement(sql);
		
		pstmt.setString(1, member.getName());
		pstmt.setString(2, member.getTel());
		//pstmt.setString(3, member.getSid());
		pstmt.setInt(3, Integer.parseInt(member.getSid()));
		
		result = pstmt.executeUpdate();
		pstmt.close();
		
		return result;
	}
	
}



















