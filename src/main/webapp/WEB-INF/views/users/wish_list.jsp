<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script>
	const contextPath = '${pageContext.request.contextPath}';
</script>
<script src="${pageContext.request.contextPath}/resources/users/script/wish_list.js"></script>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/users/css/wish_list.css" />
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/homepage/css/mypage_navigation.css">
</head>

<body>
	<jsp:include page="../homepage/homeHeader.jsp"></jsp:include>
	<c:if test="${not empty msg}">
	    <script>
	        alert("${msg}");
	    </script>
	</c:if>
	<c:if test="${not empty msg1}">
	    <script>
	        alert("${msg1}");
	    </script>
	</c:if>
	<div class="container">
		<div class="main-content">
			<jsp:include page="../homepage/mypage_navigation.jsp"></jsp:include>
			<div class="content">
				<div id="wishlist-section" style="display: block;">
					<div class="section-title">관심상품</div>
					<div id="wish-list">
						<div id="detail" class="wishlist-details">
						<c:choose>
							<c:when test="${not empty wishList}">
								<c:forEach var="vo" items="${wishList}">
									<div class="wishlist-items">
											<div class="wishlist-image">
												<img src="${pageContext.request.contextPath}/resources/${vo.image1}">
											</div>
											<div class="wishlist-info">
												<div class="wishlist-name">
													<a href="#">${vo.product_name}</a>
												</div>
												<div class="wishlist-price"><fmt:formatNumber value="${vo.final_price}" pattern="#,###"/> 원</div>
												<div class="wishlist-quantity">스펙: ${fn:replace(vo.description," "," / ") }</div>
												<div class="delivery-status">무료배송</div>
											</div>
											<div class="wishlist-actions">
												<button class="action-button shopping-cart"  onclick="location.href='${pageContext.request.contextPath}/mypage/cart/insert?product_id=${vo.product_id}'">장바구니</button>
												<button class="action-button heart-button" id="heartBtn" title="찜" onclick="location.href='${pageContext.request.contextPath}/mypage/wishlist/delete?product_id=${vo.product_id}'">
													<img src="${pageContext.request.contextPath}/resources/users/image/trashimg.png" alt="쓰레기통">
												</button>
											</div>
										</div>
									</c:forEach>
							</c:when>
							<c:when test="${empty wishList}">
								<div class="no-wishlist">관심상품 목록이 없습니다.</div>
							</c:when>
						</c:choose>
						</div>
					</div>
					
				</div>
			</div>
		</div>
	</div>
	<jsp:include page="../homepage/homeFooter.jsp"></jsp:include>
</body>
</html>