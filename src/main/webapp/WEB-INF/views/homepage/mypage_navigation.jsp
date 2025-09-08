<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>마이페이지 사이드바</title>
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resources/homepage/css/mypage_navigation.css">
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
<script
	src="${pageContext.request.contextPath}/resources/homepage/script/mypage_navigation.js"
	defer></script>
</head>

<body>
	<nav class="sidebar" id="sidebar">

		<div class="sidebar-title">
			<a href="${pageContext.request.contextPath}/mypage/check">My Home</a>
		</div>

		<!-- 주문 배송 내역 -->
		<a class="sidebar-item"
			href="${pageContext.request.contextPath}/orderhistory"> <span
			class="sidebar-icon"><i class="fas fa-box"></i></span> <span
			class="sidebar-text">주문 / 배송내역</span>
		</a>

		<!-- 장바구니 -->
		<a class="sidebar-item"
			href="${pageContext.request.contextPath}/cart_list.do"> <span
			class="sidebar-icon"><i class="fas fa-shopping-cart"></i></span> <span
			class="sidebar-text">장바구니</span>
		</a>

		<!-- 관심상품 -->
		<a class="sidebar-item"
			href="${pageContext.request.contextPath}/wishlist"> <span
			class="sidebar-icon"><i class="fas fa-heart"></i></span> <span
			class="sidebar-text">관심상품</span>
		</a>

		<!-- 리뷰관리 -->
		<div class="sidebar-item collapsible">
			<button type="button" class="sidebar-toggle">
				<span class="sidebar-icon"><i class="fas fa-pen-to-square"></i></span>
				<span class="sidebar-text">리뷰 관리</span>
			</button>
			<ul class="sidebar-submenu">
				<li><a href="${pageContext.request.contextPath}/reviewListEmpty" class="sidebar-subitem"> <span
						class="sidebar-subicon"><i class="fas fa-pen"></i></span> <span
						class="sidebar-subtext">리뷰 작성</span>
				</a></li>
				<li><a href="${pageContext.request.contextPath}/reviewListFill" class="sidebar-subitem"> <span
						class="sidebar-subicon"><i class="fas fa-file-lines"></i></span> <span
						class="sidebar-subtext">내가 작성한 리뷰</span>
				</a></li>
			</ul>
		</div>

		<!-- 문의 내역 -->
		<div class="sidebar-item collapsible">
			<button type="button" class="sidebar-toggle">
				<span class="sidebar-icon"><i class="fas fa-pen-to-square"></i></span>
				<span class="sidebar-text">문의 내역</span>
			</button>
			<ul class="sidebar-submenu">
				<li><a
					href="${pageContext.request.contextPath}/goinquiry.do?user_idx=${user.user_idx}"
					class="sidebar-subitem"> <span class="sidebar-subicon"><i
							class="fas fa-pen"></i></span> <span class="sidebar-subtext">1:1
							문의</span>
				</a></li>
				<li><a href="${pageContext.request.contextPath}/my_inquiryList"
					class="sidebar-subitem"> <span class="sidebar-subicon"><i
							class="fas fa-file-lines"></i></span> <span class="sidebar-subtext">나의
							문의 내역</span>
				</a></li>
			</ul>
		</div>
		
		<!-- 개인정보 수정 -->
		<a class="sidebar-item"
			href="${pageContext.request.contextPath}/user_edit"> <span
			class="sidebar-icon"><i class="fas fa-user-cog"></i></span> <span
			class="sidebar-text">개인정보 수정</span>
		</a>

		<!--⚙️📦 🛒❤️ -->
	</nav>
</body>
</html>