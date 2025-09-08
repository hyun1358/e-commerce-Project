const images = [
  'banner1.png',
  'banner2.png',
  'banner3.png',
  'banner4.png',
  'banner5.png'
  
];
let currentIndex = 0;

// JSP에서 선언한 contextPath를 사용 (전역 스크립트에서 미리 선언되어 있어야 함)
//const contextPath = document.body.getAttribute('data-context') || '';

function changeImage(index) 
{
  const banner = document.getElementById('banner_main');
  if (!banner) return; // 안전 체크
  banner.style.opacity = 0; // 이미지 사라짐
  setTimeout(() => 
  {
    banner.src = `${contextPath}/resources/homepage/image/${images[index]}`;
    banner.style.opacity = 1; // 이미지 나타남
  }, 300); // 이미지 변경 전에 잠시 투명해짐
}

function prev() {
  currentIndex = (currentIndex - 1 + images.length) % images.length;
  changeImage(currentIndex);
}

function next() {
  currentIndex = (currentIndex + 1) % images.length;
  changeImage(currentIndex);
}

// DOM 완전히 로드 후에 슬라이드 초기화
document.addEventListener('DOMContentLoaded', () => {
  changeImage(currentIndex); // 초기 이미지 설정
  setInterval(next, 4000);   // 자동 슬라이드 시작
});

