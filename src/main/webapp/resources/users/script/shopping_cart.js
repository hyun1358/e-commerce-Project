// 체크박스 상태 저장
function saveCheckStates() {
	const checkboxes = document.querySelectorAll('input[type="checkbox"][id^="item_check_"]');
	const state = {};
	checkboxes.forEach(cb => {
		state[cb.id] = cb.checked;
	});

	const isLoggedIn = document.body.dataset.user === "member"; // ← 로그인 상태 확인하는 방식에 맞게 수정
	const key = isLoggedIn ? "cart_check_state" : "cart_check_state_guest";
	localStorage.setItem(key, JSON.stringify(state));
}


function restoreCheckStates() {

	const isLoggedIn = document.body.dataset.user === "member"; // ← 로그인 상태 확인하는 방식에 맞게 수정
	const key = isLoggedIn ? "cart_check_state" : "cart_check_state_guest";
	const saved = localStorage.getItem(key);
	if (!saved) return;
	const state = JSON.parse(saved);
	Object.entries(state).forEach(([id, checked]) => {
		const checkbox = document.getElementById(id);
		if (checkbox) checkbox.checked = checked;
	});
	//localStorage.removeItem("cart_check_state");

	// ✅ 복원된 체크박스 기준으로 계산 실행
	updateAllSelectCheckbox();
	updateTotalsFromCheckedItems();
}





function updateDiscountDisplays(totalAmount) {
	const discountCheckboxes = document.querySelectorAll('.discount-check');
	let totalDiscount = 0;

	discountCheckboxes.forEach(cb => {
		const card = cb.dataset.card;
		const discountElem = document.getElementById('discount_' + card);
		if (!discountElem) return;

		// 무조건 할인 금액 표시 (체크 여부 무시)
		const discount = Math.floor(totalAmount * 0.07);
		discountElem.innerText = '-' + discount.toLocaleString();

		// 체크 여부에 따라 최종 할인 합산
		if (cb.checked) {
			totalDiscount += discount;
		}
	});

	// 최종 결제 예정 금액 업데이트
	const finalAmountElem = document.getElementById('final_amount');
	if (finalAmountElem) {
		const finalAmount = totalAmount - totalDiscount;
		finalAmountElem.innerText = finalAmount.toLocaleString();
	}
}



// 총합 업데이트 (변경 시만 DOM 변경)
function updateTotals(totalCount, totalAmount) {
	const countElem = document.getElementById('total_count');
	const amountElem = document.getElementById('total_amount');
	const finalAmountElem = document.getElementById('final_amount');
	if (countElem && countElem.innerText !== String(totalCount)) {
		countElem.innerText = totalCount;
	}
	const formattedAmount = totalAmount.toLocaleString();
	if (amountElem && amountElem.innerText !== formattedAmount) {
		amountElem.innerText = formattedAmount;
	}

	/*if (finalAmountElem && finalAmountElem.innerText !== formattedAmount) {
		  finalAmountElem.innerText = formattedAmount;
		}*/
}


function updateTotalsFromCheckedItems() {
	let totalCount = 0;
	let totalAmount = 0;

	const checkedItems = document.querySelectorAll('input[type="checkbox"][id^="item_check_"]:checked');

	checkedItems.forEach(cb => {
		const item = cb.closest('.item');
		if (!item) return;

		const quantityInput = item.querySelector('input[name="quantity"]');
		const quantity = quantityInput ? parseInt(quantityInput.value) || 0 : 0;

		const amountElem = item.querySelector('.text_value');
		const amountText = amountElem && amountElem.innerText ? amountElem.innerText.replace(/,/g, '') : "0";
		const amount = parseInt(amountText) || 0;

		totalCount += quantity;
		totalAmount += amount;
	});

	updateTotals(totalCount, totalAmount);
	updateDiscountDisplays(totalAmount); // ✅ 할인 계산 추가
}

// 모든 아이템 체크박스 상태 변경
function setAllCheckboxes(checked) {
	const itemCheckboxes = document.querySelectorAll('input[type="checkbox"][id^="item_check_"]');
	itemCheckboxes.forEach(cb => {
		if (cb.checked !== checked) {
			cb.checked = checked;
		}
	});
}

// 전체 선택 체크박스 상태 업데이트
function updateAllSelectCheckbox() {
	const allSelectCheckbox = document.getElementById("all_select");
	if (!allSelectCheckbox) return;

	const itemCheckboxes = document.querySelectorAll('input[type="checkbox"][id^="item_check_"]');
	const allChecked = Array.from(itemCheckboxes).every(cb => cb.checked);
	allSelectCheckbox.checked = allChecked;
}

document.addEventListener("DOMContentLoaded", () => {
	const allSelectCheckbox = document.getElementById("all_select");
	const itemCheckboxes = document.querySelectorAll('input[type="checkbox"][id^="item_check_"]');

	// 체크박스 상태 복원 (한 번만)
	restoreCheckStates();

	// 전체 선택 체크박스 이벤트
	if (allSelectCheckbox) {
		allSelectCheckbox.addEventListener("change", () => {
			setAllCheckboxes(allSelectCheckbox.checked);
			saveCheckStates();
			updateTotalsFromCheckedItems();
		});
	}

	// 각 항목 체크박스 이벤트
	itemCheckboxes.forEach(cb => {
		cb.addEventListener("change", () => {
			updateAllSelectCheckbox();
			saveCheckStates();
			updateTotalsFromCheckedItems();
		});
	});

	// 수량 input 변화 시에도 총합 업데이트
	itemCheckboxes.forEach(cb => {
		const item = cb.closest('.item');
		if (!item) return;

		const quantityInput = item.querySelector('input[name="quantity"]');
		if (quantityInput) {
			quantityInput.addEventListener('input', () => {
				// 수량 변경 시 해당 아이템이 체크되어 있으면 총합 갱신
				if (cb.checked) {
					updateTotalsFromCheckedItems();
				}
			});
		}
	});

	document.querySelectorAll('.discount-check').forEach(cb => {
		cb.addEventListener('change', () => {
			console.log('할인 체크박스 변경:', cb.dataset.card, cb.checked);
			const elem = document.getElementById('total_amount');
			const amountText = elem ? elem.innerText.replace(/,/g, '') : '0';
			const totalAmount = parseInt(amountText) || 0;
			console.log('현재 총액:', totalAmount);
			updateDiscountDisplays(totalAmount);
		});
	});



	// **페이지 로드 시에도 할인 금액 표시 업데이트**
	const elem = document.getElementById('total_amount');
	const amountText = elem ? elem.innerText.replace(/,/g, '') : '0';
	const totalAmount = parseInt(amountText) || 0;
	updateDiscountDisplays(totalAmount);

	// 초기 상태 반영
	//updateAllSelectCheckbox();
	// updateTotalsFromCheckedItems();

});


