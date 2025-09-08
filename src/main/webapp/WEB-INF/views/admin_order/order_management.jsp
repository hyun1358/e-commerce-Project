<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script>
	const contextPath = '${pageContext.request.contextPath}';
</script>
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resources/admin_order/css/order_management.css" />
<script
	src="${pageContext.request.contextPath}/resources/admin_order/script/order_management.js"
	defer></script>
</head>

<body>
	<jsp:include page="../admin_homepage/admin_homeHeader.jsp"></jsp:include>
	<div class="container">

		<!-- 사이드 메뉴 -->
		<jsp:include page="../admin_homepage/admin_navigation.jsp"></jsp:include>

		<div class="order_main">
			<div class="order_management">
			
				<h3 class="order_text">주문/배송 조회</h3>
				
				<div class="order_management_wrapper">
					<table class="management_table">
						<tr>
							<th>검색 항목</th>
							<td class="category_filter"><select name="searchCategory"
								id="searchCategory">
									<option value="user_id">아이디</option>
									<option value="user_idx">회원번호</option>
									<option value="order_id">주문번호</option>
									<option value="shipping_name">수령인 이름</option>
									<option value="shipping_phone">수령인 연락처</option>
									<option value="address">배송지 주소</option>
									<option value="product_names">상품명</option>
							</select> <input type="text" name="searchKeyword" class="order_search"
								placeholder="검색어 입력"></td>
						</tr>

						<tr>
							<th>조회 기간</th>
							<td class="category_filter">
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
							<th>주문 상태</th>
							<td>
								<div class="orderType_wrap">
									<div class="radio-group">
										<label><input type="radio" name="orderStatus"
											value="all" checked>전체</label> <label><input
											type="radio" name="orderStatus" value="paid">결제완료</label> <label><input
											type="radio" name="orderStatus" value="ready">상품준비</label> <label><input
											type="radio" name="orderStatus" value="shipping">배송중</label>
										<label><input type="radio" name="orderStatus"
											value="complete">배송완료</label>
									</div>
									<!-- paid ready shipping complete-->

								</div>
							</td>
						</tr>

						<tr>
							<th>정렬 기준</th>
							<td><select name="sortOption" id="sortOption">
									<option value="latest">최근 주문순</option>
									<!-- 주문일 내림차순 -->
									<option value="earliest">오래된 주문순</option>
									<!-- 주문일 오름차순 -->
									<option value="status">주문 상태별 정렬</option>
									<!-- 상태별 그룹화(예: 결제완료, 배송중, 배송완료) -->
									<option value="amount_high">금액 높은순</option>
									<!-- 주문 금액 내림차순 -->
									<option value="amount_low">금액 낮은순</option>
									<!-- 주문 금액 오름차순 -->
									<option value="userIdxDesc">회원번호 높은순</option>
									<option value="userIdx">회원번호 낮은순</option>
							</select></td>
						</tr>
					</table>
				</div>
			</div>
			<div class="search-buttons">
				<button type="button" class="btn-submit" id="searchBtn">검색</button>
				<button type="button" class="btn-reset">초기화</button>
			</div>

			<div class="order_list">
				<h3 class="order_text">주문/배송 목록</h3>
				<div class="order_list_wrapper">

					<div id="searchResultsContainer">

						<div class="order-count">
							전체 <span class="count">${ totalCount }</span>건
						</div>

						<table class="order_table">
							<thead>
								<tr>
									<!-- <th><input type="checkbox" class="checkbox" id="selectAll"></th> -->
									<th>주문번호</th>
									<th>주문일<small style="color: #888;">(결제일)</small></th>
									<th>상태</th>
									<th>상품명</th>
									<th>수량</th>
									<th>금액</th>
									<th>수령인 이름</th>
									<th>수령인 연락처</th>
									<th>회원번호</th>
									<th>회원아이디</th>
									<!-- 여기 추가 -->
									<th>배송지 주소</th>
									<th>관리</th>
									<!-- 여기 추가 -->
								</tr>
							</thead>


							<tbody>
								<c:if test="${empty order_list}">
									<tr>
										<td colspan="12">검색 결과가 없습니다.</td>
									</tr>
								</c:if>
								<c:forEach var="vo" items="${ order_list }">
									<tr>
										<td>${ vo.order_id }</td>
										<td>${ vo.order_date }</td>
										<td><c:choose>
												<c:when test="${ vo.status  eq '결제완료'}">
													<span class="status paid">결제완료</span>
												</c:when>
												<c:when test="${ vo.status  eq '상품 준비'}">
													<span class="status ready">배송완료</span>
												</c:when>
												<c:when test="${ vo.status  eq '배송중'}">
													<span class="status shipping">배송중</span>
												</c:when>
												<c:when test="${ vo.status  eq '배송완료'}">
													<span class="status complete">배송완료</span>
												</c:when>
											</c:choose></td>

										<td><span class="product_name">${ vo.product_names }</span></td>
										<td>${ vo.quantity }</td>
										<td><fmt:formatNumber type="number">${ vo.amount }</fmt:formatNumber></td>
										<td>${ vo.shipping_name }</td>
										<td>${ vo.shipping_phone }</td>
										<td>${ vo.user_idx }</td>
										<td>${ vo.user_id }</td>
										<td>${ vo.delivery_address }</td>
										<td>
											<button type="button" id="editUsersBtn" class="btn_right"
												onclick="location.href='${pageContext.request.contextPath}/admin/order/edit?order_id=${ vo.order_id }'">수정</button>
											<button type="button" class="btn_right" id="delete-btn" onclick="deleteOrder('${vo.order_id}')">삭제</button>
										</td>
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
	</div>
</body>
</html>