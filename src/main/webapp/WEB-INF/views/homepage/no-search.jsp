	<%@ page language="java" contentType="text/html; charset=UTF-8"
		pageEncoding="UTF-8"%>
	<!DOCTYPE html>
	<html>
		<head>
			<meta charset="UTF-8">
			<title>Good Luck</title>
			<style>
				.no-search_container{
					margin:0 auto;
					text-align:center;
					display:flex;
					flex-direction: column;
					align-items: center;
					justify-content: center;
					height: 500px;
					font-size:22px;
					line-height:22px;
				}
				.no_text{color:#1e90ff;}
				.line1{display:inline-block;}
			</style>
		</head>
	
		<body>
			<jsp:include page="homeHeader.jsp"></jsp:include>
			<div class="no-search_container">
				<div class="line1">
					<span class="no_text">""</span>
					<span class="text1">검색결과가 없습니다.</span>
				</div>
				<br/>
				<span class="text2">검색어를 다시 확인해주세요.</span>
			</div>
			<jsp:include page="homeFooter.jsp"></jsp:include>
		</body>
	</html>