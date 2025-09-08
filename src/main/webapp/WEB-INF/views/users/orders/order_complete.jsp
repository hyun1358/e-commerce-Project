<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>주문완료</title>
		<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/users/orders/css/order_complete.css" />
		<script src="${pageContext.request.contextPath}/resources/users/orders/script/order_complete.js" defer></script>
	</head>
	
	<body>
		<div id="container_complete">
			<div class="title_complete">
				<h1><span>주문이 완료</span>되었습니다.</h1>
				<p>상품을 주문해 주셔서 감사합니다.</p>
				<p>아래의 주문 내역을 확인해주세요.</p>
			</div>
			<div class="body_complete">
				<table class="complete_info" >
					<tr>
						<th>주문 번호</th>
						<td>${payment.merchant_uid}</td>
					</tr>
					<tr>
						<th>주문 상품</th>
						<td>
							<c:choose>
								<c:when test="${fn:length(product_name) == 1}">
									${product_name[0]}
								</c:when>
								<c:otherwise>
									${product_name[0]} 외 ${fn:length(product_name) - 1}건
								</c:otherwise>
							</c:choose>
						</td>
					</tr>
					<tr>
						<th rowspan="3">배송 정보</th>
						<td>${payment.buyer_name}</td>
					</tr>
					<tr>
						<td>${payment.buyer_tel}</td>
					</tr>
					<tr>
						<td>${payment.buyer_addr}</td>
					</tr>
					<tr>
						<th>배송 메모</th>
						<td>${payment.deliveryRequest}</td>
					</tr>
					<tr>
						<th rowspan="2" class="border_none">결제 정보</th>
						<td>${payment.card_name}</td>
					</tr>
					<tr>
						<td class="border_none"><fmt:formatNumber value="${payment.paid_amount}"/>원</td>
					</tr>
				</table>
			</div><!-- body_complete -->
			<div class="btn_complete">
				<div class="details_btn">
					<button type="button" class="details" 
					onclick="location.href='${pageContext.request.contextPath}/orderhistory'">
						<strong>주문 상세 정보</strong>
					</button>
				</div>
				<div class="home_btn">
					<button type="button" class="home" id='btnHome' onclick="location.href='/homepage'">
						<strong>HOME</strong>
					</button>
				</div>
			</div><!-- btn_complete -->
		</div><!-- container_complete -->
		
	</body>
</html>