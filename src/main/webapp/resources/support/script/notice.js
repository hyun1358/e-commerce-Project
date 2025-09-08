document.addEventListener("DOMContentLoaded", function () 
{
    const noticeLinks = document.querySelectorAll(".notice-link");
    const filter = document.querySelector(".filter-select");
    let currentOpenId = null;

    filter.addEventListener("change", function () {
        const selectedSort = this.value;
        const urlParams = new URLSearchParams(window.location.search);
        const currentPage = urlParams.get("page") || 1;

        const newUrl = `${contextPath}/support/notice?page=${currentPage}&sort=${selectedSort}`;
        window.location.href = newUrl;
    });

    noticeLinks.forEach(link => {
        link.addEventListener("click", function (e) {
            e.preventDefault();

            const id = this.dataset.id;
            const targetRow = document.getElementById(`content-${id}`);

            // 이미 열려있으면 닫기
            if (currentOpenId === id) {
                targetRow.style.display = "none";
                currentOpenId = null;
                return;
            }

            // 기존 열려있던 항목 닫기
            if (currentOpenId) {
                const prev = document.getElementById(`content-${currentOpenId}`);
                if (prev) prev.style.display = "none";
            }

            // 새로 열기
            targetRow.style.display = "table-row";
            currentOpenId = id;

            // 스크롤 부드럽게
        });
    });
});
