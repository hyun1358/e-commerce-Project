<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>footer</title>
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resources/homepage/css/homeFooter.css" />
</head>

<body>
	<footer>
		<div class="container">

			<div class="left">
				<h2>KH정보교육원</h2>
				<p>강남점 3관 : 서울특별시 강남구 테헤란로 130 호산빌딩</p>
				<div class="sns_img">
					<i class="fab fa-twitter"></i> <i class="fab fa-facebook-square"></i>
					<i class="fab fa-instagram"></i> <i class="fab fa-github"></i>
				</div>
			</div>

			<div class="right">
				<div class="list social">
					<h3>소셜로그인</h3>
					<ul>
						<li>ⓒ NAVER Corp.</li>
						<li>ⓒ Kakao Corp.</li>
						<li>ⓒ Google Corp.</li>
					</ul>
				</div>


				<div class="list">
					<h3>연락처</h3>
					<ul>
						<li>이메일 goodluck@test.com</li>
						<li>전화번호 070-1111-1111</li>
						<li>Fax 11111111</li>

					</ul>
				</div>


			</div>
		</div>

		<div class="copy_right">
			<div class="left-links">
				<div class="top-links">
					<div>전체서비스</div>
					<div>개인정보처리방침</div>
					<div>이용약관</div>
					<div>고객센터</div>
				</div>
				<div class="bottom-copy">© 2025 GoodLuck Co. All rights
					reserved.</div>
			</div>

			<div class="footer-inner">
				<a href="${pageContext.request.contextPath}/admin/login_form">관리자 로그인</a>
			</div>
		</div>
	</footer>

</body>
</html>