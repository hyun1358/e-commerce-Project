document.addEventListener("DOMContentLoaded", () => {
	const stars = document.querySelectorAll(".rating span");
	const ratingInput = document.getElementById("rating");
	const photoInput = document.getElementById("photo");
	const existingImageElement = document.getElementById("existingImage");
	const existingImage = existingImageElement ? existingImageElement.value : "";

	// ⭐ 별점 초기화
	const initialRating = parseInt(ratingInput.value);
	if (!isNaN(initialRating)) {
		stars.forEach(star => {
			const starValue = parseInt(star.dataset.value);
			star.classList.toggle("selected", starValue <= initialRating);
		});
	}

	// ⭐ 별 클릭 시 선택
	stars.forEach(star => {
		star.addEventListener("click", () => {
			const value = parseInt(star.dataset.value);
			ratingInput.value = value;

			stars.forEach(s => {
				s.classList.toggle("selected", parseInt(s.dataset.value) <= value);
			});
		});
	});

	// 🖼️ 이미지 미리보기 컨테이너 추가
	const imagePreviewContainer = document.createElement("div");
	imagePreviewContainer.id = "image-preview-container";
	imagePreviewContainer.style.marginTop = "15px";
	imagePreviewContainer.style.textAlign = "center";

	// 삽입 위치: 사진 첨부 input 아래
	const photoGroup = photoInput.closest(".form-group");
	photoGroup.parentNode.insertBefore(imagePreviewContainer, photoGroup.nextSibling);

	// 🖼️ 기존 이미지가 있다면 표시
	if (existingImage && existingImage.trim() !== "") {
		const img = document.createElement("img");
		//사진 경로로 
		img.src = `resources/admin/image/${encodeURIComponent(existingImage)}`;  // 실제 이미지 경로에 맞게 조정
		img.style.maxWidth = "200px";
		img.style.maxHeight = "200px";
		img.style.border = "1px solid #ddd";
		img.style.borderRadius = "8px";
		img.style.objectFit = "contain";
		imagePreviewContainer.appendChild(img);
	}

	// 📷 파일 선택 시 새 이미지 미리보기
	photoInput.addEventListener("change", (event) => {
		const file = event.target.files[0];
		if (file) {
			const reader = new FileReader();
			reader.onload = function(e) {
				imagePreviewContainer.innerHTML = "";
				const img = document.createElement("img");
				img.src = e.target.result;
				img.style.maxWidth = "200px";
				img.style.maxHeight = "200px";
				img.style.border = "1px solid #ddd";
				img.style.borderRadius = "8px";
				img.style.objectFit = "contain";
				imagePreviewContainer.appendChild(img);
			};
			reader.readAsDataURL(file);
		} else {
			imagePreviewContainer.innerHTML = "";
		}
	});
});