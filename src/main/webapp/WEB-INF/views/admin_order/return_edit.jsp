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
	href="${pageContext.request.contextPath}/resources/admin_order/css/return_edit.css" />
<script
	src="${pageContext.request.contextPath}/resources/admin_order/script/return_edit.js"
	defer></script>
</head>

<body>
	<jsp:include page="../admin_homepage/admin_homeHeader.jsp"></jsp:include>
	<div class="container">

		<!-- 사이드 메뉴 -->
		<jsp:include page="../admin_homepage/admin_navigation.jsp"></jsp:include>

		<div class="return-button-wrapper">
			<div class="tab-nav-vertical">
				<div>[No] 주문번호</div>

				<c:forEach var="vo" items="${returns}" varStatus="loop">

					<button type="button" class="tab-btn"
						data-tab-id="return_${vo.order_id}_${vo.product_id}"
						onclick="showReturnTab('${vo.order_id}_${vo.product_id}')">
						[${loop.index + 1}] ${vo.product_name}</button>
				</c:forEach>
			</div>


			<div class="return-content-area">

				<c:forEach var="vo" items="${ returns }">

					<div class="return_edit_main return-tab"
						id="return_${vo.order_id}_${vo.product_id}" style="display: none;">
						<button type="button" class="btn-back" onclick="history.back()">목록으로
							돌아가기</button>
						<div class="return_edit">

							<h3 class="return_text">취소/교환/반품/환불 수정</h3>
							<div class="table_wrapper">

								<table class="orderInformation">
									<tr>
										<th colspan="2" class="table_title">주문 정보</th>
									</tr>
									<tr>
										<th>주문번호</th>
										<td>${vo.order_id}</td>
									</tr>
									<tr>
										<th>상품명</th>
										<td>${vo.product_name}</td>
									</tr>
									<tr>
										<th>회원 번호</th>
										<td>${vo.user_idx}</td>
									</tr>
									<tr>
										<th>수령인 이름</th>
										<td>${vo.shipping_name}</td>
									</tr>
									<tr>
										<th>수령인 연락처</th>
										<td>${vo.shipping_phone}</td>
									</tr>
									<tr>
										<th>배송지 주소</th>
										<td>${vo.delivery_address}</td>
									</tr>
									<tr>
										<th>주문일(결제일)</th>
										<td>${vo.order_date}</td>
									</tr>
								</table>
								<form
									action="${pageContext.request.contextPath}/admin/return/update"
									method="post" data-order-id="${vo.order_id}"
									data-product-id="${vo.product_id}">
									<input type="hidden" name="order_id" value="${vo.order_id}" />
									<input type="hidden" name="product_id" value="${vo.product_id}" />

									<table class="displaySettings">
										<tr>
											<th colspan="1" class="table_title">요청 유형 및 처리 상태 변경</th>
											<td><div class="search-buttons">
													<button type="submit" class="btn-submit">수정</button>
													<button type="button" class="btn-reset"
														onclick="resetForm(this)">초기화</button>
												</div></td>
										</tr>

										<tr>
											<th>요청 유형</th>
											<td><select name="request_type"
												data-original="${vo.request_type}">
													<option value="C"
														${vo.request_type == 'C' ? 'selected' : ''}>취소</option>
													<option value="E"
														${vo.request_type == 'E' ? 'selected' : ''}>교환</option>
													<option value="R"
														${vo.request_type == 'R' ? 'selected' : ''}>반품</option>
													<option value="F"
														${vo.request_type == 'F' ? 'selected' : ''}>환불</option>
											</select></td>
										</tr>
										<tr>
											<th>처리 상태</th>
											<td><select name="process_status"
												data-original="${empty vo.process_status ? '' : vo.process_status}">
													<option value=""
														${vo.process_status == '' ? 'selected' : ''}>접수</option>
													<option value="P"
														${vo.process_status == 'P' ? 'selected' : ''}>승인(처리중)</option>
													<option value="C"
														${vo.process_status == 'C' ? 'selected' : ''}>완료</option>
													<option value="D"
														${vo.process_status == 'D' ? 'selected' : ''}>거절</option>
											</select></td>
										</tr>
										<tr>
											<th>요청사유</th>
											<td><textarea class="reason" readonly="readonly">${vo.note}</textarea></td>
										</tr>
									</table>


								</form>

								<table class="productInformation">
									<tr>
										<th colspan="2" class="table_title">${vo.request_type}
											요청한 상품 정보</th>
									</tr>
									<tr>
										<th>상품번호</th>
										<td>${vo.product_id}</td>
									</tr>
									<tr>
										<th>상품명</th>
										<td>${vo.product_name}</td>
									</tr>

									<tr>
										<th>단가</th>
										<td><fmt:formatNumber type="number">${vo.amount / vo.quantity}</fmt:formatNumber></td>
									</tr>

									<tr>
										<th>수량</th>
										<td>${vo.quantity}</td>
									</tr>
									<tr>
										<th>총 구매금액</th>
										<td><fmt:formatNumber type="number">${vo.amount}</fmt:formatNumber></td>
									</tr>

								</table>


							</div>

						</div>
						<!-- 	<button type="button" class="btn-back" onclick="history.back()">목록으로
								돌아가기</button> -->
					</div>
				</c:forEach>
			</div>
		</div>
	</div>
</body>
</html>