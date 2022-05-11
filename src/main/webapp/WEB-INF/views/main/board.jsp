<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

	<link rel="stylesheet"
	href="${ pageContext.request.contextPath }/resources/css/board.css">

	<link rel="preconnect" href="https://fonts.googleapis.com">
	<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
	<link
		href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@300&display=swap"
		rel="stylesheet">
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>자유게시판</title>
</head>
<body>

	<div id="logo_div">
	
		<img id="logo_img" src="${ pageContext.request.contextPath }/resources/img/logo.png" onclick="location.href='used_list.do'">
	<c:if test="${vo == null || empty vo.nickname}">
			<a class="login_a" onclick="location.href='loginpage.do'">로그인</a>
			<a id="board_a" onclick="location.href='board.do'">건의/신고/질문게시판</a>
	</c:if>		
			
	<c:if test="${vo != null || !empty vo.nickname}">
		<p id="login_a2">${vo.nickname }님 환영합니다<p>
		<a id="logout_a" onclick="location.href='logout.do'">로그아웃</a>
		<a id="board_a2" onclick="location.href='board.do'">건의/신고/질문게시판</a>
	</c:if>
		
	</div>	
	
	<div id="main_div" align="center">
		
		<h1 align="center" style="font-size: 35px; font-weight: 900; margin-bottom: 50px;">건의/신고/질문게시판</h1>
		<button id="insert_button" type="button" onclick="location.href='board_insert.do'">글쓰기</button>
		<div class="commu_header"></div>
		<table border="1" bordercolor="#C7D3D4">
			<tr>
				<th width="70px" height="30px">번호</th>
				<th width="650px" height="30px">제목</th>
				<th width="140px" height="30px">글쓴이</th>
				<th width="150px" height="30px">등록일</th>
				<th width="100px" height="30px">상태</th>
			</tr>
			
		<c:forEach var="board" items="${list }">
			<tr align="center">
				<td width="70px" height="30px">${board.b_idx }</td>
				<td align="left" width="650px" height="30px"><a href="board_view.do?b_idx=${board.b_idx}">${board.b_title }</a></td>
				<td width="140px" height="30px">${board.b_nickname }</td>
				<td width="150px" height="30px">${board.b_date }</td>
				
				<c:if test="${board.b_state == 0}">
					<td width="100px" height="30px">답변대기</td>
				</c:if>
				
				<c:if test="${board.b_state == 1}">
					<td style="color: blue;" width="100px" height="30px">답변완료</td>
				</c:if>
			</tr>
		</c:forEach>	
		
		<tr>
		<td colspan="5" align="center">
			${pageMenu }
		</td>
	</tr>
		
		</table>
		<div class="commu_header"></div>
	</div>
	
</body>
</html>