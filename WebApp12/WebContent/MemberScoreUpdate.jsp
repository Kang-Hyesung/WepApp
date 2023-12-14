<%@page import="com.test.MemberScoreDAO"%>
<%@page import="com.test.MemberScoreDTO"%>
<%@ page contentType="text/html; charset=UTF-8"%>

<%
	// MemberScoreUpdateForm.jsp 에서 옴
	String sid = request.getParameter("sid");
	String kor = request.getParameter("kor");
	String eng = request.getParameter("eng");
	String mat = request.getParameter("mat");
	
	MemberScoreDAO dao = new MemberScoreDAO();
	
	try
	{
		dao.connection();
		
		MemberScoreDTO member = new MemberScoreDTO();
		
		member.setSid(sid);
		member.setKor(Integer.parseInt(kor));
		member.setEng(Integer.parseInt(eng));
		member.setMat(Integer.parseInt(mat));
		
		
		dao.modify(member);
		
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

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" type="text/css" href="css/main.css">
</head>
<body>

</body>
</html>