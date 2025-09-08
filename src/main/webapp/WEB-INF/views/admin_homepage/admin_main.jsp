<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>Insert title here</title>
		<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/admin_homepage/css/admin_main.css" />
		
	</head>
		
	<body>
		<jsp:include page="admin_homeHeader.jsp"></jsp:include>
		<div class="container">
			<!-- 사이드 메뉴 -->
			<jsp:include page="admin_navigation.jsp"></jsp:include>
		
			<div class="admin_main">
				<div class="admin_status_wrapper">
					<div class="status_box">
						<div class="status_header">
							<div class="status_title">배송 현황</div>
						</div>	
						<div class="status_body">
							<div class="status_item">결제완료<br><strong>0</strong></div>
							<div class="status_item">상품준비<br><strong>0</strong></div>
							<div class="status_item">배송중<br><strong>0</strong></div>
							<div class="status_item">배송완료<br><strong>0</strong></div>
						</div>
					</div>
					
					<div class="status_box">
						<div class="status_header">
							<div class="status_title">취소/교환/반품/환불 현황</div>
						</div>
						<div class="status_body">
							<div class="status_item">취소<br><strong>0</strong></div>
							<div class="status_item">교환<br><strong>0</strong></div>
							<div class="status_item">반품<br><strong>0</strong></div>
							<div class="status_item">환불<br><strong>0</strong></div>
						</div>
					</div>
					
					<div class="status_box">
						<div class="status_header">
							<div class="status_title">상품 현황</div>
						</div>
						<div class="status_body">
							<div class="status_item">준비중<br><strong>0</strong></div>
							<div class="status_item">판매중<br><strong>0</strong></div>
							<div class="status_item">품절<br><strong class="red_num">0</strong></div>
							<div class="status_item">판매종료<br><strong class="red_num">0</strong></div>
						</div>
					</div>
					
					<div class="status_box">
						<div class="status_header">
							<div class="status_title">문의내역</div>
						</div>
						<div class="status_body">
							<div class="status_item">미답변<br><strong>1</strong></div>
							<div class="status_item">전체<br><strong>0</strong></div>
						</div>	
					</div>
				</div>	
				
			</div>
		</div>
	</body>
</html>