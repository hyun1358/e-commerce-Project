function sorting(f)
{
      fetch(`/final/products/sortproduct?sort=${f}`)
        .then(res => res.text())
        .then(html => {
          document.getElementById('product-list').innerHTML = html;
        })
        .catch(err => console.error('정렬 실패:', err));
}
function dropdown() 
{
	const panel = document.getElementById('compare-panel');
	panel.classList.toggle('open');
}

let comparisonList = []; // 선택된 상품 목록

window.addToComparison = function addToComparison(image, title, price, id) 
{
	if(comparisonList.length >=3)
	{
		alert("최대 3개의 상품만 비교 할수 있습니다.");
		return;
	}
    // 이미 목록에 있는지 확인
    if (comparisonList.some(product => product.id === id)) {
        alert('이미 비교 목록에 추가된 상품입니다.');
        return;
    }

    // 상품 정보를 추가
    comparisonList.push({ image, title, price, id});
    updateComparisonPanel();
};

document.querySelector('.reset-btn').addEventListener('click', () => {
    comparisonList = []; // 목록 초기화
    updateComparisonPanel();
});

function updateComparisonPanel() 
{
	const comparePanelTitle = document.querySelector('.compare-panel-title span');
    comparePanelTitle.textContent = `비교할 상품: ${comparisonList.length} / 3`;
	
    const comparePanelInfo = document.querySelector('.compare-panel-info');
    comparePanelInfo.innerHTML = ''; // 기존 내용 삭제

    comparisonList.forEach(product => 
    {
        const productDiv = document.createElement('div');
        productDiv.classList.add('compare-panel-box');

        productDiv.innerHTML = 
        `
            <div class="compare-panel-product-img">
                <img src="${product.image}" alt="${product.title}" width="100px" height="100px"/>
            </div>
            <div class="compare-panel-product-name">
                <span>${product.title}</span><br>
                <button class="compare-panel-product-remove_bnt" onclick="removeFromComparison('${product.id}')"></button>
            </div>
        `;

        comparePanelInfo.appendChild(productDiv);
    });

    // 비교 패널 표시
    if (comparisonList.length === 0) 
    {
        document.getElementById('compare-panel').style.display = 'none';
    } 
    else 
    {
        document.getElementById('compare-panel').style.display = 'block';
    }
}

function removeFromComparison(id) 
{
    // 상품 제거
    comparisonList = comparisonList.filter(product => product.id !== id);
    updateComparisonPanel();
}
document.querySelector('.reset-btn').addEventListener('click', () => 
{
    comparisonList = []; // 목록 초기화
    updateComparisonPanel();
});

document.querySelector('.result-btn').addEventListener('click', () => 
{
    if (comparisonList.length === 0) 
    {
        alert('비교할 상품이 없습니다.');
        return;
    }
});

