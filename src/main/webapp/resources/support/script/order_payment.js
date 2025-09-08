document.addEventListener("DOMContentLoaded", function () {
    const orderButton = document.getElementById("btnOrder");
    const agreeAllCheckbox = document.getElementById("agree_all");
    const agreementCheckboxes = document.querySelectorAll('.agree_check');

    // 버튼 클릭 이벤트
    if (orderButton) {
        orderButton.addEventListener("click", function () {
            let allChecked = true;

            // 모든 필수 항목이 체크되었는지 확인
            agreementCheckboxes.forEach(checkbox => {
                if (!checkbox.checked) {
                    allChecked = false;
                }
            });

            if (!allChecked) {
                alert("필수 약관에 모두 동의해야 결제를 진행할 수 있습니다.");
                return; // 이동 중단
            }

            // contextPath를 사용해 결제 완료 페이지로 이동
            if (typeof contextPath !== "undefined") {
                window.location.href = contextPath + "/users/orders/order_complete.jsp";
            } else {
                console.error("contextPath is not defined.");
            }
        });
    }

    // 전체 동의 체크박스 이벤트
    if (agreeAllCheckbox) {
        agreeAllCheckbox.addEventListener("change", function () {
            agreementCheckboxes.forEach(checkbox => {
                checkbox.checked = agreeAllCheckbox.checked;
            });
        });
    }

    // 개별 체크박스 이벤트 -> 전체 동의 체크박스 상태 업데이트
    agreementCheckboxes.forEach(checkbox => {
        checkbox.addEventListener("change", function () {
            const allIndividualChecked = Array.from(agreementCheckboxes).every(cb => cb.checked);
            if (agreeAllCheckbox) {
                agreeAllCheckbox.checked = allIndividualChecked;
            }
        });
    });
});

function execDaumPostcode()
{
	new daum.Postcode(
	{
	    oncomplete: function(data) 
	    {
		    document.getElementById('receiver_zipcode').value = data.zonecode;
		    document.getElementById('receiver_address1').value = data.roadAddress;
      	}
    }).open();
  }