<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
    <link rel="stylesheet" href="${ pageContext.request.contextPath }/resources/css/join.css">
    
    	<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@300&display=swap" rel="stylesheet">
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원가입</title>


	<!-- Ajax를 위한 httpRequest.js참조 -->
<script
	src="${pageContext.request.contextPath}/resources/js/httpRequest.js"></script>

	<script>
	
		//중복체크 확인
		var id_check_b = false;
		var nickname_check_b = false;
		var email_check_b = false;
	
		function join( f ){
			
			var id = f.id.value;
			var pwd = f.pwd.value.trim();
			var nickname = f.nickname.value.trim();
			var name = f.name.value.trim();
			var tel = f.tel.value.trim();
			var email = f.email.value.trim();
			
			//아이디
			if( id == ""){ alert("아이디를 입력해주세요."); return; }
			if( !id_check_b ){ alert("아이디 중복확인을 해주세요"); return;}
			
			//비밀번호
			if( pwd == ""){ alert("비밀번호를 입력해주세요."); return; }
			
			//닉네임
			if( nickname == ""){ alert("닉네임을 입력해주세요."); return; }
			if( !nickname_check_b ){ alert("닉네임 중복확인을 해주세요"); return; }
			
			//이름
			if( name == ""){ alert("이름을 입력해주세요."); return; }
			
			//전화번호
			if( tel == ""){ alert("전화번호를 입력해주세요."); return; }
			
			//이메일
			if( email == ""){ alert("이메일을 입력해주세요."); return; }
			
			if( !email_check_b ){ alert("이메일 중복확인을 해주세요"); return; }
			
			f.action = "insert.do";
			f.method = "post";
			f.submit();
			
		}//join	
		//아이디 중복확인  no면 중복
		function id_check(){	
			
			var id = document.getElementById("id").value.trim();

			if( id == ""){ alert("아이디를 입력해주세요."); return;}
			
			var url = "id_check.do";
			var param = "id=" + id;
			
			sendRequest(url, param, id_result, "GET");
			
		}
		
		function id_result(){
			
			if( xhr.readyState == 4 && xhr.status == 200 ){
				var data = xhr.responseText;
				
				if (data == 'no' ){
					alert("이미 사용중인 아이디입니다.");
					return;
				}else{
					alert("사용가능한 아이디입니다.");
					id_check_b = true;
					
					document.getElementById("id").readOnly = true;
				}
			}
		}
		//닉네임 중복확인
		function nick_check(){
			
			var nickname = document.getElementById("nickname").value.trim();
			
			if( nickname == ""){ alert("닉네임을 입력해주세요."); return;}
			
			var url = "nick_check.do";
			var param = "nickname=" + nickname;
			
			sendRequest(url, param, nick_result, "GET");
			
		}
		
		function nick_result(){
			
			if( xhr.readyState == 4 && xhr.status == 200 ){
				var data = xhr.responseText;
				
				if (data == 'no' ){
					alert("이미 사용중인 닉네임입니다.");
					return;
				}else{
					alert("사용가능한 닉네임입니다.");
					nickname_check_b = true;
					
					document.getElementById("nickname").readOnly = true;
				}
			}
		}
		//이메일 중복확인
		function email_check(){
			
			var email = document.getElementById("email").value.trim();
			
			if( email == ""){ alert("이메일을 입력해주세요."); return;}
			var email_pattern = /^[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*.[a-zA-Z]{2,3}$/i;
			
			if (!email_pattern.test(email)) {
				alert("이메일을 올바른 형식으로 입력해주세요");
				return;
				
		}
			
			var url = "email_check.do";
			var param = "email=" + email;
			
			sendRequest(url, param, email_result, "GET");
			
		}
		
		function email_result(){
			
			if( xhr.readyState == 4 && xhr.status == 200 ){
				var data = xhr.responseText;
				
				if (data == 'no' ){
					alert("이미 사용중인 이메일입니다.");
					return;
				}else{
					alert("사용가능한 이메일입니다.");
					email_check_b = true;
					
					document.getElementById("email").readOnly = true;
				}
			}
		}	
			
	
	</script>

</head>
<body>
	
	<img id="logo_img" src="${ pageContext.request.contextPath }/resources/img/logo.png" onclick="location.href='used_list.do'">

	<div id="main_div">
	
		<h4 align="center">JOIN US</h4><br>
		
		<h4>기본정보</h4> 
		<p id="p1"><img src="${ pageContext.request.contextPath }/resources/img/ico_star.gif">&nbsp;필수입력사항<p>
		<hr width="1300px">
		
<form>
		<p>아이디&nbsp;<img src="${ pageContext.request.contextPath }/resources/img/ico_star.gif"></p>
		<input name="id" type="text" autocomplete="off" id="id">&nbsp;<button type="button" onclick="id_check();">중복확인</button>&nbsp;(영소문자/숫자,4~16자)
		<hr width="1300px">
		
		<p>비밀번호&nbsp;<img src="${ pageContext.request.contextPath }/resources/img/ico_star.gif"></p>
		<input type="password" class="input_4" name="pwd">&nbsp;(영소대소문자/숫자,4~16자)
		<hr width="1300px">
		
		<p>닉네임&nbsp;<img src="${ pageContext.request.contextPath }/resources/img/ico_star.gif"></p>
		<input name="nickname" autocomplete="off" type="text" autocomplete="off" id="nickname">&nbsp;<button type="button" onclick="nick_check();">중복확인</button>
		<hr width="1300px">
		
		<p>이름&nbsp;<img src="${ pageContext.request.contextPath }/resources/img/ico_star.gif"></p>
		<input class="input_2" autocomplete="off" name="name">&nbsp;
		<hr width="1300px">
		
		<p>전화번호&nbsp;<img src="${ pageContext.request.contextPath }/resources/img/ico_star.gif"></p>
		<input class="input_4"  autocomplete="off" name="tel">&nbsp;
		<hr width="1300px">
		
		<p>이메일&nbsp;<img src="${ pageContext.request.contextPath }/resources/img/ico_star.gif"></p>
		<input name="email" type="text" autocomplete="off" id="email">&nbsp;<button type="button" onclick="email_check();">중복확인</button>
		<hr width="1300px">
		
		<button type="button" id="Join_button" onclick="join(this.form);">회원가입</button>
</form>
	
		
	</div>
</body>
</html>