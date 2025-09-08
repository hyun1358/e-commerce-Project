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
<script>
	const contextPath = '${pageContext.request.contextPath}';
</script>
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resources/admin_product/css/product_management.css" />
<script
	src="${pageContext.request.contextPath}/resources/admin_product/script/product_management.js"
	defer></script>

</head>

<body>
	<jsp:include page="../admin_homepage/admin_homeHeader.jsp"></jsp:include>
	<div class="container">

		<!-- 사이드 메뉴 -->
		<jsp:include page="../admin_homepage/admin_navigation.jsp"></jsp:include>

		<div class="product_main">
			<!-- <form id="searchForm"> -->
			<div class="product_management">
				<h3 class="product_text">상품 조회</h3>
				<div class="product_management_wrapper">
					<table class="management_table">
						<tr>
							<th>검색 항목</th>
							<td class="category_filter"><select name="searchCategory"
								id="searchCategory">
									<option value="product_name">상품명</option>
									<option value="product_id">상품번호</option>
									<option value="company">브랜드</option>
							</select> <input type="text" name="searchKeyword" placeholder="검색어 입력"
								autocomplete="off" class="product_search"></td>
						</tr>
						<tr>
							<th>상품 분류</th>
							<td class="category_filter">
								<div class="category_selects">
									<select id="parentCategory" name="parentCategoryId">
										<option value="">(대분류) 선택</option>

										<c:forEach var="cat" items="${parentCategories}">
											<option value="${cat.category_id}"
												<c:if test="${cat.category_id == vo.parent_category_id}">selected</c:if>>
												(대분류) ${cat.name}</option>
										</c:forEach>
									</select> <select id="childCategory" name="childCategoryId">
										<option value="">(소분류) 선택</option>
										<!-- 소분류 옵션은 초기 로드 시 JS -->
									</select>
								</div>
								<div class="all_category">
									<input type="checkbox" class="all-category-check"
										name="allCategory" value="true" checked> 분류 무관
								</div>
							</td>
						</tr>
						<tr>
							<th>상품 등록일</th>
							<td>
								<div class="regdate">
									<button data-range="all" class="all-btn active">전체</button>
									<button data-range="today">오늘</button>
									<button data-range="7">7일</button>
									<button data-range="30">1개월</button>
									<button data-range="90">3개월</button>
									<button data-range="365">1년</button>

									<input type="date" class="date-start" name="dateStart">
									<span>~</span> <input type="date" class="date-end"
										name="dateEnd">
								</div>
							</td>
						</tr>
						<tr>
							<th>판매 여부</th>
							<td>
								<div class="productType_wrap">
									<div class="radio-group">
										<label><input type="radio" name="productStatus"
											value="all" checked>전체</label> <label><input
											type="radio" name="productStatus" value="Y">판매중</label> <label><input
											type="radio" name="productStatus" value="N">숨김/판매종료</label>
									</div>
								</div>
							</td>
						</tr>

						<tr>
							<th>품절 여부</th>
							<td>
								<div class="stockStatus_wrap">
									<div class="radio-group">
										<label><input type="radio" name="stockStatus"
											value="all" checked>전체</label> <label><input
											type="radio" name="stockStatus" value="inStock">판매가능</label>
										<label><input type="radio" name="stockStatus"
											value="soldOut">재고없음</label>
									</div>
								</div>
							</td>
						</tr>

						<tr>
							<th>정렬 기준</th>
							<td><select name="sortOption" id="sortOption">
									<option value="latest">최근 등록순</option>
									<option value="stockAsc">재고가 적은순</option>
									<option value="stockDesc">재고가 많은순</option>
									<option value="productId">상품번호 낮은순</option>
									<option value="productIdDesc">상품번호 높은순</option>
									<option value="productName">상품명 (가나다순)</option>
									<option value="productNameDesc">상품명 (역순)</option>
									<option value="priceAsc">정가 낮은순</option>
									<option value="priceDesc">정가 높은순</option>
									<option value="priceSaleAsc">할인가 낮은순</option>
									<option value="priceSaleDesc">할인가 높은순</option>
							</select></td>
						</tr>
					</table>
				</div>
			</div>
			<div class="search-buttons">
				<button type="button" class="btn-submit" id="searchBtn">검색</button>
				<button type="button" class="btn-reset">초기화</button>


			</div>
			<!-- </form> -->

			<div class="product_list">
				<div class="table_header">
					<h3 class="product_text">상품 목록</h3>

					<div class="product_list_wrapper">
						<div class="product_table_btn">
							<button class="btn_right registration" id="registProductsBtn"
								onclick="location.href='${pageContext.request.contextPath}/admin/product/regist_form'">상품
								등록</button>
							<button class="btn_right" id="editProductsBtn">수정</button>
							<button type="button" class="btn_right" id="delete-btn">삭제</button>
						</div>
					</div>

				</div>

				<div id="searchResultsContainer">
					<div class="product-count">
						전체 <span class="count">${ totalCount }</span>개
					</div>
					<!-- 상품이 출력되는 곳 -->
					<table class="product_table">
						<thead>
							<tr>
								<th><input type="checkbox" class="checkbox" id="selectAll"></th>
								<th>상품번호</th>
								<th>상품명</th>
								<th>이미지</th>
								<th>카테고리(ID)</th>
								<th>판매여부</th>
								<th>정가</th>
								<th>할인가</th>
								<th>재고</th>
								<th>판매량</th>
								<th>상품 등록일</th>
							</tr>
						</thead>

						<tbody>
							<c:if test="${empty product_list}">
								<tr>
									<td colspan="11">검색 결과가 없습니다.</td>
								</tr>
							</c:if>
							<c:forEach var="vo" items="${ product_list }">
								<tr>
									<td><input type="checkbox" name="product_id"
										value="${vo.product_id}" class="checkbox"></td>
									<td>${ vo.product_id }</td>
									<td class="product-name-cell">${ vo.product_name }</td>
									<td><img
										src="${pageContext.request.contextPath}/resources/${ vo.image1 }"
										alt="상품 이미지" class="product_img" /></td>

									<td>${ vo.name }(${ vo.category_id })</td>
									<td><c:choose>
											<c:when test="${ vo.is_visible == 'Y' }">
												<span class="status preparing">${ vo.is_visible }</span>
											</c:when>
											<c:otherwise>
												<span class="status no_longer_sold">${ vo.is_visible }</span>
											</c:otherwise>
										</c:choose></td>
									<td><fmt:formatNumber type="number">${ vo.price }</fmt:formatNumber></td>
									<td><fmt:formatNumber type="number">${ vo.sale_price }</fmt:formatNumber></td>

									<td><c:choose>
											<c:when test="${ vo.stock == 0 }">
												<span class="status soldout">${ vo.stock }</span>
											</c:when>
											<c:when test="${(vo.stock < 10) and (vo.stock > 0)}">
												<span class="status lowstock">${ vo.stock }</span>
											</c:when>
											<c:otherwise>
												<span class="status nomalstock">${ vo.stock }</span>
											</c:otherwise>
										</c:choose></td>


									<td>${ vo.sales_volume }</td>
									<td>${fn:substring(vo.regdate, 0, 10)}</td>
								</tr>

							</c:forEach>

						</tbody>
					</table>

					<div id="pagingContainer" class="pagination">
						<c:out value="${pagingHtml}" escapeXml="false" />
					</div>

				</div>

			</div>

		</div>
	</div>
</body>
</html>