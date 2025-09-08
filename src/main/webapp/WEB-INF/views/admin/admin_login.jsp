<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>관리자 로그인</title>
<script>
	const contextPath = '${pageContext.request.contextPath}';
</script>

<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resources/admin/css/admin_login.css" />

<script type="text/javascript"
	src="${pageContext.request.contextPath}/resources/admin/script/admin_login.js"></script>


</head>


<body>
	<div class="login-container">
		<h2 class="logo_text">
			<a href="${pageContext.request.contextPath}/homepage"
				style="text-decoration: none; color: inherit;"> <span>Good
					Luck</span>&nbsp;&nbsp;Admin
			</a>
		</h2>

		<form action="admin_login" method="post" id="adminLoginForm">
			<%-- <input type="hidden" name="returnUrl" value="${returnUrl}" /> --%>

			<div class="input-group">
				<input type="text" id="admin_id" name="amind_id" placeholder="ID" value="admin">
			</div>

			<div class="input-group">
				<input type="password" name="admin_pwd" id="admin_pwd"
					placeholder="PASSWORD" value="111111">
			</div>

			<button class="login-button" type="submit">로그인</button>
		</form>

		<div class="footer-links">
			<a href="${pageContext.request.contextPath}/homepage">쇼핑몰로 돌아가기</a>
		</div>
	</div>

</body>
</html>
