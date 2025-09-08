<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<div id="searchResultsContainer">
	<div class="product-count">
		전체 <span class="count">${ totalCount }</span>개
	</div>
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
			<tr>
				<td colspan="11"><div id="pagingHtmlContainer"
						class="pagination">${pagingHtml}</div></td>
			</tr>
		</tbody>
	</table>
</div>
<!-- 페이징 -->
<%-- <div id="pagingContainer"><c:out value="${pagingHtml}" escapeXml="false" /></div> --%>