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
<script>
	const contextPath = '${pageContext.request.contextPath}';
</script>
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resources/admin_order/css/return_management.css" />
<script
	src="${pageContext.request.contextPath}/resources/admin_order/script/return_management.js"
	defer></script>
</head>

<body>
	<jsp:include page="../admin_homepage/admin_homeHeader.jsp"></jsp:include>
	<div class="container">

		<!-- 사이드 메뉴 -->
		<jsp:include page="../admin_homepage/admin_navigation.jsp"></jsp:include>

		<div class="return_main">
			<div class="return_management">

				<h3 class="return_text">취소·반품·교환·환불 조회</h3>

				<div class="return_management_wrapper">
					<table class="management_table">
						<tr>
							<th>검색 항목</th>
							<td class="category_filter"><select name="searchCategory"
								id="searchCategory">
									<option value="order_id">주문번호</option>
									<option value="shipping_name">수령인 이름</option>
									<option value="shipping_phone">수령인 연락처</option>
									<option value="user_idx">회원번호</option>
									<option value="product_name">상품명</option>
									<option value="address">배송지 주소</option>
							</select> <input type="text" name="searchKeyword" placeholder="검색어 입력"
								class="return_search" autocomplete="off"></td>
						</tr>

						<tr>
							<th>요청 유형</th>
							<td>
								<div class="returnType_wrap">
									<div class="radio-group">
										<label><input type="radio" name="refundStatus"
											value="all" checked>전체</label> <label><input
											type="radio" name="refundStatus" value="C">취소</label> <label><input
											type="radio" name="refundStatus" value="E">교환</label> <label><input
											type="radio" name="refundStatus" value="R">반품</label> <label><input
											type="radio" name="refundStatus" value="F">환불</label>
									</div>

								</div>
							</td>
						</tr>
						<tr>
							<th>처리 상태</th>
							<td>
								<div class="returnType_wrap">
									<div class="radio-group">
										<label><input type="radio" name="processStatus"
											value="all" checked>전체</label> <label><input
											type="radio" name="processStatus" value="">접수</label> <label><input
											type="radio" name="processStatus" value="P">승인(처리중)</label> <label><input
											type="radio" name="processStatus" value="D">거절</label> <label><input
											type="radio" name="processStatus" value="C">완료</label>
									</div>

								</div>
							</td>
						</tr>

						<tr>
							<th>조회 기간</th>
							<td class="category_filter"><select name="dateType">
									<option value="request_date">요청접수일</option>
									<option value="order_date">주문일</option>
							</select>
								<div class="regdate">
									<button data-range="all" class="active all-btn">전체</button>
									<button data-range="today">오늘</button>
									<button data-range="7">7일</button>
									<button data-range="30">1개월</button>
									<button data-range="90">3개월</button>
									<button data-range="365">1년</button>

									<input type="date" class="date-start" name="dateStart">
									<span>~</span> <input type="date" class="date-end"
										name="dateEnd">
								</div></td>
						</tr>
						<tr>
							<th>정렬 기준</th>
							<td><select name="sortOption" id="sortOption">
									<option value="latest">최근 주문순</option>
									<!-- 주문일 내림차순 -->
									<option value="earliest">오래된 주문순</option>
									<!-- 주문일 오름차순 -->
									<option value="receipt_asc">접수일 빠른순</option>
									<!-- 접수일 오름차순 -->
									<option value="receipt_desc">접수일 늦은순</option>
									<!-- 접수일 내림차순 -->
									<option value="refund_high">환불금액 높은순</option>
									<!-- 환불액 내림차순 -->
									<option value="refund_low">환불금액 낮은순</option>
									<!-- 환불액 오름차순 -->
							</select></td>
						</tr>

					</table>
				</div>
			</div>

			<div class="search-buttons">
				<button class="btn-submit" type="button" id="searchBtn">검색</button>
				<button class="btn-reset" type="button">초기화</button>
			</div>

			<div class="return_list">
				<div class="table_header">
					<h3 class="return_text">취소/교환/반품/환불 목록</h3>

					<div class="return_list_wrapper">


						<div class="bulk-actions">
							<!-- <button type="button" id="bulkApproveBtn" class="btn_right">일괄
								승인</button>
							<button type="button" id="bulkDenyBtn" class="btn_right">일괄
								거부</button> -->
							<button type="button" id="editReturnsBtn" class="btn_right">수정</button>
							<button type="button" id="deleteReturnBtn" class="btn_right">일괄삭제</button>
						</div>

					</div>
				</div>

				<div id="searchResultsContainer">
					<div class="return-count">
						전체 <span class="count">${ totalCount }</span>건
					</div>
					<table class="return_table">
						<thead>
							<tr>
								<th><input type="checkbox" class="checkbox" id="selectAll"></th>
								<th>주문일</th>
								<th>요청접수일</th>
								<th>주문번호</th>
								<th>요청</th>

								<th>상태</th>
								<th>회원번호</th>
								<th>수령인 이름</th>
								<th>수령인 연락처</th>

								<th>배송지 주소</th>
								<th>상품번호(상품명)</th>
								<th>수량</th>
								<th>환불금액</th>
								<th>관리</th>

							</tr>
						</thead>

						<tbody>
							<c:if test="${empty return_list}">
								<tr>
									<td colspan="14">검색 결과가 없습니다.</td>
								</tr>
							</c:if>

							<c:forEach var="vo" items="${ return_list }">

								<tr>
									<td><input type="checkbox" class="checkbox"
										name="selected_items" value="${vo.order_id}"
										data-product-id="${vo.product_id}" data-request-type="${vo.request_type}"
										data-process-status="${vo.process_status}"></td>
									
									<td>${ vo.order_date }</td>
									<td>${ vo.request_date }</td>
									<td>${ vo.order_id }</td>
									<td><span
										class="request-type ${vo.request_type == 'R' ? 'return' : vo.request_type == 'E' ? 'exchange' : vo.request_type == 'F' ? 'refund' : vo.request_type == 'C' ? 'cancel' : ''}">
											${fn:substring(vo.status_label, 0, 2)}</span></td>
									<td><c:choose>
											<c:when
												test="${ vo.process_status == '' or empty vo.process_status}">
												<span class="status progress">접수</span>
											</c:when>
											<c:when test="${ vo.process_status eq 'D' }">
												<span class="status deny">거절</span>
											</c:when>

											<c:when
												test="${ vo.process_status eq 'C' or vo.request_type == 'C'}">
												<span class="status complete">완료</span>
											</c:when>

											<c:when test="${ vo.process_status eq 'P' }">
												<span class="status progress">승인(처리중)</span>
											</c:when>
											<c:otherwise>
										        ${vo.process_status}
										    </c:otherwise>
										</c:choose></td>

									<td>${ vo.user_idx }</td>
									<td>${ vo.shipping_name }</td>
									<td>${ vo.shipping_phone }</td>

									<td>${vo.delivery_address}</td>
									<td>${vo.product_name}</td>
									<td>${vo.quantity}</td>
									<td><fmt:formatNumber type="number">${vo.amount}</fmt:formatNumber></td>


									<td><c:choose>
											<c:when
												test="${ vo.process_status == '' or empty vo.process_status}">
												<button type="button" class="btn_right btn-approve-single">승인</button>
												<button type="button" class="btn_right btn-deny-single">거부</button>
											</c:when>


											<c:when test="${vo.process_status eq 'P'}">
												<button type="button" class="btn_right btn-complete-single">완료</button>
											</c:when>

											<c:otherwise>
												${fn:substring(vo.status_label, 2, fn:length(vo.status_label))}됨
											</c:otherwise>
										</c:choose></td>


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
	<!-- container -->
</body>
</html>