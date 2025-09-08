<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>제품 상세 정보</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/products/css/product_details.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
    <script src="/final/resources/products/script/product_to_cart.js"></script>
    <script src="${pageContext.request.contextPath}/resources/users/script/shopping_cart.js" defer></script>
    <script>
        // 페이지 로드 시 총 가격 업데이트 및 카운트다운 시작
        window.onload = function() {
            updateTotalPrice();
            startCountdown();
        };

        // 수량 증가
        function increaseQuantity(btn) {
            const input = document.querySelector('.quantity-input');
            let val = parseInt(input.value);
            if (val > 98) {
                alert("수량은 99개까지만 가능합니다");
                return;
            }
            input.value = val + 1;
            updateTotalPrice();
        }

        // 수량 감소
        function decreaseQuantity(btn) {
            const input = document.querySelector('.quantity-input');
            let val = parseInt(input.value);
            if (val > 1) {
                input.value = val - 1;
            }
            updateTotalPrice();
        }

        // 결제 페이지로 이동
        function goToPayment(user_idx, product_id) {
            let quantity = document.querySelector('.quantity-input').value;
            location.href = "payment_page.do?user_idx=" + user_idx + "&product_id=" + product_id + "&quantity=" + quantity;
        }

        // 총 가격 업데이트
        function updateTotalPrice() {
            const quantity = parseInt(document.querySelector('.quantity-input').value) || 0;
            const unitPrice = parseInt(document.getElementById('unitPrice').value);
            const total = quantity * unitPrice;
            const formatted = new Intl.NumberFormat('ko-KR').format(total);
            document.getElementById('totalPrice').innerText = formatted + '원';
        }

        // 카운트다운 타이머
        function startCountdown() {
            const now = new Date().getTime();
            // 12시간 34분 56초 후 마감
            const endTime = now + (12 * 60 * 60 * 1000) + (34 * 60 * 1000) + (56 * 1000);

            const timer = setInterval(() => {
                const now = new Date().getTime();
                const distance = endTime - now;

                const hours = Math.floor((distance % (1000 * 60 * 60 * 24)) / (1000 * 60 * 60));
                const minutes = Math.floor((distance % (1000 * 60 * 60)) / (1000 * 60));
                const seconds = Math.floor((distance % (1000 * 60)) / 1000);

                document.getElementById('hours').textContent = hours.toString().padStart(2, '0');
                document.getElementById('minutes').textContent = minutes.toString().padStart(2, '0');
                document.getElementById('seconds').textContent = seconds.toString().padStart(2, '0');

                if (distance < 0) {
                    clearInterval(timer);
                    document.querySelector('.countdown-section').innerHTML =
                        '<div class="countdown-title"> 특가 행사가 종료되었습니다 </div>';
                }
            }, 1000);
        }
        
        // 버튼 클릭 효과
        document.addEventListener('DOMContentLoaded', function() {
            document.querySelectorAll('.buy-btn, .cart-btn').forEach(btn => {
                btn.addEventListener('click', function(e) {
                    // 기존 버튼 기능이 a 태그의 href나 onclick으로 처리되므로 ripple 효과만 추가
                    let ripple = document.createElement('span');
                    ripple.classList.add('ripple');
                    this.appendChild(ripple);

                    let x = e.clientX - e.target.getBoundingClientRect().left;
                    let y = e.clientY - e.target.getBoundingClientRect().top;

                    ripple.style.left = x + 'px';
                    ripple.style.top = y + 'px';

                    setTimeout(() => {
                        ripple.remove();
                    }, 600);
                });
            });
        });
    </script>
