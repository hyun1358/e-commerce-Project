<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>메인페이지의 배너</title>
		
		<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/homepage/css/banner.css"/>
		<script src="${pageContext.request.contextPath}/resources/homepage/script/banner.js"></script>
	</head>
	
	<body>
		<div>
			<div class='banner-container'>
				<button class="image-button prev" onClick='prev()' aria-label="이전 배너">
					<img src='${pageContext.request.contextPath}/resources/homepage/image/IconLeft.png' alt='왼쪽화살표' >
					<%--img/IconLeft.png--%>
				</button>
				
				<div class="banner-image-wrapper">
					<img src='${pageContext.request.contextPath}/resources/homepage/image/banner1.png' id='banner_main'>
				</div>
				
				<button class="image-button next" onClick='next()' aria-label="다음 배너">
					<img src='${pageContext.request.contextPath}/resources/homepage/image/IconRight.png' alt='오른쪽화살표' >
				</button>
			
			</div>
		</div>
	</body>
</html>