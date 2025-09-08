document.addEventListener('DOMContentLoaded', function() {
	const today = new Date();
	const startInput = document.querySelectorAll('.regdate input[type="date"]')[0];
	const endInput = document.querySelectorAll('.regdate input[type="date"]')[1];

	function formatDate(date) {
		const offset = date.getTimezoneOffset();
		const localDate = new Date(date.getTime() - offset * 60 * 1000);
		return localDate.toISOString().split('T')[0];
	}

	const buttons = document.querySelectorAll('.regdate button');

	startInput.value = '';
	endInput.value = formatDate(today);

	//정렬구현하고 주석해제 
	const sortSelect = document.getElementById('sortOption');
	const searchButton = document.getElementById('searchBtn');

	if (sortSelect && searchButton) {
		sortSelect.addEventListener('change', function() {
			searchButton.click();
		});
	}


	// 버튼 클릭 시 처리
	buttons.forEach((button) => {
		button.addEventListener('click', () => {
			const range = button.getAttribute('data-range');

			// 버튼 스타일 업데이트
			buttons.forEach((btn) => btn.classList.remove('active'));
			button.classList.add('active');

			let startDate = new Date();

			if (range === 'all') {
				// 2025-01-01 ~ 오늘
				startInput.value = '';
				endInput.value = formatDate(today);
				return;
			}

			switch (range) {
				case 'today':
					startDate = today;
					break;
				case '7':
					startDate.setDate(today.getDate() - 7);
					break;
				case '30':
					startDate.setMonth(today.getMonth() - 1);
					break;
				case '90':
					startDate.setMonth(today.getMonth() - 3);
					break;
				case '365':
					startDate.setFullYear(today.getFullYear() - 1);
					break;
			}

			startInput.value = formatDate(startDate);
			endInput.value = formatDate(today);
		});
	});

	document.addEventListener('change', (e) => {
		// 전체 선택
		if (e.target.id === 'selectAll') {
			const checked = e.target.checked;
			document.querySelectorAll('tbody input[type="checkbox"][name="selected_items"]')
				.forEach(cb => cb.checked = checked);
		}

		// 개별 체크 해제 시 전체 선택도 해제
		if (e.target.name === 'selected_items') {
			const all = document.querySelectorAll('tbody input[type="checkbox"][name="selected_items"]');
			const checked = document.querySelectorAll('tbody input[type="checkbox"][name="selected_items"]:checked');
			document.getElementById('selectAll').checked = all.length === checked.length;
		}
	});

});


//수정
document.getElementById('editReturnsBtn').addEventListener('click', function(e) {
	e.preventDefault();

	// 체크된 체크박스들 (이름에 맞게 수정)
	const checkedBoxes = document.querySelectorAll('tbody input[type="checkbox"][name="selected_items"]:checked');

	if (checkedBoxes.length === 0) {
		alert('하나 이상 선택해주세요!');
		return;
	}

	// order_id와 product_id를 각각 배열로 추출
	const orderIds = [];
	const productIds = [];

	checkedBoxes.forEach(cb => {
		orderIds.push(cb.value); // value가 order_id라면
		productIds.push(cb.getAttribute('data-product-id'));
	});

	// 쿼리스트링 만들기 (예: order_id=1,2,3 & product_id=10,20,30)
	const queryString = `order_id=${encodeURIComponent(orderIds.join(','))}&product_id=${encodeURIComponent(productIds.join(','))}`;

	// 페이지 이동
	window.location.href = `/final/admin/return/edit?${queryString}`;
});

