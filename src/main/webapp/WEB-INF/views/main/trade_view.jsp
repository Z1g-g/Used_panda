<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<!DOCTYPE html>

	<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
	
	<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

	<link rel="stylesheet"
		href="${ pageContext.request.contextPath }/resources/css/trade_view.css">

	<link rel="preconnect" href="https://fonts.googleapis.com">
	<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
	<link
		href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@300&display=swap"
		rel="stylesheet">
<html>
<head>
<meta charset="UTF-8">
<title>상세보기</title>

<!-- Ajax를 위한 httpRequest.js참조 -->
<script
	src="${pageContext.request.contextPath}/resources/js/httpRequest.js"></script>
	
	<script>
		
		function del( f ){
			
			pwd = f.pwd.value;
			input_pwd = f.input_pwd.value.trim();
			idx = f.idx.value;
			
			if( input_pwd == ""){
				alert("비밀번호를 입력해주세요."); return;
			}
			
			if( pwd != input_pwd){
				alert("비밀번호가 일치하지 않습니다.");return;
			}
			
			f.action = "trade_delete.do";
			f.method = "post";
			f.submit();
		
		}
		
		function insert( f ){
			
			t_nickname = f.t_nickname.value;
			t_ref = f.t_ref.value;
			t_content = f.t_content.value;
			t_pwd = f.t_pwd.value;
			
			if( t_content == "" ){ alert("댓글을 입력해주세요"); return; }
			
			f.action = "t_insert.do";
			f.method = "post";
			f.submit();
			
		}
		
		function comments_del( f ){
			
			t_pwd = f.t_pwd.value.trim();
			t_idx = f.t_idx.value;
			t_ref = f.t_ref.value;
			
			if( t_pwd == "" ){ alert("비밀번호를 입력해주세요."); return; }
			
			var url = "comments_check.do";
			var param = "t_idx=" + t_idx + "&t_pwd=" + t_pwd;
			
			sendRequest(url, param, delFn, "GET");
			
			function delFn(){
				
				if(xhr.readyState == 4 && xhr.status == 200){
					
					var data = xhr.responseText;
					
					if(data == 'no'){
						alert("비밀번호 불일치");
						return;
					}else{
						f.action = "comments_delete.do";
						f.method = "post";
						f.submit();
					}
					
				}
			}
		}
		
	</script>

</head>
<body>
	<div id="logo_div">
	
		<img id="logo_img" src="${ pageContext.request.contextPath }/resources/img/logo.png" onclick="location.href='used_list.do'">
	<c:if test="${vo == null || empty vo.nickname}">
			<a class="login_a" onclick="location.href='loginpage.do'">로그인</a>
			<c:if test="${vo != null || !empty vo.nickname}">
			<a id="board_a" onclick="location.href='board.do'">건의/신고/문의게시판</a>
		</c:if>
		<c:if test="${vo == null || empty vo.nickname}">
			<a id="board_a" onclick="alert('로그인후 이용가는한 서비스 입니다.')">건의/신고/질문게시판</a>
			</c:if>
	</c:if>
			
	<c:if test="${vo != null || !empty vo.nickname}">
	<p id="login_a2">${vo.nickname }님 환영합니다<p>
	<a id="logout_a" onclick="location.href='logout.do'">로그아웃</a>
	<a id="board_a2" onclick="location.href='board.do'">건의/신고/질문게시판</a>
	</c:if>
		
	</div>
	
	<!-- 상품상세보기 페이지 -->
	<div id="view_div">
			<img style="border-radius: 2px;" id="photo_img"
						src="${ pageContext.request.contextPath }/resources/upload/${used.filename}">
		<div id="view_div_in">	
			<p style="margin-left: 0px; font-size: 17px; font-weight: 900;">${used.nickname }</p>
			<p style="font-size: 12px; margin-left: 0px; margin-top: -5px;">${used.email }</p>
			
			<hr width="750px">
			
			<h1 style="font-weight: 900; font-size: 22px;">${used.title }</h1>
			<p style="margin: 10px 0px 20px 0px; font-size: 18px; font-weight: 900;">
			<fmt:formatNumber type="number" maxFractionDigits="3" value="${used.price }"/>원</p>
			<pre style="margin-bottom: 25px;">${used.content }</pre>
			
			<p style="display: inline; font-weight: 900; font-size: 18px;">
			지역 : </p>${used.area }
		<form>
			<input type="hidden" name="idx" value="${used.idx }">
			<input type="hidden" name="pwd" value="${used.pwd }">
			<input id="delete_input" name="input_pwd" type="password">
			<button id="delete_button" type="button" onclick="del(this.form);">글 삭제</button>
		</form>
			
			<p style="margin-top: 20px; display: inline;">전체 댓글 
			<p style="display: inline; color: red; font-size: 16px; font-weight: 900;">${used.t_comments }</p>개</p>
			
			<div class="commu_header"></div>
			
		<!-- 댓글 -->	
		<c:forEach var="list" items="${list }">
			<div id="comments">
			<form>
				<p style="font-size: 13px; font-weight: 900; margin-top: 12px; margin-left: 20px;">${list.t_nickname }</p>
				<pre style="margin-top: 8px; margin-left: 20px; font-size: 15px; margin-bottom: 25px;">${list.t_content }</pre>
				<p style="display: inline; font-size: 15px; font-weight: 500; margin-left: 20px; color:silver;">${list.t_date }</p>
				<input type="hidden" name="t_idx" value="${list.t_idx }">
				<input type="hidden" name="t_ref" value="${used.idx }">	
				<input class="comments_input" type="password" name="t_pwd" autocomplete="off" placeholder="댓글삭제 (로그인PWD)">
				<button class="comments_button" type="button" onclick="comments_del(this.form);">댓글 삭제</button><br>
				<hr width="750px">
			</form>	
			</div>
		</c:forEach>
		
		<!-- 로그인 해야 댓글작성 가능 -->
			<c:if test="${vo == null || empty vo.nickname}">
				<p style="margin: 60px 0px 100px 230px;">댓글 작성 하시려면
				<a style="text-decoration:underline; color: blue;" href="loginpage.do">로그인</a>해주세요.</p>
			</c:if>
			
			<c:if test="${vo != null || !empty vo.nickname}">
			<div id="comments_div">
		<form>	
			<p style="font-size: 13px; font-weight: 900; margin-top: 12px; margin-left: 20px;">${vo.nickname}</p>
			<input type="hidden" name="t_nickname" value="${vo.nickname}">
			<input type="hidden" name="t_ref" value="${used.idx }">
			<input type="hidden" name="t_pwd" value="${vo.pwd }">
			<textarea name="t_content"></textarea><br>
			<button id="insert_button" type="button" onclick="insert(this.form);">등록</button>
		</form>	
			</div>
			
			</c:if>
		</div>			
	</div>
	
</body>
</html>