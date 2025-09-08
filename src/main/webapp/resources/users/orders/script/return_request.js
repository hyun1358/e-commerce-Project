document.addEventListener('DOMContentLoaded', function() {
	const form = document.getElementById('returnRequestForm');
	const submitBtn = document.getElementById('submitBtn');

	submitBtn.addEventListener('click', function(event) {
		event.preventDefault();

		const formData = new FormData(form);

		const note = formData.get('note').trim();

		if (!note) {
			alert('요청 사유를 입력해주세요.');
			return;
		}
		fetch('/final/user/request', {
			method: 'POST',
			body: formData
		})
			.then(response => {
				if (!response.ok) {
					throw new Error('서버 응답 오류: ' + response.status);
				}
				return response.json(); // JSON으로 응답한다고 가정
			})
			.then(result => {
				if (result.success) {
					alert('신청 완료!');
					location.href="/final/mypage/check"
				} else {
					alert('신청 실패!');
				}
			})
			.catch(error => {
				alert('요청 중 오류가 발생했습니다: ' + error.message);
			});
	});
});