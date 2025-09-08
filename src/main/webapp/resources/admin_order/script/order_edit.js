function submitOrder(order_id){

	const statusInput = document.querySelector('input[name="orderStatus"]:checked');

	if (!statusInput) {
		alert('주문 상태를 선택해주세요.');
		return;
	}
	const orderStatus = statusInput.value;
	
	const formData = new URLSearchParams();
	formData.append("order_id", order_id);       // ✔ 이 값이 undefined일 가능성 있음
	formData.append("orderStatus", orderStatus); // ✔ 이 값은 console.log에서 "상품준비"로 확인됨
	
	
	const submitBtn = document.querySelector('.btn-submit');
	submitBtn.disabled = true;
	submitBtn.innerText = "수정 중...";
	
	fetch(`${contextPath}/admin/order/edit/submit`, {
		method: 'POST',
		headers: {
			'Content-Type': 'application/x-www-form-urlencoded'
		},
		body: formData.toString()
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
				location.reload(); // 옵션
			} else {
				alert('수정 실패!');
			}
		})
		.catch(e => {
			console.error(e);
			alert('오류 발생!');
		})
		.finally(() => {
			submitBtn.disabled = false;
			submitBtn.innerText = "수정";
		});
	
}