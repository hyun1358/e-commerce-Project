document.addEventListener("DOMContentLoaded", function() {
	// 📌 파일 선택 처리
	document.querySelectorAll('input[type="file"]').forEach(input => {
		input.addEventListener('change', event => {
			const product_id = input.dataset.product_id || input.id.split('_')[1];
			const index = input.id.split('_').pop(); // 이미지 인덱스 번호 추출
			const preview = document.getElementById(`previewImg_${product_id}_${index}`);
			const noImageText = document.getElementById(`noImageText_${product_id}_${index}`);

			const file = input.files[0];
			if (file) {
				const reader = new FileReader();
				reader.onload = e => {
					preview.src = e.target.result;
					preview.style.display = 'block';
					noImageText.style.display = 'none';
				};
				reader.readAsDataURL(file);
			}
		});
	});

	// 📌 삭제 버튼 처리
	document.querySelectorAll('.btn-file-delete').forEach(button => {
		button.addEventListener('click', function() {
			const container = this.closest(`.image-upload-controls`);
			if (!container) return;
			const input = container.querySelector('input[type="file"]');
			if (!input) return;

			const parts = input.id.split('_');
			const product_id = parts[1];
			const index = parts[2];

			const previewImg = document.getElementById(`previewImg_${product_id}_${index}`);
			const noImageText = document.getElementById(`noImageText_${product_id}_${index}`);

			input.value = '';
			if (previewImg) {
				previewImg.src = '';
				previewImg.style.display = 'none';
			}
			if (noImageText) {
				noImageText.style.display = 'block';
			}
		});
	});

	// 📌 첫 번째 탭 자동 활성화 상품폼 보여주기
	const firstTab = document.querySelector('.product-tab');
	if (firstTab) firstTab.style.display = 'block';
	const firstBtn = document.querySelector('.tab-btn');
	if (firstBtn) firstBtn.classList.add('active');



	// 카테고리 관련 초기화 예시
	// 상품 탭 각각에 대해 초기 카테고리 셋팅 처리
	document.querySelectorAll('.product-tab').forEach(tab => {
		const productId = tab.id.split('_')[1];
		const parentSelect = document.getElementById(`parentCategory_${productId}`);
		const childSelect = document.getElementById(`childCategory_${productId}`);

		// 데이터 속성에서 소분류 카테고리 ID 받아오기 (추가한 부분)
		const selectedChildId = tab.dataset.categoryId;

		if (parentSelect && childSelect) {
			// 대분류 select는 JSP에서 selected 속성으로 초기값 세팅 되어 있음
			const selectedParentId = parentSelect.value;

			// 소분류 카테고리 리스트를 AJAX로 불러와 세팅 (초기 로드 시 선택된 소분류도 맞춤)
			loadChildCategories(selectedParentId, selectedChildId, childSelect);

			// 대분류 선택이 변경되면 소분류도 다시 불러와 업데이트
			parentSelect.addEventListener('change', () => {
				loadChildCategories(parentSelect.value, null, childSelect);
			});
		}
	});

	// 소분류 카테고리 로드 함수
	function loadChildCategories(parentId, selectedChildId, childSelect) {
		if (!parentId) {
			childSelect.innerHTML = '<option value="">(소분류) 선택</option>';
			return;
		}
		fetch(`/final/categories/children?parentId=${parentId}`)
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


	const hash = location.hash;
	if (hash && hash.startsWith('#product_')) {
		const productId = hash.replace('#product_', '');
		showProductTab(productId); // 해당 상품 탭 열기
	}


const nav = document.querySelector('.tab-nav-vertical');
	const initialTop = nav.getBoundingClientRect().top + window.scrollY- 50;
	let currentY = 0;
	let targetY = 0;
	let ticking = false;

	function updatePosition() {
		currentY += (targetY - currentY) * 0.3;  // 부드럽게 이동하는 비율 조절 가능
		nav.style.transform = `translateY(${currentY}px)`;

		if (Math.abs(targetY - currentY) > 0.1) {
			requestAnimationFrame(updatePosition);
		} else {
			ticking = false;
		}
	}

	window.addEventListener('scroll', () => {
		const scrollY = window.scrollY;
		const offset = scrollY - initialTop;
		targetY = Math.max(0, offset);

		if (!ticking) {
			ticking = true;
			requestAnimationFrame(updatePosition);
		}
	});
});

function triggerImageUpload(product_id, index) {
	document.getElementById(`imageInput_${product_id}_${index}`).click();
}


// 기존: const deletedIndexes = [];
const deletedIndexesMap = {}; // 상품별 삭제 인덱스를 담는 객체

function deleteImage(product_id, index) {

	if (!deletedIndexesMap[product_id]) {
		deletedIndexesMap[product_id] = [];
	}

	// 중복된 인덱스가 여러 번 들어가지 않도록 방지
	//기존
	/*if (!deletedIndexes.includes(index)) {
		deletedIndexes.push(index);
	}*/

	if (!deletedIndexesMap[product_id].includes(index)) {
		deletedIndexesMap[product_id].push(index);
	}

	const input = document.getElementById(`imageInput_${product_id}_${index}`);
	const previewImg = document.getElementById(`previewImg_${product_id}_${index}`);
	const noImageText = document.getElementById(`noImageText_${product_id}_${index}`);

	if (input) input.value = '';
	if (previewImg) {
		previewImg.src = '';
		previewImg.style.display = 'none';
	}
	if (noImageText) {
		noImageText.style.display = 'block';
	}
}

function showProductTab(product_id) {
	//기존 deletedIndexes.length = 0; // 이전 상품 기록 초기화

	// 모든 탭 숨기기
	document.querySelectorAll('.product-tab').forEach(tab => {
		tab.style.display = 'none';
	});

	// 선택한 탭 보이기
	const selected = document.getElementById('product_' + product_id);
	if (selected) {
		selected.style.display = 'block';
	} else {
		console.error(`탭 콘텐츠를 찾을 수 없습니다: product_${product_id}`);
	}

	// 모든 버튼에서 active 제거
	document.querySelectorAll('.tab-btn').forEach(btn => {
		btn.classList.remove('active');
	});

	// 활성화할 버튼 찾기 (dataset.productId는 string)
	const activeBtn = Array.from(document.querySelectorAll('.tab-btn'))
		.find(btn => btn.dataset.productId === String(product_id));

	if (activeBtn) {
		activeBtn.classList.add('active');
	} else {
		console.error(`탭 버튼을 찾을 수 없습니다: productId=${product_id}`);
	}
}

function submitProduct(product_id) {

	// 1. 필수 입력값 검증
	const productNameInput = document.querySelector(`input[name="product_name_${product_id}"]`);
	if (!productNameInput || !productNameInput.value.trim()) {
		alert("상품명을 입력하세요.");
		return;//여기서 멈춤
	}

	const categorySelect = document.querySelector(`select[name="category_${product_id}"]`);
	if (!categorySelect || !categorySelect.value) {
		alert("카테고리를 선택해주세요.");
		return; // 함수 종료해서 submit 막기
	}

	// 2. 중복 클릭 방지 위해 버튼 비활성화
	const submitBtn = document.querySelector(`.btn-submit[data-product-id="${product_id}"]`);
	if (submitBtn) {
		submitBtn.disabled = true;
		submitBtn.innerText = "등록 중...";
	} else {
		console.warn(`submitBtn not found for product_id=${product_id}`);
	}


	const formData = new FormData();
	// images append 생략
	// product_id는 무조건 필요
	formData.append("product_id", product_id);

	// 입력 필드에서 값 가져오기 (예: name 속성 기반)
	const name = document.querySelector(`input[name="product_name_${product_id}"]`).value;
	const company = document.querySelector(`input[name="company_${product_id}"]`).value;
	const description = document.querySelector(`textarea[name="description_${product_id}"]`).value;
	const price = document.querySelector(`input[name="price_${product_id}"]`).value;
	const sale_price = document.querySelector(`input[name="sale_price_${product_id}"]`).value;
	const stock = document.querySelector(`input[name="stock_${product_id}"]`).value;
	const is_visible = document.querySelector(`input[name="is_visible_${product_id}"]:checked`).value;
	const childCategory = document.querySelector(`select[name="category_${product_id}"]`).value;
	formData.append("category_id", childCategory);

	formData.append("product_name", name);
	formData.append("company", company);
	formData.append("description", description);
	formData.append("price", price);
	formData.append("sale_price", sale_price);
	formData.append("stock", stock);
	formData.append("is_visible", is_visible);

	// 이미지들 처리
	for (let i = 1; i <= 5; i++) {
		const fileInput = document.querySelector(`#imageInput_${product_id}_${i}`);
		if (fileInput && fileInput.files.length > 0) {
			//console.log(`이미지 ${i}:`, fileInput.files[0].name);
			formData.append(`images[${i - 1}]`, fileInput.files[0]); // 0-based index
		}
		//else {
		//console.log(`이미지 ${i}: null (삭제됨 혹은 비어 있음)`);
		//}
	}

	// 삭제된 인덱스 문자열(JSON)로 변환해서 formData에 추가
	//기존 formData.append("deletedIndexes", JSON.stringify(deletedIndexes));

	//// 삭제된 인덱스들을 전송
	const deletedForThisProduct = deletedIndexesMap[product_id] || [];
	formData.append("deletedIndexes", JSON.stringify(deletedForThisProduct));


	fetch('/final/admin/product/update', {
		method: 'POST',
		body: formData
	})
		.then(res => res.text())
		.then(raw => {
			try {
				const data = JSON.parse(raw);
				console.log("JSON:", data);

				if (data.result === 'success') {
					alert("상품이 성공적으로 수정되었습니다.");
					location.hash = `#product_${product_id}`; // 해시로 상품 탭 기억
					location.reload(); // 새로고침
					deletedIndexesMap[product_id] = [];  // ✅ 삭제 인덱스 초기화

				} else if (data.result === 'no change') {
					alert("변경된 내용이 없습니다.");
				} else {
					alert("수정 중 오류가 발생했습니다:\n" + data.message);
				}

			} catch (e) {
				console.error("JSON 파싱 실패:", e);
				console.log("raw:", raw);
				alert("서버 응답 오류가 발생했습니다.");
			}
		})
		.catch(err => {
			console.error("fetch 실패:", err);
			alert("서버와 통신할 수 없습니다. 잠시 후 다시 시도해주세요.");
		})
		.finally(() => {
			if (submitBtn) {
				submitBtn.disabled = false;
				submitBtn.innerText = "수정";
			}
		});
}

