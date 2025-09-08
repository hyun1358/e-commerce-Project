<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<div id="searchResultsContainer">
	<div class="member-count">
		전체 <span class="count">${ totalCount }</span>명
	</div>
	<table class="customer_table">
		<thead>
			<tr>
				<th><input type="checkbox" class="checkbox" id="selectAll"></th>
				<th>회원번호</th>
				<th>아이디</th>
				<th>이름</th>
				<th>상태</th>
				<th>가입일</th>
				<th>연락처</th>
				<th>메일</th>
				<th>생년월일</th>
				<th>성별</th>
				<th>주소</th>
				<th>가입경로</th>
			</tr>
		</thead>
		<tbody>
			<c:if test="${empty user_list}">
				<tr>
					<td colspan="12">검색 결과가 없습니다.</td>
				</tr>
			</c:if>
			<c:forEach var="vo" items="${user_list}">

				<tr>
					<td><input type="checkbox" class="checkbox" name="user_idx"
						value="${ vo.user_idx }"></td>
					<td>${ vo.user_idx}</td>
					<td>${ vo.user_id}</td>
					<td>${ vo.user_name }</td>
					<td><c:choose>
							<c:when test="${vo.account_status eq 1}">
								<span class="status active">활동</span>
							</c:when>
							<c:when test="${vo.account_status eq 2}">
								<span class="status dormant">휴면</span>
							</c:when>
							<c:when test="${vo.account_status eq 3}">
								<span class="status withdrawn">탈퇴</span>
							</c:when>
						</c:choose></td>
					<td>${ fn:substring(vo.regdate, 0, 10) }</td>


					<td>${ vo.phone }</td>
					<td>${ vo.email }</td>
					<td>${fn:substring(vo.birth, 0, 10)}</td>
					<td><c:choose>
							<c:when test="${vo.gender eq 'M'}">M</c:when>
							<c:when test="${vo.gender eq 'F'}">F</c:when>
							<c:otherwise>-</c:otherwise>
						</c:choose></td>
					<td class="address-cell">(${vo.zipcode})
						${vo.address1}${vo.address2 }</td>
					<td>${ vo.social }</td>
				</tr>
			</c:forEach>
			<!-- 페이징 -->
			<tr>
				<td style="text-align: center;" colspan="11"><div
						id="pagingHtmlContainer" class="pagination">${pagingHtml}</div></td>
			</tr>
		</tbody>
	</table>
</div>