//초기화
document.querySelector('.btn-reset').addEventListener('click', () => {
	// select 초기화
	document.querySelectorAll('select').forEach(select => {
		select.selectedIndex = 0; // 첫번째 옵션 선택
	});

	// 텍스트 input 초기화
	document.querySelectorAll('input[type="text"]').forEach(input => {
		input.value = '';
	});


	// 라디오 초기화 (전체 선택)
	const refundStatusRadio = document.querySelector('input[name="refundStatus"][value="all"]');
	if (refundStatusRadio) refundStatusRadio.checked = true;

	const processStatusRadio = document.querySelector('input[name="processStatus"][value="all"]');
	if (processStatusRadio) processStatusRadio.checked = true;

	// 날짜 초기화: 시작일은 빈값, 종료일은 오늘
	const startInput = document.querySelector('.date-start');
	const endInput = document.querySelector('.date-end');

	function formatDate(date) {
		const offset = date.getTimezoneOffset();
		const localDate = new Date(date.getTime() - offset * 60 * 1000);
		return localDate.toISOString().split('T')[0];
	}

	startInput.value = '';
	endInput.value = formatDate(new Date());

	// 날짜 버튼 active 클래스 초기화 (전체로 되돌리기)
	document.querySelectorAll('.regdate button').forEach(btn => btn.classList.remove('active'));

	const allBtn = document.querySelector('.regdate button[data-range="all"]');
	if (allBtn) {
		allBtn.classList.add('active');
	}
});


//검색
document.getElementById('searchBtn').addEventListener('click', () => {

	//검색할 기준
	const searchCategory = document.getElementById('searchCategory').value; // user_id, user_name, email 등
	const searchKeyword = document.querySelector('input[name="searchKeyword"]').value.trim();

	//날짜 범위
	const dateStart = document.querySelector('.date-start').value;
	const dateEnd = document.querySelector('.date-end').value;

	const dateType = document.querySelector('select[name="dateType"]').value;

	// 라디오 값 가져오기
	var selectedStatusInput = document.querySelector('input[name="refundStatus"]:checked');
	const refundStatus = selectedStatusInput ? selectedStatusInput.value : 'all';

	selectedStatusInput = document.querySelector('input[name="processStatus"]:checked');
	const processStatus = selectedStatusInput ? selectedStatusInput.value : 'all';

	// 정렬 기준
	const sortOption = document.getElementById('sortOption').value;

	// 필요한 데이터 객체 생성
	const params = {
		searchCategory,
		searchKeyword,
		dateStart,
		dateEnd,
		dateType,
		refundStatus,
		processStatus,
		sortOption,
	};
	console.log(params);

	const filteredParams = Object.fromEntries(
		Object.entries(params).filter(([_, v]) => v !== undefined && v !== null && v !== '')
	);
	const queryString = new URLSearchParams(filteredParams).toString();


	// 서버에 GET 혹은 POST 요청 (예시: POST)
	fetch(`${contextPath}/admin/return/search?${queryString}`, {
		method: 'GET',
		headers: {
			'X-Requested-With': 'XMLHttpRequest'
		}
	})
		.then(res => {
			if (!res.ok) throw new Error(`서버 오류: ${res.status}`);
			return res.text(); // 🔁 여기: JSON -> text (HTML 조각)
		})
		.then(html => {
			const tempDiv = document.createElement('div');
			tempDiv.innerHTML = html;

			const newResults = tempDiv.querySelector('#searchResultsContainer');
			const container = document.getElementById('searchResultsContainer');

			if (newResults && container) {
				container.replaceWith(newResults);
				rebindReturnActionButtons();  // ✅ 새로 추가
			} else {
				console.error('searchResultsContainer가 없습니다.');
			}

			// 페이징 영역 교체
			const newPaging = tempDiv.querySelector('#pagingContainer');
			const pagingContainer = document.getElementById('pagingContainer');

			if (newPaging && pagingContainer) {
				pagingContainer.innerHTML = newPaging.innerHTML;
			} else {
				// 페이징 영역 없으면 빈 상태 혹은 기본 처리
			}

			console.log('서버 응답 (text):', html);

			const headerCheckbox = document.getElementById('selectAll');
			if (headerCheckbox) {
				headerCheckbox.checked = false;
			}
		})
		.catch(err => {
			console.error('검색 오류:', err);
		});

});



