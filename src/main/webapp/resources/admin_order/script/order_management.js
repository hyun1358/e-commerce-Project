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

	// 초기 상태: 오늘 ~ 오늘 표시
	startInput.value = '';
	endInput.value = formatDate(today);

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
});


document.getElementById('searchBtn').addEventListener('click', () => {

	//검색할 기준
	const searchCategory = document.getElementById('searchCategory').value; // user_id, user_name, email 등
	const searchKeyword = document.querySelector('input[name="searchKeyword"]').value.trim();

	//날짜 범위
	const dateStart = document.querySelector('.date-start').value;
	const dateEnd = document.querySelector('.date-end').value;

	// 판매여부
	const orderStatusInput = document.querySelector('input[name="orderStatus"]:checked');
	const orderStatus = orderStatusInput ? orderStatusInput.value : 'all';

	// 정렬 기준
	const sortOption = document.getElementById('sortOption').value;


	// 필요한 데이터 객체 생성
	const params = {
		searchCategory,
		searchKeyword,
		dateStart,
		dateEnd,
		orderStatus,
		sortOption,
	};

	console.log(params);
	// 쿼리 문자열로 변환
	const filteredParams = Object.fromEntries(
		Object.entries(params).filter(([_, v]) => v !== undefined && v !== null && v !== '')
	);
	const queryString = new URLSearchParams(filteredParams).toString();

	/*const form = document.getElementById('searchForm'); // form 태그 id가 searchForm이라 가정
	const formData = new FormData(form);
	
	// 폼 데이터에서 빈 값이나 undefined/null 제외하고 쿼리 스트링 만들기
	const filteredEntries = [...formData.entries()].filter(([key, value]) => value !== undefined && value !== null && value.trim() !== '');
	
	const queryString = new URLSearchParams(filteredEntries).toString();*/



	// 서버에 GET 혹은 POST 요청 (예시: POST)
	fetch(`${contextPath}/admin/order/search?${queryString}`, {
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


		})
		.catch(err => {
			console.error('검색 오류:', err);
		});

});

document.querySelector('.btn-reset').addEventListener('click', () => {
	// select 초기화
	document.querySelectorAll('select').forEach(select => {
		select.selectedIndex = 0;
	});

	// 텍스트 input 초기화
	document.querySelectorAll('input[type="text"]').forEach(input => {
		input.value = '';
	});

	// 라디오 초기화 (판매 여부)
	const orderStatusRadio = document.querySelector('input[name="orderStatus"][value="all"]');
	if (orderStatusRadio) orderStatusRadio.checked = true;

	
	// 날짜 초기화
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

function deleteOrder(order_id) {

	console.log('js파일 함수', order_id);

	if (!confirm("정말 삭제하시겠습니까?")) {
		return;
	}

	fetch(`${contextPath}/admin/order/delete`, {
		method: 'POST',
		headers: {
		'Content-Type': 'text/plain'  // 중요!
		},
		body: order_id  // 순수 문자열
	})
	.then(res => {
		if (!res.ok) throw new Error('서버 오류');
		return res.json();
	})
	.then(data => {
		if (data.success) {
			alert('삭제가 완료되었습니다.');
			location.reload();
		} else {
			alert('삭제에 실패했습니다.');
		}
	})
	.catch(err => {
		console.error('삭제 요청 실패:', err);
		alert('삭제 중 오류가 발생했습니다.');
	});
}

document.querySelector('input[name="searchKeyword"]').addEventListener('keypress', function(e) {
	if (e.key === 'Enter') {
		e.preventDefault();
		document.getElementById('searchBtn').click();
	}
});