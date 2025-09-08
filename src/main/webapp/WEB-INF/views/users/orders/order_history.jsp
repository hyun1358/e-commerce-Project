<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script>
	const contextPath = '${pageContext.request.contextPath}';
</script>
<script src="${pageContext.request.contextPath}/resources/users/orders/script/order_history.js"></script>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/users/orders/css/order_history.css" />
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/homepage/css/mypage_navigation.css">
</head>

<body>
	<jsp:include page="../../homepage/homeHeader.jsp"></jsp:include>

	<div class="container">
		<div class="main-content">
			<jsp:include page="../../homepage/mypage_navigation.jsp"></jsp:include>

			<div class="content">
				<div id="order-section" style="display: block;">
					<div class="section-title">주문 내역</div>
					<div class="tab-menu status-tabs">
						<button class="tab-button status-tab active" data-status="all">전체</button>
						<button class="tab-button status-tab " data-status="ordered">주문완료</button>
						<button class="tab-button status-tab" data-status="preparing">상품준비중</button>
						<button class="tab-button status-tab" data-status="shipping">배송중</button>
						<button class="tab-button status-tab" data-status="delivered">배송완료</button>
					</div>


					<div id="order-list">
					<c:if test="${ empty orderMap }">
					<div class="no-orders">주문 내역이 없습니다.</div>
					</c:if>
						<c:forEach var="order" items="${orderMap}">
							<div class="order-summary">
								<span class="order-date">${order.value[0].order_date}</span> 
								<input type="hidden" class="order-id" value="${order.key}"> 
								<span class="order-status">상태: ${order.value[0].status}</span>
								<button onclick="location.href='${pageContext.request.contextPath}/order/detail?order_id=${order.key}'">상세보기</button>
							</div>
							<div id="detail-${order.key}" class="order-details">
								<!-- style="display: none;" -->
								<c:forEach var="product" items="${order.value}" varStatus="loop">
									<div class="order-items ${!loop.last ? 'with-border' : ''}">
									<%-- <div class="order-image">
										  <a href="${pageContext.request.contextPath}/product_detail.do?product_id=${product.product_id}">
											<img
												src="${ pageContext.request.contextPath }/resources/${product.image1}"
												alt="product_image">
												</a>
										</div> --%>
										
										
										<div class="order-image">
										<c:choose>
														<c:when test="${product.is_visible eq 'N'}">
																<img class="blurred-image"
																	src="${pageContext.request.contextPath}/resources/${product.image1}"
																	alt="상품이미지" />
																<div class="sold-out-overlay">
																	<span class="sold-out-text">판매종료</span>
																</div>
															
														</c:when>
														<c:otherwise>
																<a
																	href="${pageContext.request.contextPath}/product_detail.do?product_id=${product.product_id}">
																	<img
																	src="${pageContext.request.contextPath}/resources/${product.image1}"
																	alt="상품이미지" />
																</a>
															
														</c:otherwise>
													</c:choose>
										</div>
										<div class="order-info">
											<div class="order-name"><a href="product_detail.do?product_id=${ product.product_id }">${product.product_name}</a></div>
											<div class="order-price">
												<fmt:formatNumber type="number">${product.amount}</fmt:formatNumber>
												원
											</div>
											<div class="order-quantity">수량: ${product.quantity}</div>
											<div class="delivery-status">상태: ${product.status}</div>
										</div>

										<div class="order-actions">

										<c:url var="writeUrl" value="/review_write">
											<c:param name="product_id" value="${product.product_id}" />
											<c:param name="product_name" value="${product.product_name}" />
											<c:param name="image1" value="${product.image1}" />
											<c:param name="order_id" value="${product.order_id}" />
											<c:param name="returnUrl" value="/orderhistory" />
										</c:url>
										
										<c:url var="showUrl" value="/review_show">
											<c:param name="review_id" value="${product.review_id}" />
											<c:param name="product_id" value="${product.product_id}" />
											<c:param name="product_name" value="${product.product_name}" />
											<c:param name="image1" value="${product.image1}" />
											<c:param name="order_id" value="${product.order_id}" />
											<c:param name="returnUrl" value="/orderhistory" />
										</c:url>
										<c:choose>
										<c:when test="${empty product.review_id or product.review_id == 0}">
										      <button class="action-button primary" style="background: #007BFF;color: white"
												onclick="location.href='${writeUrl}'">
												리뷰작성</button>
										  </c:when>
										  <c:otherwise>
										    <button class="action-button primary"
												onclick="location.href='${showUrl}'">리뷰수정</button>
										  </c:otherwise>
										</c:choose>
											<button class="action-button state"
												onclick="location.href='${pageContext.request.contextPath}/order/delivery?order_id=${order.key}&product_id=${product.product_id}'">배송조회</button>
										</div>
									</div>
								</c:forEach>
							</div>
						</c:forEach>
					</div>
				</div>
			</div>
		</div>
	</div>



	<jsp:include page="../../homepage/homeFooter.jsp"></jsp:include>
</body>
</html>