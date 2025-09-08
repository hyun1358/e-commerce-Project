<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>product_details</title>
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resources/products/css/product_details.css">
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
<script>
   const contextPath = "${pageContext.request.contextPath}";
</script>
<script src="/final/resources/products/script/product_to_cart.js"></script>

<script>
window.onload = updateTotalPrice;
function increaseQuantity(btn) {
    const input = btn.parentElement.querySelector('.quantity_count');
    let val = parseInt(input.value);
     if(val > 98){
    	alert("수량은 99개까지만 가능합니다")
    	return;
    }
	input.value = val + 1;
	updateTotalPrice();
}

function decreaseQuantity(btn) {
    const input = btn.parentElement.querySelector('.quantity_count');
    let val = parseInt(input.value);
    if (val > 1) input.value = val - 1;
    updateTotalPrice();
} 

function goToPayment(user_idx,product_id) {
	 let quantity = document.querySelector('.quantity_count').value;	  
	  // URL을 제대로 문자열로 만듭니다.
	  location.href = "payment_page.do?user_idx=" + user_idx + "&product_id=" + product_id + "&quantity=" + quantity;
	}
	
	function updateTotalPrice() {
	const quantity = parseInt(document.querySelector('.quantity_count').value) || 0;
	const unitPrice = parseInt(document.getElementById('unitPrice').value);
	const total = quantity * unitPrice;

	// 숫자 포맷: 1,000 등으로 표시
	const formatted = new Intl.NumberFormat().format(total);

	document.getElementById('totalPrice').innerText = formatted + '원';
	}