function compareProductResult()
{
	const laptop_container = document.getElementById("laptop-container");
	const modal = document.getElementById('modal-container');
	const modal_overlay = document.getElementById('modal-overlay');
	
	
    if (modal.style.display === "none" || modal.style.display === "") 
    {
        modal_overlay.style.display = "block";
        laptop_container.style.display = "block";
        modal.style.display = "block";
    }

	
    const modalProductCards = document.querySelector('.modalProductCards');
    modalProductCards.innerHTML = ''; // 기존 내용 삭제

    comparisonList.forEach(product => 
    {
		const modalProductCard = document.createElement('div');
		modalProductCard.classList.add('modalProductCard');

        modalProductCard.innerHTML = 
        `
            <div class="modal-card-product-img">
                <img src="${product.image}" alt="${product.title}"/>
            </div>
            <div class="modal-card-product-name">
                <strong>${product.title}</strong>
            </div>
            <div class="modal-card-product-price">
                <strong>${Number(product.price).toLocaleString()}원</strong>
            </div>
        `;
        console.log(product.price);
        modalProductCards.appendChild(modalProductCard);
    });
    
    const productSpecifications = document.querySelector('.productSpecifications');
    productSpecifications.innerHTML = ''; // 기존 내용 삭제


function formatDate(dateStr) 
{
  const date = new Date(dateStr);
  if (isNaN(date.getTime())) return dateStr; // 변환 실패 시 원본 반환
  const pad = (n) => n.toString().padStart(2, '0');
  return `${date.getFullYear()}-${pad(date.getMonth()+1)}-${pad(date.getDate())} ` +
         `${pad(date.getHours())}:${pad(date.getMinutes())}:${pad(date.getSeconds())}`;
}

function formatWeight(weight) 
{
  const num = Number(weight);
  return isNaN(num) ? weight : num.toFixed(2);
}

// 서버에 상품 제목 목록 전송 후 스펙 받아오기
fetch('product/specs', 
{
    method: 'POST',
    headers: {
        'Content-Type': 'application/json'
    },
    body: JSON.stringify(comparisonList.map(p => p.id))
})
.then(response => response.json())
.then(specsList => 
{
    const productSpecifications = document.querySelector('.productSpecifications');
    productSpecifications.innerHTML = '';
    specsList.forEach(spec => {
        const specHtml = `
            <div class="productSpecification">
                <div class="product_Specification product-cpu">
                    <h3>CPU</h3><hr><span>${spec.cpu}</span>
                </div>
                <div class="product_Specification product-ram">
                    <h3>RAM</h3><hr><span>${spec.ram}</span>
                </div>
                <div class="product_Specification product-storage">
                    <h3>저장장치</h3><hr><span>${spec.storage_type} ${spec.storage_size} ${spec.storage_unit}</span>
                </div>
                <div class="product_Specification product-display">
                    <h3>해상도/인치</h3><hr><span>${spec.resolution} / ${spec.screen_size}</span>
                </div>
				<div class="product_Specification product-gpu">
                    <h3>그래픽카드</h3><hr><span>${spec.gpu}</span>
                </div>
				<div class="product_Specification product-audio">
                    <h3>오디오</h3><hr><span>${spec.audio_description}</span>
                </div>
				<div class="product_Specification product-bluetooth">
                    <h3>블루투스</h3><hr><span>${spec.bluetooth}</span>
                </div>
				<div class="product_Specification product-network">
                    <h3>Wi-fi</h3><hr><span>${spec.network}</span>
                </div>
				<div class="product_Specification product-ports">
				    <h3>포트</h3><hr>
				    <div class="ports-content">${spec.ports}</div>
				</div>
				<div class="product_Specification product-dimensions">
                    <h3>크기</h3><hr><span>${spec.dimensions}</span>
                </div>
				<div class="product_Specification product-weight">
                    <h3>무게</h3><hr><span>${spec.weight.toFixed(1)}kg</span>
                </div>
				<div class="product_Specification product-release_date">
			    <h3>출시일</h3><hr>
			    <span>
					${spec.formatter_date}
			    </span>
			</div>
            </div>
        `;
 		console.log(spec.release_date);
        productSpecifications.innerHTML += specHtml;
    });
})
.catch(error => {
    console.error('스펙 불러오기 실패:', error);
});



function sortProductsByPrice(order = 'asc') {
	
    // 가격 문자열을 숫자로 변환 후 정렬
    const sorted = [...products].sort((a, b) => {
	const priceA = a.price;
	const priceB = b.price;
        return order === 'asc' ? priceA - priceB : priceB - priceA;
    });

    renderProducts(sorted);
}
function renderProducts(productList) {
    const container = document.getElementById('laptop-container');
    const existingSections = container.querySelectorAll('section.image-gallery');
    existingSections.forEach(section => section.remove());

    for (let i = 0; i < productList.length; i++) {
        if (i % 4 === 0) {
            const section = document.createElement('section');
            section.className = 'image-gallery';
            section.setAttribute('aria-label', `상품 이미지 갤러리 ${i / 4 + 1}`);
            container.appendChild(section);
        }

        const product = productList[i];
        const productCard = document.createElement('div');
        productCard.className = 'product-card';
        productCard.innerHTML = `
            <div class="product-image">
                <img src="${product.image}" alt="${product.title}" width="290px" height="250px"/>
                <div class="product-actions">
					<button class="wishlist-btn">
						<svg xmlns="http://www.w3.org/2000/svg"
							fill="currentColor" class="bi bi-heart" viewBox="0 0 16 16">
							<path d="m8 2.748-.717-.737C5.6.281 2.514.878 1.4 3.053c-.523 1.023-.641 2.5.314 4.385.92 1.815 2.834 3.989 6.286 6.357 3.452-2.368 5.365-4.542 6.286-6.357.955-1.886.838-3.362.314-4.385C13.486.878 10.4.28 8.717 2.01zM8 15C-7.333 4.868 3.279-3.04 7.824 1.143q.09.083.176.171a3 3 0 0 1 .176-.17C12.72-3.042 23.333 4.867 8 15" />
						</svg>
					</button>
					
					<button class="cart-btn">
						<svg xmlns="http://www.w3.org/2000/svg"
							fill="currentColor" class="bi bi-cart" viewBox="0 0 16 16">
							<path d="M0 1.5A.5.5 0 0 1 .5 1H2a.5.5 0 0 1 .485.379L2.89 3H14.5a.5.5 0 0 1 .491.592l-1.5 8A.5.5 0 0 1 13 12H4a.5.5 0 0 1-.491-.408L2.01 3.607 1.61 2H.5a.5.5 0 0 1-.5-.5M3.102 4l1.313 7h8.17l1.313-7zM5 12a2 2 0 1 0 0 4 2 2 0 0 0 0-4m7 0a2 2 0 1 0 0 4 2 2 0 0 0 0-4m-7 1a1 1 0 1 1 0 2 1 1 0 0 1 0-2m7 0a1 1 0 1 1 0 2 1 1 0 0 1 0-2" />
						</svg>
					</button>
				</div>
            </div>
            <div class="product-title">
                <a href="product_details.jsp" class="product-name">${product.title}</a>
            </div>
            <div class="product-price">
                <span>${product.price}원</span>
            </div>
            <button class="delivery">무료배송</button>
            <button class="compare" onclick="addToComparison('${product.image}', '${product.title}', '${product.price}')">
                <span>비교하기</span>
            </button>
        `;
        container.querySelector('section.image-gallery:last-child').appendChild(productCard);
    }
}
document.querySelector('.price-filter a:nth-child(1)').addEventListener('click', () => sortProductsByPrice('asc'));
document.querySelector('.price-filter a:nth-child(2)').addEventListener('click', () => sortProductsByPrice('desc'));


//gpt추천, db에 연결해서 사용할거라면 이런 구조
/*let products = []; // DB에서 받아온 원본
let filteredProducts = []; // 정렬, 필터 등 적용된 상태

// DB 연동 후 초기 렌더링
fetch('/api/products')
  .then(res => res.json())
  .then(data => {
    products = data;
    filteredProducts = [...products];
    renderProducts(filteredProducts);
  });

// 정렬
function sortProductsByPrice(order = 'asc') {
  filteredProducts.sort((a, b) => order === 'asc' ? a.price - b.price : b.price - a.price);
  renderProducts(filteredProducts);
}*/
}