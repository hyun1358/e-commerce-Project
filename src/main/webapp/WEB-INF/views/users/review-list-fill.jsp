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
<script src="${pageContext.request.contextPath}/resources/users/script/review-list-fill.js"></script>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/users/css/review-list-fill.css" />
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/homepage/css/mypage_navigation.css">
</head>

<body>
	<jsp:include page="../homepage/homeHeader.jsp"></jsp:include>

	<div class="container">
		<div class="main-content">
			<jsp:include page="../homepage/mypage_navigation.jsp"></jsp:include>

			<div class="content">
				<div id="order-section" style="display: block;">
					<div class="section-title">내가 작성한 리뷰</div>

					<div id="order-list">
						<c:choose>
						    <c:when test="${empty reviewList}">
						      <div class="no-orders">작성한 구매후기가 없습니다.</div>
						    </c:when>
						    <c:otherwise>
								<c:forEach var="order" items="${reviewList}">
									<div id="detail-${order.key}" class="order-details">
										<c:forEach var="product" items="${order.value}" varStatus="loop">
											 <div class="order-items 
												<c:if test='${loop.first}'> first-item</c:if>
		  										<c:if test='${loop.last}'> last-item</c:if>">
												<div class="order-image">
												  <a href="${pageContext.request.contextPath}/product_detail.do?product_id=${product.product_id}">
													<img
														src="${ pageContext.request.contextPath }/resources/${product.image1}"
														alt="product_image">
														</a>
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
													<c:param name="returnUrl" value="/reviewListEmpty" />
												</c:url>
												
												<c:url var="showUrl" value="/review_show">
													<c:param name="review_id" value="${product.review_id}" />
													<c:param name="product_id" value="${product.product_id}" />
													<c:param name="product_name" value="${product.product_name}" />
													<c:param name="image1" value="${product.image1}" />
													<c:param name="order_id" value="${product.order_id}" />
													<c:param name="returnUrl" value="/reviewListEmpty" />
												</c:url>
												<c:choose>
												<c:when test="${empty product.review_id or product.review_id == 0}">
		
												      <button class="action-button primary" style="background: #4169e1; color: white"
														onclick="location.href='${writeUrl}'">
														리뷰작성</button>
												 </c:when>
												  <c:otherwise>
												    <button class="action-button primary"
														onclick="location.href='${showUrl}'">리뷰수정</button>
												  </c:otherwise>
												</c:choose>
													<button class="action-button state" onclick="location.href='${pageContext.request.contextPath}/order/delivery?order_id=${order.key}&product_id=${product.product_id}'">배송상세</button>
												</div>
											</div>
										</c:forEach>
									</div>
								</c:forEach>
							</c:otherwise>
						</c:choose>	
					</div>
				</div>
			</div>
		</div>
	</div>

	<jsp:include page="../homepage/homeFooter.jsp"></jsp:include>
</body>
</html>