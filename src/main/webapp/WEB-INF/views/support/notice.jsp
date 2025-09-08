<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>공지사항</title>
<script>
	var contextPath = "${pageContext.request.contextPath}";
</script>

<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resources/support/css/notice.css" />
<script
	src="${pageContext.request.contextPath}/resources/support/script/notice.js"
	defer></script>
</head>

<body>
	<jsp:include page="../homepage/homeHeader.jsp"></jsp:include>
	<div class="notice_container">
		<h1>공지사항</h1>
		<div class="filter-section">
			<select class="filter-select">
				<option value="all" ${param.sort == 'all' ? 'selected' : ''}>전체</option>
				<option value="latest" ${param.sort == 'latest' ? 'selected' : ''}>최신순</option>
				<option value="view" ${param.sort == 'view' ? 'selected' : ''}>조회수</option>
			</select>
		</div>

		<table class="notice-table">
			<thead>
				<tr>
					<th>NO</th>
					<th>작성자</th>
					<th>제목</th>
					<th>등록일</th>
					<th>조회수</th>
				</tr>
			</thead>
			<tbody>
				<c:forEach var="list" items="${list}">
					<tr>
						<td>${list.notice_id}</td>
						<td class="category">${list.admin_id}</td>
						<td><a href="#" class="notice-link"
							data-id="${list.notice_id}">${list.title}</a></td>
						<td class="date">${list.created_at}</td>
						<td class="date">${list.views}</td>
					</tr>
					<tr class="notice-content-row" id="content-${list.notice_id}"
						style="display: none;">
						<td colspan="5">
							<div class="notice-content-area">
								<h2>${list.title}</h2>
								<div>${list.content}</div>
							</div>
						</td>
					</tr>
				</c:forEach>
			</tbody>
			<!-- ✅ 반드시 닫아야 함 -->
		</table>

		<!-- ✅ table 밖으로 나와야 footer가 밀리지 않음 -->
		<div class="paging">${pagingHtml}</div>
</div>
		<jsp:include page="../homepage/homeFooter.jsp"></jsp:include>

</body>
</html>