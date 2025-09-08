// 기간 버튼 클릭 이벤트


// 날짜 형식 변환 함수 (YYYY-MM-DD)
function formatDate(date) {
    const year = date.getFullYear();
    const month = String(date.getMonth() + 1).padStart(2, '0');
    const day = String(date.getDate()).padStart(2, '0');
    return `${year}-${month}-${day}`;
}

document.addEventListener("DOMContentLoaded", function() 
{
	document.querySelectorAll('.period-btn').forEach(btn => {
    btn.addEventListener('click', function() {
        document.querySelectorAll('.period-btn').forEach(b => {
            b.classList.remove('active');
        });
        this.classList.add('active');
        
        // 여기에 날짜 계산 로직 추가
        const today = new Date();
        let startDate = new Date();
        
        if (this.textContent === '1개월') {
            startDate.setMonth(today.getMonth() - 1);
        } else if (this.textContent === '3개월') {
            startDate.setMonth(today.getMonth() - 3);
        } else if (this.textContent === '6개월') {
            startDate.setMonth(today.getMonth() - 6);
        } else if (this.textContent === '12개월') {
            startDate.setMonth(today.getMonth() - 12);
        }
        
        // 날짜 입력 필드 업데이트
        document.querySelectorAll('.date-input')[0].value = formatDate(startDate);
        document.querySelectorAll('.date-input')[1].value = formatDate(today);
    });
});

    const rows = document.querySelectorAll(".inquiry-row");
    let openedAnswerId = null;

    rows.forEach(row => {
      row.addEventListener("click", function() {
        const inquiryId = this.getAttribute("data-id");
        const answerRow = document.getElementById(`answer-${inquiryId}`);

        if (!answerRow) return;  // 답변이 없으면 아무 동작 안함

        // 이전에 열려 있던 답변 닫기 (같지 않을 때만)
        if (openedAnswerId && openedAnswerId !== inquiryId) {
          const prevAnswerRow = document.getElementById(`answer-${openedAnswerId}`);
          if (prevAnswerRow) prevAnswerRow.style.display = "none";
        }

        // 현재 클릭한 답변 토글
        if (answerRow.style.display === "none") {
          answerRow.style.display = "table-row";
          openedAnswerId = inquiryId;
        } else {
          answerRow.style.display = "none";
          openedAnswerId = null;
        }
      });
    });
});