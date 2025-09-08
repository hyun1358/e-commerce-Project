<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>나의 문의내역</title>
		<script>   	
    		var contextPath = "${pageContext.request.contextPath}";
		</script>
		
		<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/support/css/my_inquires.css"/>
		<script src="${pageContext.request.contextPath}/resources/support/script/my_inquires.js" defer></script>
	</head>
	
	<body>
		<jsp:include page="../homepage/homeHeader.jsp"></jsp:include>
		<div class="my_inquires_container">
	        <h1 class="page-title">나의 문의내역 조회</h1>
	        
	        <div class="search-container">
	            <div class="search-row">
	                <div class="date-picker">
	                    <input type="date" class="date-input" value="2025-04-12">
	                    <span class="date-separator">~</span>
	                    <input type="date" class="date-input" value="2025-05-12">
	                </div>
	                
	                <div class="period-buttons">
	                    <button class="period-btn active">1개월</button>
	                    <button class="period-btn">3개월</button>
	                    <button class="period-btn">6개월</button>
	                    <button class="period-btn">12개월</button>
	                </div>
	                
	                <div class="select-wrapper">
	                    <select class="custom-select">
	                        <option value="all">전체</option>
	                        <option value="product">제품문의</option>
	                        <option value="delivery">배송문의</option>
	                        <option value="return">교환/반품/취소</option>
	                        <option value="etc">기타</option>
	                    </select>
	                    <span class="select-arrow">∨</span>
	                </div>
	                <button class="search-btn">조회</button>
	            </div>
	        </div>
	        
	        <div class="inquiry-header">
	            <div class="inquiry-count">
	                문의내역&nbsp;&nbsp;<strong>총 ${inquiery_count}건</strong>
	            </div>
	            
	            <a href='goinquiry.do?user_idx=${user.user_idx}' class="create-inquiry-btn">1:1 문의하기</a>
	        </div>
	        
	        <table class="inquiry-table">
	            <thead>
	                <tr>
	                    <th>NO</th>
	                    <th>사진</th>
	                    <th>제목</th>
	                    <th>내용</th>
	                    <th>작성일/답변일</th>
	                    <th>처리상태</th>
	                </tr>
	            </thead>
	            <tbody>
	            
	            <c:if test="${ empty list }">
	            <tr class="inquiry-row"><td colspan="6"><div class="no-inquiry">문의 내역이 없습니다.</div></td></tr>
	            </c:if>
	            
				  <c:forEach var="list" items="${list}">
				    <tr class="inquiry-row" data-id="${list.inquiry_id}">
				      <td>${list.inquiry_id}</td>
				      <td>
				        <c:if test="${not empty list.image1}">
				          <img src="<c:url value='${list.image1}'/>" width="100" height="100"/>
				        </c:if>
				        <c:if test="${not empty list.image2}">
				          <img src="<c:url value='${list.image2}'/>" width="100" height="100"/>
				        </c:if>
				        <c:if test="${not empty list.image3}">
				          <img src="<c:url value='${list.image3}'/>" width="100" height="100"/>
				        </c:if>
				        <c:if test="${not empty list.image4}">
				          <img src="<c:url value='${list.image4}'/>" width="100" height="100"/>
				        </c:if>
				        <!-- image2~4 동일하게 추가 -->
				      </td>
				      <td>${list.title}</td>
				      <td>${list.content}</td>
				      <td>${list.created_at}</td>
				      <td>
				        <c:choose>
				          <c:when test="${empty list.admin_reply}">미답변</c:when>
				          <c:otherwise>답변완료</c:otherwise>
				        </c:choose>
				      </td>
				    </tr>
				
				    <!-- 답변 영역: 처음 숨김 -->
				    <tr class="answer-row" id="answer-${list.inquiry_id}" style="display:none;">
				      <td colspan="5">
				        <c:if test="${not empty list.admin_reply}">
				          <div class="answer-left">
				            <strong>작성자:</strong> ${list.admin_id}<br/>
				            <strong>답변 내용:</strong> ${list.admin_reply}
				          </div>
				        </c:if>
				      </td>
				    </tr>
				  </c:forEach>
				</tbody>
	        </table>
	    </div>
		<jsp:include page="../homepage/homeFooter.jsp"></jsp:include>
	</body>
</html>