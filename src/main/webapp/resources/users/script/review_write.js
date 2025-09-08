document.addEventListener("DOMContentLoaded", () => {
    const stars = document.querySelectorAll(".rating span");
    const ratingInput = document.getElementById("rating");
    const photoInput = document.getElementById('photo');
    const reviewForm = document.querySelector('.review-container form');

    // 이미지 미리보기를 위한 요소 생성
    const imagePreviewContainer = document.createElement('div');
    imagePreviewContainer.id = 'image-preview-container';
    imagePreviewContainer.style.marginTop = '15px';
    imagePreviewContainer.style.textAlign = 'center';
    reviewForm.insertBefore(imagePreviewContainer, photoInput.closest('.form-group').nextSibling);

    // 이미지 선택시 미리보기 표시
    photoInput.addEventListener('change', function(event) {
        const file = event.target.files[0];
        if (file) {
            const reader = new FileReader();

            reader.onload = function(e) {
                imagePreviewContainer.innerHTML = ''; // 기존 미리보기 제거
                const img = document.createElement('img');
                img.src = e.target.result;
                img.style.maxWidth = '200px';
                img.style.maxHeight = '200px';
                img.style.border = '1px solid #ddd';
                img.style.borderRadius = '8px';
                img.style.objectFit = 'contain';
                imagePreviewContainer.appendChild(img);
            };

            reader.readAsDataURL(file);
        } else {
            imagePreviewContainer.innerHTML = ''; // 파일 선택 취소 시 미리보기 제거
        }
    });

    // 별점 클릭 이벤트 처리
    stars.forEach(star => {
        star.addEventListener("click", () => {
            const value = parseInt(star.dataset.value);
            ratingInput.value = value;

            stars.forEach(s => {
                s.classList.toggle("selected", parseInt(s.dataset.value) <= value);
            });
        });
    });

    // 제출 전 별점 선택 여부 확인
    reviewForm.addEventListener('submit', function(e) {
        if (!ratingInput.value || ratingInput.value === "0") {
            alert("별점을 선택해주세요.");
            e.preventDefault();
        }
    });
});
