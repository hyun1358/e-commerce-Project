<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Good Luck 쇼핑몰</title>
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resources/homepage/css/homeHeader.css" />
<script defer
	src="${pageContext.request.contextPath}/resources/homepage/script/homeHeader.js"></script>

<script>
	function searchKeyword() {
		var inputKeyword = document.getElementById("searchInput").value.trim();
		if (inputKeyword === "") {
			alert("검색어를 입력해주세요")
			return false;//입력값이 없으면 제출되지 않게 함
		}
		return true; // 정상 제출
	}
</script>

</head>

<body>
	<div class="nav-container">
		<div class="head-wrapper">
			<a href="${pageContext.request.contextPath}/homepage"> <img
				src="${pageContext.request.contextPath}/resources/homepage/image/logo.jpg"
				class="logo_img" width="180" alt="Good Luck 로고">
			</a>

			<div class="search-bar">
				<form action="${pageContext.request.contextPath}/search"
					method="get" onsubmit="return searchKeyword()">
					<input type="text" name="keyword" id="searchInput"
						autocomplete="off" class="text-bar" placeholder="검색어를 입력하세요"
						value="${param.keyword}">
					<button type="submit" class="bar-btn">
						<img
							src="${pageContext.request.contextPath}/resources/homepage/image/search.png"
							alt="검색">
					</button>
				</form>
			</div>


			<div class="infomation-cart-main">
				<a href="${pageContext.request.contextPath}/mypage/check"
					class="person-main" title="마이페이지"> <svg
						xmlns="http://www.w3.org/2000/svg" width="16" height="16"
						fill="currentColor" class="bi bi-person-fill" viewBox="0 0 16 16">
					<path
							d="M3 14s-1 0-1-1 1-4 6-4 6 3 6 4-1 1-1 1zm5-6a3 3 0 1 0 0-6 3 3 0 0 0 0 6" />
					</svg>
				</a> <a href="${pageContext.request.contextPath}/wishlist"
					class="favorite-main" title="찜"> <svg
						xmlns="http://www.w3.org/2000/svg" width="23" height="23"
						fill="currentColor" class="bi bi-heart" viewBox="0 0 16 16">
							<path
							d="m8 2.748-.717-.737C5.6.281 2.514.878 1.4 3.053c-.523 1.023-.641 2.5.314 4.385.92 1.815 2.834 3.989 6.286 6.357 3.452-2.368 5.365-4.542 6.286-6.357.955-1.886.838-3.362.314-4.385C13.486.878 10.4.28 8.717 2.01zM8 15C-7.333 4.868 3.279-3.04 7.824 1.143q.09.083.176.171a3 3 0 0 1 .176-.17C12.72-3.042 23.333 4.867 8 15" />
						</svg>
				</a> <a href="${pageContext.request.contextPath}/cart_list.do"
					class="cart-main" title="장바구니"> <svg
						xmlns="http://www.w3.org/2000/svg" fill="currentColor"
						class="bi bi-cart4" viewBox="0 0 16 16">
					    	<path
							d="M0 2.5A.5.5 0 0 1 .5 2H2a.5.5 0 0 1 .485.379L2.89 4H14.5a.5.5 0 0 1 .485.621l-1.5 6A.5.5 0 0 1 13 11H4a.5.5 0 0 1-.485-.379L1.61 3H.5a.5.5 0 0 1-.5-.5M3.14 5l.5 2H5V5zM6 5v2h2V5zm3 0v2h2V5zm3 0v2h1.36l.5-2zm1.11 3H12v2h.61zM11 8H9v2h2zM8 8H6v2h2zM5 8H3.89l.5 2H5zm0 5a1 1 0 1 0 0 2 1 1 0 0 0 0-2m-2 1a2 2 0 1 1 4 0 2 2 0 0 1-4 0m9-1a1 1 0 1 0 0 2 1 1 0 0 0 0-2m-2 1a2 2 0 1 1 4 0 2 2 0 0 1-4 0" />
					    </svg>
				</a>
			</div>
		</div>
		<hr>
		<div class="head2-wrapper">
			<button class="menu" id="categoryBtn">전체 카테고리</button>
			<a href="${pageContext.request.contextPath}/best_list">베스트</a> <a
				href="${pageContext.request.contextPath}/all/Products">전체상품</a> <a
				href="${pageContext.request.contextPath}/sale/product">세일상품</a> <a
				href="${pageContext.request.contextPath}/support/notice">공지사항</a> <a
				href="${pageContext.request.contextPath}/support/faq">FAQ</a>

			<div class="utility-menu">
				<c:if test="${not empty user}">
					<a href="#">${user.user_name}님</a>
					<a href="${ pageContext.request.contextPath }/logout">로그아웃</a>
				</c:if>

				<c:if test="${empty user}">
					<a href="${pageContext.request.contextPath}/login_form">로그인</a>
					<a href="${pageContext.request.contextPath}/register">회원가입</a>
				</c:if>
				<a href="${pageContext.request.contextPath}/support/section">고객지원</a>
			</div>
			<!-- 카테고리 드롭다운 -->
			<div class="category-dropdown" id="categoryDropdown">
				<ul class="category-main" id="mainCategoryList">
				
					<c:forEach var="parent" items="${parentCategories}">
						<li data-sub="sub${parent.category_id}">${parent.name}</li>
					</c:forEach>
				</ul>

				<!-- 2차 카테고리들 -->
				<!-- 자식 카테고리 그룹 (각 부모 기준으로) -->
				<c:forEach var="parent" items="${parentCategories}">
					<ul class="category-sub" id="sub${parent.category_id}">
						<c:forEach var="child"
							items="${childCategoryMap[parent.category_id]}">
							<li><a
								href="${pageContext.request.contextPath}/category?category_id=${child.category_id}">
									${child.name} </a></li>
						</c:forEach>
					</ul>
				</c:forEach>
			</div>
		</div>

		<hr>

	</div>

</body>
</html>