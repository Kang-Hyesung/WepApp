<%@page import="com.test.MemberDTO"%>
<%@page import="com.test.MemberDAO"%>
<%@ page contentType="text/html; charset=UTF-8"%>

<%
	StringBuffer str= new StringBuffer();
	MemberDAO dao = new MemberDAO();
	
	try
	{
		dao.connection();
		
		str.append("<table class='table'>");
		str.append("	<tr>");
		str.append("		<th style='width: 50px;'>번호</th>");
		str.append("		<th style='width: 100px;'>이름</th>");
		str.append("		<th style='width: 150px;'>전화번호</th>");
		str.append("		<th style='width: 200px;'>관리</th>");
		str.append("	</tr>");
		
		
		
		for(MemberDTO member : dao.lists())
		{
			str.append("<tr>");
			
			str.append("	<td>" + member.getSid() +  "</td>");
			str.append("	<td>" + member.getName() + "</td>");
			str.append("	<td>" + member.getTel() + "</td>");
			str.append("	<td>");
			str.append("		<a href='MemberUpdateForm.jsp?sid="+ member.getSid() +"'>");
			str.append(				"<button type='button' class='btn01'>수정</button>");
			str.append(			"</a>");
			
			str.append("		<a>");
			str.append("			<button type='button' class='btn01'>삭제</button>");
			str.append("		</a>");
			str.append("	</td>");
			
			str.append("</tr>");
		} 
		
		str.append("</table>");
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
	
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>MemberSelect.jsp</title>
<link rel="stylesheet" type="text/css" href="css/MemberScore.css">
<style type="text/css">
	a {text-decoration: none;}
</style>
</head>
<body>

<div>
	<h1>회원 <span style="color: red;">명단</span> 관리 및 출력 페이지</h1>
	<hr>
</div>

<div>
	<a href="MemberScoreSelect.jsp"><button type="button">회원 성적 관리</button></a>
	<a href="MemberInsertForm.jsp"><button type="button">신규 회원 등록</button></a>
</div>
<br>

<div>
	<!-- 리스트 출력 -->
	<!-- <table class="table">
		<tr>
			<th style="width: 50px;">번호</th>
			<th style="width: 100px;">이름</th>
			<th style="width: 150px;">전화번호</th>
			<th style="width: 200px;">관리</th>
		</tr>
		<tr>
			<td>1</td>
			<td>희동이</td>
			<td>010-1111-1111</td>
			<td>
				<a><button type="button" class="btn01">수정</button></a>
				<a><button type="button" class="btn01">삭제</button></a>
			</td>
		</tr>
		<tr>
			<td>2</td>
			<td>도우너</td>
			<td>010-2222-2222</td>
			<td>
				<a><button type="button" class="btn01">수정</button></a>
				<a><button type="button" class="btn01">삭제</button></a>
			</td>
		</tr>
		<tr>
			<td>3</td>
			<td>마이콜</td>
			<td>010-3333-3333</td>
			<td>
				<a><button type="button" class="btn01">수정</button></a>
				<a><button type="button" class="btn01">삭제</button></a>
			</td>
		</tr>
	</table> -->
	<%=str.toString() %>
</div>

</body>
</html>