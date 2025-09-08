<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>장바구니</title>
<!-- contextPath 먼저 선언 -->
<script> var contextPath = "${pageContext.request.contextPath}"; </script>

<!-- CSS -->
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resources/users/css/shopping_cart.css" />

<!-- JS (외부 스크립트) -->
<script
	src="${pageContext.request.contextPath}/resources/users/script/shopping_cart.js"
	defer></script>
<script src="${pageContext.request.contextPath}/resources/ajax/httpRequest.js"></script>

<script>
	let contextBtn = null;
	/* 수량 변경 회원 */
	function c_update(btn) 
	{
		contextBtn = btn; // 버튼을 저장
		let f = btn.form
		let quantity = f.quantity.value.trim();
		let cart_id = f.cart_id.value;
		
		if (!f.user_idx || f.user_idx.value === "") {// 비회원용 처리
	        updateGuestCart(f.product_id.value, quantity);
	    }else{
			let url = "cnt_update_ajax.do"
			let param = "user_idx=" + f.user_idx.value + "&cart_id=" + cart_id
				+ "&quantity=" + quantity	
			sendRequest(url, param, resFn, "post");
	    }
	}
	
	/* 수량 변경 비회원 */
	function updateGuestCart(product_id, quantity) {
		const url = contextPath + "/guest/cart/update";
	    const param = "product_id=" + product_id + "&quantity=" + quantity
	    sendRequest(url, param, resFn, "post");
	}

	/* 쓰레기통 모양눌렀을때 회원 */
	function delProduct(cart_id, user_idx, product_id){
		const isGuest = !user_idx || user_idx === "null" || user_idx === "undefined" || user_idx === "";
		
		if(isGuest){
			 deleteGuestCart(product_id);
		}
		else{
			let url="cart_del_one.do"
			let param = 'cart_id=' + cart_id + '&user_idx=' + user_idx;
				
			sendRequest(url, param, delFn, "post");
		}
	}
	
	/* 쓰레기통 모양눌렀을때 비회원 */
	function deleteGuestCart(product_id) {
	    let url = contextPath +"/guest/cart/delete";
	    let param = "product_id="+product_id;
	    sendRequest(url, param, delFn, "post");
	}
	
	
	/* 선택삭제 눌렀을때 회원*/
	function delSelectedProducts(user_idx) {
	    const checkboxes = document.querySelectorAll('input[type="checkbox"][id^="item_check_"]:checked');

	    if (checkboxes.length === 0) {
	        alert("삭제할 상품을 선택하세요.");
	        return;
	    }
	    const isGuest = !user_idx || user_idx === "null" || user_idx === "undefined" || user_idx === "";

	    if (isGuest) {
	        let productIds = Array.from(checkboxes).map(cb => cb.dataset.productId);
	        deleteGuestSelected(productIds);
	    }else{
	    	 // cart_id 목록 수집
		    let cartIds = Array.from(checkboxes).map(cb => cb.id.replace("item_check_", ""));

		    let url = "cart_del_selected.do";
		    let param = "user_idx=" + user_idx + "&cart_ids=" + cartIds.join(",");

		    sendRequest(url, param, delSelectedFn, "post");	
	    } 
	    
	}
	/* 선택삭제 눌렀을때 비회원*/
	function deleteGuestSelected(productIds) {
	    const url = contextPath +"/guest/cart/deleteSelected";
	    const param = "product_ids=" + productIds.join(",");
	    sendRequest(url, param, delSelectedFn, "post");
	}
	
	//------ callback함수 --------
	
	/* 선택삭제 ->비회원/회원 */
	function delSelectedFn() {
	    if (xhr.readyState === 4 && xhr.status === 200) {
	        let data = xhr.responseText;
	        let res = new Function('return ' + data)(); // JSON 파싱

	        if (res[0].result === "success") {
	           //updateTotals(res[0].total_cnt, res[0].total_amount);
	           updateTotalsFromCheckedItems()
	           saveCheckStates(); // ✅ 체크 상태 저장
	           location.reload(); // 페이지 새로고침 
	            
	        } else {
	            alert("선택 삭제 실패");
	        }
	    }
	}
	
	/* 쓰레기통 ->비회원/회원 */
	function delFn() {
		if (xhr.readyState === 4 && xhr.status === 200) {
			let data = xhr.responseText;
			let res = new Function('return ' + data)()

			if (res[0].result === "success") {
				// ✅ 화면의 총 수량, 총 금액 동적으로 갱신
				
				//updateTotals(res[0].total_cnt, res[0].total_amount);
				updateTotalsFromCheckedItems()
				saveCheckStates(); // ✅ 체크 상태 저장
				location.reload(); // 페이지 새로고침
				
			} else {
				alert("삭제 실패");
			}
		}
	}
	
	/* 수량변경 비회원/회원 */
	function resFn() {
		if (xhr.readyState === 4 && xhr.status === 200) {
			let data = xhr.responseText;
			let res = new Function('return ' + data)()

			if (res[0].result === "success") {
				//화면의 총 수량, 총 금액 동적으로 갱신
				//updateTotals(res[0].total_cnt, res[0].total_amount);
			 	updateTotalsFromCheckedItems()
	            saveCheckStates(); // ✅ 체크 상태 저장
	            location.reload(); // 페이지 새로고침 
	            
			} else {
				alert("수량 변경 실패");
				//수정 실패 시 원래 수량 복원
				/* const form = event.target.form; */
				const form = btn.form;
				form.quantity.value = res[0].original_quantity;
			}
		}
	}
	
	
	function selectPayment(user_idx) {
	    const checkboxes = document.querySelectorAll('input[type="checkbox"][id^="item_check_"]:checked');

	    if (checkboxes.length === 0) {
	        alert("구매할 상품을 선택하세요.");
	        return;
	    }

	    // cart_id 목록 수집
		let cartIds = Array.from(checkboxes).map(cb => cb.id.replace("item_check_", ""));
		
		location.href='payment_page.do?user_idx=' + user_idx + '&cart_ids=' + cartIds.join(",");
	    
	}
	
