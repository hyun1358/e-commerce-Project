<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
	.header-title { width: 1300px; 
					  height: auto; 
					  margin: 40px auto 0 auto; }
</style>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/products/css/category_list.css">
<script>
  const hasProducts = ${not empty list ? 'true' : 'false'};
</script>
</head>
<body>
	<jsp:include page="../homepage/homeHeader.jsp"></jsp:include>
			<h1 class="header-title">세일상품</h1>
		    <div class="price-filter">
		    	<a href="#" data-sort="sales">판매 높은순</a>
		    	<a href="#" data-sort="price_asc">낮은 가격순</a>
		    	<a href="#" data-sort="price_desc">높은 가격순</a>
		    	<a href="#" data-sort="review_count">리뷰 많은순</a>
		    	<a href="#" data-sort="rating">평점 좋은순</a>
		    	<a href="#" data-sort="latest">최신순</a>
		    	<div class="search-info">
		      		<span>전체상품(총 ${search_count}개)</span>
		    	</div>
		    </div>
	    <div id="product-list-container">
	    <c:forEach var="vo" items="${list}" varStatus="status">
			<!-- 4개마다 새로운 section 시작 -->
			<c:if test="${status.index % 4 == 0}">
				<section class="image-gallery" aria-label="상품 이미지 갤러리">
			</c:if>
			<div class="product-card">
				<div class="product-image">
					<!-- 상품 이미지, 제목, 가격 등 기존 내용 -->
					<img src="${pageContext.request.contextPath}/resources/${vo.image1}"
						alt="${vo.description}" width="290px" height="250px" />
					<!-- 재고 없음 또는 노출 안 되는 상품일 때 품절 배지 -->
					<c:if test="${vo.stock lt 1}">
						<!-- <div class="sold-out-banner">품절</div> -->
					<div class="sold-out-overlay">
				<span class="sold-out-text">품절</span>
			</div>
					</c:if>
					<div class="product-actions">
					<c:choose>
						<c:when test="${not empty user}">
							<button class="wishlist-btn" data-product-id="${vo.product_id}">
							<svg xmlns="http://www.w3.org/2000/svg" fill="currentColor" class="bi bi-heart" viewBox="0 0 16 16">
								<path d="m8 2.748-.717-.737C5.6.281 2.514.878 1.4 3.053c-.523 1.023-.641 2.5.314 4.385.92 1.815 2.834 3.989 6.286 6.357 3.452-2.368 5.365-4.542 6.286-6.357.955-1.886.838-3.362.314-4.385C13.486.878 10.4.28 8.717 2.01zM8 15C-7.333 4.868 3.279-3.04 7.824 1.143q.09.083.176.171a3 3 0 0 1 .176-.17C12.72-3.042 23.333 4.867 8 15" />
							</svg>
						</button>
						</c:when>
						<c:otherwise>
							<button class="wishlist-btn" onclick="location.href='${pageContext.request.contextPath}/login_form'; return false;">
							<svg xmlns="http://www.w3.org/2000/svg" fill="currentColor" class="bi bi-heart" viewBox="0 0 16 16">
								<path d="m8 2.748-.717-.737C5.6.281 2.514.878 1.4 3.053c-.523 1.023-.641 2.5.314 4.385.92 1.815 2.834 3.989 6.286 6.357 3.452-2.368 5.365-4.542 6.286-6.357.955-1.886.838-3.362.314-4.385C13.486.878 10.4.28 8.717 2.01zM8 15C-7.333 4.868 3.279-3.04 7.824 1.143q.09.083.176.171a3 3 0 0 1 .176-.17C12.72-3.042 23.333 4.867 8 15" />
							</svg>
						</button>
						</c:otherwise>
					</c:choose>	
						<!-- 일단 보존 -->
						<c:choose>
						<c:when test="${vo.stock lt 1}">
							<button class="cart-btn" disabled title="품절로 인해 장바구니 사용 불가">
								<!-- cart icon SVG -->
							</button>
						</c:when>
							<c:when test="${not empty user}">
								<button class="cart-btn" onclick="addCart(${vo.product_id}, ${user.user_idx}); return false;">
									<svg xmlns="http://www.w3.org/2000/svg" fill="currentColor" class="bi bi-cart" viewBox="0 0 16 16">
										<path d="M0 1.5A.5.5 0 0 1 .5 1H2a.5.5 0 0 1 .485.379L2.89 3H14.5a.5.5 0 0 1 .491.592l-1.5 8A.5.5 0 0 1 13 12H4a.5.5 0 0 1-.491-.408L2.01 3.607 1.61 2H.5a.5.5 0 0 1-.5-.5M3.102 4l1.313 7h8.17l1.313-7zM5 12a2 2 0 1 0 0 4 2 2 0 0 0 0-4m7 0a2 2 0 1 0 0 4 2 2 0 0 0 0-4m-7 1a1 1 0 1 1 0 2 1 1 0 0 1 0-2m7 0a1 1 0 1 1 0 2 1 1 0 0 1 0-2" />
									</svg>
								</button>
							</c:when>
							<c:otherwise>
								<button class="cart-btn"
									onclick="addGuestCart(${vo.product_id}); return false;">
									<svg xmlns="http://www.w3.org/2000/svg" fill="currentColor" class="bi bi-cart" viewBox="0 0 16 16">
										<path d="M0 1.5A.5.5 0 0 1 .5 1H2a.5.5 0 0 1 .485.379L2.89 3H14.5a.5.5 0 0 1 .491.592l-1.5 8A.5.5 0 0 1 13 12H4a.5.5 0 0 1-.491-.408L2.01 3.607 1.61 2H.5a.5.5 0 0 1-.5-.5M3.102 4l1.313 7h8.17l1.313-7zM5 12a2 2 0 1 0 0 4 2 2 0 0 0 0-4m7 0a2 2 0 1 0 0 4 2 2 0 0 0 0-4m-7 1a1 1 0 1 1 0 2 1 1 0 0 1 0-2m7 0a1 1 0 1 1 0 2 1 1 0 0 1 0-2" />
									</svg>
								</button>
							</c:otherwise>
						</c:choose>
					</div>
				</div>
				<div class="product-title">
					<a href="${pageContext.request.contextPath}/product_detail.do?product_id=${vo.product_id}" class="product-name">${vo.product_name}</a>
				</div>
				<div class="product-price">
					<span><fmt:formatNumber value="${vo.final_price}" type="number" />원
					<div>
						<img alt=""src="data:image/svg+xml;charset=utf8,%3Csvg width='36' height='36' fill='none' xmlns='http://www.w3.org/2000/svg'%3E%3Cpath d='m20.324 1.675 3.527 9.559 9.787.554a2.618 2.618 0 0 1 2.244 1.83 2.625 2.625 0 0 1-.81 2.782l-7.612 6.458 2.523 9.9a2.519 2.519 0 0 1-2.302 3.24 2.512 2.512 0 0 1-1.453-.39L18 30.04l-8.228 5.566a2.512 2.512 0 0 1-3.738-1.344 2.518 2.518 0 0 1-.016-1.505l2.523-9.9L.928 16.4a2.622 2.622 0 0 1 1.434-4.612l9.787-.554 3.527-9.559A2.453 2.453 0 0 1 19.432.462c.417.3.73.725.892 1.213Z' fill='%23ffcc00'/%3E%3C/svg%3E"/>${vo.avg_rating}(${vo.review_count})
					</div>
					</span>
				</div>
				<button class="delivery">무료배송</button>
				<button class="compare">
					<span>비교하기</span>
				</button>
			</div>
			<!-- 4개마다 section 닫기 -->
			<c:if
				test="${(status.index + 1) % 4 == 0 || (status.index + 1) == total}">
				</section>
			</c:if>
		</c:forEach>
	</div>
	<jsp:include page="../homepage/homeFooter.jsp"></jsp:include>
	<script>
		const contextPath = "${pageContext.request.contextPath}";
	</script>
	<script src="${pageContext.request.contextPath}/resources/products/script/product_to_cart.js"></script>
	<script src="${pageContext.request.contextPath}/resources/products/script/category_list.js" defer></script>
	<script src="${pageContext.request.contextPath}/resources/products/script/product_list_common.js"></script>
	<script>
		document.addEventListener('DOMContentLoaded', () => {
			initializeProductListActions('${pageContext.request.contextPath}'); // 초기 로드 시 호출
			initializeCartActions('${pageContext.request.contextPath}'); // 초기 로드 시 장바구니/찜 기능 초기화
			const sortLinks = document.querySelectorAll('.price-filter a');
			sortLinks.forEach(link => {
				link.addEventListener('click', (e) => {
					e.preventDefault();
					
					sortLinks.forEach(el => el.classList.remove('active'));
					link.classList.add('active');

					const sortValue = link.dataset.sort;
					
					var xhr = new XMLHttpRequest();
					xhr.open('GET', '${pageContext.request.contextPath}/sale/sortProducts?sort=' + sortValue, true);
					xhr.onreadystatechange = function () {
						if (xhr.readyState === 4 && xhr.status === 200) {
							document.getElementById('product-list-container').innerHTML = xhr.responseText;
							initializeProductListActions('${pageContext.request.contextPath}'); // AJAX 로드 후 호출
							initializeCartActions('${pageContext.request.contextPath}'); // AJAX 로드 후 장바구니/찜 기능 초기화
						}
					};
					xhr.send();
				});
			});
		});
	</script>
</body>
</html>