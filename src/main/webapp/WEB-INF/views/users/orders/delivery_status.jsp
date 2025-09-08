<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ taglib  prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>주문 상세 내역</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/users/orders/css/delivery_status.css">
</head>
<body>
    <div class="container">
        <header class="page-header">
            <h1>배송 상세</h1>
            <p>주문번호: ${order.order_id}</p>
        </header>

        <main>
            <!-- 배송 상태 진행 바 -->
            <section class="card progress-card" data-status="${order.status}">
                <div class="progress-steps">
                    <div class="step" data-step="결제완료">
                        <div class="step-icon"></div><span class="step-label">결제완료</span>
                    </div>
                    <div class="step-line"></div>
                    <div class="step" data-step="상품준비중">
                        <div class="step-icon"></div><span class="step-label">상품준비중</span>
                    </div>
                    <div class="step-line"></div>
                    <div class="step" data-step="배송시작">
                        <div class="step-icon"></div><span class="step-label">배송시작</span>
                    </div>
                    <div class="step-line"></div>
                    <div class="step" data-step="배송중">
                        <div class="step-icon"></div><span class="step-label">배송중</span>
                    </div>
                    <div class="step-line"></div>
                    <div class="step" data-step="배송완료">
                        <div class="step-icon"></div><span class="step-label">배송완료</span>
                    </div>
                </div>
            </section>

            <!-- 주문 상품 정보 -->
            <section class="card">
                <h2>주문 상품 정보</h2>
                <div class="product-list">
                    <div class="product-item">
                        <img src="${pageContext.request.contextPath}/resources/${product.image1}" alt="${product.product_name}" class="product-image">
                        <div class="product-info">
                            <p class="product-brand">${product.company}</p>
                            <p class="product-name">${product.product_name}</p>
                            <p class="product-option">${fn:replace(product.description," "," / ") }</p>
                        </div>
                        <div class="product-quantity">${detail.quantity}개</div>
                        <div class="product-price">${detail.amount}원</div>
                    </div>
                </div>
            </section>

            <div class="info-grid">
                <!-- 배송지 정보 -->
                <section class="card">
                    <h2>배송지 정보</h2>
                    <dl class="info-list">
                        <dt>받는 분</dt><dd>${order.shipping_name}</dd>
                        <dt>연락처</dt><dd>${order.shipping_phone}</dd>
                        <dt>주소</dt><dd>(${order.zipcode}) ${order.address1}</dd>
                        <dt>배송 메모</dt><dd>${order.request}</dd>
                    </dl>
                </section>

                <!-- 최종 결제 정보 -->
                <section class="card">
                    <h2>최종 결제 정보</h2>
                    <dl class="info-list payment-summary">
                        <dt>총 상품 금액</dt>
                        <dd id="totalPrice">${detail.amount}원</dd>
                        
                        <dt>배송비</dt>
                        <dd id="deliveryPrice">무료배송</dd>
                        
                        <!-- <dt>포인트 사용</dt>
                        <dd class="discount" id="pointPrice">- 0원</dd> -->
                        <hr>
                        <dt class="total">총 결제 금액</dt>
                        <dd class="total-amount">${detail.amount}원</dd>
                    </dl>
                </section>
            </div>

            <div class="page-actions">
                <button type="button" class="btn btn-secondary" onclick="history.back()">목록으로</button>
            </div>
        </main>
    </div>

    <script src="${pageContext.request.contextPath}/resources/users/orders/script/delivery_status.js"></script>
</body>
</html>