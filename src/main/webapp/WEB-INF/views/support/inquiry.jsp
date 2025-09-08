<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>1:1문의</title>
		<script>   	
    		var contextPath = "${pageContext.request.contextPath}";
		</script>
		
		<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/support/css/inquiry.css"/>
		<script src="${pageContext.request.contextPath}/resources/support/script/inquiry.js" defer></script>
	</head>
	
	<body>
		<jsp:include page="../homepage/homeHeader.jsp"></jsp:include>
		<div class="container">
	        <h1>1:1문의</h1>
	        <div class="form-container">
	            <div class="title-underline">
	                <div class="required-note">*필수 입력 항목</div>
	            </div>
	
	            <form id="inquiryForm" action="form_inquiry_insert" method="post" enctype="multipart/form-data">
	                <div class="input-group">
	                    <label class="required">문의 유형</label>
	                    <select id="inquiryType" name="type" required>
	                        <option value="" selected>문의 유형을 선택해 주세요.</option>
	                        <option value="product">상품 문의</option>
	                        <option value="order">주문/결제 문의</option>
	                        <option value="shipping">배송 문의</option>
	                        <option value="return">교환/반품/취소 문의</option>
	                        <option value="other">기타 문의</option>
	                    </select>
	                </div>
	
	                <div class="input-group">
	                    <label class="required">제목</label>
	                    <input type="text" id="subject" name="title" placeholder="제목을 입력해 주세요." required>
	                </div>
	
	                <div class="input-group">
	                    <label class="required">내용</label>
	                    <textarea id="content" name="content" placeholder="내용을 입력해 주세요." maxlength="2000" required style="resize: none;"></textarea>
	                    <div class="char-count"><span id="charCount">0</span> / 2,000자</div>
	                </div>
	
	                <div class="input-group">
	                    <label>첨부</label>
	                    <label for="fileUpload" class="file-upload">
	                        <span>+</span>
	                        <input type="file" name="image" id="fileUpload" onchange="read(this)" multiple>
	                    </label>
	                    <div id="file-image-container">
	                    	
	                    </div>
	                    <div class="file-count">(0/4)</div>
	                </div>
	
	                <div class="divider"></div>
	
	                <div class="notice">※ 제품/서비스/멤버십 관련 문의는 상담전화(1544-9970)로 문의 바랍니다.</div>
	                <div class="notice">※ 주민등록번호, 연락처 등 민감정보는 개인정보 도용의 위험이 있으니 포함되지 않도록 주의해 주시기 바랍니다.</div>
	
	                <div class="button-group">
	                    <button type="button" class="btn btn-cancel" onclick="history.back();" >취소</button>
	                    <button type="submit" class="btn btn-submit">등록</button>
	                </div>
	            </form>
	        </div>
	    </div>
		<jsp:include page="../homepage/homeFooter.jsp"></jsp:include>
	</body>
</html>