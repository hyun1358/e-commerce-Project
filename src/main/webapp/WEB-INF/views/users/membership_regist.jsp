<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>회원가입</title>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/users/css/membership_regist.css">
    <script defer src="${pageContext.request.contextPath}/resources/users/script/membership_regist.js" ></script>
    <script src="${pageContext.request.contextPath}/resources/ajax/httpRequest.js"></script>
</head>

<body>
	<div class="container">
		<div class="logo">
	        <a href="homepage">
	        <img id="rotatingLogo1"src="${pageContext.request.contextPath}/resources/homepage/image/logo_notext.png" width="50" height="50"></a>
	        
	        <h3>Good Lu<span>c</span>k에 오신 것을 환영합니다.</h3>
	        <a href="homepage">
	        <img id="rotatingLogo2" src="${pageContext.request.contextPath}/resources/homepage/image/logo_notext.png" width="50" height="50"></a>
	        <script>
	        window.addEventListener('DOMContentLoaded', () => 
	        {
	            const logo1 = document.getElementById('rotatingLogo1');
	            const logo2 = document.getElementById('rotatingLogo2');
	            logo1.classList.add('rotate1');
	            logo2.classList.add('rotate1');
	        });
	        </script>
	
	    </div>
	    
	    <form id="registerForm" action="local_register" method="post">
	
	        <div class="input-group" id="usernameGroup">
	            <label>아이디</label>
	            <input type="text" name="user_id" id="user_id" placeholder="아이디" autofocus>
	            <div class="error-message" id="userIdError"></div>
	        </div>
	
	        <div class="input-group" id="password">
	            <label>비밀번호</label>
	            <input type="password" name="user_pwd" id="user_pwd" placeholder="비밀번호">
	        </div>
	        
	        <div class="input-group" id="password_check">
	            <label>비밀번호확인</label>
	            <input type="password" id="user_pwd_check" placeholder="비밀번호확인">
	            <div class="error-message" id="userPwd_check_error"></div>
	        </div>
	
			<div class="input-group" id="nameGroup">
	            <label>이름</label>
	            <input type="text" name="user_name" id="user_name" placeholder="이름">
	            <div class="error-message" id="userNameError"></div>
	        </div>
	
			<div class="input-group" id="phoneGroup">
	            <label>휴대전화번호</label>
	            <input type="text" name="phone" id="phone" maxlength="11" placeholder="전화번호">
	            <div class="error-message" id="phoneError"></div>
	        </div>
	
			<div class="input-group input_email">
	            <label>이메일</label>
	            <input type="text" name="email" id="email" placeholder="이메일">
	            <button type="button" id="btn_send" onclick="verification_send()">인증번호 전송</button>
	            <div class="error-message" id="email_error"></div>
	        </div>
	
	        <div class="input-group input_verification_code">
	            <label>인증번호</label>
	            <input type="number" name="auth_code" id="auth_code" maxlength="8" placeholder="인증번호">
	            <button type="button" id="btn_ver_code" onclick="verification_code()">인증하기</button>
	            <div class="error-message" id="email_auth_code_error"></div>
	        </div>
	
	        <button type="button" id="btn_submit" onclick="m_send(this.form)">가입하기</button>
	    </form>
	</div>
</body>
</html>
