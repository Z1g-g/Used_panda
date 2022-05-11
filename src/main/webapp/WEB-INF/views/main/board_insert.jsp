<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
     <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

	<link rel="stylesheet"
	href="${ pageContext.request.contextPath }/resources/css/board_insert.css">

	<link rel="preconnect" href="https://fonts.googleapis.com">
	<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
	<link
		href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@300&display=swap"
		rel="stylesheet">
		
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>글쓰기</title>

<script>
	function insert( f ){
		
		b_title = f.b_title.value;
		b_content = f.b_content.value;
		b_pwd = f.b_pwd.value.trim();
		b_nickname = f.b_nickname.value;
		
		if(b_title == ""){ alert("글 제목을 입력해주세요"); return; }
		if(b_content == ""){ alert("글 내용을 입력해주세요"); return; }
		if(b_pwd == ""){ alert("글삭제를 위한 비밀번호는 필수입니다"); return; }
		
		f.action = "b_insert.do";
		f.method = "post";
		f.submit();
		
	}
</script>

</head>
<body>
	<div id="main_div">
		<h1>글쓰기</h1>
	<form>
		<input type="hidden" name="b_nickname" value="${vo.nickname }">	
		<input type="text" name="b_title" id="title_input" placeholder=" 제목을 입력해주세요."><br>
		<textarea name="b_content" placeholder=" 내용을 입력해주세요"></textarea><br>
		<input type="password" name="b_pwd" id="pwd_input" placeholder="비밀번호"><p id="img_p">&nbsp;<img src="${ pageContext.request.contextPath }/resources/img/ico_star.gif">글삭제시 사용</p><br>
		<button id="button1" type="button" onclick="insert(this.form);">등록</button>
		<button type="button" onclick="location.href='board.do'">취소</button>
	</form>	
	</div>
</body>
</html>