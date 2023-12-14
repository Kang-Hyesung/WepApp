<%@page import="com.test.MemberDTO"%>
<%@page import="com.test.MemberDAO"%>
<%@ page contentType="text/html; charset=UTF-8"%>

<%
	// 이전 페이지(MemberSelect.jsp)로부터 넘어온 데이터 수신
	// -> sid
	
	// 수신한 sid 를 가지고 회원 데이터 조회
	// 조회해서 얻어낸 데이터를 폼에 구성
	
	String sid = request.getParameter("sid");
	int kor,eng,mat;
	
	MemberDAO dao = new MemberDAO();
	
	try
	{
		// 데이터베이스 연결
		dao.connection();
		
		MemberDTO member = dao.searchMember(sid);
		sid = member.getSid();
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
<title>MemberUpdateForm.jsp</title>
<link rel="stylesheet" type="text/css" href="css/MemberScore.css">
<style type="text/css">
	a {text-decoration: none;}
</style>

<script type="text/javascript">
	
	// 입력하기 버튼 클릭 시 호출되는 자바스크립트 함수
	function memberSubmit()
	{
		// 확인
		// alert("함수 호출");
		
		var memberForm = document.getElementById("memberForm");
		
		var uName = document.getElementById("uName");
		var nameMsg = document.getElementById("nameMsg");
		
		nameMsg.style.display = "none";
		
		if(uName.value == "")
		{
			nameMsg.style.display = "inline";
			uName.focus();
			return;
		}
		
		// form 을 직접 지정하여 submit 역할 수행
		memberForm.submit();
	}
	
	function memberReset()
	{
		// 확인
		// alert("함수 호출");
		
		var memberForm = document.getElementById("memberForm");
		var uName = document.getElementById("uName");
		var nameMsg = document.getElementById("nameMsg");
		
		nameMsg.style.display = "none";
		
		// form 을 직접 지정하여 reset 액션 수행
		memberForm.reset();	// 원래대로 돌아가는 것
		
		uName.focus();
	}
	
</script>

</head>
<body>

<div>
	<h1>회원 <span style="color: red;">명단</span> 관리 및 
	<span style="color: blue;">수정</span> 페이지</h1>
	<hr>
</div>

<div>
	<a href="MemberSelect.jsp"><button type="button">회원 명단 관리</button></a>
</div>
<br>

<div>
	<!-- 회원 데이터 수정 폼 구성 -->
					<!-- 3방법 -->
	<form action="MemberUpdate.jsp?sid=<%=sid %>" method="post" id="memberForm">
		<table class="table">
			<tr>
				<th>번호</th>
				<!-- <td>1</td> -->
				<!-- name 속성이 없어서 가져올 수 없다(getparameter로 다음 jsp에서) -->
				<td>	<!-- 1방법 -->
					<%-- <input type="text" name="sid" value="<%=sid %>" disabled="disabled"> --%>
					<%=sid %>
				</td>
			</tr>
			<tr>
				<th>이름(*)</th>
				<td>
					<input type="text" id="uName" name="uName" value="<%=name%>">
				</td>
				<td>
					<span class="errMsg" id="nameMsg">이름을 입력해야 합니다.</span>
				</td>
			</tr>
			<tr>
				<th>전화번호</th>
				<td>
					<input type="text" id="uTel" name="uTel" value="<%=tel %>">
				</td>
				<td></td>
			</tr>
		</table>
		
		
		<%-- 2방법
		 <input type="hidden" name="sid" value="<%=sid %>"> --%>
		<br>
		
		<a href="javascript:memberSubmit()"><button type="button">수정하기</button></a>
		<a href="javascript:memberReset()"><button type="button">취소하기</button></a>
		<a href="MemberSelect.jsp"><button type="button">목록으로</button></a>
	</form>
</div>




</body>
</html>