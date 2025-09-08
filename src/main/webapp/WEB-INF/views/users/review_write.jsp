<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>리뷰 작성</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/users/css/review_write.css">
    <script src="${pageContext.request.contextPath}/resources/users/script/review_write.js"></script>
</head>
<body>
<jsp:include page="../homepage/homeHeader.jsp" />
<div class="review-container">
    <h2>리뷰 작성</h2>
    <form action="review/regist" method="post" enctype="multipart/form-data">
    <!--  이미지 업로드가 가능하도록 처리됨. -->
    <input type="hidden" name="returnUrl" value="${ returnUrl }">
    <input type="hidden" name="order_id" value="${ order_id }">
        <div class="product-info">
            <img src="${pageContext.request.contextPath}/resources/${vo.image1}" alt="상품 이미지" class="product-image">
            <p class="product-name">${vo.product_name }</p>
            <input type="hidden" name="product_id" value="${ vo.product_id }"> 
        </div>
        <div class="form-group">
            <div class="rating">
                <span data-value="1">★</span>
                <span data-value="2">★</span>
                <span data-value="3">★</span>
                <span data-value="4">★</span>
                <span data-value="5">★</span>
            </div>
            <input type="hidden" name="star_rating" id="rating" value="0">
        </div>
        <div class="form-group">
            <label for="title">제목</label>
            <input type="text" id="title" name="title" placeholder="제목을 입력해주세요" required>
        </div>
        <div class="form-group">
            <label for="content">내용</label>
            <pre><textarea id="content" name="content" rows="6" placeholder="내용을 입력해주세요" required ></textarea></pre>
        </div>
        <div class="form-group">
            <label for="photo">사진 첨부</label>
            <input type="file" id="photo" name="imageFile" accept="image/*">
        </div>
        <div class="button-group">
            <button type="button" class="btn cancel" onclick="history.go(-1)">취소</button>
         	<button type="submit" class="btn submit">등록</button>
        </div>
    </form>
</div>
<jsp:include page="../homepage/homeFooter.jsp"></jsp:include>
</body>
</html>