document.addEventListener("DOMContentLoaded",function()
{
	const tabs = document.querySelectorAll(".status-tab");
	tabs.forEach(tab =>
	{
		tab.addEventListener("click",function()
		{
			tabs.forEach(t => t.classList.remove("active"));
			this.classList.add("active");
			
			const status = this.dataset.status;
			fetchOrderList(status);	
		})
	})	
})

function fetchOrderList(status) {
  const url = `${contextPath}/orderhistory_filter?status=${status}`;
  fetch(url)
    .then(response => 
	{
      if (!response.ok) throw new Error("오류");
      return response.json();
    })
    .then(orderMap => 
	{
		const orderListContainer = document.getElementById("order-list");
      	orderListContainer.innerHTML = "";

  	if (Object.keys(orderMap).length === 0) 
  	{
		orderListContainer.innerHTML = "<div class='no-orders'>해당 상태의 주문 내역이 없습니다.</div>";
		return;
  	}

    for (const orderId in orderMap) 
	{
		const products = orderMap[orderId];
        // orderId, products는 JS 변수이므로 문자열 내 ${}가 아닌 실제 변수 사용
        let orderHtml = `
          <div class="order-summary">
            <span class="order-date">${products[0].order_date}</span>
            <input type="hidden" class="order-id" value="${orderId}">
            <span class="order-status">상태: ${products[0].status}</span>
            <button onclick="location.href='${contextPath}/order/detail?order_id=${orderId}'">상세보기</button>
          </div>
          <div id="detail-${orderId}" class="order-details">
        `;

        products.forEach((product, index) => {
          orderHtml += `
            <div class="order-items ${index !== products.length - 1 ? 'with-border' : ''}">
              <div class="order-image">
                <img src="${contextPath}/resources/${product.image1}" alt="product_image" />
              </div>
              <div class="order-info">
                <div class="order-name">${product.product_name}</div>
                <div class="order-price">${product.amount.toLocaleString()}원</div>
                <div class="order-quantity">수량: ${product.quantity}</div>
                <div class="delivery-status">상태: ${product.status}</div>
              </div>
              <div class="order-actions">
                ${
                  !product.review_id || product.review_id === 0
                    ? `<button class="action-button primary" style="background:#007BFF;color:white"
                          onclick="location.href='${contextPath}/review_write?product_id=${product.product_id}&product_name=${encodeURIComponent(product.product_name)}&image1=${encodeURIComponent(product.image1)}&order_id=${orderId}&returnUrl=/orderhistory'">리뷰작성</button>`
                    : `<button class="action-button primary"
                          onclick="location.href='${contextPath}/review_show?review_id=${product.review_id}&product_id=${product.product_id}&product_name=${encodeURIComponent(product.product_name)}&image1=${encodeURIComponent(product.image1)}&order_id=${orderId}&returnUrl=/orderhistory'">리뷰수정</button>`
                }
                <button class="action-button state"
                  onclick="location.href='${contextPath}/order/delivery?order_id=${orderId}'">배송상세</button>
              </div>
            </div>
          `;
        });

        orderHtml += `</div>`;

        orderListContainer.insertAdjacentHTML('beforeend', orderHtml);
      }
    })
    .catch(error => {
      console.error(error);
      alert("주문내역을 불러오는 중 오류가 발생했습니다.");
    });
}