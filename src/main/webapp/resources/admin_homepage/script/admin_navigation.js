document.addEventListener('DOMContentLoaded', () => {
  const sidebar = document.getElementById('sidebar');
  const initialTop = sidebar.getBoundingClientRect().top + window.scrollY;
  let currentY = 0;
  let targetY = 0;
  let ticking = false;

  function updatePosition() {
    currentY += (targetY - currentY) * 0.8;  // 보간 비율 조절 가능 (0.1 ~ 0.2 정도가 부드러움)
    sidebar.style.transform = `translateY(${currentY}px)`;

    if (Math.abs(targetY - currentY) > 0.1) {
      requestAnimationFrame(updatePosition);
    } else {
      ticking = false;
    }
  }

  window.addEventListener('scroll', () => {
    const scrollY = window.scrollY;
    const offset = scrollY - initialTop + 50;
    targetY = Math.max(0, offset);

    if (!ticking) {
      ticking = true;
      requestAnimationFrame(updatePosition);
    }
  });

  // 현재 URL과 href 비교해서 active 설정
  const sidebarItems = document.querySelectorAll('.sidebar-item');
  const currentPath = window.location.pathname;

  sidebarItems.forEach(item => {
    const link = item.getAttribute('href');
    if (currentPath.includes(link)) {
      item.classList.add('active');
    }
  });
});
