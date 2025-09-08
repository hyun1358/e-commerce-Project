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
	// 초기 상태: 비움 ~ 오늘 표시
	startInput.value = '';
	endInput.value = formatDate(today);

	const sortSelect = document.getElementById('sortOption');
	const searchButton = document.getElementById('searchBtn');

	if (sortSelect && searchButton) {
		sortSelect.addEventListener('change', function() {
			searchButton.click(); // 정렬 select 변경 시 자동 검색 실행
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
				// 비움 ~ 오늘
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


	// 이벤트는 DOMContentLoaded나 스크립트 맨 아래 딱 한 번만 등록!
	document.addEventListener('change', (e) => {
		if (e.target.id === 'selectAll') {
			const checked = e.target.checked;
			document.querySelectorAll('tbody input[type="checkbox"][name="user_idx"]').forEach(cb => cb.checked = checked);
		}
		// 개별 체크박스 클릭 시 전체 선택 상태 조정
		if (e.target.name === 'user_idx') {
			const checkboxes = document.querySelectorAll('tbody input[type="checkbox"][name="user_idx"]');
			const checkedBoxes = document.querySelectorAll('tbody input[type="checkbox"][name="user_idx"]:checked');

			const selectAll = document.getElementById('selectAll');
			if (selectAll) {
				selectAll.checked = checkboxes.length === checkedBoxes.length;
			}
		}

	});

});

document.getElementById('editUsersBtn').addEventListener('click', function(e) {
	e.preventDefault(); // 기본 링크 이동 막기

	const checkedBoxes = document.querySelectorAll('tbody input[type="checkbox"][name="user_idx"]:checked');

	if (checkedBoxes.length === 0) {
		alert('하나 이상 선택해주세요!');
		return;
	}

	const userIds = Array.from(checkedBoxes).map(cb => cb.value);
	const queryString = userIds.join(',');

	window.location.href = `${contextPath}/admin/customer/edit?user_idx=${encodeURIComponent(queryString)}`;
});


document.getElementById('searchBtn').addEventListener('click', () => {

	//검색할 기준
	const searchCategory = document.getElementById('searchCategory').value; // user_id, user_name, email 등
	const searchKeyword = document.querySelector('input[name="searchKeyword"]').value.trim();

	//날짜 범위
	const dateStart = document.querySelector('.date-start').value;
	const dateEnd = document.querySelector('.date-end').value;

	// 회원 상태 라디오 값 가져오기
	const selectedStatusInput = document.querySelector('input[name="customerStatus"]:checked');
	const customerStatus = selectedStatusInput ? selectedStatusInput.value : 'all';

	// 정렬 기준
	const sortOption = document.getElementById('sortOption').value;

	// 필요한 데이터 객체 생성
	const params = {
		searchCategory,
		searchKeyword,
		dateStart,
		dateEnd,
		customerStatus,
		sortOption,
	};
	console.log(params);

	const filteredParams = Object.fromEntries(
		Object.entries(params).filter(([_, v]) => v !== undefined && v !== null && v !== '')
	);
	const queryString = new URLSearchParams(filteredParams).toString();


	// 서버에 GET 혹은 POST 요청 (예시: POST)
	fetch(`${contextPath}/admin/customer/search?${queryString}`, {
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

			const headerCheckbox = document.getElementById('selectAll');
			if (headerCheckbox) {
				headerCheckbox.checked = false;
			}
		})
		.catch(err => {
			console.error('검색 오류:', err);
		});

});

/*function renderSearchResults(data) {
	const userList = data.user_list;
	const container = document.getElementById('searchResultsContainer'); // 결과를 보여줄 div 등

	if (!container) {
		console.error('검색 결과를 표시할 컨테이너가 없습니다.');
		return;
	}

	container.innerHTML = ''; // 기존 결과 초기화

	if (!userList || userList.length === 0) {
		container.innerHTML = '<p>검색 결과가 없습니다.</p>';
		return;
	}

	userList.forEach(user => {
		const div = document.createElement('div');
		div.textContent = `${user.user_name} (${user.user_id}) - 상태: ${user.account_status}`;
		container.appendChild(div);
	});
}
*/


/*document.getElementById('pagingContainer').addEventListener('click', function(e) {
	if (e.target.tagName === 'A') {
		e.preventDefault();

		const page = new URL(e.target.href).searchParams.get('page');
		const form = document.getElementById('searchForm');
		const formData = new FormData(form);
		const params = new URLSearchParams(formData);

		params.set('page', page);


		fetch(`${contextPath}/admin/product/search?${params.toString()}`, {
			method: 'GET',
			headers: { 'X-Requested-With': 'XMLHttpRequest' }
		})
			.then(res => {
				if (!res.ok) throw new Error(`서버 오류: ${res.status}`);
				return res.text();
			})
			.then(html => {
				const tempDiv = document.createElement('div');
				tempDiv.innerHTML = html;

				const newResults = tempDiv.querySelector('#searchResultsContainer');
				const container = document.getElementById('searchResultsContainer');
				if (newResults && container) container.replaceWith(newResults);

				const newPaging = tempDiv.querySelector('#pagingContainer');
				const pagingContainer = document.getElementById('pagingContainer');

				if (newPaging && pagingContainer) {
					pagingContainer.innerHTML = newPaging.innerHTML;
				} else {
					// 페이징 영역 없으면 빈 상태 혹은 기본 처리
				}

			})
			.catch(err => {
				console.error('페이징 로드 오류:', err);
			});
	}
});*/

document.querySelector('input[name="searchKeyword"]').addEventListener('keypress', function(e) {
	if (e.key === 'Enter') {
		e.preventDefault();
		document.getElementById('searchBtn').click();
	}
});

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
	const defaultRadio = document.querySelector('input[name="customerStatus"][value="all"]');
	if (defaultRadio) defaultRadio.checked = true;

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

	/*document.querySelector('.regdate button[data-range="all"]')?.classList.add('active'); 수정*/
	const allBtn = document.querySelector('.regdate button[data-range="all"]');
	if (allBtn) {
		allBtn.classList.add('active');
	}
});

// 헤더 체크박스
/*document.addEventListener('DOMContentLoaded', () => {
	/*const headerCheckbox = document.getElementById('selectAll');
	const bodyCheckboxes = document.querySelectorAll('tbody input[type="checkbox"][name="user_idx"]');

	headerCheckbox.addEventListener('change', () => {
		const checked = headerCheckbox.checked;
		bodyCheckboxes.forEach(cb => cb.checked = checked);
	});

	const headerCheckbox = document.getElementById('selectAll');

	headerCheckbox.addEventListener('change', () => {
		const checked = headerCheckbox.checked;
		const bodyCheckboxes = document.querySelectorAll('tbody input[type="checkbox"][name="user_idx"]');
		bodyCheckboxes.forEach(cb => cb.checked = checked);
	});
});*/

document.getElementById('delete-btn').addEventListener('click', () => {
	const checked = document.querySelectorAll('input[name="user_idx"]:checked');

	if (checked.length === 0) {
		alert('삭제할 회원을 선택해주세요.');
		return;
	}

	const userIds = Array.from(checked).map(cb => cb.value);

	if (!confirm(`선택한 ${userIds.length}명의 회원을 삭제하시겠습니까?`)) return;

	fetch('/final/admin/customer/delete', {
		method: 'POST',
		headers: {
			'Content-Type': 'application/json'
		},
		body: JSON.stringify({ userIds }) // { "userIds": [1, 2, 3] } 
		//서버에서 .get("userIds") 사용하는 이름이 완전히 일치해야 함.
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
