<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>고객지원</title>
		<script>   	
    		var contextPath = "${pageContext.request.contextPath}";
		</script>
		
		<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/support/css/customer_service.css"/>
		<script src="${pageContext.request.contextPath}/resources/support/script/customer_service.js" defer></script>
	</head>
	
	<body>
		<jsp:include page="../homepage/homeHeader.jsp"></jsp:include>
		<div class="customer_service_container">
		    <!-- Banner Section -->
		    <div class="banner-container">
		        <img class="banner-img" src="${pageContext.request.contextPath}/resources/support/image/notice2.png" style="filter:blur(3px);" alt="고객서비스 배너 이미지"/>
		        <div class="banner-text">
		            <h1>고객 서비스</h1>
		            <p>Good Luck 제품관련 소식 및 안내사항을 확인하세요.</p>
		        </div>
		    </div>
		
		    <!-- Card Section -->
		    <div class="card-container">
		        <!-- FAQ 카드 -->
		        <div class="card" onclick="location.href='${pageContext.request.contextPath}/support/faq'">
		            <div class="card-icon">
		                <svg xmlns="http://www.w3.org/2000/svg" width="28" height="28" viewBox="0 0 24 24" fill="none" stroke="#4070f4" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
		                    <circle cx="12" cy="12" r="10"></circle>
		                    <path d="M9.09 9a3 3 0 0 1 5.83 1c0 2-3 3-3 3"></path>
		                    <line x1="12" y1="17" x2="12.01" y2="17"></line>
		                </svg>
		            </div>
		            <div class="card-content">
		                <div class="card-title">자주 묻는 질문 (FAQ)</div>
		                <div class="card-description">자주 물어보시는 질문들을 확인해보세요</div>
		            </div>
		            <div class="card-arrow">›</div>
		        </div>
		
		        <!-- 공지사항 카드 -->
		        <div class="card" onclick="location.href='${pageContext.request.contextPath}/support/notice'">
		            <div class="card-icon">
		                <svg xmlns="http://www.w3.org/2000/svg" width="28" height="28" viewBox="0 0 24 24" fill="none" stroke="#4070f4" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
		                    <path d="M22 17H2a3 3 0 0 0 3-3V9a7 7 0 0 1 14 0v5a3 3 0 0 0 3 3zm-8.27 4a2 2 0 0 1-3.46 0"></path>
		                </svg>
		            </div>
		            <div class="card-content">
		                <div class="card-title">공지사항</div>
		                <div class="card-description">쇼핑몰의 최신 소식과 업데이트를 확인하세요</div>
		            </div>
		            <div class="card-arrow">›</div>
		        </div>
		
		        <!-- 1:1 문의하기 카드 -->
		        <div class="card" onclick="location.href='${pageContext.request.contextPath}/goinquiry.do?user_idx=${user.user_idx}'">
		            <div class="card-icon">
		                <svg xmlns="http://www.w3.org/2000/svg" width="28" height="28" viewBox="0 0 24 24" fill="none" stroke="#4070f4" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
		                    <path d="M21 15a2 2 0 0 1-2 2H7l-4 4V5a2 2 0 0 1 2-2h14a2 2 0 0 1 2 2z"></path>
		                </svg>
		            </div>
		            <div class="card-content">
		                <div class="card-title">1:1 문의하기</div>
		                <div class="card-description">자세한 상담이 가능해요</div>
		            </div>
		            <div class="card-arrow">›</div>
		        </div>
		
		        <!-- 나의 문의 내역 카드 -->
		        <div class="card" onclick="location.href='${pageContext.request.contextPath}/my_inquiryList'">
		            <div class="card-icon">
		                <svg xmlns="http://www.w3.org/2000/svg" width="28" height="28" viewBox="0 0 24 24" fill="none" stroke="#4070f4" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
		                    <path d="M14 2H6a2 2 0 0 0-2 2v16a2 2 0 0 0 2 2h12a2 2 0 0 0 2-2V8z"></path>
		                    <polyline points="14 2 14 8 20 8"></polyline>
		                    <line x1="16" y1="13" x2="8" y2="13"></line>
		                    <line x1="16" y1="17" x2="8" y2="17"></line>
		                    <polyline points="10 9 9 9 8 9"></polyline>
		                </svg>
		            </div>
		            <div class="card-content">
		                <div class="card-title">나의 문의 내역</div>
		                <div class="card-description">문의한 내용을 확인해보세요</div>
		            </div>
		            <div class="card-arrow">›</div>
		        </div>
		    </div>
		</div>
		<jsp:include page="../homepage/homeFooter.jsp"></jsp:include>
	</body>
</html>