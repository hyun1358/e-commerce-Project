document.addEventListener('DOMContentLoaded', () => {
    const progressCard = document.querySelector('.progress-card');
    if (!progressCard) return;

    const currentStatus = progressCard.dataset.status;
    const steps = Array.from(document.querySelectorAll('.step'));
    const statusOrder = ['결제완료', '상품준비중', '배송시작', '배송중', '배송완료'];
    const currentIndex = statusOrder.indexOf(currentStatus);

    if (currentIndex === -1) {
        console.error('Invalid order status:', currentStatus);
        return;
    }

    // Loop through steps to update their 'active' class
    for (let i = 0; i < steps.length; i++) {
        if (i <= currentIndex) {
            steps[i].classList.add('active');
        }
    }
	
	const totalPrice = parseInt(document.getElementById("totalPrice").innerText.replace(/[,원\s]/g, ""));
	const deliveryPrice = parseInt(document.getElementById("deliveryPrice").innerText.replace(/[,원\s]/g,""));
	const pointPrice = parseInt(document.getElementById("pointPrice").innerText.replace(/[^0-9]/g, ''));
	const finalPrice = totalPrice + deliveryPrice - pointPrice;
	
	const totalAmount = document.querySelector(".total-amount");
	totalAmount.innerText = finalPrice.toLocaleString() + "원";
	
	
	 
});