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
	href="${pageContext.request.contextPath}/resources/admin_order/css/order_edit.css" />
<script
	src="${pageContext.request.contextPath}/resources/admin_order/script/order_edit.js"
	defer></script>

</head>

<body>
	<jsp:include page="../admin_homepage/admin_homeHeader.jsp"></jsp:include>
	<div class="container">

		<!-- 사이드 메뉴 -->
		<jsp:include page="../admin_homepage/admin_navigation.jsp"></jsp:include>

		<div class="order_edit_main">
			<div class="order_edit">
				<h3 class="order_text">주문/배송 수정</h3>
				<div class="table_wrapper">

					<table class="orderInformation">
						<tr>
							<th colspan="2" class="table_title">주문 정보</th>
						</tr>
						<tr>
							<th>주문번호</th>
							<td>${ ordervo.order_id }</td>
						</tr>
						<tr>
							<th>주문일(결제일)</th>
							<td>${ ordervo.order_date }</td>
						</tr>

						<tr>
							<th>주문자명</th>
							<td>${ ordervo.shipping_name }</td>
						</tr>
						<tr>
							<th>연락처</th>
							<td>${ ordervo.shipping_phone }</td>
						</tr>
						<tr>
							<th>주소</th>
							<td>(${ ordervo.zipcode }) ${ ordervo.address1 } ${ ordervo.address2 }</td>
						</tr>
						<tr>
							<th>배송 요청사항</th>
							<td>${ordervo.request }</td>
						</tr>
					</table>


					<table class="displaySettings">
						<tr>
							<th colspan="2" class="table_title">배송 상태</th>
						</tr>

						<tr>
							<th>주문/배송 상태</th>
							<td>
								<div class="radio-group">
									<label><input type="radio" name="orderStatus"
										value="결제완료"
										<c:if test="${ ordervo.status == '결제완료'}">checked</c:if>>결제완료</label>
									<label><input type="radio" name="orderStatus"
										value="상품준비"
										<c:if test="${ ordervo.status == '상품준비'}">checked</c:if>>상품준비</label>
									<label><input type="radio" name="orderStatus"
										value="배송중"
										<c:if test="${ ordervo.status == '배송중'}">checked</c:if>>배송중</label>
									<label><input type="radio" name="orderStatus"
										value="배송완료"
										<c:if test="${ ordervo.status == '배송완료'}">checked</c:if>>배송완료</label>
								</div>
							</td>
						</tr>
						<tr>
							<th>운송장 번호</th>
							<td><input type="text" name="tracking_number" /></td>
						</tr>

						<tr>
							<th>취소/교환/환불</th>
							<td><c:if test="${hasRefundRequest}">
									<div style="color: red; font-weight: bold;">환불 요청이 접수된
										상품이 있습니다.</div>
								</c:if> <c:if test="${hasExchangeRequest}">
									<div style="color: red; font-weight: bold;">교환 요청이 접수된
										상품이 있습니다.</div>
								</c:if> <c:if test="${hasProcessingRequest}">
									<div style="color: orange; font-weight: bold;">처리 중인
										교환/반품/환불 요청이 있습니다.</div>
								</c:if> <c:if test="${hasRejectedRequest}">
									<div style="color: gray; font-weight: bold;">거절된 교환/반품/환불
										요청이 있습니다.</div>
								</c:if> <c:if
									test="${not hasRefundRequest and not hasExchangeRequest and not hasProcessingRequest and not hasRejectedRequest}">
									<div>없음</div>
								</c:if></td>

						</tr>

					</table>


					<table class="productInformation">

						<c:forEach var="detailvo" items="${order_details}"
							varStatus="loop">
							<tr>
								<th colspan="2" class="table_title">주문한 상품${loop.index + 1}</th>
							</tr>

							<tr>
								<th>상품번호</th>
								<td>${ detailvo.product_id }</td>
							</tr>

							<tr>
								<th>상품명</th>
								<td>${ detailvo.product_name }</td>
							</tr>

							<tr>
								<th>금액</th>
								<td><fmt:formatNumber value="${detailvo.amount}"
										type="number" />원</td>
							</tr>
							<tr>
								<th>수량</th>
								<td>${ detailvo.quantity }개</td>
							</tr>


							<tr>
								<th>교환/환불 상태</th>
								<td><c:choose>
										<c:when test="${detailvo.refund_status == 'N'}">정상</c:when>
										<c:when test="${detailvo.refund_status == 'R'}">반품요청</c:when>
										<c:when test="${detailvo.refund_status == 'E'}">교환요청</c:when>
										<c:when test="${detailvo.refund_status == 'C'}">처리완료</c:when>
										<c:when test="${detailvo.refund_status == 'D'}">요청거절</c:when>
										<c:when test="${detailvo.refund_status == 'P'}">처리중</c:when>
										<c:otherwise>알 수 없음</c:otherwise>
									</c:choose></td>
							</tr>

							<c:if test="${not empty detailvo.refund_requested_at}">
								<tr>
									<th>요청 시간</th>
									<td>${ detailvo.refund_requested_at }</td>
								</tr>
								<tr>
									<th>이유</th>
									<td>${ detailvo.note }</td>
								</tr>
							</c:if>

						</c:forEach>

					</table>

					<table class="paymentInformation">
						<tr>
							<th colspan="2" class="table_title">결제 정보</th>
						</tr>
						<tr>
							<th>결제 고유 번호</th>
							<td>${ paymentvo.payment_id }</td>
						</tr>
						<tr>
							<th>결제 고유 ID(imp_uid)</th>
							<td>${ paymentvo.imp_uid }</td>
						</tr>
						<tr>
							<th>주문 번호</th>
							<td>${ paymentvo.merchant_uid }</td>
						</tr>

						<tr>
							<th>결제 수단</th>
							<td>${ paymentvo.pay_method }</td>
						</tr>
						<tr>
							<th>결제 카드사명</th>
							<td>${ paymentvo.card_name }</td>
						</tr>

						<tr>
							<th>결제 일시</th>
							<td>${ paymentvo.paid_at }</td>
						</tr>
						<tr>
							<th>결제 완료된 금액 합계</th>
							<td>(${paymentvo.currency}) ${ paymentvo.total_paid_amount }</td>
						</tr>
						<tr>
							<th>결제 취소된 금액 합계</th>
							<td>(${paymentvo.currency}) ${ paymentvo.total_cancelled_amount }</td>
						</tr>

						<tr>
							<th>결제 완료된 상품 수량</th>
							<td>${ paymentvo.total_count_paid }개</td>
						</tr>

						<tr>
							<th>결제 취소된 상품 수량</th>
							<td>${ paymentvo.total_count_cancelled }개</td>
						</tr>
					</table>
				</div>
			</div>

			<div class="search-buttons">
				<button class="btn-submit"
					onclick="submitOrder('${fn:escapeXml(ordervo.order_id)}')">수정</button>
				<button class="btn-reset" onclick="history.back()">취소</button>
			</div>
		</div>
	</div>
</body>
</html>