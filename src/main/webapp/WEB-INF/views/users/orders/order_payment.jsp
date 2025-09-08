<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>주문/결제</title>

<script>
	var contextPath = "${pageContext.request.contextPath}";
</script>

<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resources/users/orders/css/order_payment.css" />
<!-- JS (외부 스크립트) -->
<script
	src="${pageContext.request.contextPath}/resources/users/orders/script/order_payment.js"
	defer></script>
<!-- jQuery -->
<script type="text/javascript"
	src="https://code.jquery.com/jquery-1.12.4.min.js"></script>
<!-- iamport.payment.js -->
<script type="text/javascript"
	src="https://cdn.iamport.kr/js/iamport.payment-1.2.0.js"></script>

</head>
<body>

	<jsp:include page="../../homepage/homeHeader.jsp"></jsp:include>
	<div id="payment_window_container">
		<div id="payment_window_content">
			<div id="payment_window_head">
				<div class="payment_window_header">
					<h2 class="payment_window_title">주문/결제</h2>
				</div>
			</div>
			<!--payment_window_head-->
			<div id="payment_window_body">
				<div id="body_left">
					<div class="payment_window_list_box">
						<div class="option_title_bar">
							<span class="option_title_span"> <label
								for="option_title_text"><strong>주문상품</strong></label>
							</span>
						</div>
						<div class="payment_window_list">
							<h3 class="blind">주문/결제 목록</h3>
							<div class="payment_window_item">
								<ul class="ul_list">
									<c:forEach var="vo" items="${ cart_list }">
									<li class="li_list">
									
											<div class="item">
												<div class="item_img">
													<a href="#"> <img
														src="${pageContext.request.contextPath}/resources/${vo.image1}"
														alt="상품이미지">
													</a>
												</div>
												<div class="item_info">

													<dl class="unit_item">

														<dt>
															<strong class="blind">구매할 상품 상세정보</strong>
														</dt>

														<dd>
															<div class="unit_item_title">
																<a href="#"> <strong class="blind">상품명</strong> 
																	<span class="item_name">${vo.product_name}</span>
																</a> 
																<span class="item_detail_list"> 
																	<span class="item_number">${ vo.company }</span> 
																	<span class="item_detail">${fn:replace(vo.description," ", " / ") }</span>
																</span>
															</div>
															<div class="payment_amount">
																<ul class="ul_payment_amount">
																	<li class="li_payment_amount">수량</li>
																	<li class="li_payment_amount_bar"></li>
																	<li class="li_payment_amount">${ vo.quantity }개</li>
																</ul>
															</div>
															<div class="unit_price">
																<strong class="blind">상품 금액</strong> <span> <strong
																	class="text_value"><fmt:formatNumber
																			maxFractionDigits="0">${vo.amount}</fmt:formatNumber></strong>
																	<span class="text_won"><strong>원</strong></span>
															</div>
														</dd>
													</dl>
												</div>
											</div>
												<div class="item-summary" data-product-name="${vo.product_name}" data-product-id="${vo.product_id}" data-quantity="${vo.quantity}" data-amount="${vo.amount}">
												    <!-- 상품 내용 -->
												</div>
												</li>
										</c:forEach> 
									<!--item-->

								</ul>
							</div>
							<!--payment_window_item-->
						</div>
						<!-- payment_window_list -->
					</div>
					<!-- payment_window_list_box -->
					<div class="payment_window_delivery_box">
						<div class="option_title">
							<span class="option_title_span"> <label
								for="option_title_text"><strong>배송정보</strong></label>
							</span>
						</div>
						<div class="payment_window_delivery">
							<h3 class="blind">배송지 입력</h3>
							<div class="delivery_form">
								<form>
									<div class="form_row">
										<div id="user-data" data-email="${user.email}"></div>
										<div class="form_label">
											<label for="receiver_name">주문자</label>
										</div>
										<div class="form_input">
											<input type="text" id="receiver_name" name="receiver_name"
												value="<c:out value='${not empty user ? user.user_name : ""}'/>"
												placeholder="<c:out value='${empty user ? "주문자 이름을 입력하세요" : ""}'/>" readonly>
										</div>
									</div>
									<div class="form_row">
										<div class="form_label">
											<label for="receiver_phone">연락처</label>
										</div>
										<div class="form_input">
											<input type="tel" id="receiver_phone" name="receiver_phone"
												value="${not empty user ? user.phone : ''}"
												placeholder="${empty user ? '010-0000-0000' : ''}" readonly>
										</div>
									</div>
									<div class="form_row">
										<div class="form_label">
											<label for="receiver_zipcode">우편번호</label>
										</div>
										<div class="form_input zipcode_group">
											<input type="text" id="receiver_zipcode"
												name="receiver_zipcode"
												value="${not empty user ? user.zipcode : ''}"
												placeholder="${empty user ? '우편번호' : ''}" readonly>
											<button type="button" class="btn_find_address"
												id="btn_find_address" onclick="execDaumPostcode()">주소찾기</button>
											<script
												src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
										</div>

									</div>
									<div class="form_row">
										<div class="form_label">
											<label for="receiver_address1">기본주소</label>
										</div>
										<div class="form_input">
											<input type="text" id="receiver_address1"
												name="receiver_address1"
												value="${not empty user ? user.address1 : ''}"
												placeholder="${empty user ? '기본주소(도로명/지번)' : ''}" readonly>
										</div>
									</div>
									<div class="form_row">
										<div class="form_label">
											<label for="receiver_address2">상세주소</label>
										</div>
										<div class="form_input">
											<input type="text" id="receiver_address2"
												name="receiver_address2"
												value="${not empty user ? user.address2 : '' }"
												placeholder="${empty user ? '상세주소' : '' }">
										</div>
									</div>
									<div class="form_row">
										<div class="form_label">
											<label for="delivery_request">배송요청사항</label>
										</div>
										<div class="form_input">
											<select id="delivery_request" name="delivery_request">
												<option value="">배송 시 요청사항을 선택해주세요</option>
												<option value="문 앞에 놓아주세요">문 앞에 놓아주세요</option>
												<option value="경비실에 맡겨주세요">경비실에 맡겨주세요</option>
												<option value="배송 전 연락 바랍니다">배송 전 연락 바랍니다</option>
												<!-- <option value="direct">직접 입력</option>시간되는사람!! 손!! -->
											</select>
										</div>
									</div>
									<div class="form_row address_save_row">
										<div class="form_checkbox">
											<input type="checkbox" id="save_address" name="save_address">
											<label for="save_address">이 배송지를 기본 배송지로 저장</label>
										</div>
									</div>
								</form>
							</div>
						</div>
						<!--payment_window_delivery-->
					</div>
					<!-- payment_window_delivery_box -->
					<div class="payment_window_notice">
						<strong class="notice_title">유의사항</strong>
						<ul class="ul_notice">
							<li class="li_notice">택배배송은 재고/물류 상황에 따라 택배사에서 순차 배송해 드립니다.</li>
							<li class="li_notice">미성년자의 제품 주문/결제에 대해 법정대리인이 미동의 시, 미성년자
								본인 또는 법정대리인이 주문을 취소할 수 있습니다.</li>
							<li class="li_notice">일부 제품에 대해서 결제 수단이 제한 될 수 있습니다.</li>
							<li class="li_notice">판매 종료되거나 품절된 제품은 별도 표기됩니다.</li>
						</ul>
					</div>
				</div>
				<!--body_left-->



				<div id="body_right">
					<div class="cart_order_box">
						<h3 class="blind">최종 결제정보</h3>
						<div class="order">
							<div class="order_head">
								<strong class="text_title">결제정보</strong>
							</div>
							<!--order_head-->
							<div class="order_body">
								<ul class="payment_list">
									<li class="pay_list"><span class="pay_list_text">전체
											상품</span> <span class="pay_list_amount"> <strong
											class="pay_number">${total_cnt }</strong> <span
											class="pay_unit"><strong>개</strong></span>
									</span></li>
									<li class="pay_list"><span class="pay_list_text">주문
											금액</span> <span class="pay_list_amount"> <strong
											class="pay_value"><fmt:formatNumber>${ total_amount }</fmt:formatNumber></strong>
											<span class="pay_won"><strong>원</strong></span>
									</span></li>
									<li class="pay_list"><span class="pay_list_text">배송비</span>
										<span class="pay_list_amount"> <strong
											class="pay_value"></strong> <span class="pay_won"><strong>무료배송</strong></span>
									</span></li>
								</ul>
							</div>
							<!--order_body-->
							<div class="order_discount">
								<ul class="payment">
									<li>
										<div class="card_footer">
											<span class="total_text"><strong>결제 예정 금액</strong></span> <span
												class="total_payment"> <strong class="total_value"
												id="total_value"><fmt:formatNumber>${ total_amount }</fmt:formatNumber></strong>
												<span class="total_won"><strong>원</strong></span>
											</span>
										</div>
									</li>
								</ul>
								<!--payment-->
								<div class="agreement_section">
									<div class="agreement_all">
										<input type="checkbox" id="agree_all"> <label
											for="agree_all">주문 내용을 확인하였으며, 정보 제공 등에</label> <label
											for="agree_all">모두 동의합니다.</label>
									</div>
									<div class="agreement_details">
										<div class="agreement_item">
											<input type="checkbox" id="agree_purchase"
												class="agree_check"> <label for="agree_purchase">[필수]
												구매조건 및 결제대행 서비스 약관 동의</label> <a href="#" class="btn_detail">보기</a>
										</div>
										<div class="agreement_item">
											<input type="checkbox" id="agree_privacy" class="agree_check">
											<label for="agree_privacy">[필수] 개인정보 수집 및 이용 동의</label> <a
												href="#" class="btn_detail">보기</a>
										</div>
										<div class="agreement_item">
											<input type="checkbox" id="agree_third_party"
												class="agree_check"> <label for="agree_third_party">[필수]
												개인정보 제3자 제공 동의</label> <a href="#" class="btn_detail">보기</a>
										</div>
									</div>
								</div>
								<button id="btnOrder" type="button"
									data-product-name="<c:choose>
								        <c:when test='${fn:length(cart_list) == 1}'>
								        	${cart_list[0].product_name}
								        </c:when>
								        <c:when test='${fn:length(cart_list) > 1}'>
								        	${cart_list[0].product_name} 외 ${fn:length(cart_list) - 1}건
								        </c:when>
								    </c:choose>">
									<strong>결제하기</strong>
								</button>

							</div>
							<!--order_discount-->
						</div>
						<!--order-->
					</div>
					<!--cart_order_box-->
				</div>
				<!--body_right-->
			</div>
			<!--payment_window_body-->
		</div>
		<!--content-->
	</div>
	<!--container-->
	<jsp:include page="../../homepage/homeFooter.jsp"></jsp:include>

</body>
</html>