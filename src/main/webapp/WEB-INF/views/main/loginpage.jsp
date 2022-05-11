<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
    <link rel="stylesheet" href="${ pageContext.request.contextPath }/resources/css/loginpage.css">
    
    <link rel="preconnect" href="https://fonts.googleapis.com">
	<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
	<link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@300&display=swap" rel="stylesheet">
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>로그인</title>

<!-- Ajax를 위한 httpRequest.js참조 -->
<script
	src="${pageContext.request.contextPath}/resources/js/httpRequest.js"></script>

	<script>
	
	function login( f ){
		
		id = f.id.value.trim();
		pwd = f.pwd.value.trim();
		
		if(id == ""){ alert("아이디를 입력해주세요"); return;}
		if(pwd == ""){ alert("비밀번호를 입력해주세요"); return;}
		
		var url = "login_check.do";
		var param ="id="+id+"&pwd="+pwd;
		
		sendRequest(url, param, loginFn, "GET");
	
	function loginFn(){
		
		if(xhr.readyState == 4 && xhr.status == 200){
			var data = xhr.responseText;
			
			if (data == 'no' ){
				alert("아이디 또는 비밀번호가 정확하지 않습니다.");
				return;
			}else{
				f.action = "login.do";
				f.method = "post";
				f.submit();
			}
		
		}
	}
	}
		
	</script>

</head>
<body>

	<img id="logo_img" src="${ pageContext.request.contextPath }/resources/img/logo.png" onclick="location.href='used_list.do'">
<div id="login_div" align="center">

	<h4>MENBER LOGIN</h4>
	
	<div id="login_id_pwd_div">
	<form>
		<input name="id" placeholder="ID" autocomplete="off"><br>
		<input name="pwd" type="password" placeholder="PASSWORD"><br>
		<button type="button" id="login_button" onclick="login(this.form)">로그인</button>
	</form>	
	</div>	
	
	<div id="icon_div">
	<img src="${ pageContext.request.contextPath }/resources/img/icon.gif">
	보안접속
	</div>
	
	<!-- <a>아이디찾기</a>/<a>비밀번호찾기</a> -->	
	
	<!-- <br>  --><br>
	
	<hr width="360px">
	
	<p>회원가입을 하시면 다양하고 특별한<br>혜택이 준비되어 있습니다.</p>
	
	<button id="Join_button" onclick="location.href='join.do'">회원가입</button>
	
</div>	
		
</body>
</html>






