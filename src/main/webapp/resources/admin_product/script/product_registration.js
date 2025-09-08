document.addEventListener("DOMContentLoaded", function() {
	for (let i = 1; i <= 5; i++) {
		const input = document.getElementById(`imageInput_${i}`);
		const preview = document.getElementById(`previewImg_${i}`);
		const noImageText = document.getElementById(`noImageText_${i}`);

		if (input) {
			input.addEventListener("change", e => {
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
		}
	}


	const parentSelect = document.getElementById("parentCategory");
	const childSelect = document.getElementById("childCategory");

	if (parentSelect && childSelect) {
		parentSelect.addEventListener("change", () => {
			const parentId = parentSelect.value;

			if (!parentId) {
				childSelect.innerHTML = '<option value="">(소분류) 선택</option>';
				return;
			}

			fetch(`/final/categories/children?parentId=${parentId}`)
				.then(res => res.json())
				.then(data => {
					let options = '<option value="">(소분류) 선택</option>';
					data.forEach(cat => {
						options += `<option value="${cat.category_id}">${cat.name}</option>`;
					});
					childSelect.innerHTML = options;
				})
				.catch(err => {
					console.error('소분류 불러오기 실패:', err);
					childSelect.innerHTML = '<option value="">(소분류) 선택</option>';
				});
		});
	}

});

function triggerImageUpload(index) {
	document.getElementById(`imageInput_${index}`).click();
}

function deleteImage(index) {
	const input = document.getElementById(`imageInput_${index}`);
	const preview = document.getElementById(`previewImg_${index}`);
	const noImageText = document.getElementById(`noImageText_${index}`);

	if (input) input.value = '';
	if (preview) {
		preview.src = '';
		preview.style.display = 'none';
	}
	if (noImageText) {
		noImageText.style.display = 'block';
	}
}


document.querySelector('.btn-submit').addEventListener('click', () => {
	// 1. 필수 입력값 검증
	if (!document.querySelector('input[name="product_name"]').value.trim()) {
		alert("상품명을 입력하세요.");
		return; // 여기서 멈춤
	}

	const categorySelect = document.querySelector(`select[name="category"]`);
	if (!categorySelect || !categorySelect.value) {
		alert("카테고리를 선택해주세요.");
		return; // 함수 종료해서 submit 막기
	}


	// 2. 중복 클릭 방지 위해 버튼 비활성화
	const submitBtn = document.querySelector('.btn-submit');
	submitBtn.disabled = true;
	submitBtn.innerText = "등록 중...";


	// 3. FormData 생성 및 데이터 추가
	const formData = new FormData();
	formData.append("product_name", document.querySelector('input[name="product_name"]').value);
	formData.append("company", document.querySelector('input[name="company"]').value);
	formData.append("description", document.querySelector('textarea[name="description"]').value);
	formData.append("price", document.querySelector('input[name="price"]').value);
	formData.append("sale_price", document.querySelector('input[name="sale_price"]').value);
	formData.append("stock", document.querySelector('input[name="stock"]').value);
	formData.append("is_visible", document.querySelector('input[name="is_visible"]:checked').value);
	formData.append("category_id", document.querySelector('select[name="category"]').value);

	for (let i = 1; i <= 5; i++) {
		const input = document.getElementById(`imageInput_${i}`);
		if (input && input.files.length > 0) {
			formData.append(`images[${i - 1}]`, input.files[0]);
		}
	}

	// 4. fetch 요청 보내기
	fetch('/final/admin/product/register', {
		method: 'POST',
		body: formData
	})
		.then(res => res.text())
		.then(raw => {
			try {
				const data = JSON.parse(raw);
				if (data.result === 'success') {
					alert("상품이 등록되었습니다.");
					//location.reload();
					location.href="final/admin_product"
				} else {
					alert("등록 실패: " + data.message);
					submitBtn.disabled = false;
					submitBtn.innerText = "등록";
				}
			} catch (e) {
				console.error("응답 파싱 실패", e);
				alert("서버 오류");
				submitBtn.disabled = false;
				submitBtn.innerText = "등록";
			}
		})
		.catch(err => {
			console.error("등록 중 오류", err);
			alert("등록 요청 실패");
			submitBtn.disabled = false;
			submitBtn.innerText = "등록";
		});
});

