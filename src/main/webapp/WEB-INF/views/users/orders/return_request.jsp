<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>교환/반품 신청</title>
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resources/users/orders/css/return_request.css" />
<script
	src="${pageContext.request.contextPath}/resources/users/orders/script/return_request.js"
	defer></script>
</head>
<body>
	<jsp:include page="../../homepage/homeHeader.jsp" />
	
	<div class="return-container">
		<h2>교환/반품 신청</h2>
		
		<form action="user/request" method="post" id="returnRequestForm">
			<input type="hidden" name="order_id" value="${order_id}"> 
			<input type="hidden" name="product_id" value="${product_id}">
			
			<div class="table-border">
				<table class="main-table">
					<tr>
						<td class="label-cell">주문번호</td>
						<td class="value-cell">${order_id}</td>
					</tr>
					<tr>
						<td class="label-cell">상품번호</td>
						<td class="value-cell">${product_id}</td>
					</tr>
					<tr>
						<td class="label-cell">상품명</td>
						<td class="value-cell">${product_name}</td>
					</tr>
					<tr>
						<td class="label-cell">
							<label for="request_type">요청 유형</label>
						</td>
						<td class="input-cell">
							<select name="request_type" id="request_type" required>
								<option value="E" ${request_type == 'exchange' ? 'selected' : ''}>교환</option>
								<option value="R" ${request_type == 'return' ? 'selected' : ''}>반품</option>
								<option value="F" ${request_type == 'refund' ? 'selected' : ''}>환불</option>
							</select>
						</td>
					</tr>
					<tr>
						<td class="label-cell">
							<label for="note">요청 사유</label>
						</td>
						<td class="input-cell">
							<pre><textarea id="note" name="note" rows="6" placeholder="요청 사유를 자세히 입력해주세요." required></textarea></pre>
						</td>
					</tr>
				</table>
			</div>
			
			<!-- 버튼 그룹 -->
			<div class="button-group">
				<button type="button" class="btn cancel" onclick="history.go(-1)">취소</button>
				<input type="button" id="submitBtn" class="btn submit" value="요청하기">
			</div>
		</form>
	</div>
	
	<jsp:include page="../../homepage/homeFooter.jsp"></jsp:include>
</body>
</html>