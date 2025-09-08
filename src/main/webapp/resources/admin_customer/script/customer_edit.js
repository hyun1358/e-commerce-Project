function togglePassword(userIdx, btn) {
  const input = document.getElementById(`memberPassword_${userIdx}`);
  const isSecured = input.classList.contains("secure");

  if (isSecured) {
    input.classList.remove("secure");
    btn.textContent = "🔓";
  } else {
    input.classList.add("secure");
    btn.textContent = "🔒";
  }
}


function submitUser(user_idx) {
	const container = document.getElementById(`customer_${user_idx}`);
	if (!container) {
		console.error("유저컨테이너를 찾을 수 없습니다:", user_idx);
		return;
	}

	const submitBtn = document.querySelector(`.btn-submit[data-user-idx="${user_idx}"]`);
	if (submitBtn) {
		submitBtn.disabled = true;
		submitBtn.innerText = "수정 중...";
	} else {
		console.warn(`submitBtn not found for user_idx=${user_idx}`);
	}

	const user_id = container.querySelector(`input[name="user_id_${user_idx}"]`).value;
	const user_pwd = container.querySelector(`input[name="user_pwd_${user_idx}"]`).value;
	const user_name = container.querySelector(`input[name="user_name_${user_idx}"]`).value;
	const birth = container.querySelector(`input[name="birth_${user_idx}"]`).value;
	const email = container.querySelector(`input[name="email_${user_idx}"]`).value;
	const phone = container.querySelector(`input[name="phone_${user_idx}"]`).value;
	const address1 = container.querySelector(`input[name="address1_${user_idx}"]`).value;
	const address2 = container.querySelector(`input[name="address2_${user_idx}"]`).value;
	const account_status_input = container.querySelector(`input[name="account_status_${user_idx}"]:checked`);
	const account_status = account_status_input ? parseInt(account_status_input.value, 10) : null;

	const gender_input = container.querySelector(`input[name="gender_${user_idx}"]:checked`);
	const gender = gender_input ? gender_input.value : null;

	// 필수 항목 검사
	if (!user_id) {
		alert('아이디를 입력해주세요.');
		return;
	}
	if (!user_pwd) {
		alert('비밀번호를 입력해주세요.');
		return;
	}
	if (!user_name) {
		alert('이름을 입력해주세요.');
		return;
	}
	if (!birth) {
		alert('생년월일을 입력해주세요.');
		return;
	}
	if (!email) {
		alert('이메일을 입력해주세요.');
		return;
	}

	if (!phone) {
		alert('휴대폰번호를 입력해주세요.');
		return;
	}

	const data = {
		user_idx: user_idx,
		user_id,
		user_pwd,
		user_name,
		birth,
		account_status,
		gender,
		email,
		phone,
		address1,
		address2
	};

	fetch('/final/admin/customer/edit/submit', {
		method: 'POST',
		headers: {
			'Content-Type': 'application/json'
		},
		body: JSON.stringify(data)
	})
		.then(res => {
			if (!res.ok) {
				throw new Error(`서버 오류: ${res.status}`);
			}
			return res.json();
		})
		.then(result => {
			if (result.success) {
				alert('수정 완료!');
				location.hash = `#customer_${user_idx}`;
				location.reload(); // 새로고침
			} else {
				alert('수정 실패!');
			}
		})
		.catch(e => {
			console.error(e);
			alert('오류 발생!');
		})
		.finally(() => {
			// 버튼 상태 원복
			if (submitBtn) {
				submitBtn.disabled = false;
				submitBtn.innerText = "수정";
			}
		});
}

function showUserTab(userIdx) {
	// 모든 탭 숨김
	const allTabs = document.querySelectorAll('.user-tab');
	allTabs.forEach(tab => tab.style.display = 'none');

	// 선택한 탭만 보이기
	const selected = document.getElementById('customer_' + userIdx);
	if (selected) {
		selected.style.display = 'block';
	}

	// 탭 버튼 활성화 스타일
	document.querySelectorAll('.tab-btn').forEach(btn => btn.classList.remove('active'));
	const activeBtn = Array.from(document.querySelectorAll('.tab-btn')).find(btn => btn.onclick.toString().includes(userIdx));
	if (activeBtn) activeBtn.classList.add('active');
}

// 페이지 로드 시 첫 번째 유저 표시
window.addEventListener('DOMContentLoaded', () => {
	const first = document.querySelector('.user-tab');
	if (first) first.style.display = 'block';

	const firstBtn = document.querySelector('.tab-btn');
	if (firstBtn) firstBtn.classList.add('active');


	const hash = location.hash;
	if (hash && hash.startsWith('#customer_')) {
		const userIdx = hash.replace('#customer_', '');
		showUserTab(userIdx); // 해당 상품 탭 열기
	}

	//추가
	const nav = document.querySelector('.tab-nav-vertical');
	const initialTop = nav.getBoundingClientRect().top + window.scrollY- 50;;
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