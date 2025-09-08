<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resources/homepage/css/mypage_navigation.css">
<link rel="stylesheet"
	href="${pageContext.request.contextPath }/resources/users/orders/css/order_detail.css">

</head>
<body>
	<jsp:include page="../../homepage/homeHeader.jsp"></jsp:include>
	<div class="main-wrapper">
		<jsp:include page="../../homepage/mypage_navigation.jsp"></jsp:include>
		<div class="container">
			<div class="order-details-wrapper">
				<div class="order_title">
					<h3>
						<span>${ orderVO.order_date }</span> <span class="order_id">주문번호
							: ${ orderVO.order_id }</span>
					</h3>
				</div>

				<div class="product-section">

					<c:forEach var="order" items="${order_list}">
						<div class="item">

							<div class="order-image">
								<c:choose>
									<c:when test="${order.is_visible eq 'N'}">

										<img class="blurred-image"
											src="${pageContext.request.contextPath}/resources/${order.image1}"
											alt="상품이미지" />
										<div class="sold-out-overlay">
											<span class="sold-out-text">판매종료</span>
										</div>

									</c:when>
									<c:otherwise>
										<a
											href="${pageContext.request.contextPath}/product_detail.do?product_id=${order.product_id}">
											<img
											src="${ pageContext.request.contextPath }/resources/${order.image1}"
											alt="${order.product_name}" />
										</a>

									</c:otherwise>
								</c:choose>
							</div>

							<div class="item-details">
								<a class="order-name"
									href="${pageContext.request.contextPath}/product_detail.do?product_id=${order.product_id}">
									${order.product_name} </a>
								<div class="price">
									<fmt:formatNumber type="number">${ order.amount }</fmt:formatNumber>
									원
								</div>


								<div class="price-button-wrapper">
									<div class="item-info">
										<p>
											옵션 :
											<c:out value="" default="-" />
										</p>
										<p>구매수량: ${ order.quantity }개</p>
										<p>상태 : ${ orderVO.status } / ${ order.refund_status }</p>
									</div>
									<div class="button-section">
										<button onclick="location.href='${pageContext.request.contextPath}/order/delivery?order_id=${orderVO.order_id}&product_id=${order.product_id}'">배송조회</button>

										<c:url var="writeUrl" value="/review_write">
											<c:param name="product_id" value="${order.product_id}" />
											<c:param name="product_name" value="${order.product_name}" />
											<c:param name="image1" value="${order.image1}" />
											<c:param name="order_id" value="${orderVO.order_id}" />
											<c:param name="returnUrl"
												value="/order/detail?order_id=${orderVO.order_id}" />
										</c:url>

										<c:url var="showUrl" value="/review_show">
											<c:param name="review_id" value="${order.review_id}" />
											<c:param name="product_id" value="${order.product_id}" />
											<c:param name="product_name" value="${order.product_name}" />
											<c:param name="image1" value="${order.image1}" />
											<c:param name="order_id" value="${orderVO.order_id}" />
											<c:param name="returnUrl"
												value="/order/detail?order_id=${orderVO.order_id}" />
										</c:url>

										<c:choose>
											<c:when
												test="${empty order.review_id or order.review_id == 0}">
												<button onclick="location.href='${writeUrl}'">리뷰작성</button>
											</c:when>
											<c:otherwise>
												<button onclick="location.href='${showUrl}'">리뷰수정</button>
											</c:otherwise>
										</c:choose>
										<button onclick="location.href='${ pageContext.request.contextPath }/user/request_from?order_id=${orderVO.order_id}&product_id=${order.product_id}&request_type=exchange'">교환신청</button>
										<button>반품신청</button>
										<button onclick="location.href='${ pageContext.request.contextPath }/user/request_from?order_id=${orderVO.order_id}&product_id=${order.product_id}&request_type=return'">반품신청</button>
									</div>
								</div>
							</div>
						</div>
					</c:forEach>
				</div>
			</div>
			<div class="info-wrapper">
				<div class="orders-information">
					<h3>배송지 정보</h3>
					<p>받는 사람 : ${ orderVO.shipping_name }</p>
					<p>연락처 : ${ orderVO.shipping_phone }</p>
					<p>주소 : (${orderVO.zipcode}) ${orderVO.address1 }</p>
					<p>배송 요청사항 : ${orderVO.request}</p>
				</div>

				<div class="payment-information">
					<h3>결제 정보</h3>

					<p>
						결제 수단 :
						<c:out value="${orderVO.cardname}" default="-" />
						(
						<c:out value="${paymentVO.pay_method}" default="-" />
						)
					</p>

					<p>
						총 상품금액 :
						<fmt:formatNumber type="number"
							value="${empty total_amount ? 0 : total_amount}" />
						원
					</p>
					<p>총 배송비 : 0 원</p>

					<div>
						<p class="paid_total_amount">
							<span>총 결제금액 :</span> <span><strong><fmt:formatNumber
										type="number" value="${empty total_amount ? 0 : total_amount}" /></strong>원</span>
						</p>
					</div>
				</div>

			</div>

		</div>
	</div>
	<jsp:include page="../../homepage/homeFooter.jsp"></jsp:include>
</body>
</html>