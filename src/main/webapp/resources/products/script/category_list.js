// 전역 상태
let comparisonList = [];
let products = [];

// DOMContentLoaded 이벤트 - DOM이 완전히 준비된 후 실행
document.addEventListener('DOMContentLoaded', () => {
    const productList = document.getElementById('product-list');
    const categoryId = document.body.dataset.categoryId;

    // 이 스크립트가 카테고리 페이지에서 실행되는지 확인
    if (!productList || !categoryId) {
        return; // 카테고리 페이지가 아니면 스크립트 실행 중단
    }

    const defaultSort = document.body.dataset.defaultSort || "sales";
    const links = document.querySelectorAll('.price-filter > a');

    // 1. 최초 로드 시 기본 정렬 active 클래스 적용
    links.forEach(link => {
        if (link.dataset.sort === defaultSort) {
            link.classList.add('active');
        }
    });

    // 2. 각 링크 클릭 이벤트 등록 (정렬)
    links.forEach(link => {
        link.addEventListener('click', e => {
            e.preventDefault();
            if (typeof hasProducts !== 'undefined' && !hasProducts) return;

            links.forEach(el => el.classList.remove('active'));
            link.classList.add('active');

            const sortKey = link.dataset.sort;

            fetch(`${contextPath}/category/sortproduct?category_id=${categoryId}&sort=${sortKey}`)
                .then(res => {
                    if (!res.ok) {
                        throw new Error(`HTTP error! status: ${res.status}`);
                    }
                    return res.text();
                })
                .then(html => {
                    productList.innerHTML = html;
                    if (typeof bindWishlistButtons === 'function') {
                        bindWishlistButtons();
                    }
                })
                .catch(err => console.error('정렬 실패:', err));
        });
    });

    // 3. 비교하기 관련 버튼 이벤트
    const resetBtn = document.querySelector('.reset-btn');
    if (resetBtn) {
        resetBtn.addEventListener('click', () => {
            comparisonList = [];
            updateComparisonPanel();
        });
    }

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
});

// 찜 버튼 상태 업데이트 및 이벤트 바인딩
function bindWishlistButtons() {
    let productIdList = [];
    document.querySelectorAll(".wishlist-btn").forEach(btn => {
        const productId = parseInt(btn.dataset.productId, 10);
        if (!isNaN(productId)) {
            productIdList.push(productId);
        }
        // 기존 이벤트 리스너 제거 (중복 방지)
        const newBtn = btn.cloneNode(true);
        btn.parentNode.replaceChild(newBtn, btn);
        
        newBtn.addEventListener("click", function() {
            if (typeof wishBtn === 'function') {
                wishBtn(newBtn, productId);
            }
        });
    });

    if (productIdList.length > 0) {
        fetch(`${contextPath}/product_list_wishStatus`, {
            method: "POST",
            headers: { "Content-Type": "application/json" },
            body: JSON.stringify({ product_id: productIdList })
        })
        .then(response => response.json())
        .then(data => {
            data.product_id.forEach(pid => {
                const btn = document.querySelector(`.wishlist-btn[data-product-id='${pid}']`);
                if (btn) {
                    const svg = btn.querySelector('svg');
                    if (svg) svg.classList.add("active");
                }
            });
        })
        .catch(error => console.log("Wishlist status error: ", error.message));
    }
}

// 비교 패널 토글
function dropdown() {
    const panel = document.getElementById('compare-panel');
    if(panel) panel.classList.toggle('open');
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
    if(titleSpan) titleSpan.textContent = `비교할 상품: ${comparisonList.length} / 3`;

    const info = document.querySelector('.compare-panel-info');
    if(info) {
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
    }
    
    const panel = document.getElementById('compare-panel');
    if(panel) panel.style.display = comparisonList.length === 0 ? 'none' : 'block';
}

// 비교 패널에서 상품 제거
function removeFromComparison(id) {
    comparisonList = comparisonList.filter(p => p.id !== id);
    updateComparisonPanel();
}

// 비교 결과 모달 띄우기
function compareProductResult() {
    const modal = document.getElementById('modal-container');
    const modalOverlay = document.getElementById('modal-overlay');

    if (!modal || !modalOverlay) {
        alert('모달 요소를 찾을 수 없습니다.');
        return;
    }

    modalOverlay.style.display = 'block';
    modal.style.display = 'block';

    const modalProductCards = document.querySelector('.modalProductCards');
    if(modalProductCards) modalProductCards.innerHTML = '';

    comparisonList.forEach(product => {
        const card = document.createElement('div');
        card.className = 'modalProductCard';
        card.innerHTML = `
          <div class="modal-card-product-img"><img src="${product.image}" alt="${product.title}" /></div>
          <div class="modal-card-product-name"><strong>${product.title}</strong></div>
          <div class="modal-card-product-price"><strong>${Number(product.price).toLocaleString()}원</strong></div>
        `;
        if(modalProductCards) modalProductCards.appendChild(card);
    });

    fetch('product/specs', {
        method: 'POST',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify(comparisonList.map(p => p.id))
    })
    .then(res => res.json())
    .then(specsList => {
        const specContainer = document.querySelector('.productSpecifications');
        if(specContainer) {
            specContainer.innerHTML = '';
            specsList.forEach(spec => {
                specContainer.innerHTML += `
                  <div class="productSpecification">
                    <div><h3>CPU</h3><hr><span>${spec.cpu || ''}</span></div>
                    <div><h3>RAM</h3><hr><span>${spec.ram || ''}</span></div>
                    <div><h3>저장장치</h3><hr><span>${spec.storage_type || ''} ${spec.storage_size || ''} ${spec.storage_unit || ''}</span></div>
                    <div><h3>해상도/인치</h3><hr><span>${spec.resolution || ''} / ${spec.screen_size || ''}</span></div>
                    <div><h3>그래픽카드</h3><hr><span>${spec.gpu || ''}</span></div>
                    <div><h3>오디오</h3><hr><span>${spec.audio_description || ''}</span></div>
                    <div><h3>블루투스</h3><hr><span>${spec.bluetooth || ''}</span></div>
                    <div><h3>Wi-fi</h3><hr><span>${spec.network || ''}</span></div>
                    <div><h3>포트</h3><hr><div class="ports-content">${spec.ports || ''}</div></div>
                    <div><h3>크기</h3><hr><span>${spec.dimensions || ''}</span></div>
                    <div><h3>무게</h3><hr><span>${spec.weight ? Number(spec.weight).toFixed(1) + 'kg' : ''}</span></div>
                    <div><h3>출시일</h3><hr><span>${spec.release_date || ''}</span></div>
                  </div>
                `;
            });
        }
    })
    .catch(err => console.error('스펙 불러오기 실패:', err));
}