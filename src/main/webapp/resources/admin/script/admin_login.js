function login_send(f) {
	let id = f.admin_id.value.trim();
	let pwd = f.admin_pwd.value.trim();

	let id_pattern = /^[a-zA-Z0-9!@#$%^&*()_+{}\[\]:;<>,.?~\\/\-]{4,}$/;
	let pwd_pattern = /^[a-zA-Z0-9!@#$%^&*()_+{}\[\]:;<>,.?~\\/\-]{5,}$/;

	if (id === "") {
		alert("아이디를 입력해 주세요");
		return false;
	}

	if (!id_pattern.test(id)) {
		alert("아이디는 4자 이상이며, 영문/숫자/특수문자만 사용할 수 있습니다.");
		return false;
	}

	if (pwd === "") {
		alert("비밀번호를 입력해주세요");
		return false;
	}

	if (!pwd_pattern.test(pwd)) {
		alert("비밀번호는 최소 5자 이상이어야 하며, 영문, 숫자, 특수문자만 사용할 수 있습니다.");
		return false; // 중요!
	}

	fetch(`${contextPath}/admin/login`, {
		method: "POST",
		headers: { "Content-Type": "application/x-www-form-urlencoded" },
		body: `admin_id=${encodeURIComponent(id)}&admin_pwd=${encodeURIComponent(pwd)}`,
	})
		.then((res) => res.json())
		.then((data) => {
			if (data.success) {
				alert(data.name + " 관리자님, 환영합니다");
				location.href = `${contextPath}/admin/main`;
			} else {
				alert("로그인 실패! 아이디 또는 비밀번호가 올바르지 않습니다.");
				/* alert("로그인 실패: " + data.message);*/
			}
		})
		.catch((err) => {
			console.error("서버 오류:", err);
			alert("서버 오류가 발생했습니다.");
		});

	return false; // 폼 기본 제출 막기

}


document.addEventListener("DOMContentLoaded", () => {
	const form = document.getElementById("adminLoginForm");

	form.addEventListener("submit", function(e) {
		e.preventDefault(); // 기본 제출 막기
		login_send(this);
	});
});