/* 	function selectPayment(user_idx) {
	    const checkboxes = document.querySelectorAll('input[type="checkbox"][id^="item_check_"]:checked');

	    if (checkboxes.length === 0) {
	        alert("구매할 상품을 선택하세요.");
	        return;
	    }

	    const isLoggedIn = document.body.dataset.user === "member";

	    let cartIds = Array.from(checkboxes).map(cb => cb.id.replace("item_check_", ""));

	    if (isLoggedIn) {
	        location.href = 'payment_page.do?user_idx=' + user_idx + '&cart_ids=' + cartIds.join(",");
	    } else {
	        location.href = 'login_form?returnUrl=cart_list.do';
	    }
	} */
	
	
	function increaseQuantity(btn) {
	    const input = btn.parentElement.querySelector('.quantity_count');
	    input.value = parseInt(input.value) + 1;
	    c_update(input);
	}

	function decreaseQuantity(btn) {
	    const input = btn.parentElement.querySelector('.quantity_count');
	    let val = parseInt(input.value);
	    if (val > 1) input.value = val - 1;
	    c_update(input);
	} 
	
	
</script>


</head>

<body data-user="${empty user ? 'guest' : 'member'}">
	<jsp:include page="../homepage/homeHeader.jsp" />
	<div id="container">
		<div id="content">
			<div id="cart_head">
				<div class="cart_header">
					<h2 class="cart_title">장바구니</h2>
				</div>
			</div>
			<!--cart_head-->
			<div id="cart_body">
				<div id="body_left">
					<div class="cart_option_box">
						<ul class="ul_option">
							<li class="li_option"><span class="option_select"> <input
									id="all_select" type="checkbox" class="input_checkbox">
									<label for="all_select"><strong>전체선택</strong></label>
							</span></li>
							<li>
								<button class="select_delete"
									onclick="delSelectedProducts(${user.user_idx})">
									<span>선택삭제</span>
								</button>
							</li>
						</ul>
					</div>
					<div class="cart_content_box">
						<div class="basket_list">
							<h3 class="blind">장바구니 목록</h3>
							<div class="basket_event">
								<a href="${pageContext.request.contextPath}/category?category_id=${10}" class="event_banner"> <span
									class="event_text1">8월 11일 (월) 오전 9시</span> <span
									class="event_text2">event 기획전 보러가기</span> <img
									src="${pageContext.request.contextPath}/resources/users/image/event_notebook.png"
									alt="이벤트 이미지" />
								</a>
							</div>

							<div class="basket_item">
								<ul class="ul_list">
									<li class="li_list">
									<c:if test="${empty cart_list }">
									<div class="no-cart">장바구니에 담긴 상품이 없습니다.</div>
									</c:if>
									
									<c:forEach var="vo"
											items="${ cart_list }">
											<div class="item">
												<div class="item_select">
													<span class="item_area"> <c:choose>
															<c:when test="${vo.visible == 'false' or vo.stock lt 1}">

																<input type="checkbox" disabled
																	class="input_checkbox disabled" title="재고 없음" />
															</c:when>
															<%-- <c:when test="${not vo.visible or vo.stock lt 1}"> --%>

															<c:otherwise>
																<c:choose>
																	<c:when test="${not empty user }">
																		<input id="item_check_${vo.cart_id}" type="checkbox"
																			class="input_checkbox"
																			data-product-id="${vo.product_id}">
																	</c:when>

																	<c:otherwise>
																		<input id="item_check_${vo.product_id}"
																			type="checkbox" class="input_checkbox"
																			data-product-id="${vo.product_id}">
																	</c:otherwise>
																</c:choose>
															</c:otherwise>
														</c:choose>

													</span>
												</div>
												<div class="item_img">
													<div class="product-image">
														<c:choose>
															<c:when test="${vo.is_visible eq 'N'}">
																<img class="blurred-image"
																	src="${pageContext.request.contextPath}/resources/${vo.image1}"
																	alt="상품이미지" />
																<div class="sold-out-overlay">
																	<span class="sold-out-text">판매종료</span>
																</div>

															</c:when>
															<c:otherwise>

																<a
																	href="${pageContext.request.contextPath}/product_detail.do?product_id=${vo.product_id}">
																	<img
																	src="${pageContext.request.contextPath}/resources/${vo.image1}"
																	alt="상품이미지" />
																</a>

															</c:otherwise>
														</c:choose>
													</div>
													<%-- <a
														href="${pageContext.request.contextPath}/product_detail.do?product_id=${vo.product_id}">
														<img
														src="${pageContext.request.contextPath}/resources/${vo.image1}"
														alt="상품이미지" />
													</a> --%>
												</div>
												<div class="item_info">


													<div class="unit_delete">
														<!-- 비회원이면 cart_id가 0이고 대신 product_id 사용 -->
														<button type="button" class="trash">
															<img
																src="${pageContext.request.contextPath}/resources/users/image/trashimg.png"
																alt="쓰레기통"
																onclick="delProduct(${vo.cart_id}, '${empty user.user_idx ? '' : user.user_idx}', ${vo.product_id})">
															<span class="blind">상품 삭제</span>
														</button>
													</div>
													<dl class="unit_item">
														<dt>
															<strong class="blind">구매할 상품 상세정보</strong>
														</dt>
														<dd>
															<div class="unit_item_title">
																<%-- 																<c:choose>
																	<c:when test="${vo.is_visible eq 'N'}">
																		<span
																		class="item_name">${vo.product_name}</span>
																	</c:when>
																	<c:otherwise>
																	<a
																		href="${pageContext.request.contextPath}/product_detail.do?product_id=${vo.product_id}">
																		<strong class="blind">상품명</strong> <span
																		class="item_name">${vo.product_name}</span>

																	</a>
																	</c:otherwise>
																</c:choose> --%>
																<a
																	href="${pageContext.request.contextPath}/product_detail.do?product_id=${vo.product_id}">
																	<strong class="blind">상품명</strong> <span
																	class="item_name">${vo.product_name}</span>

																</a>
																<c:if test="${vo.stock lt vo.quantity}">
																	<div class="stock-warning">
																		<span style="color: red; font-weight: bold;">※
																			재고 부족 (현재 재고: ${vo.stock})</span>
																	</div>
																</c:if>
																<c:if test="${vo.visible == false}">
																	<span style="color: red; font-weight: bold;">※구매
																		불가</span>
																</c:if>


																<span class="item_detail_list"> <span
																	class="item_number">${ vo.company }</span> <span
																	class="item_detail">${fn:replace(vo.description," "," / ") }</span>
																	
																</span>
															</div>

															<form>
																<input type="hidden" name="user_idx"
																	value="${empty user.user_idx ? '' : user.user_idx}">
																<input type="hidden" name="cart_id"
																	value="${vo.cart_id}"> <input type="hidden"
																	name="product_id" value="${vo.product_id}">

																	<div class="unit_item_btn">
																		<c:choose>
																			<c:when
																				test="${vo.visible == 'false' or vo.stock lt vo.quantity}">
																				<!-- 재고 부족 시: 수량 수정 비활성화 -->
																				<button type="button" class="btn_minus" disabled>-</button>
																				<input type="text" class="quantity_count"
																					name="quantity" value="${vo.quantity}" title="수량입력"
																					readonly style="background-color: #f0f0f0;">
																				<button type="button" class="btn_plus" disabled>+</button>
																			</c:when>
																			<c:otherwise>
																				<!-- 정상 수량 조정 가능 -->
																				<button type="button" class="btn_minus"
																					onclick="decreaseQuantity(this)">-</button>
																				<input type="text" class="quantity_count"
																					name="quantity" value="${vo.quantity}" title="수량입력"
																					onchange="c_update(this)">
																				<button type="button" class="btn_plus"
																					onclick="increaseQuantity(this)">+</button>
																			</c:otherwise>
																		</c:choose>
																	</div>
															</form>


															<div class="unit_price">
																<strong class="blind">상품 금액</strong>

																<c:if test="${vo.is_visible eq 'Y'}">
																	<span class="amount_box"> <strong
																		class="text_value"><fmt:formatNumber
																				value="${ vo.amount }" type="number" /></strong> <span
																		class="text_won"><strong>원</strong></span>
																	</span>
																</c:if>
															</div>

														</dd>
													</dl>
												</div>
											</div>
											<!--item-->
										</c:forEach></li>
								</ul>
							</div>
							<!--basket_item-->
							<div class="cart_notice">
								<strong class="notice_title">유의사항</strong>
								<ul class="ul_notice">
									<li class="li_notice">택배배송은 재고/물류 상황에 따라 택배사에서 순차 배송해
										드립니다.</li>
									<li class="li_notice">미성년자의 제품 주문/결제에 대해 법정대리인이 미동의 시,
										미성년자 본인 또는 법정대리인이 주문을 취소할 수 있습니다.</li>
									<li class="li_notice">일부 제품에 대해서 결제 수단이 제한 될 수 있습니다.</li>
									<li class="li_notice">판매 종료되거나 품절된 제품은 별도 표기됩니다.</li>
								</ul>
							</div>
							<!-- cart_notice -->
						</div>
						<!--basket_list-->
					</div>
					<!--cart_content_box-->
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
											class="pay_number" id="total_count">0</strong> <span
											class="pay_unit"><strong>개</strong></span>
									</span></li>

									<li class="pay_list"><span class="pay_list_text">주문
											금액</span> <span class="pay_list_amount"> <strong
											class="pay_value" id="total_amount">0</strong> <span
											class="pay_won"><strong>원</strong></span>
									</span></li>
								</ul>
							</div>
							<!--order_body-->
							<div class="order_discount">
								<ul class="card_list">
									<li class="drop_option">
										<div class="drop_head">
											<span class="card_head">카드 혜택</span>
											<button type="button" class="btn_card">
												<img
													src="${pageContext.request.contextPath}/resources/users/image/exclamation.png"
													alt="느낌표">
											</button>
											<a href="#" class="dropButtonOpen"> <span class="blind">자세히보기</span>
											</a>
										</div> <!-- 할인 -->
										<div class="drop_body">
											<strong class="drop_body_title">결제일할인 / 캐시백</strong>
											<!-- 삼성할인 -->
											<div class="drop_list">
												<div class="card_check">
													<input id="btnRd1" type="checkbox" class="discount-check"
														data-card="samsung"> <label>삼성카드로 결제시 7%</label>
												</div>
												<span class="card_text"> <strong class="card_value"
													id="discount_samsung">0</strong> <span class="card_won">원</span>
												</span>
											</div>

											<!-- 롯데할인 -->
											<div class="drop_list">
												<div class="card_check">
													<input id="btnRd2" type="checkbox" class="discount-check"
														data-card="lotte"> <label>롯데카드로 결제시 7%</label>
												</div>
												<span class="card_text"> <strong class="card_value"
													id="discount_lotte">0</strong> <span class="card_won">원</span>
												</span>
											</div>


											<!-- 현대할인 -->
											<div class="drop_list">
												<div class="card_check">
													<input id="btnRd3" type="checkbox" class="discount-check"
														data-card="hyundai"> <label>현대카드로 결제시 7%</label>
												</div>
												<span class="card_text"> <strong class="card_value"
													id="discount_hyundai">0</strong> <span class="card_won">원</span>
												</span>
											</div>

											<!-- 국민할인 -->
											<div class="drop_list">
												<div class="card_check">
													<input id="btnRd4" type="checkbox" class="discount-check"
														data-card="kb"> <label>국민카드로 결제시 7%</label>
												</div>
												<span class="card_text"> <strong class="card_value"
													id="discount_kb">0</strong> <span class="card_won">원</span>
												</span>
											</div>

											<!-- 신한할인 -->
											<div class="drop_list">
												<div class="card_check">
													<input id="btnRd5" type="checkbox" class="discount-check"
														data-card="shinhan"> <label>신한카드로 결제시 7%</label>
												</div>
												<span class="card_text"> <strong class="card_value"
													id="discount_shinhan">0</strong> <span class="card_won">원</span>
												</span>
											</div>

											<!-- 우리할인 -->
											<div class="drop_list">
												<div class="card_check">
													<input id="btnRd6" type="checkbox" class="discount-check"
														data-card="woori"> <label>우리카드로 결제시 7%</label>
												</div>
												<span class="card_text"> <strong class="card_value"
													id="discount_woori">0</strong> <span class="card_won">원</span>
												</span>
											</div>

										</div>
									</li>
								</ul>
								<!--card_list-->
								<ul class="payment">
									<li>
										<div class="card_footer">
											<span class="total_text"><strong>결제 예정 금액</strong></span> <span
												class="total_payment"> <%-- <strong class="total_value"><fmt:formatNumber value="${total_amount}" type="number" /></strong> --%>

												<strong class="total_value" id="final_amount">0</strong> <span
												class="total_won"><strong>원</strong></span>
											</span>
										</div>
									</li>
								</ul>
								<!--payment-->
								<c:choose>
									<c:when test="${ not empty user }">
										<button id="btnOrder" type="button"
											onclick="selectPayment(${user.user_idx})">
											<strong>주문하기</strong>

										</button>
									</c:when>
									<c:otherwise>
										<c:url var="returnUrl" value="/cart_list.do">
										</c:url>
										<button id="btnOrder" type="button"
											onclick="location.href='login_form?returnUrl=${returnUrl}'">
											<strong>주문하기</strong>
										</button>

									</c:otherwise>

								</c:choose>

							</div>
							<!--order_discount-->
						</div>
						<!--order-->
					</div>
					<!--cart_order_box-->
				</div>
				<!--body_right-->
			</div>
			<!--cart_body-->
		</div>
		<!--content-->
	</div>
	<!--container-->
	<jsp:include page="../homepage/homeFooter.jsp"></jsp:include>
</body>
</html>