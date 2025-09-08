<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

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
				<th>주문자명</th>
				<th>연락처</th>
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
						<button type="button" class="btn_right" id="delete-btn">삭제</button>
					</td>
				</tr>
			</c:forEach>

			<tr>
				<td colspan="12"><div id="pagingHtmlContainer"
						class="pagination">${pagingHtml}</div></td>
			</tr>

		</tbody>
	</table>

</div>