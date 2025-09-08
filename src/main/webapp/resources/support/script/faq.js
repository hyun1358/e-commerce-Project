// FAQ 아코디언 및 탭 기능을 위한 자바스크립트
document.addEventListener('DOMContentLoaded', function() {
    // 아코디언 기능
    const faqQuestions = document.querySelectorAll('.faq-question');

    faqQuestions.forEach(question => {
        question.addEventListener('click', function() {
            const answer = this.nextElementSibling;
            const toggleIcon = this.querySelector('.toggle-icon');

            // 현재 선택된 항목이 아닌 다른 항목들 닫기
            faqQuestions.forEach(q => {
                if (q !== this) {
                    q.nextElementSibling.classList.remove('show');
                    q.querySelector('.toggle-icon').classList.remove('rotate');
                }
            });

            // 현재 항목 토글
            answer.classList.toggle('show');
            toggleIcon.classList.toggle('rotate');
        });
    });

    // 탭 전환 기능
    const tabs = document.querySelectorAll('.tab');
    const tabContents = document.querySelectorAll('.tab-content');
    
    // 초기에는 첫 번째 탭 콘텐츠만 표시
    tabContents.forEach((content, index) => {
        if (index !== 0) {
            content.style.display = 'none';
        }
    });

    tabs.forEach((tab, index) => {
        tab.addEventListener('click', function(e) {
            e.preventDefault(); // 기본 링크 동작 방지
            
            // 모든 탭에서 active 클래스 제거
            tabs.forEach(t => t.classList.remove('active'));
            
            // 현재 탭에 active 클래스 추가
            this.classList.add('active');
            
            // 모든 탭 콘텐츠 숨기기
            tabContents.forEach(content => {
                content.style.display = 'none';
            });
            
            // 현재 탭에 해당하는 콘텐츠 표시
            const contentId = `content${index + 1}`;
            document.getElementById(contentId).style.display = 'block';
        });
    });

    // 초기 페이지 로드 시 본문 내용이 준비되도록 함
    document.querySelectorAll('.faq-answer').forEach(answer => {
        answer.style.position = 'static';
        answer.style.width = '100%';
    });
});