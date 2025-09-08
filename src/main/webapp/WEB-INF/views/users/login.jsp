<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>로그인</title>
	<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/users/css/login.css" />
	<script type="text/javascript" src="https://static.nid.naver.com/js/naverLogin_implicit-1.0.2.js" charset="utf-8"></script>
	<script src="https://code.jquery.com/jquery-1.11.3.min.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/resources/users/script/login.js"></script>
</head>
<body>
    <div class="login-container">
        <div class="logo">
            <a href="homepage">
            	<img src="${pageContext.request.contextPath}/resources/homepage/image/logo.jpg" width="250" height="100">
            </a>
        </div>
        
        <form id="loginForm" action="login_check" method="post">
        	 <input type="hidden" name="returnUrl" value="${returnUrl}" />
            <div class="input-group">
                <input type="text" id="user_id" name="user_id" placeholder="아이디 입력">
            </div>
            
            <div class="input-group">
                <input type="password" name="user_pwd" id="user_pwd" placeholder="비밀번호 입력">
            </div>
            
            <div class="checkbox-group">
                <input type="checkbox" id="remember">
                <label for="remember">로그인 상태 유지</label>
            </div>
            
            <button class="login-button" type="button" onclick="m_send(this.form)">로그인</button>
        </form>
        
        <c:if test="${param.signup eq 'success'}">
		    <script>
		        alert("🎉 회원가입이 성공적으로 완료되었습니다. 이제 로그인하여 서비스를 이용해 주세요.");
		    </script>
		</c:if>
		<c:if test="${param.signup eq 'not_equals'}">
		    <script>
		        alert("이미 등록된 이메일입니다. 다른 아이디를 사용해주세요");
		    </script>
		</c:if>
		<c:if test="${param.signup eq 'null'}">
		    <script>
		        alert("아이디가 존재하지 않거나 비밀번호가 틀렸습니다.");
		    </script>
		</c:if>
        
        <div class="social-login">
            <div class="social-icon"><a href="${naver_url}"><img src="${pageContext.request.contextPath}/resources/users/image/social_naver.png" alt="네이버 로그인"></a></div>
            <div class="social-icon"><a href="${kakao_url}"><img src="${pageContext.request.contextPath}/resources/users/image/social_kakao.png" alt="카카오톡 로그인"></a></div>
            <div class="social-icon"><a href="${google_url}"><img src="${pageContext.request.contextPath}/resources/users/image/social_google.png" alt="구글 로그인"></a></div>
        </div>
        
        <div class="footer-links">
            <a href="id_find_form?check=first">아이디찾기</a>
            <a href="pwd_find_form?check=first">비밀번호찾기</a>
            <a href="register">회원가입</a>
            <a href="admin/login_form">관리자 로그인</a>
        </div>
    </div>
    
   </body>
</html>
