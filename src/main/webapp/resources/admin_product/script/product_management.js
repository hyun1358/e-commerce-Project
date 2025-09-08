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

	const parentSelect = document.getElementById('parentCategory');
	const childSelect = document.getElementById('childCategory');

	if (parentSelect && childSelect) {
		const selectedParentId = parentSelect.value;
		const selectedChildId = childSelect.dataset.selectedChildId || null; // 데이터 속성에서 초기 선택 소분류 id를 받을 수도 있음

		// 초기 로드 시 소분류 불러오기
		loadChildCategories(selectedParentId, selectedChildId, childSelect);

		// 대분류 변경 시 소분류 업데이트
		parentSelect.addEventListener('change', () => {
			loadChildCategories(parentSelect.value, null, childSelect);
		});
	}

	// 이벤트는 DOMContentLoaded나 스크립트 맨 아래 딱 한 번만 등록!
	document.addEventListener('change', (e) => {
		if (e.target.id === 'selectAll') {
			const checked = e.target.checked;
			document.querySelectorAll('tbody input[type="checkbox"][name="product_id"]')
				.forEach(cb => cb.checked = checked);
		}
		// 개별 체크 해제 시 전체 선택 체크박스도 해제
		if (e.target.name === 'product_id') {
			const checkboxes = document.querySelectorAll('tbody input[type="checkbox"][name="product_id"]');
			const checkedBoxes = document.querySelectorAll('tbody input[type="checkbox"][name="product_id"]:checked');

			// 전체 선택 체크박스 상태 조정
			const selectAll = document.getElementById('selectAll');
			if (selectAll) {
				selectAll.checked = checkboxes.length === checkedBoxes.length;
			}
		}
	});

});


/*수정한거 */
document.getElementById('editProductsBtn').addEventListener('click', function(e) {
	e.preventDefault(); // 기본 링크 이동 막기

	const checkedBoxes = document.querySelectorAll('tbody input[type="checkbox"][name="product_id"]:checked');

	if (checkedBoxes.length === 0) {
		alert('하나 이상 선택해주세요!');
		return;
	}

	const productIds = Array.from(checkedBoxes).map(cb => cb.value);
	const queryString = productIds.join(',');

	window.location.href = `${contextPath}/admin/product/edit?product_id=${encodeURIComponent(queryString)}`;
});


// 소분류 카테고리 로드 함수
function loadChildCategories(parentId, selectedChildId, childSelect) {
	if (!parentId) {
		childSelect.innerHTML = '<option value="">(소분류) 선택</option>';
		return;
	}

	fetch(`${contextPath}/categories/children?parentId=${parentId}`)
		.then(res => res.json())
		.then(data => {
			let options = '<option value="">(소분류) 선택</option>';
			data.forEach(cat => {
				options += `<option value="${cat.category_id}" ${cat.category_id == selectedChildId ? 'selected' : ''}>${cat.name}</option>`;
			});
			childSelect.innerHTML = options;
		})
		.catch(err => {
			console.error('소분류 불러오기 실패:', err);
			childSelect.innerHTML = '<option value="">(소분류) 선택</option>';
		});
}


