<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>로그인</title>
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resources/users/css/user_mypage.css" />

</head>
<body>
	<!-- 헤더 -->
	<jsp:include page="../homepage/homeHeader.jsp"></jsp:include>
	<div class="container">
		<jsp:include page="../homepage/mypage_navigation.jsp"></jsp:include>
		<!-- 메인 콘텐츠 -->
		<main class="main">
			<!-- 프로필 & 요약 -->
			<section class="card profile">
				<div class="profile-info">
					<div class="profile-lastName">
						<b>${ fn:substring(user.user_name, 0, 1) }</b>
					</div>
					<div class="profile-actions">
						<div class="utility-menu-wrapper">
							<div class="user-name">
								<b>${ user.user_name }</b> <span class="user-suffix">님</span> <span
									class="welcome-message">환영합니다 !</span>
							</div>
							<div class="user-edit">
								<a href="${pageContext.request.contextPath}/user_edit">
									<button class='addressform'>개인정보 수정</button>
								</a>
							</div>
						</div>
					</div>
				</div>
				<!-- <div class="profile-pay">
					<span>Good Luck pay</span> <b>0원</b>
				</div> -->
			</section>

			<!-- 혜택 배너 -->
			<section class="benefits-banner">
				<span style="margin-left: 10px;">AI for YOU</span> <span
					class="mini-banner">AI가 만들어갈 편리한 일상, 스마트한 변화를 경험하세요</span>
			</section>

			<!-- 주요 바로가기 카드 -->
			<section class="card shortcut-card">
				<a href="${pageContext.request.contextPath}/orderhistory" class="shortcut-item">
					<span class="shortcut-item-label" onclick="location.href='${pageContext.request.contextPath}/orderhistory'">주문/배송내역</span>
					<span class="shortcut-item-count">${order_count}</span>
				</a> 
				<a href="${pageContext.request.contextPath}/cart_list.do" class="shortcut-item"> 
					<span class="shortcut-item-label">장바구니</span>
					<span class="shortcut-item-count">${cart_count}</span>
				</a>
				<a href="${pageContext.request.contextPath}/wishlist" class="shortcut-item"> <span
					class="shortcut-item-label">관심상품</span> <span
					class="shortcut-item-count">${wish_count}</span>
				</a> 
				<a href="${pageContext.request.contextPath}/reviewListEmpty" class="shortcut-item">
					<span class="shortcut-item-label">작성가능한 리뷰</span> 
					<span class="shortcut-item-count">${pending_review}</span>
				</a> 
				<a href="${pageContext.request.contextPath}/reviewListFill" class="shortcut-item"> 
					<span class="shortcut-item-label">작성한리뷰</span> 
					<span class="shortcut-item-count">${written_review}</span>
				</a> 
				<a href="${pageContext.request.contextPath}/my_inquiryList" class="shortcut-item"> 
					<span class="shortcut-item-label">문의내역</span> 
					<span class="shortcut-item-count">${inquiry_count}</span>
				</a>
			</section>

			<!-- 주문/배송내역 -->
			<section class="card">
				<div class="order-header">
					<b> <a href="${pageContext.request.contextPath}/orderhistory">최근&nbsp;주문&nbsp;내역</a>
					</b>
				</div>
				<c:if test="${ empty latest_order }">
					<div class="order-item no-orders" >최근 주문 내역이 없습니다.</div>
				</c:if>
				<c:forEach var="vo" items="${ latest_order }">
					<div class="order-item">
						<div class="order-date">
							<b>${ vo.order_date }</b> <span style="margin-left: 12px;">${vo.status }
							</span>
						</div>
						<div class="order-product">
							<button class="product-image-btn" onclick="location.href='${ pageContext.request.contextPath }/product_detail.do?product_id=${vo.product_id}'">
								<img class="product-image" src="${ pageContext.request.contextPath }/resources/${vo.image1}" alt="상품이미지">
							</button>
							<div class="product-info">
								<button class="product-name-btn" onclick="location.href='${ pageContext.request.contextPath }/product_detail.do?product_id=${vo.product_id}'">${ vo.product_name }</button>
								<div class="product-price"><strong>${ vo.amount } 원</strong></div>
								<p>수량 : ${ vo.quantity }개</p>
							</div>
							<div class="product-actions">
								<button onclick="location.href='${pageContext.request.contextPath}/order/delivery?order_id=${vo.order_id}&product_id=${vo.product_id}'">배송조회</button>
								<c:url var="writeUrl" value="/review_write">
									<c:param name="product_id" value="${vo.product_id}" />
									<c:param name="product_name" value="${vo.product_name}" />
									<c:param name="image1" value="${vo.image1}" />
									<c:param name="order_id" value="${vo.order_id}" />
									<c:param name="returnUrl" value="/mypage/check" />
								</c:url>
								<c:url var="showUrl" value="/review_show">
									<c:param name="review_id" value="${vo.review_id}" />
									<c:param name="product_id" value="${vo.product_id}" />
									<c:param name="product_name" value="${vo.product_name}" />
									<c:param name="image1" value="${vo.image1}" />
									<c:param name="order_id" value="${vo.order_id}" />
									<c:param name="returnUrl" value="/mypage/check" />
								</c:url>
								<c:choose>
									<c:when test="${empty vo.review_id or vo.review_id == 0}">
										<c:url var="returnUrl" value="/mypage/check">
										</c:url>
										<button onclick="location.href='${writeUrl}'">리뷰작성</button>
									</c:when>
									<c:otherwise>
										<button onclick="location.href='${showUrl}'">리뷰수정</button>
									</c:otherwise>
								</c:choose>
								<button onclick="location.href='${ pageContext.request.contextPath }/user/request_from?order_id=${vo.order_id}&product_id=${vo.product_id}&product_name=${ vo.product_name }&request_type=exchange'">교환신청</button>
								<button onclick="location.href='${ pageContext.request.contextPath }/user/request_from?order_id=${vo.order_id}&product_id=${vo.product_id}&product_name=${ vo.product_name }&request_type=return'">반품신청</button>
							</div>
						</div>
					</div>
				</c:forEach>
			</section>
		</main>
	</div>
	<jsp:include page="../homepage/homeFooter.jsp"></jsp:include>
</body>
</html>