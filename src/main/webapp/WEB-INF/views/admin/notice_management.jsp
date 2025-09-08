<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>Insert title here</title>
		<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/admin/css/notice_management.css" />
		<script src="${pageContext.request.contextPath}/resources/admin/js/notice_management.js" defer></script>
	</head>
		
	<body>
		<jsp:include page="../admin_homepage/admin_homeHeader.jsp"></jsp:include>
		<div class="container">
		
			<!-- 사이드 메뉴 -->
			<jsp:include page="../admin_homepage/admin_navigation.jsp"></jsp:include>
		
			<div class="notice_main">
			
				<div class="notice_management">
					<h3 class="notice_text">공지사항 조회</h3>
					<div class="notice_management_wrapper">
						<table class="management_table">
							<tr>
				                <th>검색 분류</th>
				                <td class="category_filter">
				                    <select>
				                        <option>제목</option>
				                    </select>
				                    <input type="text" name="search" class="notice_search">
				                </td>
				            </tr>
				            <tr>
				                <th>상품 분류</th>
				                <td class="category_filter">
				                    <select>
				                    	<option>전체</option>
				                    	<option>디지털</option>
				                    	<option>음향기기</option>
				                    	<option>주방가전</option>
				                    	<option>계절가전</option>
				                    	<option>생활가전</option>
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
				                <th>공지 유형</th>
				                <td>
				                	<div class="noticeType_wrap">
				                		<div class="radio-group">
						                    <label><input type="radio" name="noticeType" checked>전체</label>
						                    <label><input type="radio" name="noticeType">기본</label>
						                    <label><input type="radio" name="noticeType">긴급</label>
					                    </div>
					                   
							        </div>
				                </td>
				            </tr>
				            <tr>
				                <th>표시 상태</th>
				                <td>
				                	<div class="noticeType_wrap">
				                		<div class="radio-group">
						                    <label><input type="radio" name="showType" checked>전체</label>
						                    <label><input type="radio" name="showType">표시함</label>
						                    <label><input type="radio" name="showType">표시안함</label>
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
			
				<div class="notice_list">
					<h3 class="notice_text">공지사항 목록</h3>
					<div class="notice_list_wrapper">
						<div class="notice_table_btn">
							<a href="${pageContext.request.contextPath}/notice_registration.jsp" class="btn_right registration">공지사항 등록</a>
						    <button type="button" class="btn_right">삭제</button>
						</div>
						<table class="notice_table">
							<thead>
								<tr>
									<th><input type="checkbox" class="checkbox"></th>
									<th>No</th>
									<th>유형</th>
									<th>분류</th>
									<th>제목</th>
									<th>권한(읽기)</th>
									<th>작성일</th>
									<th>조회수</th>
									<th>관리</th>
									<th>상태</th>
								</tr>
							</thead>
							<tbody>
								<tr>
									<td><input type="checkbox" class="checkbox"></td>
									<td>55</td>
									<td>기본</td>
									<td>디지털</td>
									<td><span class="notice_title">삼성 노트북 배터리 무상 교환 프로그램 안내</span></td>
									<td>비회원</td>
									<td>2025-07-02 15:25:28</td>
									<td>4243</td>
									<td>
										<div class="notice_table_btn_unit">
											<button type="button" class="btn_right single">글보기</button>
											<a href="${pageContext.request.contextPath}/notice_edit.jsp" class="btn_right single">수정</a>
											<button type="button" class="btn_right single">삭제</button>
										</div>
									</td>
									<td><span class="status show">표시함</span></td>
								</tr>
								<tr>
									<td><input type="checkbox" class="checkbox"></td>
									<td>46</td>
									<td>기본</td>
									<td>음향기기</td>
									<td><span class="notice_title">삼성 노트북 배터리 무상 교환 프로그램 안내</span></td>
									<td>비회원</td>
									<td>2025-07-02 15:25:28</td>
									<td>123</td>
									<td>
										<div class="notice_table_btn_unit">
											<button type="button" class="btn_right single">글보기</button>
											<button type="button" class="btn_right single">수정</button>
											<button type="button" class="btn_right single">삭제</button>
										</div>
									</td>
									<td><span class="status show">표시함</span></td>
								</tr>
								<tr>
									<td><input type="checkbox" class="checkbox"></td>
									<td>37</td>
									<td>긴급</td>
									<td>계절가전</td>
									<td><span class="notice_title">삼성 노트북 배터리 무상 교환 프로그램 안내</span></td>
									<td>비회원</td>
									<td>2025-07-02 15:25:28</td>
									<td>2654</td>
									<td>
										<div class="notice_table_btn_unit">
											<button type="button" class="btn_right single">글보기</button>
											<button type="button" class="btn_right single">수정</button>
											<button type="button" class="btn_right single">삭제</button>
										</div>
									</td>
									<td><span class="status hide">표시안함</span></td>
								</tr>
								<tr>
									<td><input type="checkbox" class="checkbox"></td>
									<td>36</td>
									<td>기본</td>
									<td>디지털</td>
									<td><span class="notice_title">삼성 노트북 배터리 무상 교환 프로그램 안내</span></td>
									<td>회원</td>
									<td>2025-07-02 15:25:28</td>
									<td>3242</td>
									<td>
										<div class="notice_table_btn_unit">
											<button type="button" class="btn_right single">글보기</button>
											<button type="button" class="btn_right single">수정</button>
											<button type="button" class="btn_right single">삭제</button>
										</div>
									</td>
									<td><span class="status show">표시함</span></td>
								</tr>
								<tr>
									<td><input type="checkbox" class="checkbox"></td>
									<td>33</td>
									<td>기본</td>
									<td>음향기기</td>
									<td><span class="notice_title">삼성 노트북 배터리 무상 교환 프로그램 안내</span></td>
									<td>회원</td>
									<td>2025-07-02 15:25:28</td>
									<td>123</td>
									<td>
										<div class="notice_table_btn_unit">
											<button type="button" class="btn_right single">글보기</button>
											<button type="button" class="btn_right single">수정</button>
											<button type="button" class="btn_right single">삭제</button>
										</div>
									</td>
									<td><span class="status show">표시함</span></td>
								</tr>
								<tr>
									<td><input type="checkbox" class="checkbox"></td>
									<td>20</td>
									<td>긴급</td>
									<td>계절가전</td>
									<td><span class="notice_title">삼성 노트북 배터리 무상 교환 프로그램 안내</span></td>
									<td>관리자</td>
									<td>2025-07-02 15:25:28</td>
									<td>2654</td>
									<td>
										<div class="notice_table_btn_unit">
											<button type="button" class="btn_right single">글보기</button>
											<button type="button" class="btn_right single">수정</button>
											<button type="button" class="btn_right single">삭제</button>
										</div>
									</td>
									<td><span class="status hide">표시안함</span></td>
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