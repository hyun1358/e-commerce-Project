document.addEventListener("DOMContentLoaded", function () 
{
    const orderButton = document.getElementById("btnOrder");
    const agreeAllCheckbox = document.getElementById("agree_all");
    const agreementCheckboxes = document.querySelectorAll('.agree_check');

	//receiver_zipcode 우편번호
	//receiver_address1 주소
	//receiver_address2 상세
	const zipcode = document.getElementById("receiver_zipcode");
	const address1 = document.getElementById("receiver_address1");
	const address2= document.getElementById("receiver_address2");
	
	let zipcode_check = false;
	let address1_check = false;
	let address2_check = false;
	

// 버튼 클릭 이벤트
if (orderButton)
{
    orderButton.addEventListener("click", function () 
	{
        let allChecked = true;
        // 모든 필수 항목이 체크되었는지 확인
        agreementCheckboxes.forEach(checkbox => 
		{
            if (!checkbox.checked) 
			{
                allChecked = false;
            }
        });

        if (!allChecked) {
            alert("필수 약관에 모두 동의해야 결제를 진행할 수 있습니다.");
            return; // 이동 중단
        }

		
		if(zipcode.value.trim()==="")
		{
			alert("우편번호를 입력하세요");
			return;
		}
		else
		{
			zipcode_check = true;
		}
		
		if(address1.value.trim()==="")
		{
			address1_check=false;
			alert("주소를 입력하세요");
			return;
		}
		else
		{
			address1_check=true;
		}
		
		if(address2.value.trim()==="")
		{
			address2_check=false;
			alert("상세주소를 적어주세요");
			return;
		}
		
		else
		{
			address2_check=true;
		}

        if (typeof contextPath !== "undefined") 
		{
            requestPay()
        } 
		else 
		{
            console.error("contextPath is not defined.");
        }
	});
}
// 전체 동의 체크박스 이벤트
if (agreeAllCheckbox) 
{
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
});/*돔*/

let products = [];
document.querySelectorAll('.item-summary').forEach(item => {
	const productName = item.dataset.productName;  // ✅ camelCase
	const productId = item.dataset.productId;
	const quantity = item.dataset.quantity;
	const amount = item.dataset.amount;

	if (productId && quantity && amount) {
		products.push({ productName, productId, quantity, amount });
	}
});
 //결제 페이지에 있는 상품id 수량

function requestPay()
{
	const baseUrl = window.location.origin; // 접속한 주소(도메인+포트) 동적 할당

	var IMP = window.IMP; 
	IMP.init("imp03207245"); 

	function generateUUID() 
	{
	  return 'xxxxxxxx-xxxx-4xxx-yxxx-xxxxxxxxxxxx'.replace(/[xy]/g, function(c) {
	    const r = Math.random() * 16 | 0;
	    const v = c === 'x' ? r : (r & 0x3 | 0x8);
	    return v.toString(16);
	  });
	}
	
	function sanitizeProductName(name) 
	{
	  // 특수문자(® ™ 등) 제거
	  return name.replace(/[®™]/g, '');
	}
	
	
	
	let name = document.getElementById("receiver_name").value;
	let phone = document.getElementById("receiver_phone").value;
	let zipcode = document.getElementById("receiver_zipcode").value;
	let address1 = document.getElementById("receiver_address1").value;
	let address2 = document.getElementById("receiver_address2").value;
	let userDiv = document.getElementById("user-data");
	let email = userDiv.dataset.email;
	let uuid = generateUUID()
	let total_pirce = document.getElementById("total_value").textContent.trim();
	
	const orderButton = document.getElementById("btnOrder");
	const productName = orderButton.dataset.productName;
	
	
	const cleanedText = sanitizeProductName(productName).replace(/\s+/g, ' ').trim(); //상품이름 나오기ㅌ
	console.log(uuid);
	// 배송 요청사항 가져오기
	let deliveryRequest = document.getElementById("delivery_request").value;
    IMP.request_pay({
        pg : 'html5_inicis.INIpayTest',
        pay_method : 'card',
        merchant_uid: uuid,
        name : cleanedText,
        amount : total_pirce,
        buyer_email : email,
        buyer_name : name,
        buyer_tel : phone,
        buyer_addr : address1+" "+address2,
        buyer_postcode : zipcode,
		products : products
    }, 
		function (rsp) 
		{
        	if(rsp.success) 
			{
                jQuery.ajax({
			        url: `${baseUrl}/pay_test`, 
			        method: "POST",
			        headers: { "Content-Type": "application/json" },
			        data: JSON.stringify(
					{
					  success:rsp.success,								//true or false
			          imp_uid: rsp.imp_uid,               				 // 결제 고유번호
					  pay_method:rsp.pay_method,          				 //결제 종류(ex card)					  
			          merchant_uid: rsp.merchant_uid,     				 // 주문번호
					  name:rsp.name, 									//주문 상품 이름
					  paid_amount:rsp.paid_amount,						//상품가격
				      currency:rsp.currency,							//돈 종류(Ex: KRW)
				      card_name:rsp.card_name,								//카드사
					  card_number:rsp.card_number,						//카드번호
					  buyer_name: rsp.buyer_name,
					  buyer_tel:rsp.buyer_tel,							//주문자 전번
					  buyer_addr:rsp.buyer_addr,						//주문자 주소
					  buyer_postcode:rsp.buyer_postcode,					//우편번호
					  paid_at:rsp.paid_at,									//결제시간
					  receipt_url:rsp.receipt_url,						//url
					  status:rsp.status,
					  deliveryRequest:deliveryRequest,						//요청사항
					  products:products
			        })
		      	}).done(function(data)//컨트롤에서 리턴한 값이 들어옴 
					{
						
						location.href = `${baseUrl}/orders_udapte?merchant_uid=`+data;
		      })
            } 
			else 
			{
                console.log(rsp);
            }
    	});
}/*function requestPay()*/



//주소가져오기
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