</script>
</head>
<body>
	<jsp:include page="../homepage/homeHeader.jsp"></jsp:include>

	<main class="container">
		<section class="image-section">
				<img id="mainImage"
					src="${pageContext.request.contextPath}/resources/${vo.image1}"
					alt="대표 상품 이미지">
		</section>

		<section class="info-section">
			<p class="product_company">${ vo.company }</p>
			<h1>${ vo.product_name }</h1>
			<%-- 			<div class="rating"> 평점 ${review_avg}</div> --%>
			<%-- 			<c:set var="ratingInt" value="${ratingInt}" />
			
			<c:forEach var="i" begin="1" end="${ratingInt}">
			  <i class="fas fa-star filled"></i>
			</c:forEach>
			<c:forEach var="j" begin="${ratingInt + 1}" end="5">
			  <i class="far fa-star empty"></i>
			</c:forEach> --%>
			<div class="price">
			<p class="price_label" style="color: red; font-weight: normal; margin-left: 20px">
				<c:choose>
					<c:when test="${vo.discount_percent ne 0}">
						${vo.discount_percent}%
					</c:when>
					<c:otherwise>
						&nbsp; <!-- 공백 문자로 자리 유지 -->
					</c:otherwise>
				</c:choose>
			</p>
				<div class="price_values">
					<c:if test="${vo.sale_price != null && vo.sale_price != 0}">
						<span class="original_price"> <fmt:formatNumber
								value="${vo.price}" type="number" />원
						</span>
					</c:if>
					<span class="final_price" style="font-size: 25px; color: red;">
						<fmt:formatNumber value="${vo.final_price}" type="number" />원
					</span>
				</div>
			</div>

			
			<div class="product-options-container">
				<div class="product-spec-list"><pre>${ vo.description }</pre></div>
				
				<div class="quantity_box">
					<p class="quantity_label">수량 선택</p>
					<div class="quantity_controls">
						<button type="button" class="btn_minus"
							onclick="decreaseQuantity(this)">-</button>
						<input type="text" class="quantity_count" name="quantity"  oninput="updateTotalPrice()"
							value="1">
						<button type="button" class="btn_plus"
							onclick="increaseQuantity(this)">+</button>
					</div>
				</div>

				<input type="hidden" id="unitPrice" value="${vo.final_price}" />
				<div class="price">
					<p class="price_label">총 &nbsp;금액</p>
					<!-- 총 &nbsp;금액 -->

					<div class="price_values">
						<span class="final_price" id="totalPrice"> <fmt:formatNumber
								value="${vo.final_price}" type="number" />원
						</span>
					</div>
				</div>
			</div>
			<div class="buttons">
				<c:choose>
					<c:when test="${not empty user}">
						<!-- 회원일 때 -->
						<a href="#" id="heartBtn" class="heart-button" title="찜">
							<svg xmlns="http://www.w3.org/2000/svg"
								 class="bi bi-heart heart-icon" viewBox="0 0 16 16">
								<path d="m8 2.748-.717-.737C5.6.281 2.514.878 1.4 3.053c-.523 1.023-.641 2.5.314 4.385.92 1.815 2.834 3.989 6.286 6.357 3.452-2.368 5.365-4.542 6.286-6.357.955-1.886.838-3.362.314-4.385C13.486.878 10.4.28 8.717 2.01zM8 15C-7.333 4.868 3.279-3.04 7.824 1.143q.09.083.176.171a3 3 0 0 1 .176-.17C12.72-3.042 23.333 4.867 8 15" />
							</svg>
						</a>
						<a href="#"
							onclick="addCart(${vo.product_id}, ${user.user_idx}); return false;"
							class="cart-button">장바구니 담기</a>
						<a href="#"
                     			class="buy-button ${vo.stock == 0 ? 'sold-out' : ''}"
                     			onclick="${vo.stock == 0 ? 'return false;' : 'goToPayment('}${user.user_idx}, ${vo.product_id}); return false;">
                     			${vo.stock == 0 ? '품절' : '결제하기'}
                  		</a>
					</c:when>
					<c:otherwise>
						<!-- 비회원일 때 -->
						<a href="#"
		                     onclick="location.href='${pageContext.request.contextPath}/login_form'; return false;"
		                     class="heart-button" title="찜">
		                     <svg xmlns="http://www.w3.org/2000/svg"
		                          class="bi bi-heart heart-icon" viewBox="0 0 16 16">
		                        <path d="m8 2.748-.717-.737C5.6.281 2.514.878 1.4 3.053c-.523 1.023-.641 2.5.314 4.385.92 1.815 2.834 3.989 6.286 6.357 3.452-2.368 5.365-4.542 6.286-6.357.955-1.886.838-3.362.314-4.385C13.486.878 10.4.28 8.717 2.01zM8 15C-7.333 4.868 3.279-3.04 7.824 1.143q.09.083.176.171a3 3 0 0 1 .176-.17C12.72-3.042 23.333 4.867 8 15" />
		                     </svg>
		                </a>
						<a href="#"
							onclick="addGuestCart(${vo.product_id}); return false;"
							class="cart-button">장바구니 담기</a>

						<c:url var="returnUrl" value="/product_detail.do">
							<c:param name="product_id" value="${vo.product_id}" />
						</c:url>

						<!-- 이 returnUrl은 /product_detail.do?product_id=6 형식임 -->

						<a href="login_form?returnUrl=${returnUrl}" class="buy-button">결제하기</a>

					</c:otherwise>
				</c:choose>
			</div>
		</section>
	</main>

	<div class="product-detail-line"><span class="line-text">DETAILS</span></div>
		
	<div class="product-detail-container">
		<div class="product-detail-images" id="productDetailImages">
			<div class="detail-images">
				<img src="${pageContext.request.contextPath}/resources/${vo.image5}" alt="상품 상세 이미지">
			</div>	
		</div>
		<div class="more-button">	
			<button id="moreButton" onclick="toggleProductImages()">더보기</button>
		</div>	
	</div>

	<div class="review-head">
		<div class="product-detail-line"><span class="line-text">REVIEW | ${review_cnt }</span>
			<%-- <p class="review_title_text">REVIEW | ${review_cnt }</p> --%>
			<%-- <div class="review-summary">
				<div class="score">
					<i class="fas fa-star"></i> ${review_avg }
				</div>
				<div class="review-stats">
					<div class="bar1">
						<div></div>
						<span>5</span>
					</div>
					<div class="bar2">
						<div></div>
						<span>4</span>
					</div>
					<div class="bar3">
						<div></div>
						<span>3</span>
					</div>
					<div class="bar4">
						<div></div>
						<span>2</span>
					</div>
					<div class="bar5">
						<div></div>
						<span>1</span>
					</div>
				</div>
			</div> --%>
			<div class="review-summary">
			    <div class="score">
			        <!-- 별 아이콘 반복 출력 -->
			        <c:set var="ratingInt" value="${fn:split(review_avg, '.')[0]}" />
			        <c:forEach var="i" begin="1" end="${ratingInt}">
			            <i class="fas fa-star" style="color:#FFD700; font-size: 33px;"></i>
			        </c:forEach>
			        <c:forEach var="j" begin="${ratingInt + 1}" end="5">
			            <i class="far fa-star" style="color:#ccc; font-size: 33px;"></i>
			        </c:forEach>
			        
			        <!-- 숫자 평점 표시 -->
			        <span style="margin-left: 8px; font-size: 35px; font-weight: bold;">${review_avg}</span>
			    </div>
			</div>
		</div>
	</div>

	<div class="control-container">
		<select id="review-filter">
	        <option class="rec" value="newest">최신순</option>
	        <option class="ven" value="oldest">오래된순</option>
	        <option class="high" value="highest">평점높은순</option>
	        <option class="low" value="lowest">평점낮은순</option>
    </select>

		<!-- 팝업 모달 -->
		<div id="popup" class="detail-popup">
			<div class="popup-content">
				<span class="close-btn" id="closePopup">&times;</span>
				<h2>제품 부품 스펙</h2>
				<ul>
					<li><strong>CPU:</strong> Intel Core i7-13700K</li>
					<li><strong>GPU:</strong> NVIDIA RTX 4070 Ti</li>
					<li><strong>RAM:</strong> 32GB DDR5 6000MHz</li>
					<li><strong>Storage:</strong> 1TB NVMe SSD</li>
					<li><strong>Motherboard:</strong> ASUS Z790-P</li>
					<li><strong>Power Supply:</strong> 750W 80+ Gold</li>
					<li><strong>Case:</strong> Lian Li PC-O11 Dynamic</li>
				</ul>
			</div>
		</div>

		<div class="complain">
			<button id="estimateBtn" class="estimateBtn" onclick="compareSingleProduct('${pageContext.request.contextPath}/resources/${vo.image1}', '${fn:escapeXml(vo.product_name)}', '${vo.final_price}', '${vo.product_id}')">제품 견적</button>
			<c:choose>
				<c:when test="${ not empty user }">
					<a href="goinquiry.do?user_idx=${user.user_idx}"
						class="complain_button">문의하기</a>
				</c:when>
				<c:otherwise>
					<c:url var="returnUrl" value="/product_detail.do">
						<c:param name="product_id" value="${vo.product_id}" />
					</c:url>

					<a href="login_form?returnUrl=${returnUrl}" class="complain_button">문의하기</a>
				</c:otherwise>

			</c:choose>

		</div>
	</div>

	<div class="product-detail-lineOne"></div>

	<div class="review-container">
	<c:forEach var="rev" items="${ review_list }">
		<!-- 개별 리뷰 박스 -->
		<div class="review-box">
			<div class="review-header">
                <div class="user-section">
					<div class="user-info">
						<div class="user-avatar"></div>
            			<p>${rev.masked_user_id}</p>
            			<p class="review-date">${rev.regdate}</p>
         			</div>
         			<p class="product-info">제품이름 : ${ vo.product_name }</p>
         		</div>	
				<div class="rating-section">
					<div class="star-rating">
						<!-- 채워진 별 -->
						<c:forEach var="i" begin="1" end="${rev.star_rating}">
							<i class="fas fa-star filled"></i>
						</c:forEach>
						<!-- 빈 별 -->
						<c:forEach var="j" begin="${rev.star_rating + 1}" end="5">
							<i class="far fa-star"></i>
						</c:forEach>
					</div>
				</div>
			</div>
			<div class="review-content">
				<h3 class="review-title"><strong>${rev.title}</strong></h3>
				<div class="review-text"><pre>${rev.content}</pre></div>
				<div class="review-images">
					<c:if test="${not empty rev.image1}">
						<img src="${pageContext.request.contextPath}${rev.image1}" alt="리뷰 이미지">
					</c:if>
				</div>
			</div>
			<div class="admin-response">
				<span class="admin-badge"><strong>판매자 답변 :</strong></span>
				<p class="admin-text">안녕하세요 고객님! 만족해주셔서 감사합니다 😊</p>
			</div>
		</div>
      </c:forEach>
	</div>
	
	<div class="pagination">
	  <c:out value="${paging_html}" escapeXml="false"/>
	</div>
	
	<jsp:include page="../products/modal.jsp"></jsp:include>
	<jsp:include page="../homepage/homeFooter.jsp"></jsp:include>
	<script src="${pageContext.request.contextPath}/resources/products/script/product_details.js" defer></script>
	
</body>
</html>
