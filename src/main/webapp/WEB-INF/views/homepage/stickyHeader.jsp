<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>스크롤 내렸을때</title>
	<link rel="stylesheet" href="${pageContext.request.contextPath}/homepage/css/stickyHeader.css" />
	<script defer src="${pageContext.request.contextPath}/homepage/script/stickyHeader.js"></script> <!-- defer 추가 -->
</head>
<body>
	<div id="sticky-header" class="sticky-header">
		<div class="head-wrapper">
			<div class="head">
				<button class="category-btn" onclick="sticky_category()">☰</button>
				<a href="${pageContext.request.contextPath}/homepage/main-page.jsp" class="head-logo"><img src="image/logo.jpg" class="logo_img" 
					alt="Good Luck 로고" width="140"></a>
				<div class="search-bar">
					<input class="text-bar" type="text" placeholder="검색어를 입력하세요">
					<button class="bar-btn"><img src="image/search.png" height="28"></button>
		    	</div><!-- search-bar -->
		    	
		    	<div class="infomation">
	        		 <a href="#" class="person">
			        	<svg xmlns="http://www.w3.org/2000/svg" fill="currentColor" class="bi bi-person-circle" viewBox="0 0 16 16">
						<path d="M11 6a3 3 0 1 1-6 0 3 3 0 0 1 6 0"/>
						<path fill-rule="evenodd" d="M0 8a8 8 0 1 1 16 0A8 8 0 0 1 0 8m8-7a7 7 0 0 0-5.468 11.37C3.242 11.226 4.805 10 8 10s4.757 1.225 5.468 2.37A7 7 0 0 0 8 1"/></svg>
					</a>
	        		<a href="#" class="bell">
			        	<svg xmlns="http://www.w3.org/2000/svg" fill="currentColor" class="bi bi-bell-fill" viewBox="0 0 16 16">
			  			<path d="M8 16a2 2 0 0 0 2-2H6a2 2 0 0 0 2 2m.995-14.901a1 1 0 1 0-1.99 0A5 5 0 0 0 3 6c0 1.098-.5 6-2 7h14c-1.5-1-2-5.902-2-7 0-2.42-1.72-4.44-4.005-4.901"/></svg>
		  			</a>
		        	<a href="#" class="cart" >
			        	<svg xmlns="http://www.w3.org/2000/svg" fill="currentColor" class="bi bi-cart4" viewBox="0 0 16 16">
			  		    <path d="M0 2.5A.5.5 0 0 1 .5 2H2a.5.5 0 0 1 .485.379L2.89 4H14.5a.5.5 0 0 1 .485.621l-1.5 6A.5.5 0 0 1 13 11H4a.5.5 0 0 1-.485-.379L1.61 3H.5a.5.5 0 0 1-.5-.5M3.14 5l.5 2H5V5zM6 5v2h2V5zm3 0v2h2V5zm3 0v2h1.36l.5-2zm1.11 3H12v2h.61zM11 8H9v2h2zM8 8H6v2h2zM5 8H3.89l.5 2H5zm0 5a1 1 0 1 0 0 2 1 1 0 0 0 0-2m-2 1a2 2 0 1 1 4 0 2 2 0 0 1-4 0m9-1a1 1 0 1 0 0 2 1 1 0 0 0 0-2m-2 1a2 2 0 1 1 4 0 2 2 0 0 1-4 0"/></svg>
					</a>
        		</div><!-- infomation -->
			</div>
		</div><!-- head-wrapper -->
		<hr/>
		<div id="sticky-container">
			<div class="head2-wrapper">
	            <!-- 카테고리 드롭다운 -->
	            <div class="category-dropdown" id="categoryDropdown">
	                <ul class="category-main" id="mainCategoryList">
	                    <li data-sub="sub1">브랜드패션</li>
	                    <li data-sub="sub2">컴퓨터·디지털·가전</li>
	                    <li data-sub="sub3">패션의류·잡화·뷰티</li>
	                    <li data-sub="sub4">식품·생활·주방</li>
	                    <li data-sub="sub5">스포츠·레저</li>
	                </ul>
	                <!-- 2차 카테고리들 -->
	                <ul class="category-sub" id="sub1">
	                    <li>남성의류</li>
	                    <li>여성의류</li>
	                    <li>신발</li>
	                    <li>가방</li>
	                    <li>시계/쥬얼리</li>
	                </ul>
	                <ul class="category-sub" id="sub2">
	                    <li><a href="${pageContext.request.contextPath}/products/laptop.jsp">노트북/데스크탑</a></li>
	                    <li>PC주변기기</li>
	                    <li>저장장치</li>
	                    <li>모바일/태블릿</li>
	                    <li>카메라</li>
	                </ul>
	                <ul class="category-sub" id="sub3">
	                    <li>음향기기</li>
	                    <li>주방가전</li>
	                    <li>계절가전</li>
	                    <li>생활가전</li>
	                </ul>
	                <ul class="category-sub" id="sub4">
	                    <li>식품</li>
	                    <li>생필품</li>
	                    <li>주방용품</li>
	                    <li>주방가전</li>
	                </ul>
	                <ul class="category-sub" id="sub5">
	                    <li>헬스/건강</li>
	                    <li>자전거/보드</li>
	                    <li>캠핑/등산</li>
	                    <li>골프</li>
	                </ul>
	            </div>
	        </div>
		
		</div>
	</div>
</body>
</html>