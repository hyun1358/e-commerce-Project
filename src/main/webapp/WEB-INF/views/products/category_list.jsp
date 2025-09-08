<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resources/products/css/category_list.css">
<script src="${pageContext.request.contextPath}/resources/products/script/product_to_cart.js" defer></script>
<script>
  const hasProducts = ${not empty list ? 'true' : 'false'};
</script>

</head>
<body data-category-id="${ category_id }" data-default-sort="sales">
	<jsp:include page="../homepage/homeHeader.jsp"></jsp:include>
	<div class="laptop-container" id="laptop-container">
		<h1>${ category_name }</h1>
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
		<div id="product-list">
			<!-- 최초 리스트 렌더링 -->
			<c:choose>
				<c:when test="${empty list or category_id == null}">
					<div class="no-results">
						<h2>상품을 준비 중입니다</h2>
						<span>나중에 다시 시도해주세요</span>
					</div>
				</c:when>
				<c:otherwise>
					<!-- 기존 상품 리스트 출력 부분 -->
					<jsp:include page="product_list_partial.jsp" />
				</c:otherwise>
			</c:choose>
		</div>
	</div>

	<div class="compare-panel" id="compare-panel">
		<div class="compare-panel-toggle">
			<button class="compare-panel-toggle-switch" id="dropdown-btn"
				onclick="dropdown()">
				<svg xmlns="http://www.w3.org/2000/svg" width="30" height="30"
					fill="currentColor" class="bi bi-chevron-compact-down"
					viewBox="0 0 16 16">
				  <path fill-rule="evenodd"
						d="M1.553 6.776a.5.5 0 0 1 .67-.223L8 9.44l5.776-2.888a.5.5 0 1 1 .448.894l-6 3a.5.5 0 0 1-.448 0l-6-3a.5.5 0 0 1-.223-.67" />
				</svg>
			</button>
		</div>
		<div class="compare-panel-title">
			<h4>카테고리별 제품 비교하기</h4>
			<span></span>
			<div class="button-group">
				<button class="reset-btn">초기화</button>
				<button class="result-btn" onclick="compareProductResult()">결과보기</button>
			</div>
		</div>
		<hr>
		<div class="compare-panel-info">
			<div class="compare-panel-box">
				<div class="compare-panel-product-name">
					<span>제품이름</span> <span>제품가격</span>
					<button>x</button>
				</div>
			</div>
		</div>
	</div>
	<!-- compare-panel  -->
	<jsp:include page="../products/modal.jsp"></jsp:include>
	<jsp:include page="../homepage/homeFooter.jsp"></jsp:include>
	<script src="${pageContext.request.contextPath}/resources/products/script/category_list.js" defer></script>
</body>
</html>