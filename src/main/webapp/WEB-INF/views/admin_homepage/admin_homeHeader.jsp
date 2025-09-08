<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resources/admin_homepage/css/admin_homeHeader.css" />
</head>

<body>
	<div class="nav-container">
		<div class="head-wrapper">

			<h2 class="logo_text">
				<a href="${pageContext.request.contextPath}/admin/main"
					style="text-decoration: none; color: inherit;"> <span>Good
						Luck</span>&nbsp;&nbsp;Admin
				</a>
			</h2>

			<div class="infomation-cart-main">
				<p class="admin-text">${ adminUser.name } 님, 환영합니다!</p>
				<a href="#" class="person-main" title="마이페이지"> <svg
						xmlns="http://www.w3.org/2000/svg" fill="currentColor"
						class="bi bi-person-fill" viewBox="0 0 16 16">
						  <path
							d="M3 14s-1 0-1-1 1-4 6-4 6 3 6 4-1 1-1 1zm5-6a3 3 0 1 0 0-6 3 3 0 0 0 0 6" />
						</svg>
				</a> <a href="#" class="bell" title="알림"> <svg
						xmlns="http://www.w3.org/2000/svg" fill="currentColor"
						class="bi bi-bell-fill" viewBox="0 0 16 16">
			  			<path
							d="M8 16a2 2 0 0 0 2-2H6a2 2 0 0 0 2 2m.995-14.901a1 1 0 1 0-1.99 0A5 5 0 0 0 3 6c0 1.098-.5 6-2 7h14c-1.5-1-2-5.902-2-7 0-2.42-1.72-4.44-4.005-4.901" /></svg>
				</a> <a href="${pageContext.request.contextPath}/admin/logout"
					class="logout-link" title="로그아웃" aria-label="로그아웃"> <svg
						xmlns="http://www.w3.org/2000/svg" fill="currentColor"
						viewBox="0 0 24 24">
  <path
							d="M10.09 15.59L11.5 17l5-5-5-5-1.41 1.41L12.67 11H3v2h9.67l-2.58 2.59z" />
  <path
							d="M19 3H5c-1.1 0-2 .9-2 2v4h2V5h14v14H5v-4H3v4c0 1.1.9 2 2 2h14c1.1 0 2-.9 2-2V5c0-1.1-.9-2-2-2z" />
</svg>

				</a>

			</div>
		</div>
	</div>
</body>
</html>