document.getElementById('imageInput').addEventListener('change', function(e) {
    const file = e.target.files[0];
    if (file) {
        // 파일 크기 체크 (5MB 제한)
        if (file.size > 5 * 1024 * 1024) {
            alert('파일 크기는 5MB 이하여야 합니다.');
            this.value = '';
            return;
        }
        
        // 이미지 파일 타입 체크
        if (!file.type.startsWith('image/')) {
            alert('이미지 파일만 업로드 가능합니다.');
            this.value = '';
            return;
        }
        
        const reader = new FileReader();
        reader.onload = function(e) {
            const previewImg = document.getElementById('previewImg');
            const noImageText = document.getElementById('noImageText');
            
            previewImg.src = e.target.result;
            previewImg.style.display = 'block';
            noImageText.style.display = 'none';
            
            /*// 파일 정보 표시
            const imageInfo = document.getElementById('imageInfo');
            imageInfo.innerHTML = `
                <span class="file-name">${file.name}</span>
                <span class="file-size">(${(file.size / 1024).toFixed(1)}KB)</span>
            `;*/
        };
        reader.readAsDataURL(file);
    }
});

function deleteImage() {
    const imageInput = document.getElementById('imageInput');
    const previewImg = document.getElementById('previewImg');
    const noImageText = document.getElementById('noImageText');
    const imageInfo = document.getElementById('imageInfo');
    
    imageInput.value = '';
    previewImg.src = '';
    previewImg.style.display = 'none';
    noImageText.style.display = 'block';
    imageInfo.innerHTML = '';
}