document.getElementById('searchBtn').addEventListener('click', () => {

	//검색할 기준
	const searchCategory = document.getElementById('searchCategory').value; // user_id, user_name, email 등
	const searchKeyword = document.querySelector('input[name="searchKeyword"]').value.trim();

	const isAllCategoryChecked = document.querySelector('.all_category input[type="checkbox"]').checked;

	let parentCategoryId = '';
	let childCategoryId = '';

	if (!isAllCategoryChecked) {
		parentCategoryId = document.getElementById('parentCategory').value;
		childCategoryId = document.getElementById('childCategory').value;
	}

	//날짜 범위
	const dateStart = document.querySelector('.date-start').value;
	const dateEnd = document.querySelector('.date-end').value;

	// 판매여부
	const productStatusInput = document.querySelector('input[name="productStatus"]:checked');
	const productStatus = productStatusInput ? productStatusInput.value : 'all';

	// 품절 여부
	const stockStatusInput = document.querySelector('input[name="stockStatus"]:checked');
	const stockStatus = stockStatusInput ? stockStatusInput.value : 'all';

	// 정렬 기준
	const sortOption = document.getElementById('sortOption').value;


	// 필요한 데이터 객체 생성
	const params = {
		searchCategory,
		searchKeyword,
		parentCategoryId,
		childCategoryId,
		dateStart,
		dateEnd,
		productStatus,
		stockStatus,
		sortOption
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
	fetch(`${contextPath}/admin/product/search?${queryString}`, {
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



document.getElementById('pagingContainer').addEventListener('click', function(e) {
	if (e.target.tagName === 'A') {
		e.preventDefault();

		const page = new URL(e.target.href).searchParams.get('page');

		// searchBtn 클릭 때와 동일하게 검색 조건 수집
		const searchCategory = document.getElementById('searchCategory').value;
		const searchKeyword = document.querySelector('input[name="searchKeyword"]').value.trim();

		const isAllCategoryChecked = document.querySelector('.all_category input[type="checkbox"]').checked;

		let parentCategoryId = '';
		let childCategoryId = '';

		if (!isAllCategoryChecked) {
			parentCategoryId = document.getElementById('parentCategory').value;
			childCategoryId = document.getElementById('childCategory').value;
		}

		const dateStart = document.querySelector('.date-start').value;
		const dateEnd = document.querySelector('.date-end').value;

		const productStatusInput = document.querySelector('input[name="productStatus"]:checked');
		const productStatus = productStatusInput ? productStatusInput.value : 'all';

		const stockStatusInput = document.querySelector('input[name="stockStatus"]:checked');
		const stockStatus = stockStatusInput ? stockStatusInput.value : 'all';

		const sortOption = document.getElementById('sortOption').value;

		const params = {
			searchCategory,
			searchKeyword,
			parentCategoryId,
			childCategoryId,
			dateStart,
			dateEnd,
			productStatus,
			stockStatus,
			sortOption,
			page // 페이징 번호 추가
		};

		const filteredParams = Object.fromEntries(
			Object.entries(params).filter(([_, v]) => v !== undefined && v !== null && v !== '')
		);

		const queryString = new URLSearchParams(filteredParams).toString();

		/*const page = new URL(e.target.href).searchParams.get('page');
		const form = document.getElementById('searchForm');
		const formData = new FormData(form);
		const params = new URLSearchParams(formData);

		params.set('page', page);


		fetch(`${contextPath}/admin_product/search?${params.toString()}`, {*/

		fetch(`${contextPath}/admin/product/search?${queryString}`, {
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
				}
			})
			.catch(err => {
				console.error('페이징 로드 오류:', err);
			});
	}
});


// 헤더 체크박스
/*document.addEventListener('DOMContentLoaded', () => {
	const headerCheckbox = document.getElementById('selectAll');
	const bodyCheckboxes = document.querySelectorAll('tbody input[type="checkbox"][name="product_id"]');
	
	headerCheckbox.addEventListener('change', () => {
		const checked = headerCheckbox.checked;
		bodyCheckboxes.forEach(cb => cb.checked = checked);
	});
});*/

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
	const productStatusRadio = document.querySelector('input[name="productStatus"][value="all"]');
	if (productStatusRadio) productStatusRadio.checked = true;

	// 라디오 초기화 (품절 여부)
	const stockStatusRadio = document.querySelector('input[name="stockStatus"][value="all"]');
	if (stockStatusRadio) stockStatusRadio.checked = true;

	// 전체 선택 체크박스 초기화 (체크 상태 true)
	const allCategoryCheckbox = document.querySelector('.all_category input[type="checkbox"]');
	if (allCategoryCheckbox) {
		allCategoryCheckbox.checked = true;
	}

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

document.getElementById('delete-btn').addEventListener('click', () => {
	const checked = document.querySelectorAll('input[name="product_id"]:checked');

	if (checked.length === 0) {
		alert('삭제할 상품을 선택해주세요.');
		return;
	}

	const productIds = Array.from(checked).map(cb => cb.value);

	if (!confirm(`선택한 ${productIds.length}개의 상품을 삭제하시겠습니까?`)) return;

	fetch(`${contextPath}/admin/product/delete`, {
		method: 'POST',
		headers: {
			'Content-Type': 'application/json'
		},
		body: JSON.stringify({ productIds })
		//서버에서 사용하는 이름이 완전히 일치해야 함.
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

document.querySelector('input[name="searchKeyword"]').addEventListener('keypress', function(e) {
	if (e.key === 'Enter') {
		e.preventDefault();
		document.getElementById('searchBtn').click();
	}
});