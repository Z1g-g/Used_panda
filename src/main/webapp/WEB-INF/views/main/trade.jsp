<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
    <link rel="stylesheet" href="${ pageContext.request.contextPath }/resources/css/trade.css">
    
    	<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@300&display=swap" rel="stylesheet">
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>거래 글 작성</title>

<script>

	function insert( f ){
		
		title = f.title.value;
		content = f.content.value;
		price = f.price.value.trim();
		area = f.area.value;
		pwd = f.pwd.value.trim();
		nickname = f.nickname.value;
		email = f.email.value;
		
		if( title == ''){ alert("제목을 입력해주세요."); return; }
		if( content == ''){ alert("글 내용을 입력해주세요."); return; }
		if( price == ''){ alert("가격을 입력해주세요."); return; }
		if( area == ''){ alert("직거래 장소를 입력해주세요."); return; }
		if( pwd == ''){ alert("비밀번호를 입력해주세요."); return; }
		
		f.action = "product_insert.do";
		f.method = "post";
		f.submit();
	}

</script>

</head>
<body>
	<div id="main_div">
		<div id="writing_div">
			<h2>거래 글 작성</h2>
			
		<form method="post" enctype="Multipart/form-data">	
		
			<input type="hidden" name="nickname" value="${vo.nickname }">
			<input type="hidden" name="email" value="${vo.email }">
		
		
			<input id="title_input" name="title" placeholder="제목을 입력해 주세요."><br>
			<textarea id="content" name="content" placeholder="내용을 입력하세요."></textarea><br>
			가격 : <input id="price_input" type="number" name="price" placeholder="(숫자만입력가능)">&nbsp;원<br>
			<input id="area_input" name="area" autocomplete="off" placeholder="직거래 지역을 입력해주세요 ex)서울시 중구 광희동"><br>
			<input id="file_input" type="file" name="img"><br>
			거래글 삭제용 비밀번호 : <input id="pwd_input" name="pwd" type="password" placeholder="비밀번호">
			<p class="p"><img src="${ pageContext.request.contextPath }/resources/img/ico_star.gif">허위사실을 기재한 경우 계정정지 등 제재를 가할 수 있습니다.</p>
			<button id="go_button" onclick="insert(this.form);">거래 글 등록</button>
			<button type="button" id="stop_button" onclick="location.href='product_list.do'">등록 취소</button>
			
		</form>	
		
		</div>
	</div>
</body>
</html>