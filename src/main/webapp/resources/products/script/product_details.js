// 전역 상태
let comparisonList = [];

// 비교 결과 모달 띄우기 (product_list.js에서 가져옴)
function compareProductResult() {
  const modal = document.getElementById('modal-container');
  const modalOverlay = document.getElementById('modal-overlay');

  // 모달 요소가 없으면 경고 후 종료
  if (!modal || !modalOverlay) {
    alert('모달 요소를 찾을 수 없습니다.');
    return;
  }

  modalOverlay.style.display = 'block';
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

// 상세 페이지에서 단일 상품 견적 모달 띄우기
function compareSingleProduct(image, title, price, id) {
  comparisonList = []; // 기존 비교목록 초기화
  comparisonList.push({ image, title, price, id }); // 선택 상품만 추가
  compareProductResult(); // 모달 띄우고 스펙 조회
}

// 찜 버튼 처리 함수 (중복 제거)
function handleWishlistToggle(product_id) 
{
  const heartBtn = document.getElementById('heartBtn');
  const heartIcon = heartBtn.querySelector('.heart-icon');
  
  // 중복 클릭 방지
  if (heartBtn.disabled) return;
  heartBtn.disabled = true;

  fetch(`${contextPath}/user_wishList?product_id=${product_id}`)
    .then(response => response.json())
    .then(data => {
      if(data.status === "added") {
        heartIcon.classList.add('active');
        alert("찜 등록 완료");
      } else if(data.status === "removed") {
        heartIcon.classList.remove('active');
        alert("찜 삭제 완료");
      } else {
        alert("오류가 발생했습니다.");
      }
    })
    .catch(error => {
      console.error(error);
      alert("오류가 발생했습니다.");
    })
    .finally(() => {
      // 처리 완료 후 버튼 다시 활성화
      heartBtn.disabled = false;
    });
}

document.addEventListener("DOMContentLoaded", function() {
  const url = new URL(window.location.href);
  const product_id = url.searchParams.get("product_id");
  const heartBtn = document.getElementById('heartBtn');
  const heartIcon = heartBtn.querySelector('.heart-icon');

  // 1) 페이지 로드 시 찜 상태 확인
  fetch(`${contextPath}/user_wishList_status?product_id=${product_id}`)
    .then(response => response.json())
    .then(data => {
      if(data.status === "added") {
        heartIcon.classList.add('active');
      } else {
        heartIcon.classList.remove('active');
      }
    })
    .catch(error => console.error(error));

  // 2) 찜 버튼 클릭 이벤트 - 한 번만 등록
  heartBtn.addEventListener('click', function(e) {
    e.preventDefault();
    handleWishlistToggle(product_id);
  });
});

/* 이미지 더보기 버튼 */
let detail_div = document.querySelector(".Product_Detail_Images");
let detail_btn = document.getElementById("moreButton");

detail_btn.addEventListener("click", function() {
    if (detail_div.style.maxHeight === "300px" || detail_div.style.maxHeight === "") {
        // 현재 축소 상태 -> 펼치기
        detail_div.style.maxHeight = "none";
        detail_btn.textContent = "축소하기";
    } else {
        // 현재 펼친 상태 -> 축소하기
        detail_div.style.maxHeight = "300px";
        detail_btn.textContent = "더보기";
    }
});

/* 상품 상세 더보기 버튼 */
function toggleProductImages() {
  const container = document.getElementById('productDetailImages');
  const button = document.getElementById('moreButton');
  
  // 현재 상태 확인
  const isExpanded = container.classList.contains('expanded');
  
  if (isExpanded) {
    // 접기
    container.classList.remove('expanded');
    container.classList.add('collapsed');
    button.innerHTML = `
      더보기 
      <svg class="arrow-icon" viewBox="0 0 24 24" style="width: 14px; height: 14px; fill: currentColor; transition: transform 0.3s ease;">
        <path d="M7 10l5 5 5-5z"/>
      </svg>
    `;
    
    // 스크롤을 상단으로 부드럽게 이동
    setTimeout(() => {
      container.scrollIntoView({ 
        behavior: 'smooth', 
        block: 'start' 
      });
    }, 100);
  } else {
    // 펼치기
    container.classList.remove('collapsed');
    container.classList.add('expanded');
    button.innerHTML = `
      접기 
      <svg class="arrow-icon rotated" viewBox="0 0 24 24" style="width: 14px; height: 14px; fill: currentColor; transition: transform 0.3s ease; transform: rotate(180deg);">
        <path d="M7 10l5 5 5-5z"/>
      </svg>
    `;
  }
}

// 페이지 로드 시 초기 설정
window.addEventListener('load', function() {
  const container = document.getElementById('productDetailImages');
  const button = document.getElementById('moreButton');
  
  // 기본적으로 접힌 상태로 설정
  container.classList.add('collapsed');
  
  // 기존 버튼에 새로운 스타일과 아이콘 추가
  button.innerHTML = `
    더보기 
    <svg class="arrow-icon" viewBox="0 0 24 24" style="width: 14px; height: 14px; fill: currentColor; transition: transform 0.3s ease;">
      <path d="M7 10l5 5 5-5z"/>
    </svg>
  `;
});

/* 리뷰 정렬 */
const url = new URL(window.location.href);
const product_id = url.searchParams.get("product_id");
let page = url.searchParams.get("page") || 1;

const review_filter = document.getElementById("review-filter");
const reviewListContainer = document.querySelector(".review-container");

review_filter.addEventListener("change", function () 
{
	history.replaceState(null, "", `?product_id=${product_id}&sort=${review_filter.value}&page=${page}`);
    fetch(`${contextPath}/revie_fiter?product_id=${product_id}&sort=${review_filter.value}&page=${page}`)
    .then((response) => response.json())
    .then(data => {
        const productName = data.vo.product_name;
        const reviewList = data.review_list;

        // 리뷰 리스트 초기화
        reviewListContainer.innerHTML = "";

        if (reviewList.length === 0) {
            reviewListContainer.innerHTML = "<p>리뷰가 없습니다.</p>";
            return;
        }

        reviewList.forEach(rev => {
            let starsHTML = "";
            for (let i = 1; i <= parseInt(rev.star_rating); i++) 
			{
                starsHTML += '<i class="fas fa-star filled"></i>';
            }
			
            for (let j = parseInt(rev.star_rating) + 1; j <= 5; j++) {
                starsHTML += '<i class="far fa-star"></i>';
            }

            let imageHTML = "";
            if (rev.image1) 
			{
                imageHTML = `<img src="${contextPath}${rev.image1}" alt="리뷰 이미지" style="width:150px;">`;
            }

            const reviewHTML = `
                <div class="review-box">
					<div class="review-header">
		                <div class="user-section">
							<div class="user-info">
								<div class="user-avatar"></div>
		            			<p>${rev.masked_user_id}</p>
		            			<p class="review-date">${rev.regdate}</p>
		         			</div>
		         			<p class="product-info">제품이름 : ${ productName }</p>
		         		</div>	
						<div class="rating-section">
							<div class="star-rating">
								${starsHTML}
							</div>
						</div>
					</div>	
					<div class="review-content">
						<h3 class="review-title"><strong>${rev.title}</strong></h3>
						<div class="review-text"><pre>${rev.content}</pre></div>
						<div class="review-images">${imageHTML}</div>
					</div>
					<div class="admin-response">
						<span class="admin-badge"><strong>판매자 답변 :</strong></span>
						<p class="admin-text">${rev.admin_reply ? rev.admin_reply : '등록된 답변이 없습니다.'}</p>
					</div>
				</div>
            `;
			reviewListContainer.innerHTML += reviewHTML;
        });

        // ★ 여기에서 페이징 HTML 삽입
        document.querySelector(".pagination").innerHTML = data.pagingHtml;
        // ★ 새로 삽입된 페이징 링크에 이벤트 다시 연결
        document.querySelectorAll(".pagination a").forEach(link => 
		{
            link.addEventListener("click", function (e) {
                e.preventDefault(); // 기본 이동 막기
                const href = new URL(this.href);
                const newPage = href.searchParams.get("page");

                page = newPage;
                // 다시 fetch 호출 (재귀 호출 가능)
                review_filter.dispatchEvent(new Event("change"));
				console.log("filter재귀호출");
            });
        });
    })
    .catch(error => console.error("리뷰 정렬 실패:", error));
});