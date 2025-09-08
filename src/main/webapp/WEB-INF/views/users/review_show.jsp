<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>리뷰 수정</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/users/css/review_write.css">
    <script src="${pageContext.request.contextPath}/resources/users/script/review_show.js"></script>
</head>
<body>
<jsp:include page="../homepage/homeHeader.jsp" />

<div class="review-container">
    <h2>리뷰 수정</h2>
    <form action="${pageContext.request.contextPath}/review/modify" method="post" enctype="multipart/form-data">
        <input type="hidden" name="returnUrl" value="${ returnUrl }">
        <input type="hidden" name="order_id" value="${ reviewVO.order_id }">
        <input type="hidden" name="review_id" value="${ reviewVO.review_id }">
        <input type="hidden" name="image1" value="${reviewVO.image1}">

        <div class="product-info">
            <img src="${pageContext.request.contextPath}/resources/${productVO.image1}" alt="상품 이미지" class="product-image">
            <p class="product-name">${productVO.product_name }</p>
            <input type="hidden" name="product_id" value="${ productVO.product_id }">
        </div>

        <div class="form-group">
            <div class="rating">
                <span data-value="1">★</span>
                <span data-value="2">★</span>
                <span data-value="3">★</span>
                <span data-value="4">★</span>
                <span data-value="5">★</span>
            </div>
            <input type="hidden" name="star_rating" id="rating" value="${ reviewVO.star_rating }">
        </div>

        <div class="form-group">
            <label for="title">제목</label>
            <input type="text" id="title" name="title" value="${ reviewVO.title }" required>
        </div>

        <div class="form-group">
            <label for="content">내용</label>
            <pre><textarea id="content" name="content" rows="6" required >${ reviewVO.content }</textarea></pre>
        </div>

        <div class="form-group">
            <label for="photo">사진 첨부</label>
            <input type="file" id="photo" name="imageFile" accept="image/*">
        </div>

        <div class="button-group">
            <button type="button" class="btn cancel" onclick="history.go(-1)">취소</button>
            <button type="submit" class="btn submit">수정</button>
        </div>
    </form>
</div>

<jsp:include page="../homepage/homeFooter.jsp"></jsp:include>
</body>
</html>