</head>
<body>
    <jsp:include page="../homepage/homeHeader.jsp"></jsp:include>

    <!-- 상단 알림 배너 -->
    <div class="top-banner">
        <i class="fas fa-fire"></i> 지금 주문하면 무료배송 + 추가 5% 할인 <i class="fas fa-fire"></i>
    </div>

    <!-- 메인 컨테이너 -->
    <div class="main-container">
        <!-- 특가 라벨 -->
        <div class="special-label">특가</div>

        <!-- 카운트다운 타이머 -->
        <div class="countdown-section">
            <div class="countdown-title"><i class="fas fa-clock"></i> 한정 특가 마감까지</div>
            <div class="countdown-timer">
                <div class="time-unit"><span class="time-number" id="hours">12</span><span class="time-label">시간</span></div>
                <div class="time-unit"><span class="time-number" id="minutes">34</span><span class="time-label">분</span></div>
                <div class="time-unit"><span class="time-number" id="seconds">56</span><span class="time-label">초</span></div>
            </div>
            <div>놓치면 후회하는 기회 지금 바로 주문하세요</div>
        </div>

        <!-- 메인 상품 영역 -->
        <div class="product-section">
            <div class="image-section">
                <img src="${pageContext.request.contextPath}/resources/${vo.image1}" alt="${vo.product_name}" class="product-image">
                <div class="image-badges">
                    <div class="badge new">NEW</div>
                    <div class="badge hot">HOT</div>
                </div>
            </div>
            <div class="info-section">
                <p class="company-name">${vo.company}</p>
                <h1 class="product-title">${vo.product_name}</h1>

                <div class="rating-section">
                    <div class="stars">
                        <c:set var="ratingInt" value="${review_avg}" />
                        <c:forEach var="i" begin="1" end="${ratingInt}"><i class="fas fa-star"></i></c:forEach>
                        <c:forEach var="j" begin="${ratingInt + 1}" end="5"><i class="far fa-star"></i></c:forEach>
                    </div>
                    <span class="rating-text">${review_avg}/5.0 (${review_cnt}개 리뷰)</span>
                </div>

                <!-- 가격 섹션 -->
                <div class="price-section">
                    <c:if test="${vo.discount_percent ne 0}">
                        <div class="discount-badge">${vo.discount_percent}% OFF</div>
                    </c:if>
                    <c:if test="${vo.sale_price > 0}">
                        <div class="original-price">정가 <fmt:formatNumber value="${vo.price}" type="number" />원</div>
                    </c:if>
                    <div class="current-price"><fmt:formatNumber value="${vo.final_price}" type="number" />원</div>
                    <div class="price-description">
                        <i class="fas fa-truck"></i> 무료배송 | <i class="fas fa-gift"></i> 사은품 증정
                    </div>
                </div>

                <!-- 재고 알림 -->
                <div class="stock-alert">
                    <div class="stock-text">⚡ 긴급 재고 알림 ⚡</div>
                    <div>현재 남은 수량: <span class="stock-count">${vo.stock}개</span></div>
                </div>
                
                <ul class="product-spec-list" style="list-style-type: none; padding-left: 0; margin-bottom: 15px;">
                  <c:forEach var="desc" items="${fn:split(vo.description, '/')}">
                    <li style="margin-bottom: 5px; color: #555;">- ${desc}</li>
                  </c:forEach>
                </ul>
                
                <select class="option_select" style="width: 100%; padding: 10px; border-radius: 5px; border: 1px solid #ddd; margin-bottom: 15px;">
                    <option class="red">레드</option>
                    <option class="blue">블루</option>
                    <option class="green">그린</option>
                    <option class="white">화이트</option>
                    <option class="black">블랙</option>
                </select>

                <!-- 수량 선택 -->
                <div class="quantity-section">
                    <span class="quantity-label">수량:</span>
                    <div class="quantity-controls">
                        <button class="quantity-btn" onclick="decreaseQuantity(this)">-</button>
                        <input type="number" class="quantity-input" name="quantity" value="1" min="1" max="99">
                        <button class="quantity-btn" onclick="increaseQuantity(this)">+</button>
                    </div>
                    <div class="total-price">
                        총 금액: <span id="totalPrice"><fmt:formatNumber value="${vo.final_price}" type="number" />원</span>
                    </div>
                </div>
                <input type="hidden" id="unitPrice" value="${vo.final_price}" />

                <!-- 버튼 영역 -->
                <div class="button-section">
                    <c:choose>
                        <c:when test="${not empty user}">
                            <a href="#" onclick="addCart(${vo.product_id}, ${user.user_idx}); return false;" class="cart-btn"><i class="fas fa-shopping-cart"></i> 장바구니</a>
                            <a href="#" onclick="goToPayment(${user.user_idx}, ${vo.product_id}); return false;" class="buy-btn"><i class="fas fa-bolt"></i> 지금 주문하기</a>
                        </c:when>
                        <c:otherwise>
                            <a href="#" onclick="addGuestCart(${vo.product_id}); return false;" class="cart-btn"><i class="fas fa-shopping-cart"></i> 장바구니</a>
                            <c:url var="returnUrl" value="/product_detail.do"><c:param name="product_id" value="${vo.product_id}" /></c:url>
                            <a href="login_form?returnUrl=${returnUrl}" class="buy-btn"><i class="fas fa-bolt"></i> 지금 주문하기</a>
                        </c:otherwise>
                    </c:choose>
                </div>

                <!-- 고객 혜택 -->
                <div class="benefits-section">
                    <div class="benefits-title">특별 혜택</div>
                    <div class="benefit-item"><i class="fas fa-shipping-fast benefit-icon"></i><span>전국 무료배송 (당일발송)</span></div>
                    <div class="benefit-item"><i class="fas fa-shield-alt benefit-icon"></i><span>3년 무상 A/S 보장</span></div>
                    <div class="benefit-item"><i class="fas fa-undo benefit-icon"></i><span>30일 무료 교환/환불</span></div>
                    <div class="benefit-item"><i class="fas fa-phone benefit-icon"></i><span>24시간 고객상담 서비스</span></div>
                </div>
            </div>
        </div>

        <!-- 리뷰 섹션 -->
        <div class="review-section">
            <div class="review-header">
                <h2 class="review-title">실제 고객 리뷰</h2>
                <div class="review-summary">
                    <div class="review-score">${review_avg}</div>
                    <div class="review-stars">
                         <c:set var="ratingInt" value="${review_avg}" />
                        <c:forEach var="i" begin="1" end="${ratingInt}"><i class="fas fa-star"></i></c:forEach>
                        <c:forEach var="j" begin="${ratingInt + 1}" end="5"><i class="far fa-star"></i></c:forEach>
                    </div>
                    <div>(${review_cnt}개 리뷰)</div>
                </div>
            </div>
            
            <div class="control-container" style="display: flex; justify-content: space-between; align-items: center; margin-bottom: 20px;">
                <select style="padding: 8px; border-radius: 5px;">
                    <option class="rec">최신순</option>
                    <option class="ven">오래된순</option>
                    <option class="high">평점높은순</option>
                    <option class="low">평점낮은순</option>
                </select>
                <div class="complain">
                    <button id="estimateBtn" class="estimateBtn" style="padding: 8px 15px; border-radius: 5px; border: none; background-color: #6c757d; color: white; cursor: pointer; margin-right: 10px;">제품견적</button>
                    <c:choose>
                        <c:when test="${ not empty user }">
                            <a href="goinquiry.do?user_idx=${user.user_idx}" class="complain_button" style="padding: 8px 15px; border-radius: 5px; background-color: #333; color: white; text-decoration: none;">문의하기</a>
                        </c:when>
                        <c:otherwise>
                            <c:url var="returnUrl" value="/product_detail.do"><c:param name="product_id" value="${vo.product_id}" /></c:url>
                            <a href="login_form?returnUrl=${returnUrl}" class="complain_button" style="padding: 8px 15px; border-radius: 5px; background-color: #333; color: white; text-decoration: none;">문의하기</a>
                        </c:otherwise>
                    </c:choose>
                </div>
            </div>

            <c:forEach var="rev" items="${review_list}">
                <div class="review-box">
                    <div class="review-user">${rev.masked_user_id}</div>
                    <div class="review-stars">
                        <c:forEach var="i" begin="1" end="${rev.star_rating}"><i class="fas fa-star"></i></c:forEach>
                        <c:forEach var="j" begin="${rev.star_rating + 1}" end="5"><i class="far fa-star"></i></c:forEach>
                    </div>
                    <div class="review-content">
                        <strong>${rev.title}</strong><br>
                        ${rev.content}
                        <c:if test="${not empty rev.image1}">
                            <img src="${pageContext.request.contextPath}${rev.image1}" alt="리뷰 이미지" style="max-width: 100px; margin-top: 10px; border-radius: 5px;">
                        </c:if>
                    </div>
                     <p style="margin-top: 10px; padding-top: 10px; border-top: 1px solid #eee;"><strong>관리자 답변:</strong> 안녕하세요 고객님 만족해주셔서 감사합니다</p>
                </div>
            </c:forEach>
        </div>
    </div>

    <!-- 떠다니는 효과 요소들 -->
    <div class="floating-element floating-1"></div>
    <div class="floating-element floating-2">⚡</div>
    <div class="floating-element floating-3"></div>

    <jsp:include page="../products/modal.jsp"></jsp:include>
    <jsp:include page="../homepage/homeFooter.jsp"></jsp:include>
</body>
</html>
