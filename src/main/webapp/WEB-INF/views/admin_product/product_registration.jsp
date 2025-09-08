<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resources/admin_product/css/product_registration.css" />
<script
	src="${pageContext.request.contextPath}/resources/admin_product/script/product_registration.js"
	defer></script>
</head>

<body>
	<jsp:include page="../admin_homepage/admin_homeHeader.jsp"></jsp:include>
	<div class="container">

		<!-- 사이드 메뉴 -->
		<jsp:include page="../admin_homepage/admin_navigation.jsp"></jsp:include>

		<div class="product_registration_main">
			<div class="product_registration">
				<h3 class="product_text">상품 등록</h3>
				<div class="table_wrapper">

					<!-- 상품 이름등 기본 정보 설정 -->
					<table class="basicInformation">
						<tr>
							<th colspan="2" class="table_title">기본 정보</th>
						</tr>
						<tr>
							<th>상품번호</th>
							<td><span>자동생성</span></td>
						</tr>
						<tr>
							<th>상품 분류 선택</th>
							<td class="category_filter"><select id="parentCategory"
								name="parent_category">
									<option value="">(대분류) 선택</option>

									<c:forEach var="cat" items="${parentCategories}">
										<option value="${cat.category_id}">(대분류) ${cat.name}</option>
									</c:forEach>
							</select> <select id="childCategory" name="category" child-category-select>
									<option value="">(소분류) 선택</option>
									<!-- 소분류 옵션은 초기 로드 시 JS -->
							</select></td>
						</tr>
						<tr>
							<th>상품명 <small style="color: #888;">(50자 이하)</small></th>
							<td><input type="text" name="product_name">
							</td>
						</tr>
						
						<tr>
							<th>제조사 <small style="color: #888;">(15자 이하)</small></th>
							<td><input type="text" name="company">
							</td>
						</tr>

						<tr>
							<th>상품 상세설명</th>
							<td><pre><textarea class="descriptionBox" name="description"></textarea></pre>
							</td>
						</tr>
					</table>


					<!-- 가격, 재고 정보 설정 -->
					<table class="salesInformation">
						<tr>
							<th colspan="2" class="table_title">판매 정보</th>
						</tr>
						<tr>
							<th>판매 상태</th>
							<td>
								<div class="radio-group">
									<label><input type="radio" name="is_visible" value="Y"
										checked>판매중</label> <label><input type="radio"
										name="is_visible" value="N">숨김/판매종료</label>
								</div>
							</td>
						</tr>
						<tr>
							<th>판매가</th>
							<td><span>KRW</span><input type="number" name="price" min="0" required><span>원</span>
							</td>
						</tr>
						<tr>
							<th>할인가</th>
							<td><span>KRW</span><input type="number" name="sale_price" min="0"><span>원</span>
							</td>
						</tr>
						<tr>
							<th>재고수량</th>
							<td><input type="number" name="stock" min="0"></td>
						</tr>
					</table>


					<!-- 이미지 설정 -->
					<table class="imageInformation">
						<tr>
							<th colspan="2" class="table_title">이미지정보</th>
						</tr>
						<tr>
							<th>이미지등록</th>
							<td>
								<div class="image-wrapper">

									<div class="image-upload-container" id="imageContainer">

										<c:forEach var="i" begin="1" end="5">

											<div class="image-preview-wrapper">

												<div class="image-preview" id="imagePreview_${i}"
													onclick="triggerImageUpload(${i})">

													<!-- 이미지가 없기 때문에 +를 display: block;-->
													<img id="previewImg_${i}" alt="이미지 미리보기" src="#"
														style="display: none;">
													<div class="no-image-text" id="noImageText_${i}"
														style="display: block;">+</div>
												</div>


												<div class="image-upload-controls">
													<input type="file" id="imageInput_${ i }" name="images[${i - 1}]" accept="image/*"
														style="display: none;">
													<button type="button" class="btn-file-delete"
														onclick="deleteImage(${i})">삭제</button>
												</div>

											</div>
											<!-- image-preview-wrapper닫음 -->
										</c:forEach>
									</div>
									<!-- image-upload-container 닫음 -->
									<div class="image-info" id="imageInfo">이미지는 최대 5개까지 가능합니다.</div>
								</div> <!-- image-wrapper닫음 -->

							</td>
						</tr>
					</table>
				</div>
			</div>
			<div class="search-buttons">
				<button class="btn-reset" onclick="history.back()">취소</button>
				<button class="btn-submit" onclick="submitProduct()">등록</button>
			</div>
		</div>
	</div>
</body>
</html>