/**
 * 
 */

 // discount-timer.js

function startCountdown() {
    const now = new Date();
    const end = new Date();
    end.setHours(23, 59, 59, 999); // 오늘 자정까지

    function updateTimer() {
        const nowTime = new Date();
        const diff = end - nowTime;

        if (diff <= 0) {
            document.getElementById("timer").textContent = "00:00:00";
            clearInterval(interval);
            return;
        }

        const hours = String(Math.floor(diff / (1000 * 60 * 60))).padStart(2, '0');
        const minutes = String(Math.floor((diff % (1000 * 60 * 60)) / (1000 * 60))).padStart(2, '0');
        const seconds = String(Math.floor((diff % (1000 * 60)) / 1000)).padStart(2, '0');

        document.getElementById("timer").textContent = `${hours}:${minutes}:${seconds}`;
    }

    updateTimer(); // 페이지 로드 시 바로 실행
    const interval = setInterval(updateTimer, 1000);
}


const cart = [];
	
/* 	  function addToCart(name, price) {
	    // 장바구니에 담기
	    cart.push({ name, price });
	
	    // 담김 효과 표시 (예: alert 또는 애니메이션)
	    alert(`"${name}"이(가) 장바구니에 담겼습니다.`);
	
	    // 콘솔 로그 (디버깅용)
	    console.log("현재 장바구니:", cart);
	  } */
	  function showToast(message) {
		  const toast = document.getElementById('toast');
		  toast.textContent = message;
		  toast.style.display = 'block';
		  setTimeout(() => {
		    toast.style.display = 'none';
		  }, 2000);
		}

		function addToCart(name, price) {
		  cart.push({ name, price });
		  showToast(`"${name}"이(가) 장바구니에 담겼습니다.`);
		}

document.addEventListener("DOMContentLoaded", startCountdown);



/*  let currentIndex_best = 0;
  const cardWidth = 320; // 카드 너비 + margin
  const visibleCards = 4;
  const totalCards = 8;

  setInterval(() => {
    currentIndex_best++;
    if (currentIndex_best > totalCards - visibleCards) {
      currentIndex_best = 0;
    }
    document.querySelector('.best-slider').style.transform = 
      `translateX(-${currentIndex_best * cardWidth}px)`;
  }, 3000); // 3초마다 이동*/
let intervalId;
  document.addEventListener("DOMContentLoaded", () => {
  startCountdown(); // 타이머 시작

  const slider = document.getElementById("bestSlider");
  const prevBtn = document.getElementById("prevBtn");
  const nextBtn = document.getElementById("nextBtn");

  if (!slider || !prevBtn || !nextBtn) {
    console.error("슬라이더 또는 버튼 요소가 없습니다.");
    return;
  }

  const cardWidth = 320;
  const totalCards = document.querySelectorAll(".best-card").length / 2;
  let currentIndex = 0;
  let intervalId;

  function updateSlider() {
    slider.style.transition = "transform 0.5s ease-in-out";
    slider.style.transform = `translateX(${-cardWidth * currentIndex}px)`;
  }

  function slideNext() {
    currentIndex++;
    if (currentIndex >= totalCards) {
      currentIndex = 0;
      slider.style.transition = "none";
      slider.style.transform = `translateX(0px)`;
    } else {
      updateSlider();
    }
  }

  function slidePrev() {
    if (currentIndex <= 0) {
      currentIndex = totalCards - 1;
    } else {
      currentIndex--;
    }
    updateSlider();
  }

  function startAutoSlide() {
    intervalId = setInterval(slideNext, 3000);
  }

  function stopAutoSlideTemporarily() {
    clearInterval(intervalId);
    startAutoSlide();
  }

  // 최초 자동 슬라이드 시작
  startAutoSlide();

  // 버튼 이벤트
  nextBtn.addEventListener("click", () => {
    slideNext();
    stopAutoSlideTemporarily();
  });

  prevBtn.addEventListener("click", () => {
    slidePrev();
    stopAutoSlideTemporarily();
  });
});
