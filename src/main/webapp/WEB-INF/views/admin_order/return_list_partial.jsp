<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>


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
						data-product-id="${vo.product_id}"
						data-request-type="${vo.request_type}"
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
			<tr>
				<td colspan="14"><div id="pagingHtmlContainer"
						class="pagination">${pagingHtml}</div></td>
			</tr>

		</tbody>
	</table>

</div>