<%@page import="com.test.MemberScoreDAO"%>
<%@page import="com.test.MemberScoreDTO"%>
<%@ page contentType="text/html; charset=UTF-8"%>

<%
	// MemberScoreUpdateForm.jsp 에서 옴
	String sid = request.getParameter("sid");
	String kor = request.getParameter("kor");
	String eng = request.getParameter("eng");
	String mat = request.getParameter("mat");
	
	// MemberScoreDAO 인스턴스 생성
	MemberScoreDAO dao = new MemberScoreDAO();
	
	try
	{
		dao.connection();
		
		MemberScoreDTO score = new MemberScoreDTO();
		
		score.setSid(sid);
		score.setKor(Integer.parseInt(kor));
		score.setEng(Integer.parseInt(eng));
		score.setMat(Integer.parseInt(mat));
		
		dao.modify(score);
		
		// 위 메소드 호출 결과 반환값을 활용한 분기 처리 가능
	}
	catch(Exception e)
	{
		System.out.println(e.toString());
	}
	finally
	{
		try
		{
			dao.close();
		}
		catch(Exception e)
		{
			System.out.println(e.toString());
		}
	}
	
	// 클라이언트에 MemberSelect.jsp 페이지를 다시 요청할 수 있도록 안내
	response.sendRedirect("MemberScoreSelect.jsp");
		
	// 이후 보여지는 페이지 구성 모두 삭제
	
%>