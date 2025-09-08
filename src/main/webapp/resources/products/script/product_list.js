// 전역 상태
let comparisonList = [];
let products = [];  // DB 연동 시 여기에 데이터 담기 가능 (필요시)

// DOMContentLoaded 이벤트 - DOM이 완전히 준비된 후 실행
document.addEventListener('DOMContentLoaded', () => 
{
  const defaultSort = document.body.dataset.defaultSort || "sales"; // 기본 정렬값
  const links = document.querySelectorAll('.price-filter > a');
  const currentKeyword = document.body.dataset.keyword;

  //  [1] 최초 로드 시 기본 정렬 active 클래스 적용
  links.forEach(link => 
  {
    if (link.dataset.sort === defaultSort) 
    {
      link.classList.add('active');
    }
  });

  links.forEach(link => {
    link.addEventListener('click', e => {
      e.preventDefault();
      if (!hasProducts) { //상품이 없으면 아무 동작도 하지 않음
        return;
      }
      
      // 모든 링크에서 'active' 클래스 제거
      links.forEach(el => el.classList.remove('active'));
      
      // 현재 클릭된 링크에 'active' 클래스 추가
      link.classList.add('active');
      const sortKey = link.dataset.sort;
      fetch(`${contextPath}/search/sortproduct?keyword=${encodeURIComponent(currentKeyword)}&sort=${sortKey}`)
        .then(res => res.text())
        .then(html => {
          document.getElementById('product-list').innerHTML = html;
        })
        .catch(err => console.error('검색 정렬 실패:', err));
    });
  });

  // 초기화 버튼 이벤트
  const resetBtn = document.querySelector('.reset-btn');
  if (resetBtn) {
    resetBtn.addEventListener('click', () => {
      comparisonList = [];
      updateComparisonPanel();
    });
  }

  // 결과보기 버튼 이벤트
  const resultBtn = document.querySelector('.result-btn');
  if (resultBtn) {
    resultBtn.addEventListener('click', () => {
      if (comparisonList.length === 0) {
        alert('비교할 상품이 없습니다.');
        return;
      }
      compareProductResult();
    });
  }

	//상품 리스트 찜
	let product_idList = [];
    
    // forEach 대신 직접 배열에 push
    document.querySelectorAll(".wishlist-btn").forEach((btn, index) => {
        const product_id = btn.dataset.productId;
        if (product_id) {  // null/undefined 체크
            product_idList.push(parseInt(product_id)); // 정수로 변환
        }
    });
    
    console.log(product_idList);
    
    if (product_idList.length > 0) 
	{
        fetch(`${contextPath}/product_list_wishStatus`, 
		{
            method: "POST",
            headers: {
                "Content-Type": "application/json"
            },
            body: JSON.stringify({
                product_id: product_idList
            })
        })
        .then(response => response.json())  // JSON 파싱 추가
        .then(data => 
		{
			
		})
        .catch(error => console.log("error: ", error.message));
    }

});

// 비교 패널 토글
function dropdown() {
  const panel = document.getElementById('compare-panel');
  panel.classList.toggle('open');
}

// 상품 비교목록에 추가
function addToComparison(image, title, price, id) {
  if (comparisonList.length >= 3) {
    alert('최대 3개의 상품만 비교할 수 있습니다.');
    return;
  }
  if (comparisonList.some(p => p.id === id)) {
    alert('이미 비교 목록에 추가된 상품입니다.');
    return;
  }
  comparisonList.push({ image, title, price, id });
  updateComparisonPanel();
}

// 비교 패널 업데이트
function updateComparisonPanel() {
  const titleSpan = document.querySelector('.compare-panel-title span');
  titleSpan.textContent = `비교할 상품: ${comparisonList.length} / 3`;
  const info = document.querySelector('.compare-panel-info');
  info.innerHTML = '';

  comparisonList.forEach(product => {
    const div = document.createElement('div');
    div.className = 'compare-panel-box';
    div.innerHTML = `
      <div class="compare-panel-product-img">        
        <img src="${product.image}" alt="${product.title}" width="100" height="100" />      
      </div>      
      <div class="compare-panel-product-name">        
        <span>${product.title}</span><br>        
        <button class="compare-panel-product-remove-btn" onclick="removeFromComparison('${product.id}')"></button>      
      </div>    
    `;
    info.appendChild(div);
  });
  document.getElementById('compare-panel').style.display = comparisonList.length === 0 ? 'none' : 'block';
}

