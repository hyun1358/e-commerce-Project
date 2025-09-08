function modal_close(){
    const modal = document.getElementById('modal-container');
    const modal_overlay = document.getElementById('modal-overlay');

    // 모달과 오버레이 요소가 존재하는지 확인 후 스타일 변경
    if(modal && modal_overlay) {
        if(modal.style.display==="block" || modal.style.display===""){
            modal_overlay.style.display ='none';
            modal.style.display ='none';
        }
    }
}