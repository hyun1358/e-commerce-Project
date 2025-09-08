<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>아이디찾기</title>
	<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/users/css/id_find.css" />
	<script type="text/javascript" src="${pageContext.request.contextPath}/resources/users/script/id_find.js"></script>
	<script type="text/javascript" src="http://code.jquery.com/jquery-1.11.3.min.js"></script>
	</head>
    
</head>
<body>
    <div class="login-container">
        <div class="logo">
            <a href="${pageContext.request.contextPath}/homepage">
            	<img src="${pageContext.request.contextPath}/resources/homepage/image/logo.jpg" width="250" height="100">
            </a>
        </div>
        <c:if test="${param.check eq 'first'}">
        	<form id="loginForm" action="${pageContext.request.contextPath}/id_find" method="post">
	            <div class="input-group">
	                <input type="text" id="email" name="email" placeholder="이메일 입력">
	            </div>
	            <button class="login-button" type="button" onclick="m_send(this.form)">아이디 찾기</button>
       	 	</form>
        </c:if>
        <c:if test="${param.check eq 'yes'}">
        	<button class="login-button" type="button" onclick="location.href='${pageContext.request.contextPath}/login_form'">로그인 하기</button>
        </c:if>
        
    </div>
</html>