// 비교 패널에서 상품 제거
function removeFromComparison(id) {
  comparisonList = comparisonList.filter(p => p.id != id); // 수정: == 대신 != 사용
  updateComparisonPanel();
}

// 비교 결과 모달 띄우기
function compareProductResult() {
  const laptopContainer = document.getElementById('laptop-container'); // 이 부분은 product_list.js에서만 유효합니다.
  const modal = document.getElementById('modal-container');
  const modalOverlay = document.getElementById('modal-overlay');

  if (!modal || !modalOverlay) { 
    alert('모달 요소를 찾을 수 없습니다.');
    return;
  }

  modalOverlay.style.display = 'block';
  // laptopContainer.style.display = 'block'; // product_list.js에서만 필요
  modal.style.display = 'block';

  const modalProductCards = document.querySelector('.modalProductCards');
  modalProductCards.innerHTML = '';

  comparisonList.forEach(product => {
    const card = document.createElement('div');
    card.className = 'modalProductCard';
    card.innerHTML = `
      <div class="modal-card-product-img">        
        <img src="${product.image}" alt="${product.title}" />      
      </div>      
      <div class="modal-card-product-name"><strong>${product.title}</strong></div>      
      <div class="modal-card-product-price"><strong>${Number(product.price).toLocaleString()}원</strong></div>    
    `;
    modalProductCards.appendChild(card);
  });

  // 서버에 상품 ID 리스트 보내서 스펙 받아오기
  fetch('product/specs', {
    method: 'POST',
    headers: { 'Content-Type': 'application/json' },
    body: JSON.stringify(comparisonList.map(p => p.id))
  })
  .then(res => res.json())
  .then(specsList => {
    const specContainer = document.querySelector('.productSpecifications');
    specContainer.innerHTML = '';

    specsList.forEach(spec => {
      // 날짜 및 무게 포맷팅 함수는 별도 전역 함수로 구현
      specContainer.innerHTML += `
          <div class="productSpecification">            
            <div class="product_Specification product-cpu"><h3>CPU</h3><hr><span>${spec.cpu}</span></div>            
            <div class="product_Specification product-ram"><h3>RAM</h3><hr><span>${spec.ram}</span></div>            
            <div class="product_Specification product-storage"><h3>저장장치</h3><hr><span>${spec.storage_type} ${spec.storage_size} ${spec.storage_unit}</span></div>            
            <div class="product_Specification product-display"><h3>해상도/인치</h3><hr><span>${spec.resolution} / ${spec.screen_size}</span></div>            
            <div class="product_Specification product-gpu"><h3>그래픽카드</h3><hr><span>${spec.gpu}</span></div>            
            <div class="product_Specification product-audio"><h3>오디오</h3><hr><span>${spec.audio_description}</span></div>            
            <div class="product_Specification product-bluetooth"><h3>블루투스</h3><hr><span>${spec.bluetooth}</span></div>            
            <div class="product_Specification product-network"><h3>Wi-fi</h3><hr><span>${spec.network}</span></div>            
            <div class="product_Specification product-ports"><h3>포트</h3><hr><div class="ports-content">${spec.ports}</div></div>            
            <div class="product_Specification product-dimensions"><h3>크기</h3><hr><span>${spec.dimensions}</span></div>            
            <div class="product_Specification product-weight"><h3>무게</h3><hr><span>${Number(spec.weight).toFixed(1)}kg</span></div>            
            <div class="product_Specification product-release_date"><h3>출시일</h3><hr><span>${spec.release_date}</span></div>          
          </div>        
        `;
    });
  })
  .catch(err => console.error('스펙 불러오기 실패:', err));
}