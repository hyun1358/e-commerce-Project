<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>배송 상태</title>
  <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/users/orders/css/delivery_progress.css">
  <script src="${pageContext.request.contextPath}/resources/users/orders/script/delivery_progress.js" defer></script>
  
</head>
<body>
<div class="shipping-status-container">
    <div class="status-line"></div>
    <div class="progress-line" id="progressLine"></div>
    <div class="status-step active" id="payment">
      <div class="status-circle">1</div>
      <div class="status-text">결제완료</div>
    </div>
    <div class="status-step" id="preparing">
      <div class="status-circle">2</div>
      <div class="status-text">상품준비중</div>
    </div>
    <div class="status-step" id="shipping">
      <div class="status-circle">3</div>
      <div class="status-text">배송시작</div>
    </div>
    <div class="status-step" id="delivering">
      <div class="status-circle">4</div>
      <div class="status-text">배송중</div>
    </div>
    <div class="status-step" id="delivered">
      <div class="status-circle">5</div>
      <div class="status-text">배송완료</div>
    </div>
  </div>
</body>
</html>