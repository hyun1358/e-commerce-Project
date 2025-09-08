document.addEventListener('DOMContentLoaded', () => {
  const toggles = document.querySelectorAll(".sidebar-toggle");
  const sidebar = document.getElementById('sidebar');
  const footer = document.querySelector('footer');
  const initialTop = sidebar.getBoundingClientRect().top + window.scrollY;
  let currentY = 0;

  // 메뉴 토글
  toggles.forEach(function (toggle) {
    toggle.addEventListener("click", function () {
      const parent = toggle.closest(".collapsible");
      parent.classList.toggle("open");
    });
  });

  // 스크롤 따라오는 사이드바
  window.addEventListener('scroll', () => {
    const scrollY = window.scrollY;
    const offset = scrollY - initialTop + 30;
    let targetY = Math.max(0, offset);

    // footer top 위치
    const footerTop = footer.getBoundingClientRect().top + window.scrollY;
    // sidebar 높이
    const sidebarHeight = sidebar.offsetHeight;

    // sidebar 위치가 footer 영역 안으로 들어가지 않도록 제한
    const maxY = footerTop - sidebarHeight - initialTop;
    if(targetY > maxY) targetY = maxY;

    currentY += (targetY - currentY) * 0.8;

    sidebar.style.transform = `translateY(${currentY}px)`;
  });
});
