<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
    <link rel="stylesheet" href="${ pageContext.request.contextPath }/resources/css/main.css">
    
    	<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@300&display=swap" rel="stylesheet">
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>중고판다</title>
</head>
<body>
		
<div id="banner_div">
	
	<div id="banner_h1">
	<h1>우리 동네<br>중고 직거래 마켓</h1><br>
	<p class="p" id="p1">동네 주민들과 가깝고 따뜻한 거래를 지금 경험해보세요.</p><br>
	<button type="button" id="button1" onclick="location.href='product_list.do'" style="cursor: pointer;">인기매물 보기</button>
	</div>
	
	<img id="banner_img" src="${ pageContext.request.contextPath }/resources/img/pokemon2.png">
</div>

<div id="main_div">
	<div id="logo_div">
	
		<img style="cursor: pointer;" id="logo_img" src="${ pageContext.request.contextPath }/resources/img/logo.png" onclick="location.href='used_list.do'">
	<c:if test="${vo == null || empty vo.nickname}">
			<a class="login_a" onclick="location.href='loginpage.do'">로그인</a>
			<c:if test="${vo != null || !empty vo.nickname}">
			<a id="board_a" onclick="location.href='board.do'">건의/신고/질문게시판</a>
		</c:if>
		<c:if test="${vo == null || empty vo.nickname}">
			<a id="board_a" onclick="alert('로그인후 이용가는한 서비스 입니다.')">건의/신고/질문게시판</a>
			</c:if>
	</c:if>		
			
	<c:if test="${vo != null || !empty vo.nickname}">
	<p class="p" id="login_a2">${vo.nickname }님 환영합니다<p>
	<a id="logout_a" onclick="location.href='logout.do'">로그아웃</a>
	<a id="board_a2" onclick="location.href='board.do'">건의/신고/질문게시판</a>
	</c:if>
		
		
	</div>	
		 
</div>

	<div align="center" id="product_div">
		<h1>중고 직거래 인기매물</h1>
		
	<c:forEach var="used" begin="0" end="7" items="${list }">	
		<div class="product" align="left" onclick="location.href='trade_view.do?idx=${used.idx}'">
			<div class="product_in">
				<img id="img1" width="250px" height="250px" src="${ pageContext.request.contextPath }/resources/upload/${used.filename}">
			</div>
			<p class="p">${used.title }</p>
			<p class="p" style="font-weight: 900;"><fmt:formatNumber type="number" maxFractionDigits="3" value="${used.price }"/>원</p>
			<p class="p" style="font-size: 14px;">${used.area }</p>
		</div>
	</c:forEach>	
			
				
	</div>	
			<a id="a_last" onclick="location.href='product_list.do'">인기매물 더 보기</a>
	
	
</body>
</html>