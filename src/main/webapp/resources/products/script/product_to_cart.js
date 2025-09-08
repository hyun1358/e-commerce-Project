function initializeCartActions(contextPath) {
    function sendRequest(url, params, callback, method) {
        const xhr = new XMLHttpRequest();
        const httpMethod = method ? method.toUpperCase() : "GET";

        if (httpMethod === "GET" && params) {
            url += "?" + params;
        }

        xhr.onreadystatechange = function () {
            callback(xhr);
        };

        xhr.open(httpMethod, url, true);

        if (httpMethod === "POST") {
            xhr.setRequestHeader("Content-type", "application/x-www-form-urlencoded");
            xhr.send(params);
        } else {
            xhr.send(null);
        }
    }

    // 로그인 사용자의 장바구니 추가
    window.addCart = function(product_id, user_idx) { // 전역 함수로 노출
        const url = contextPath + "/cart_insert.do";
        const param = "product_id=" + product_id + "&user_idx=" + user_idx;

        sendRequest(url, param, addFn, "POST");
    }

    function addFn(xhr) {
        if (xhr.readyState === 4 && xhr.status === 200) {
            const data = xhr.responseText;
            const json = new Function('return ' + data)();
            if (json[0].result === 'yes') {
                alert("장바구니에 담았습니다.");
            } else {
                alert("이미 장바구니에 있습니다. 수량변경은 장바구니에서 가능합니다");
            }
        }
    }

    // 비회원 장바구니 추가
    window.addGuestCart = function(product_id) { // 전역 함수로 노출
        const url = contextPath + "/guest_cart_insert.do";
        const param = "product_id=" + product_id;

        sendRequest(url, param, guestAddFn, "POST");
    }

    function guestAddFn(xhr) {
        if (xhr.readyState === 4 && xhr.status === 200) {
            const result = xhr.responseText;
            if (result === "added") {
                alert("장바구니에 담았습니다 (비회원).");
            } else if (result === "exists") {
                alert("이미 장바구니에 있습니다. 수량변경은 장바구니에서 가능합니다");
            } else {
                alert("장바구니 저장 실패.");
            }
        }
    }
}