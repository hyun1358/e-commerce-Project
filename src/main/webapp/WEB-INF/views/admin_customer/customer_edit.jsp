<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resources/admin_customer/css/customer_edit.css" />
<script
	src="${pageContext.request.contextPath}/resources/admin_customer/script/customer_edit.js"></script>
</head>

<body>
	<jsp:include page="../admin_homepage/admin_homeHeader.jsp"></jsp:include>
	<div class="container">

		<!-- 사이드 메뉴 -->
		<jsp:include page="../admin_homepage/admin_navigation.jsp"></jsp:include>

		<div class="user-button-wrapper">
			<div class="tab-nav-vertical">
				<div>[회원번호] 회원ID</div>
				<c:forEach var="vo" items="${users}" varStatus="loop">
					<button type="button" class="tab-btn"
						onclick="showUserTab(${vo.user_idx})">
						<!-- ${loop.index + 1} -->
						[${ vo.user_idx }] ${ vo.user_id }
					</button>
				</c:forEach>
			</div>

			<div class="user-content-area">
				<c:forEach var="vo" items="${ users }">

					<div class="customer_edit_main user-tab"
						id="customer_${vo.user_idx}" style="display: none;">
						<div class="customer_edit">
							<h3 class="customer_text">회원 수정</h3>
							<p>회원번호 : ${ vo.user_idx } ( 회원ID : ${ vo.user_id } )</p>

							<div class="table_wrapper">
								<!-- 								<table class="displaySettings">
									<tr>
										<th colspan="2" class="table_title">표시 설정</th>
									</tr>
									
								</table> -->

								<table class="basicInformation">
									<tr>
										<th colspan="2" class="table_title">기본 정보</th>
									</tr>

									<tr>
										<th>아이디</th>
										<td><input type="text" name="user_id_${vo.user_idx}"
											value="${vo.user_id}"></td>
									</tr>
									<tr>
										<th>비밀번호</th>
										<td>
											<div class="password-wrapper">
												<input type="text" class="password-input secure"
													id="memberPassword_${vo.user_idx}"
													name="user_pwd_${vo.user_idx}" value="${vo.user_pwd}" />

												<button type="button"
													onclick="togglePassword(${vo.user_idx}, this)"
													class="password-toggle-icon">🔒</button>
											</div>
										</td>
									</tr>
									<tr>
										<th>이름(실명)</th>
										<td><input type="text" name="user_name_${vo.user_idx}"
											value="${vo.user_name}"></td>
									</tr>

									<tr>
										<th>가입일</th>
										<td><span class="readonly-data">${vo.regdate}</span></td>
									</tr>
									<tr>
										<th>가입 경로</th>
										<td>${vo.social }</td>
									</tr>

									<tr>
										<th>회원 상태</th>
										<td>
											<div class="radio-group">
												<label> <input type="radio"
													name="account_status_${vo.user_idx}" value="1"
													<c:if test="${vo.account_status eq 1}">checked</c:if>>활동
												</label> <label> <input type="radio"
													name="account_status_${vo.user_idx}" value="2"
													<c:if test="${vo.account_status eq 2}">checked</c:if>>휴면
												</label> <label> <input type="radio"
													name="account_status_${vo.user_idx}" value="3"
													<c:if test="${vo.account_status eq 3}">checked</c:if>>탈퇴
												</label>

												<!-- <c:if test="${vo.account_status == null}">checked</c:if> 그외 -->
											</div>

										</td>
									</tr>

									<tr>
										<th>연락처</th>
										<td><input type="text" name="phone_${vo.user_idx}"
											value="${vo.phone}"></td>
									</tr>
									<tr>
										<th>E-mail</th>
										<td><input type="text" name="email_${vo.user_idx}"
											value="${vo.email}"></td>
									</tr>
									<tr>
										<th>생년월일</th>
										<td><input type="text" name="birth_${vo.user_idx}"
											value="${fn:substring(vo.birth, 0, 10)}"></td>
									</tr>

									<tr>
										<th>성별</th>
										<td>
											<div class="radio-group">
												<label> <input type="radio"
													name="gender_${vo.user_idx}" value="M"
													<c:if test="${vo.gender eq 'M'}">checked</c:if>>남자
												</label> <label> <input type="radio"
													name="gender_${vo.user_idx}" value="F"
													<c:if test="${vo.gender eq 'F'}">checked</c:if>>여자
												</label> <label> <input type="radio"
													name="gender_${vo.user_idx}" value="-"
													<c:if test="${vo.gender eq '-'}">checked</c:if>>비공개
												</label>
											</div>
										</td>
									</tr>

								</table>



								<table class="addressInformation">
									<tr>
										<th colspan="2" class="table_title">주소 정보</th>
									</tr>

									<tr>
										<th>주소</th>
										<td><input type="text" name="address1_${vo.user_idx}"
											value="${vo.address1}"></td>
									</tr>
									<tr>
										<th>상세주소</th>
										<td><input type="text" name="address2_${vo.user_idx}"
											value="${vo.address2}"></td>
									</tr>

								</table>

								<table class="memberMemo">
									<tr>
										<th colspan="2" class="table_title">메모</th>
									</tr>
									<tr>
										<th>메모</th>
										<td><textarea name="memoBox_${vo.user_idx}"
												class="memoBox"></textarea></td>
									</tr>
								</table>
							</div>
						</div>
						<div class="search-buttons">
							<button class="btn-submit" data-user-idx="${ vo.user_idx }"
								onclick="submitUser(${vo.user_idx })">수정</button>
							<button class="btn-reset" onclick="history.back()">취소</button>
						</div>
					</div>
				</c:forEach>
			</div>
		</div>
	</div>
</body>
</html>