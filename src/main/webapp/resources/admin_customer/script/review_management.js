document.addEventListener('DOMContentLoaded', function () {
  const today = new Date();
  const startInput = document.querySelectorAll('.regdate input[type="date"]')[0];
  const endInput = document.querySelectorAll('.regdate input[type="date"]')[1];

  function formatDate(date) {
    const offset = date.getTimezoneOffset();
    const localDate = new Date(date.getTime() - offset * 60 * 1000);
    return localDate.toISOString().split('T')[0];
  }

  const buttons = document.querySelectorAll('.regdate button');

  // 초기 상태: 오늘 ~ 오늘 표시
  startInput.value = formatDate(today);
  endInput.value = formatDate(today);

  // 버튼 클릭 시 처리
  buttons.forEach((button) => {
    button.addEventListener('click', () => {
      const range = button.getAttribute('data-range');

      // 버튼 스타일 업데이트
      buttons.forEach((btn) => btn.classList.remove('active'));
      button.classList.add('active');

      let startDate = new Date();

      if (range === 'all') {
        // 2025-01-01 ~ 오늘
        startDate = new Date('2025-01-01');
        startInput.value = formatDate(startDate);
        endInput.value = formatDate(today);
        return;
      }

      switch (range) {
        case 'today':
          startDate = today;
          break;
        case '7':
          startDate.setDate(today.getDate() - 7);
          break;
        case '30':
          startDate.setMonth(today.getMonth() - 1);
          break;
        case '90':
          startDate.setMonth(today.getMonth() - 3);
          break;
        case '365':
          startDate.setFullYear(today.getFullYear() - 1);
          break;
      }

      startInput.value = formatDate(startDate);
      endInput.value = formatDate(today);
    });
  });
});
