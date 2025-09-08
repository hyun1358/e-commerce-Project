<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resources/admin_product/css/product_edit.css" />
<script
	src="${pageContext.request.contextPath}/resources/admin_product/script/product_edit.js"
	defer></script>
</head>

<body>
	<jsp:include page="../admin_homepage/admin_homeHeader.jsp"></jsp:include>
	<div class="container">

		<!-- 사이드 메뉴 -->
		<jsp:include page="../admin_homepage/admin_navigation.jsp"></jsp:include>

		<!-- 상품 버튼 -->
		<div class="product-button-wrapper">
			<div class="tab-nav-vertical">
				<div>[상품번호] 상품명</div>

				<c:forEach var="vo" items="${products}">

					<button type="button" class="tab-btn"
						data-product-id="${vo.product_id}"
						onclick="showProductTab(${vo.product_id})">[${ vo.product_id }]
						${ vo.product_name }</button>

				</c:forEach>
			</div>

			<div class="product-content-area">

				<!-- 상품리스트 초기 정보 다 가져옴 -->
				<c:forEach var="vo" items="${ products }">

					<div class="product_edit_main product-tab"
						id="product_${ vo.product_id }" style="display: none;"
						data-category-id="${vo.category_id}">

						<div class="product_edit">
							<h3 class="product_text">상품 수정</h3>
							<p>상품번호 : ${ vo.product_id }</p>
							<div class="table_wrapper">


								<!-- 상품 이름등 기본 정보 수정 -->
								<table class="basicInformation">
									<tr>
										<th colspan="2" class="table_title">기본 정보</th>
									</tr>
									<tr>
										<th>상품번호</th>
										<td><span>자동생성</span></td>
									</tr>

									<tr>
										<th>상품 등록일시</th>
										<td>${ vo.regdate }</td>
									</tr>
									<tr>
										<th>상품 분류 선택</th>
										<td class="category_filter"><select
											id="parentCategory_${vo.product_id}"
											name="parent_category_${vo.product_id}">
												<option value="">(대분류) 선택</option>

												<c:forEach var="cat" items="${parentCategories}">
													<option value="${cat.category_id}"
														<c:if test="${cat.category_id == vo.parent_category_id}">selected</c:if>>
														(대분류) ${cat.name}</option>
												</c:forEach>

										</select> <!-- 소분류 셀렉트 --> <select id="childCategory_${vo.product_id}"
											name="category_${vo.product_id}" class="child-category-select">
												<option value="">(소분류) 선택</option>
												<!-- 소분류 옵션은 초기 로드 시 JS -->
										</select></td>
									</tr>

									<tr>

										<th>상품명 <small style="color: #888;">(50자 이하)</small></th>
										<td><input type="text"
											name="product_name_${ vo.product_id }"
											value="${ vo.product_name }"></td>
									</tr>

									<tr>
										<th>제조사 <small style="color: #888;">(15자 이하)</small></th>
										<td><input type="text" name="company_${ vo.product_id }"
											value="${ vo.company }"></td>
									</tr>

									<tr>
										<th>상품 상세설명</th>
										<td><textarea class="descriptionBox"
												name="description_${ vo.product_id }">${ vo.description }</textarea>
										</td>
									</tr>


								</table>


								<!-- 가격, 재고 정보 수정 -->
								<table class="salesInformation">
									<tr>
										<th colspan="2" class="table_title">판매 정보</th>
									</tr>
									<tr>
										<th>판매 여부</th>
										<td>
											<div class="radio-group">

												<label><input type="radio"
													name="is_visible_${ vo.product_id }" value="Y"
													<c:if test="${vo.is_visible == 'Y'}">checked</c:if>>판매중</label>

												<label><input type="radio"
													name="is_visible_${ vo.product_id }" value="N"
													<c:if test="${vo.is_visible == 'N'}">checked</c:if>>숨김/판매종료</label>

											</div>
										</td>
									</tr>
									<tr>
										<th>판매가</th>
										<td><span>KRW</span><input type="number"
											name="price_${ vo.product_id }" min="0" value="${ vo.price }"
											required><span>원</span></td>
									</tr>
									<tr>
										<th>할인가</th>
										<td><span>KRW</span><input type="number"
											name="sale_price_${ vo.product_id }" min="0"
											value="${ vo.sale_price }"><span>원</span></td>
									</tr>
									<tr>
										<th>재고수량</th>
										<td><input type="number" min="0"
											name="stock_${ vo.product_id }" value="${ vo.stock }"></td>
									</tr>
									<tr>
										<th>판매량</th>
										<td>${ vo.sales_volume }개</td>
									</tr>
								</table>





								<!-- 이미지 정보 수정 -->
								<table class="imageInformation">
									<tr>
										<th colspan="2" class="table_title">이미지정보</th>
									</tr>
									<tr>
										<th>이미지등록</th>
										<td>
											<div class="image-wrapper">
												<div class="image-upload-container"
													id="imageContainer_${vo.product_id}">

													<c:forEach var="i" begin="1" end="5">
														<c:choose>
															<c:when test="${i == 1}">
																<c:set var="imageName" value="${vo.image1}" />
															</c:when>
															<c:when test="${i == 2}">
																<c:set var="imageName" value="${vo.image2}" />
															</c:when>
															<c:when test="${i == 3}">
																<c:set var="imageName" value="${vo.image3}" />
															</c:when>
															<c:when test="${i == 4}">
																<c:set var="imageName" value="${vo.image4}" />
															</c:when>
															<c:when test="${i == 5}">
																<c:set var="imageName" value="${vo.image5}" />
															</c:when>
														</c:choose>

														<div class="image-preview-wrapper">
															<c:choose>

																<c:when test="${not empty imageName}">
																	<div class="image-preview"
																		id="imagePreview_${vo.product_id}_${i}"
																		onclick="triggerImageUpload('${vo.product_id}', ${i})">
																		<img id="previewImg_${vo.product_id}_${i}"
																			src="${pageContext.request.contextPath}/resources/${fn:escapeXml(imageName)}"
																			alt="이미지 미리보기" style="display: block;">
																		<div class="no-image-text"
																			id="noImageText_${vo.product_id}_${i}"
																			style="display: none;">+</div>
																	</div>
																</c:when>

																<c:otherwise>
																	<div class="image-preview"
																		id="imagePreview_${vo.product_id}_${i}"
																		onclick="triggerImageUpload('${vo.product_id}', ${i})">
																		<img id="previewImg_${vo.product_id}_${i}" src="#"
																			alt="이미지 미리보기" style="display: none;">
																		<div class="no-image-text"
																			id="noImageText_${vo.product_id}_${i}"
																			style="display: block;">+</div>
																	</div>
																</c:otherwise>
															</c:choose>


														</div>
														<div class="image-upload-controls">
															<input type="file" id="imageInput_${vo.product_id}_${i}"
																name="images" accept="image/*"
																data-product-id="${vo.product_id}"
																style="display: none;">
															<button type="button" class="btn-file-delete"
																onclick="deleteImage('${vo.product_id}', ${i})">삭제</button>
														</div>
														<!-- image-preview-wrapper 닫기 -->

													</c:forEach>

												</div>
												<!-- image-upload-container 닫기 -->
												<div class="image-info" id="imageInfo">이미지는 최대 5개까지
													가능합니다.</div>
											</div> <!-- image-wrapper 닫음 -->
										</td>
									</tr>
								</table>
							</div>

						</div>

						<div class="search-buttons">
							<button class="btn-submit" data-product-id="${vo.product_id}"
								onclick="submitProduct('${vo.product_id}')">수정</button>
							<button class="btn-reset" onclick="history.back()">취소</button>

						</div>
					</div>
				</c:forEach>
			</div>
		</div>
	</div>
</body>
</html>