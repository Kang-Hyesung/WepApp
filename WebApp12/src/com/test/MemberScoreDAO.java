/*==========================================
 	MemberScoreDAO.java
 	- 데이터베이스 액션 처리 전용 클래스
 	  (TBL_MEMBERSCORE 테이블 전용 DAO)
 =========================================*/


package com.test;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import com.util.DBConn;

public class MemberScoreDAO
{
	// 주요 속성 구성
	private Connection conn;
	
	// 데이터베이스 연결 담당 메소드
	public Connection connection() throws ClassNotFoundException, SQLException 
	{
		conn = DBConn.getConnection();
		return conn;
	}
	
	// 데이터 입력 담당 메소드(성적 데이터 입력)
	public int add(MemberScoreDTO score) throws SQLException
	{
		int result = 0;
		
		String sql = "INSERT INTO TBL_MEMBERSCORE(SID, KOR, ENG, MAT) VALUES(?, ?, ?, ?)";
		
		PreparedStatement pstmt = conn.prepareStatement(sql);
		
		pstmt.setInt(1, Integer.parseInt(score.getSid()));
		pstmt.setInt(2, score.getKor());
		pstmt.setInt(3, score.getEng());
		pstmt.setInt(4, score.getMat());
		
		result = pstmt.executeUpdate();
		
		return result;
	}
	
	// 성적 전체 리스트 출력 담당 메소드(성적 데이터 전체 출력)
	public ArrayList<MemberScoreDTO> lists() throws SQLException
	{
		ArrayList<MemberScoreDTO> lists = new ArrayList<MemberScoreDTO>();
		
		String sql = "SELECT SID, NAME, KOR, ENG, MAT, (KOR+ENG+MAT) AS TOT, (KOR+ENG+MAT)/3,1 AS AVG , (RANK() OVER(ORDER BY (KOR+ENG+MAT) DESC)) AS RANK"
				+ " FROM VIEW_MEMBERSCORE2"
				+ " ORDER BY SID";
		
		PreparedStatement pstmt = conn.prepareStatement(sql);
		
		ResultSet rs = pstmt.executeQuery();
		
		while(rs.next())
		{
			MemberScoreDTO score = new MemberScoreDTO();
			score.setSid(rs.getString(1));
			score.setName(rs.getString(2));
			score.setKor(rs.getInt(3));
			score.setEng(rs.getInt(4));
			score.setMat(rs.getInt(5));
			score.setTot(rs.getInt(6));
			score.setAvg(rs.getDouble(7));
			score.setRank(rs.getInt(8));
			//score.setRank(rs.getInt("RANK"));
			
			lists.add(score);
		}
		
		pstmt.close();
		rs.close();
		
		return lists;
	}
	
	// 데이터베이스 연결 종료(해제) 담당 메소드
	public void close() throws SQLException
	{
		DBConn.close();
	}
	
	// 메소드 추가
	// 번호 검색 담당 메소드
	public MemberScoreDTO search(String sid) throws SQLException
	{
		MemberScoreDTO member = new MemberScoreDTO();
		
		String sql = "SELECT SID, NAME, KOR, ENG, MAT FROM VIEW_MEMBERSCORE WHERE SID=?";
		
		PreparedStatement pstmt = conn.prepareStatement(sql);
		pstmt.setInt(1, Integer.parseInt(sid));
		
		ResultSet rs = pstmt.executeQuery();
		
		if(rs.next())
		{
			member.setSid(rs.getString(1));
			member.setName(rs.getString(2));
			member.setKor(rs.getInt(3));
			member.setEng(rs.getInt(4));
			member.setMat(rs.getInt(5));
		}
		rs.close();
		pstmt.close();
		
		return member;
	}
	
	// 메소드 추가
	// 성적 데이터 수정 담당 메소드
	public int modify(MemberScoreDTO score) throws SQLException
	{
		int result = 0;
		
		String sql = "UPDATE TBL_MEMBERSCORE SET KOR=?, ENG=?, MAT=? WHERE SID=?";
		
		PreparedStatement pstmt = conn.prepareStatement(sql);
		
		pstmt.setInt(1, score.getKor());
		pstmt.setInt(2, score.getEng());
		pstmt.setInt(3, score.getMat());
		pstmt.setInt(4, Integer.parseInt(score.getSid()));
		
		result = pstmt.executeUpdate();
		
		return result;
	}
	
	// 메소드 추가
	// 성적 데이터 삭제 담당 메소드
	public int remove(String sid) throws SQLException
	{
		int result = 0;
		
		String sql = "DELETE FROM TBL_MEMBERSCORE WHERE SID=?";
		
		PreparedStatement pstmt = conn.prepareStatement(sql);
		
		pstmt.setString(1, sid);
		result = pstmt.executeUpdate();
		pstmt.close();
		
		return result;
	}
}























