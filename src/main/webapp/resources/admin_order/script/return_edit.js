function showReturnTab(id) {
	// 모든 탭 숨기기
	document.querySelectorAll('.return-tab').forEach(tab => tab.style.display = 'none');

	// 선택한 탭 보이기
	const selected = document.getElementById('return_' + id);
	if (selected) selected.style.display = 'block';

	// 버튼 활성화 클래스 토글
	document.querySelectorAll('.tab-btn').forEach(btn => btn.classList.remove('active'));
	const activeBtn = document.querySelector(`.tab-btn[data-tab-id="return_${id}"]`);
	if (activeBtn) activeBtn.classList.add('active');
}



// 페이지 로드 시 첫 번째 탭 자동 활성화
window.addEventListener('DOMContentLoaded', () => {
	const firstTab = document.querySelector('.return-tab');
	if (firstTab) firstTab.style.display = 'block';

	const firstBtn = document.querySelector('.tab-btn');
	if (firstBtn) firstBtn.classList.add('active');

	// 해시가 있으면 해당 탭 열기
	const hash = location.hash;
	if (hash && hash.startsWith('#return_')) {
		const id = hash.replace('#return_', '');
		showReturnTab(id);
	}


	//추가
	const nav = document.querySelector('.tab-nav-vertical');
	const initialTop = nav.getBoundingClientRect().top + window.scrollY - 50;;
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


	const forms = document.querySelectorAll("form");

	forms.forEach(form => {
		form.addEventListener("submit", function(e) {
			e.preventDefault(); // 기본 submit 막기

			const formData = new FormData(form);

			const order_id = form.dataset.orderId;
			const product_id = form.dataset.productId;

			fetch(form.action, {
				method: "POST",
				body: formData
			})
				.then(response => {
					if (!response.ok) throw new Error("서버 오류 발생");
					return response.json(); // ✅ JSON으로 파싱
				})
				.then(data => {

					if (data.success) {
						alert("요청이 성공적으로 처리되었습니다.");
						location.hash = `#return_${order_id}_${product_id}`; // 정확한 탭 해시 저장
						location.reload();
					} else {
						alert("처리 실패: 알 수 없는 오류");
					}

					// 필요시 form 상태 초기화나 스타일 변경도 가능
				})
				.catch(err => {
					console.error(err);
					alert("요청 처리 중 오류가 발생했습니다.");
				});
		});
	});


});

function updateProcessOptions(processSelect, currentValue) {
  const form = processSelect.closest('form');
  const requestSelect = form.querySelector('select[name="request_type"]');
  const type = requestSelect.value;

  if (type === 'C') {
    processSelect.innerHTML = `<option value="C" selected>완료</option>`;
    processSelect.disabled = true;
  } else {
    processSelect.innerHTML = `
      <option value="" ${currentValue === '' ? 'selected' : ''}>접수</option>
      <option value="P" ${currentValue === 'P' ? 'selected' : ''}>승인(처리중)</option>
      <option value="C" ${currentValue === 'C' ? 'selected' : ''}>완료</option>
      <option value="D" ${currentValue === 'D' ? 'selected' : ''}>거절</option>
    `;
    processSelect.disabled = false;
  }
}

// 기존 이벤트 리스너는 이렇게 변경
document.querySelectorAll('select[name="request_type"]').forEach(requestSelect => {
  const processSelect = requestSelect.closest('form').querySelector('select[name="process_status"]');

  // 초기 상태 설정
  updateProcessOptions(processSelect, processSelect.value);

  // 변경 시 적용
  requestSelect.addEventListener('change', () => {
    updateProcessOptions(processSelect, '');
  });
});

// resetForm도 이렇게 수정
function resetForm(button) {
  const form = button.closest("form");

  const requestTypeSelect = form.querySelector("select[name='request_type']");
  const processStatusSelect = form.querySelector("select[name='process_status']");

  const originalRequestType = requestTypeSelect.dataset.original;
  const originalProcessStatus = processStatusSelect.dataset.original;

  // request_type 복원
  requestTypeSelect.value = originalRequestType;

  // process_status 옵션 갱신 + 선택값 셋팅
  updateProcessOptions(processStatusSelect, originalProcessStatus);
}