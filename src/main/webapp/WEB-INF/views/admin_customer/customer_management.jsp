<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
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
	href="${pageContext.request.contextPath}/resources/admin_customer/css/customer_management.css" />
<script
	src="${pageContext.request.contextPath}/resources/admin_customer/script/customer_management.js"
	defer></script>
</head>

<body>
	<jsp:include page="../admin_homepage/admin_homeHeader.jsp"></jsp:include>
	<div class="container">

		<!-- 사이드 메뉴 -->
		<jsp:include page="../admin_homepage/admin_navigation.jsp"></jsp:include>

		<div class="customer_main">
			<!-- <form id="searchForm"> -->
			<div class="customer_management">
				<h3 class="customer_text">회원 조회</h3>
				<div class="customer_management_wrapper">
					<table class="management_table">
						<tr>
							<th>검색 항목</th>
							<td class="category_filter"><select name="searchCategory"
								id="searchCategory">
									<option value="user_idx">회원번호</option>
									<option value="user_id">아이디</option>
									<option value="user_name">이름</option>
									<option value="email">이메일</option>
									<option value="phone">연락처</option>
									<option value="address">주소</option>

							</select> <input type="text" name="searchKeyword" class="customer_search"
								autocomplete="off" placeholder="검색어 입력"></td>
						</tr>
						<tr>
							<th>가입일</th>
							<td>
								<div class="regdate">
									<button data-range="all" class="active all-btn">전체</button>
									<button data-range="today">오늘</button>
									<button data-range="7">7일</button>
									<button data-range="30">1개월</button>
									<button data-range="90">3개월</button>
									<button data-range="365">1년</button>

									<input type="date" name="dateStart" class="date-start">
									<span>~</span> <input type="date" name="dateEnd"
										class="date-end">
								</div>
							</td>
						</tr>
						<tr>
							<th>회원 상태</th>
							<td>
								<div class="customerType_wrap">
									<div class="radio-group">
										<label><input type="radio" name="customerStatus"
											value="all" checked>전체</label> <label><input
											type="radio" name="customerStatus" value="active">활동</label>
										<label><input type="radio" name="customerStatus"
											value="sleep">휴면</label> <label><input type="radio"
											name="customerStatus" value="withdrawn">탈퇴</label>
									</div>
								</div>
							</td>
						</tr>

						<tr>
							<th>정렬 기준</th>
							<td><select name="sortOption" id="sortOption">
									<option value="latest">최근 가입일순</option>
									<option value="userIdx">회원번호 오름차순</option>
									<option value="userIdxDesc">회원번호 내림차순</option>
									<option value="userId">아이디 오름차순</option>
									<option value="userIdDesc">아이디 내림차순</option>
									<option value="userName">이름 오름차순</option>
									<option value="userNameDesc">이름 내림차순</option>
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

			<div class="customer_list">
				<div class="table_header">
					<h3 class="customer_text">회원 목록</h3>
					<div class="customer_table_btn">
						<button type="button" id="editUsersBtn" class="btn_right">수정</button>
						<button type="button" class="btn_right" id="delete-btn">삭제</button>
					</div>
				</div>
				<div class="customer_list_wrapper">
					<div id="searchResultsContainer">
					
						<!-- 전체 회원수 스타일링 추가 -->
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
										<td><input type="checkbox" class="checkbox"
											name="user_idx" value="${ vo.user_idx }"></td>
										<td>${ vo.user_idx }</td>
										<td>${ vo.user_id }</td>
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
										<td>${ fn:substring(vo.birth, 0, 10) }</td>
										<td><c:choose>
												<c:when test="${vo.gender eq 'M'}">M</c:when>
												<c:when test="${vo.gender eq 'F'}">F</c:when>
												<c:otherwise>-</c:otherwise>
											</c:choose></td>
										<td class="address-cell">(${ vo.zipcode })
											${ vo.address1 }${ vo.address2 }</td>
										<td>${ vo.social }</td>
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