document.querySelector('input[name="searchKeyword"]').addEventListener('keypress', function(e) {
	if (e.key === 'Enter') {
		e.preventDefault();
		document.getElementById('searchBtn').click();
	}
});



//일괄삭제
document.getElementById('deleteReturnBtn').addEventListener('click', () => {

	// 체크된 체크박스들 (이름에 맞게 수정)
	const checkedBoxes = document.querySelectorAll('tbody input[type="checkbox"][name="selected_items"]:checked');

	if (checkedBoxes.length === 0) {
		alert('삭제할 회원을 선택해주세요.');
		return;
	}

	// order_id와 product_id를 각각 배열로 추출
	const orderIds = [];
	const productIds = [];

	checkedBoxes.forEach(cb => {
		orderIds.push(cb.value); // value가 order_id라면
		productIds.push(cb.getAttribute('data-product-id'));
	});

	// 쿼리스트링 만들기 (예: order_id=1,2,3 & product_id=10,20,30)
	//const queryString = `order_id=${encodeURIComponent(orderIds.join(','))}&product_id=${encodeURIComponent(productIds.join(','))}`;


	if (!confirm(`선택한 ${orderIds.length}개의 주문을 삭제하시겠습니까?`)) return;

	fetch('/final/admin/return/delete', {
		method: 'POST',
		headers: {
			'Content-Type': 'application/json'
		},
		body: JSON.stringify({ orderIds, productIds }) // 
	})
		.then(res => {
			if (!res.ok) throw new Error('서버 오류');
			return res.json();
		})
		.then(data => {
			if (data.success) {
				alert('삭제가 완료되었습니다.');
				location.reload(); // 페이지 새로고침
			} else {
				alert('삭제에 실패했습니다.');
			}
		})
		.catch(err => {
			console.error('삭제 요청 실패:', err);
			alert('삭제 중 오류가 발생했습니다.');
		});
});


function handleReturnAction(buttonSelector, processStatus, confirmMsg, successMsg, errorMsg) {
	document.querySelectorAll(buttonSelector).forEach(function(btn) {
		btn.addEventListener("click", function() {
			const row = this.closest("tr");
			const checkbox = row.querySelector("input[type='checkbox']");
			const orderId = checkbox.value;
			const productId = checkbox.dataset.productId;
			const requestType = checkbox.dataset.requestType;
			const refundStatus = processStatus;

			if (confirm(confirmMsg.replace("{orderId}", orderId))) {
				fetch("/final/admin/return/updateStatus/single", {
					method: "POST",
					headers: {
						"Content-Type": "application/json"
					},
					body: JSON.stringify({
						order_id: orderId,
						product_id: productId,
						request_type: requestType,
						process_status: processStatus,
						refund_status: refundStatus
					})
				})
					.then((res) => res.json())
					.then((data) => {
						if (data.success) {
							alert(successMsg);
							location.reload();
						} else {
							alert(errorMsg);
						}
					})
					.catch((error) => {
						console.error("처리 오류:", error);
						alert("서버 요청 실패");
					});
			}
		});
	});
}

document.addEventListener("DOMContentLoaded", function() {
	rebindReturnActionButtons();  // ✅ 초기 바인딩용으로도 충분함
});

function rebindReturnActionButtons() {
	handleReturnAction(".btn-approve-single", "P", "주문번호 {orderId}를 승인 처리하시겠습니까?", "승인 완료되었습니다.", "승인 처리 중 오류가 발생했습니다.");
	handleReturnAction(".btn-deny-single", "D", "주문번호 {orderId}를 거부 처리하시겠습니까?", "거부 처리되었습니다.", "거부 처리 중 오류가 발생했습니다.");
	handleReturnAction(".btn-complete-single", "C", "주문번호 {orderId}를 완료 처리하시겠습니까?", "완료 처리되었습니다.", "완료 처리 중 오류가 발생했습니다.");
}