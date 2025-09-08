<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<html>
<head>
<meta charset="UTF-8">
<title>개인정보 수정</title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/users/css/user_mypage.css" />
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/users/css/user_edit.css" />
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script>
	let pwd_value = false;
	
	let user_pwd = "";
	function findPostcode()
	{
		new daum.Postcode({
	        oncomplete: function(data) 
	        {
	        	document.getElementById("zipcode").value = data.zonecode;
	        	document.getElementById("address1").value = data.roadAddress;
	        }
	    }).open();
	}
	function formatPhoneNumber(input)
	{
		let value = input.value.replace(/[^0-9]/g,'');
		console.log(value);
	}
	
	function pwd_check(input)
	{
		user_pwd = input.value;
	}
	
	function send(f) 
	{
		if (user_pwd !== "" && user_pwd.length < 6) 
		{
			alert("비밀번호는 6자 이상이어야 합니다.");
			return;
		}
		f.submit();
	}
</script>
</head>
<body>
	<jsp:include page="../homepage/homeHeader.jsp" />
	
	<c:if test="${not empty requestScope.msg}">
		<script>
			alert("${requestScope.msg}");
		</script>
	</c:if>
	
	<div class="container">
		<jsp:include page="../homepage/mypage_navigation.jsp" />
	
		<main class="main">
			<section class="user-edit-card">
				<h2 class="edit-title">개인정보 수정</h2>
				<form class="edit-form" action="user_update" method="post">
					<input type="hidden" id="user_idx" name="user_idx" value="${user.user_idx}">
					
					<table class="form-table">
						<tr>
							<th><label for="user_name">이름</label></th>
							<td>
								<input type="text" id="user_name" name="user_name" value="${user.user_name}" required />
							</td>
						</tr>
						
						<tr>
							<th><label for="email">이메일</label></th>
							<td>
								<input type="email" id="email" name="email" value="${user.email}" required />
							</td>
						</tr>
						
						<tr>
							<th><label for="phone">휴대폰 번호</label></th>
							<td>
								<input type="tel" id="phone" name="phone" value="${user.phone}" placeholder="숫자만 입력하세요" required oninput="this.value = this.value.replace(/[^0-9]/g, '');" maxlength="11"/>
							</td>
						</tr>
						
						<c:if test="${user.social eq 'local'}">
							<tr>
								<th><label for="user_pwd">비밀번호</label></th>
								<td>
									<input type="password" id="user_pwd" name="user_pwd" placeholder="6자 이상 입력하세요" oninput="pwd_check(this)"/>
									<div class="password-note">※ 비밀번호를 변경하려면 6자 이상 입력하세요. 변경하지 않으려면 비워두세요.</div>
								</td>
							</tr>
						</c:if>
						
						<c:if test="${user.social ne 'local'}">
							<input type="hidden" id="user_pwd" name="user_pwd" value="${user.user_pwd}"/>
						</c:if>
						
						<tr>
							<th><label for="zipcode">우편번호</label></th>
							<td>
								<div class="address-input-group">
									<input type="text" id="zipcode" name="zipcode" placeholder="우편번호" value="${user.zipcode}" readonly/>
									<button type="button" class="postcode-search-btn" onclick="findPostcode()">주소찾기</button>
								</div>
							</td>
						</tr>
						
						<tr>
							<th><label for="address1">주소</label></th>
							<td>
								<input type="text" id="address1" name="address1" placeholder="주소" value="${user.address1}" readonly/>
							</td>
						</tr>
						
						<tr>
							<th><label for="address2">상세주소</label></th>
							<td>
								<input type="text" id="address2" name="address2" placeholder="상세주소 입력" value="${user.address2}"/>
							</td>
						</tr>
					</table>
					
					<div class="form-actions">
						<button type="reset" class="cancel-btn">초기화</button>
						<button type="button" class="save-btn" onclick="send(this.form)">저장</button>
					</div>
				</form>
			</section>
		</main>
	</div>
	<jsp:include page="../homepage/homeFooter.jsp" />
</body>
</html>