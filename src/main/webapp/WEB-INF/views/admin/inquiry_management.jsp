<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>Insert title here</title>
		<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/admin/css/inquiry_management.css" />
		<script src="${pageContext.request.contextPath}/resources/admin/script/inquiry_management.js" defer></script>
	</head>
		
	<body>
		<jsp:include page="../admin_homepage/admin_homeHeader.jsp"></jsp:include>
		<div class="container">
		
			<!-- 사이드 메뉴 -->
			<jsp:include page="../admin_homepage/admin_navigation.jsp"></jsp:include>
		
			<div class="inquiry_main">
			
				<div class="inquiry_management">
					<h3 class="inquiry_text">문의 조회</h3>
					<div class="inquiry_management_wrapper">
						<table class="management_table">
							<tr>
				                <th>검색 분류</th>
				                <td class="category_filter">
				                    <select>
				                        <option>제목</option>
				                        <option>아이디</option>
				                        <option>이메일</option>
				                        <option>상품번호</option>
				                    </select>
				                    <input type="text" name="search" class="inquiry_search">
				                </td>
				            </tr>
				            <tr>
				                <th>문의 유형</th>
				                <td class="filters">
				                    <select>
				                    	<option>전체</option>
				                    	<option>상품 문의</option>
				                    	<option>주문/결제 문의</option>
				                    	<option>배송 문의</option>
				                    	<option>취소/교환/반품 문의</option>
				                    	<option>기타 문의</option>
				                    </select>
				                </td>
				            </tr>
				            <tr>
				                <th>작성일</th>
				                <td>
				                    <div class="regdate">
				                        <button data-range="today">오늘</button>
				                        <button data-range="7">7일</button>
				                        <button data-range="30">1개월</button>
				                        <button data-range="90">3개월</button>
				                        <button data-range="365">1년</button>
				                        <button data-range="all" class="active">전체</button>
				                        <input type="date" class="date-start">
				                        <span>~</span>
				                        <input type="date" class="date-end">
				                    </div>
				                </td>
				            </tr>
				            <tr>
				                <th>처리 상태</th>
				                <td>
				                	<div class="inquiryType_wrap">
				                		<div class="radio-group">
						                    <label><input type="radio" name="inquiryType" checked>전체</label>
						                    <label><input type="radio" name="inquiryType">미답변</label>
						                    <label><input type="radio" name="inquiryType">답변완료</label>
					                    </div>
					                   
							        </div>
				                </td>
				            </tr>
						</table>
					</div>	
				</div>
				<div class="search-buttons">
		        	<button class="btn-submit">검색</button>
		        	<button class="btn-reset">초기화</button>
		        </div>
				
				<div class="inquiry_list">
					<h3 class="inquiry_text">문의 목록</h3>
					<div class="inquiry_list_wrapper">
						<div class="inquiry_table_btn">
							<%-- <a href="${pageContext.request.contextPath}/inquiry_registration.jsp" class="btn_right registration">답변 등록</a>
						    <a href="${pageContext.request.contextPath}/inquiry_edit.jsp" class="btn_right">수정</a> --%>
						    <button type="button" class="btn_right">삭제</button>
						</div>
						<table class="inquiry_table">
							<thead>
								<tr>
									<th><input type="checkbox" class="checkbox"></th>
									<th>No</th>
									<th>작성일</th>
									<th>문의유형</th>
									<th>제목</th>
									<th>상품번호</th>
									<th>이미지</th>
									<th>아이디</th>
									<th>이메일</th>
									<th>관리</th>
									<th>상태</th>
								</tr>
							</thead>
							<tbody>
								<tr>
									<td><input type="checkbox" class="checkbox"></td>
									<td>15</td>
									<td>2025-07-01 14:07:28</td>
									<td>주문/결제 문의</td>
									<td><span class="inquiry_title">결제가 잘 안돼요</span></td>
									<td>P1654165</td>
									<td><img src="${pageContext.request.contextPath}/image/sample1.jpg" alt="상품 이미지" class="product_img" /></td>
									<td>id111</td>
									<td>id111@naver.com</td>
									<td>
										<div class="inquiry_table_btn_unit">
											<button type="button" class="btn_right single">글보기</button>
											<a href="${pageContext.request.contextPath}/inquiry_registration.jsp" class="btn_right single">답변</a>
											<button type="button" class="btn_right single">삭제</button>
										</div>
									</td>
									<td><span class="status pending">미답변</span></td>
								</tr>
								<tr>
									<td><input type="checkbox" class="checkbox"></td>
									<td>10</td>
									<td>2025-07-01 14:07:28</td>
									<td>취소/교환/반품 문의</td>
									<td><span class="inquiry_title">다른 물건이 왔어요 교환해주세요</span></td>
									<td>P1654165</td>
									<td><img src="${pageContext.request.contextPath}/image/sample1.jpg" alt="상품 이미지" class="product_img" /></td>
									<td>id111</td>
									<td>id111@naver.com</td>
									<td>
										<div class="inquiry_table_btn_unit">
											<button type="button" class="btn_right single">글보기</button>
											<a href="${pageContext.request.contextPath}/inquiry_edit.jsp" class="btn_right single">수정</a>
											<button type="button" class="btn_right single">삭제</button>
										</div>
									</td>
									<td><span class="status complete">답변완료</span></td>
								</tr>
								<tr>
									<td><input type="checkbox" class="checkbox"></td>
									<td>8</td>
									<td>2025-07-01 14:07:28</td>
									<td>배송 문의</td>
									<td><span class="inquiry_title">언제 도착해요?</span></td>
									<td>P1654165</td>
									<td><img src="${pageContext.request.contextPath}/image/sample1.jpg" alt="상품 이미지" class="product_img" /></td>
									<td>id111</td>
									<td>id111@naver.com</td>
									<td>
										<div class="inquiry_table_btn_unit">
											<button type="button" class="btn_right single">글보기</button>
											<a href="${pageContext.request.contextPath}/inquiry_edit.jsp" class="btn_right single">수정</a>
											<button type="button" class="btn_right single">삭제</button>
										</div>
									</td>
									<td><span class="status complete">답변완료</span></td>
								</tr>
								<tr>
									<td><input type="checkbox" class="checkbox"></td>
									<td>7</td>
									<td>2025-07-01 14:07:28</td>
									<td>주문/결제 문의</td>
									<td><span class="inquiry_title">결제가 잘 안돼요</span></td>
									<td>P1654165</td>
									<td><img src="${pageContext.request.contextPath}/image/sample1.jpg" alt="상품 이미지" class="product_img" /></td>
									<td>id111</td>
									<td>id111@naver.com</td>
									<td>
										<div class="inquiry_table_btn_unit">
											<button type="button" class="btn_right single">글보기</button>
											<a href="${pageContext.request.contextPath}/inquiry_edit.jsp" class="btn_right single">수정</a>
											<button type="button" class="btn_right single">삭제</button>
										</div>
									</td>
									<td><span class="status complete">답변완료</span></td>
								</tr>
								<tr>
									<td><input type="checkbox" class="checkbox"></td>
									<td>3</td>
									<td>2025-07-01 14:07:28</td>
									<td>취소/교환/반품 문의</td>
									<td><span class="inquiry_title">다른 물건이 왔어요 교환해주세요</span></td>
									<td>P1654165</td>
									<td><img src="${pageContext.request.contextPath}/image/sample1.jpg" alt="상품 이미지" class="product_img" /></td>
									<td>id111</td>
									<td>id111@naver.com</td>
									<td>
										<div class="inquiry_table_btn_unit">
											<button type="button" class="btn_right single">글보기</button>
											<a href="${pageContext.request.contextPath}/inquiry_edit.jsp" class="btn_right single">수정</a>
											<button type="button" class="btn_right single">삭제</button>
										</div>
									</td>
									<td><span class="status complete">답변완료</span></td>
								</tr>
								<tr>
									<td><input type="checkbox" class="checkbox"></td>
									<td>1</td>
									<td>2025-07-01 14:07:28</td>
									<td>배송 문의</td>
									<td><span class="inquiry_title">언제 도착해요?</span></td>
									<td>P1654165</td>
									<td><img src="${pageContext.request.contextPath}/image/sample1.jpg" alt="상품 이미지" class="product_img" /></td>
									<td>id111</td>
									<td>id111@naver.com</td>
									<td>
										<div class="inquiry_table_btn_unit">
											<button type="button" class="btn_right single">글보기</button>
											<a href="${pageContext.request.contextPath}/inquiry_edit.jsp" class="btn_right single">수정</a>
											<button type="button" class="btn_right single">삭제</button>
										</div>
									</td>
									<td><span class="status complete">답변완료</span></td>
								</tr>
							</tbody>
						</table>
						<div class="pagination">
							<button class="page-btn prev" disabled>〈〈</button>
							<button class="page-btn active">1</button>
							<button class="page-btn">2</button>
							<button class="page-btn">3</button>
							<button class="page-btn next">〉〉</button>
						</div>
					</div>
				</div>
				
			</div>
		</div>
	</body>
</html>