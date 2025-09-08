function initializeProductListActions(contextPath) {
    let product_idList = [];

    document.querySelectorAll(".wishlist-btn").forEach(btn => {
        const product_id = parseInt(btn.dataset.productId);
        if (!isNaN(product_id)) {
            product_idList.push(product_id);
        }

        btn.addEventListener("click", function (e) {
            wishBtn(btn, product_id);
        });
    });

    if (product_idList.length > 0) {
        fetch(`${contextPath}/product_list_wishStatus`, {
            method: "POST",
            headers: {
                "Content-Type": "application/json"
            },
            body: JSON.stringify({ product_id: product_idList })
        })
            .then(response => response.json())
            .then(data => {
                data.product_id.forEach(pid => {
                    document.querySelectorAll(".wishlist-btn").forEach(btn => {
                        if (parseInt(btn.dataset.productId) === pid) {
                            const svg = btn.querySelector('svg');
                            if (svg) svg.classList.add("active");
                        }
                    });
                });
            })
            .catch(error => console.log("error: ", error.message));
    } else {
        console.log("위시리스트 버튼이 없거나 product_id가 없습니다.");
    }
}

function wishBtn(btnElement, product_id) {
    fetch(`${contextPath}/user_wishList?product_id=` + product_id)
        .then((response) => response.json())
        .then((data) => {
            const svg = btnElement.querySelector('svg');
            if (!svg) return;

            if (data.status === "added") {
                svg.classList.add("active");
                alert("찜 추가 완료");
            } else if (data.status === "removed") {
                svg.classList.remove("active");
                alert("찜 삭제 완료");
            }
        })
        .catch((error) => console.log(error));
}