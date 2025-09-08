<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<script type="text/javascript"
	src="${pageContext.request.contextPath}/resources/admin_homepage/script/admin_navigation.js"></script>
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resources/admin_homepage/css/admin_navigation.css" />

<nav class="sidebar" id="sidebar">
	<div class="sidebar-title">
		<a href="${pageContext.request.contextPath}/admin/main">Home</a>
	</div>
	<a class="sidebar-item"
		href="${pageContext.request.contextPath}/homepage">쇼핑몰 홈으로</a> <a
		class="sidebar-item"
		href="${pageContext.request.contextPath}/admin/customer">회원 관리</a> <a
		class="sidebar-item"
		href="${pageContext.request.contextPath}/admin/product">상품 관리</a> <a
		class="sidebar-item"
		href="${pageContext.request.contextPath}/admin/order">주문/배송 관리</a>
	<!--·  -->
	<a class="sidebar-item"
		href="${pageContext.request.contextPath}/admin/return">교환·반품 관리</a>
	<%-- 	<a class="sidebar-item" href="${pageContext.request.contextPath}/admin_notice">공지사항 관리</a> 
	<a class="sidebar-item" href="${pageContext.request.contextPath}/admin_inquiry">문의 관리</a>
	<a class="sidebar-item" href="${pageContext.request.contextPath}/admin_review">리뷰 관리</a>  
	<a class="sidebar-item" href="#">통계</a>--%>

</nav>