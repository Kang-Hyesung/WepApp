<%@page import="com.test.MemberScoreDTO"%>
<%@page import="com.test.MemberScoreDAO"%>
<%@ page contentType="text/html; charset=UTF-8"%>

<%
	// 이전 페이지(MemberScoreSelect.jsp)로부터 넘어온 데이터 수신
	// -> sid
	
	String sid = request.getParameter("sid");
	String name = "";
	int kor,eng,mat;
	kor = eng = mat = 0;
	
	MemberScoreDAO dao = new MemberScoreDAO();
	
	try
	{
		// 데이터베이스 연결
		dao.connection();
		
		MemberScoreDTO score = dao.search(sid);
		
		name = score.getName();
		kor = score.getKor();
		eng = score.getEng();
		mat = score.getMat();
		
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
<title>MemberScoreUpdateForm.jsp</title>
<link rel="stylesheet" type="text/css" href="css/MemberScore.css">
<style type="text/css">
	a {text-decoration: none;}
</style>

<script type="text/javascript">
	
	// 입력하기 버튼 클릭 시 호출되는 자바스크립트 함수
	function memberScoreSubmit()
	{
		// 확인
		// alert("submit 함수 호출");
		
		var memberScoreForm = document.getElementById("memberScoreForm");
		
		var kor = document.getElementById("kor");
		var eng = document.getElementById("eng");
		var mat = document.getElementById("mat");
		
		var korMsg = document.getElementById("korMsg");
		var engMsg = document.getElementById("engMsg");
		var matMsg = document.getElementById("matMsg");
		
		korMsg.style.display = "none";
		engMsg.style.display = "none";
		matMsg.style.display = "none";
		
		if(kor.value=="" || isNaN(kor.value) || Number(kor.value) < 0 || Number(kor.value) > 100)
		{
			korMsg.style.display = "inline";
			kor.focus();
			return;
		}
		
		if(eng.value=="" || isNaN(eng.value) || Number(eng.value) < 0 || Number(eng.value) > 100)
		{
			engMsg.style.display = "inline";
			eng.focus();
			return;
		}
		
		if(mat.value=="" || isNaN(mat.value) || Number(mat.value) < 0 || Number(mat.value) > 100)
		{
			matMsg.style.display = "inline";
			mat.focus();
			return;
		}
		
		memberScoreForm.submit();
		
	}// end memberScoreSubmit()
	
	function memberScoreReset()
	{
		// 확인
		// alert("reset 함수 호출");
		var memberScoreFrom = document.getElementById("memberScoreForm");
		
		var kor = document.getElementById("kor");
		
		var korMsg = document.getElementById("korMsg");
		var engMsg = document.getElementById("engMsg");
		var matMsg = document.getElementById("matMsg");
		
		korMsg.style.display = "none";
		engMsg.style.display = "none";
		matMsg.style.display = "none";
		
		memberScoreForm.reset();
		
		kor.focus();
		
	}
	
</script>

</head>
<body>

<div>
	<h1>회원 <span style="color: red;">성적</span> 관리 및 
	<span style="color: green;">입력</span> 페이지</h1>
	<hr>
</div>

<div>
	<a href="MemberScoreSelect.jsp"><button type="button">회원 성적 관리</button></a>
</div>
<br>

<div>
	<!-- 성적 데이터 입력 폼 구성 -->
	<form action="MemberScoreUpdate.jsp?sid=<%=sid %>" method="post" id="memberScoreForm">
		<table class="table">
			<tr>
				<th>번호</th>
				<td>
					<!-- 1 -->
					<%=sid %>
				</td>
				<td></td>
			</tr>
			<tr>
				<th>이름</th>
				<td>
					<!-- 문정환 -->
					<%=name %>
				</td>
				<td></td>
			</tr>
			<tr>
				<th>국어점수</th>
				<td>
					<input type="text" id="kor" name="kor" value="<%=kor %>" class="txtScore">
				</td>
				<td>
					<span class="errMsg" id="korMsg">0 ~ 100 사이의 국어점수 입력</span>
				</td>
			</tr>
			<tr>
				<th>영어점수</th>
				<td>
					<input type="text" id="eng" name="eng" value="<%=eng %>" class="txtScore">
				</td>
				<td>
					<span class="errMsg" id="engMsg">0 ~ 100 사이의 영어점수 입력</span>
				</td>
			</tr>
			<tr>
				<th>수학점수</th>
				<td>
					<input type="text" id="mat" name="mat" value="<%=mat %>" class="txtScore">
				</td>
				<td>
					<span class="errMsg" id="matMsg">0 ~ 100 사이의 수학점수 입력</span>
				</td>
			</tr>
		</table>
		<br>
		
		<a href="javascript:memberScoreSubmit()"><button type="button">수정하기</button></a>
		<a href="javascript:memberScoreReset()"><button type="button">취소하기</button></a>
		<a href="MemberScoreSelect.jsp"><button type="button">목록으로</button></a>
		
	</form>
</div>




</body>
</html>