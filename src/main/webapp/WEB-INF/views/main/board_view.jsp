<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

	<link rel="stylesheet"
	href="${ pageContext.request.contextPath }/resources/css/board_view.css">

	<link rel="preconnect" href="https://fonts.googleapis.com">
	<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
	<link
		href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@300&display=swap"
		rel="stylesheet">
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

	<script>
		
		function del( f ){
			
			b_pwd = f.b_pwd.value;
			input_pwd = f.input_pwd.value.trim();
			b_idx = f.b_idx.value;
			
			if( input_pwd == ""){
				alert("비밀번호를 입력해주세요."); return;
			}
			
			if( b_pwd != input_pwd){
				alert("비밀번호가 일치하지 않습니다.");return;
			}
			
			f.action = "delete.do";
			f.method = "post";
			f.submit();
		
		}
		
		function insert( f ){
			
			b_idx = f.b_idx.value;
			mgr_content = f.mgr_content.value;
			
			if( mgr_content == "" ){ alert("답변내용을 입력해주세요"); return; }
			
			f.action = "mgr_insert.do";
			f.method = "post";
			f.submit();
			
		}
		
	</script>

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
	
	<div id="view_Div">
		<p id="title_p">${b_view.b_title }</p><br>
		<p id="nickname_p" style="font-size: 13px; font-weight: 500;">${b_view.b_nickname } </p>
		<p id="|_p" style="color: silver; margin-left: 10px;">|</p>
		<p id="date_p" style="margin-left: 10px; font-size: 13px; font-weight: 500;"> ${b_view.b_date }</p>
		
		<c:if test="${b_view.b_state == 0}">
			<p style="margin-left: 700px;font-size: 15px;font-weight: 700;">답변대기</p><br>
		</c:if>
				
		<c:if test="${b_view.b_state == 1}">
			<p style="margin-left: 700px;font-size: 15px;font-weight: 700; color: blue;">답변완료</p><br>
		</c:if>
		
		<hr>
		<pre id="content_pre">${b_view.b_content }</pre>
		
		<!-- 글 삭제 -->
		<form>
			<input type="hidden" name="b_idx" value="${b_view.b_idx }">
			<input type="hidden" name="b_pwd" value="${b_view.b_pwd }">
			<input id="delete_input" name="input_pwd" type="password">
			<button id="delete_button" type="button" onclick="del(this.form);">글 삭제</button>
		</form>
		
		
		<p id="com_p">관리자답변</p>
		<div class="commu_header"></div>
	
	<c:if test="${b_view.mgr_content != null }">
		<pre id="comments_pre" style="margin-left: 20px;">${b_view.mgr_content }</pre>
	</c:if>	
	
	<c:if test="${vo.nickname eq '관리자' && b_view.mgr_content == null}">
	
		<div id="answer">
				<form>
					<input type="hidden" name="b_idx" value="${b_view.b_idx }">
					<textarea id="answer_text" name="mgr_content"></textarea>
					<button id="insert_button" type="button" onclick="insert(this.form);">등록</button>
				</form>
		</div>
	</c:if>	
		
	</div>
</body>
</html>