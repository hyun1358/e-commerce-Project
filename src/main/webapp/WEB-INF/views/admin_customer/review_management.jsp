<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>Insert title here</title>
		<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/admin_customer/css/review_management.css" />
		<script src="${pageContext.request.contextPath}/resources/admin_customer/script/review_management.js" defer></script>
	</head>
		
	<body>
		<jsp:include page="../admin_homepage/admin_homeHeader.jsp"></jsp:include>
		<div class="container">
		
			<!-- 사이드 메뉴 -->
			<jsp:include page="../admin_homepage/admin_navigation.jsp"></jsp:include>
		
			<div class="review_main">
			
				<div class="review_management">
					<h3 class="review_text">리뷰 조회</h3>
					<div class="review_management_wrapper">
						<table class="management_table">
							<tr>
				                <th>검색 분류</th>
				                <td class="category_filter">
				                    <select>
				                        <option>상품명</option>
				                        <option>아이디</option>
				                        <option>제목</option>
				                    </select>
				                    <input type="text" name="search" class="review_search">
				                </td>
				            </tr>
				            <tr>
				                <th>별점</th>
				                <td class="category_filter">
				                    <select>
				                    	<option>전체</option>
				                    	<option>★★★★★</option>
				                    	<option>★★★★☆</option>
				                    	<option>★★★☆☆</option>
				                    	<option>★★☆☆☆</option>
				                    	<option>★☆☆☆☆</option>
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
				                <th>노출 여부</th>
				                <td>
				                	<div class="reviewType_wrap">
				                		<div class="radio-group">
						                    <label><input type="radio" name="showType" checked>전체</label>
						                    <label><input type="radio" name="showType">노출</label>
						                    <label><input type="radio" name="showType">비노출</label>
					                    </div>
					                   
							        </div>
				                </td>
				            </tr>
				            <tr>
				                <th>처리 상태</th>
				                <td>
				                	<div class="reviewType_wrap">
				                		<div class="radio-group">
						                    <label><input type="radio" name="reviewType" checked>전체</label>
						                    <label><input type="radio" name="reviewType">미답변</label>
						                    <label><input type="radio" name="reviewType">답변완료</label>
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
				
				<div class="review_list">
					<h3 class="review_text">리뷰 목록</h3>
					<div class="review_list_wrapper">
						<div class="review_table_btn">
						    <button type="button" class="btn_right">삭제</button>
						</div>
						<table class="review_table">
							<thead>
								<tr>
									<th><input type="checkbox" class="checkbox"></th>
									<th>No</th>
									<th>작성일</th>
									<th>상품명</th>
									<th>이미지</th>
									<th>아이디</th>
									<th>별점</th>
									<th>리뷰 제목</th>
									<th>노출</th>
									<th>관리</th>
									<th>상태</th>
								</tr>
							</thead>
							<tbody>
								<tr>
									<td><input type="checkbox" class="checkbox"></td>
									<td>118</td>
									<td>2025-07-01 14:07:28</td>
									<td><span class="product_name">LG 그램 Pro 360 16T90TP-GA5HK</span></td>
									<td><img src="${pageContext.request.contextPath}/image/sample1.jpg" alt="상품 이미지" class="product_img" /></td>
									<td>id111</td>
									<td>★★★★★</td>
									<td><span class="review_title">제품이 좋아요</span></td>
									<td>노출</td>
									<td>
										<div class="review_table_btn_unit">
											<button type="button" class="btn_right single">글보기</button>
											<a href="${pageContext.request.contextPath}/" class="btn_right single">답변</a>
											<button type="button" class="btn_right single">삭제</button>
										</div>
									</td>
									<td><span class="status pending">미답변</span></td>
								</tr>
								<tr>
									<td><input type="checkbox" class="checkbox"></td>
									<td>81</td>
									<td>2025-07-01 14:07:28</td>
									<td><span class="product_name">LG 그램 Pro 360 16T90TP-GA5HK</span></td>
									<td><img src="${pageContext.request.contextPath}/image/sample1.jpg" alt="상품 이미지" class="product_img" /></td>
									<td>id111</td>
									<td>★★★★☆</td>
									<td><span class="review_title">식품·유통업계, 이달에 라면·빵·커피 등 최대 반값 할인</span></td>
									<td>노출</td>
									<td>
										<div class="review_table_btn_unit">
											<button type="button" class="btn_right single">글보기</button>
											<a href="${pageContext.request.contextPath}/" class="btn_right single">수정</a>
											<button type="button" class="btn_right single">삭제</button>
										</div>
									</td>
									<td><span class="status complete">답변완료</span></td>
								</tr>
								<tr>
									<td><input type="checkbox" class="checkbox"></td>
									<td>8</td>
									<td>2025-07-01 14:07:28</td>
									<td><span class="product_name">LG 그램 Pro 360 16T90TP-GA5HK</span></td>
									<td><img src="${pageContext.request.contextPath}/image/sample1.jpg" alt="상품 이미지" class="product_img" /></td>
									<td>qwer1111</td>
									<td>★★★★☆</td>
									<td><span class="review_title">쓸만하네요</span></td>
									<td>노출</td>
									<td>
										<div class="review_table_btn_unit">
											<button type="button" class="btn_right single">글보기</button>
											<a href="${pageContext.request.contextPath}/" class="btn_right single">수정</a>
											<button type="button" class="btn_right single">삭제</button>
										</div>
									</td>
									<td><span class="status complete">답변완료</span></td>
								</tr>
								<tr>
									<td><input type="checkbox" class="checkbox"></td>
									<td>8</td>
									<td>2025-07-01 14:07:28</td>
									<td><span class="product_name">LG 그램 Pro 360 16T90TP-GA5HK</span></td>
									<td><img src="${pageContext.request.contextPath}/image/sample1.jpg" alt="상품 이미지" class="product_img" /></td>
									<td>asdf111</td>
									<td>★☆☆☆☆</td>
									<td><span class="review_title">내구도가 부실해서 별로에요</span></td>
									<td>비노출</td>
									<td>
										<div class="review_table_btn_unit">
											<button type="button" class="btn_right single">글보기</button>
											<a href="${pageContext.request.contextPath}/" class="btn_right single">수정</a>
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