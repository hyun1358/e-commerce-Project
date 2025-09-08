/**
 * 스크롤을 내렸을 때 위에 검색창과 로고가 나오게 되어있음
*/
// 카테고리 드롭다운 열기/닫기
        const categoryBtn = document.getElementById('categoryBtn');
        const categoryDropdown = document.getElementById('categoryDropdown');
        const mainCategoryList = document.getElementById('mainCategoryList');
        const subCategories = document.querySelectorAll('.category-sub');

        categoryBtn.addEventListener('click', function(e) {
            e.stopPropagation();
            categoryDropdown.classList.toggle('active');
            // 첫번째 카테고리 자동 활성화
            if (categoryDropdown.classList.contains('active')) {
                const firstLi = mainCategoryList.querySelector('li');
                if (firstLi) firstLi.dispatchEvent(new Event('mouseenter'));
            } else {
                mainCategoryList.querySelectorAll('li').forEach(li => li.classList.remove('active'));
                subCategories.forEach(ul => ul.classList.remove('active'));
            }
        });

        // 외부 클릭 시 드롭다운 닫기
        document.addEventListener('click', function(e) {
            if (!categoryDropdown.contains(e.target) && !categoryBtn.contains(e.target)) {
                categoryDropdown.classList.remove('active');
                mainCategoryList.querySelectorAll('li').forEach(li => li.classList.remove('active'));
                subCategories.forEach(ul => ul.classList.remove('active'));
            }
        });

        // 1차 카테고리 hover/클릭 시 2차 카테고리 표시
        mainCategoryList.querySelectorAll('li').forEach(li => {
            li.addEventListener('mouseenter', function() {
                mainCategoryList.querySelectorAll('li').forEach(l => l.classList.remove('active'));
                subCategories.forEach(ul => ul.classList.remove('active'));
                li.classList.add('active');
                const subId = li.getAttribute('data-sub');
                if (subId) {
                    document.getElementById(subId).classList.add('active');
                }
            });         
        });

document.addEventListener('DOMContentLoaded', () => {
  const defaultInput = document.querySelector('#default-header .text-bar');
  const stickyInput = document.querySelector('#sticky-header .text-bar');
  const stickyHeader = document.getElementById('sticky-header');

  if (!defaultInput || !stickyInput) return;

  // 입력할 때 동기화 (양방향)
  defaultInput.addEventListener('input', () => {
    stickyInput.value = defaultInput.value;
  });

  stickyInput.addEventListener('input', () => {
    defaultInput.value = stickyInput.value;
  });

  // 스크롤 이벤트
document.addEventListener('scroll', function () 
{
	const targetElement = document.getElementById('sticky-header');
	const triggerHeight = 30; //높이
	
    
    
    if(window.scrollY >= triggerHeight) 
    {
    	targetElement.style.display = 'block';
  	} 
  	else
  	{
    	targetElement.style.display = 'none'; // 필요 시 숨김 처리
  	}
    
}
);
});


/*
function sticky_category()
{
	let category = document.getElementById("sticky-layout");
	
	if (category.style.display === "block") 
	{ 
        category.style.display = "none";
        layout.style.display = "none";
    } 
    else {
		 
        category.style.display = "block";
        layout.style.display = "block";
    }
}*/
document.addEventListener('click', function (e) 
{
    const sticky_layout = document.getElementById('sticky-layout');
    const sticky_menu = document.querySelector('sticky-menu');
    
    // 메뉴가 안 떠있으면 무시
    if (sticky_menu.style.display !== 'block') return;
    
    // 메뉴나 버튼을 누른 거면 무시
    if (sticky_menu.contains(e.target) || sticky_layout.contains(e.target)) return;
    
    // 그 외에는 닫기
    carts_layout.style.display = 'none';
    document.getElementById("category").style.display = 'none'; // 카테고리도 닫기
});

/*
document.addEventListener('scroll', function () 
{
	const targetElement = document.getElementById('sticky-header');
	const triggerHeight = 30; //높이
	
    const sticky_layout = document.getElementById('sticky-layout');
    
    
    if(window.scrollY >= triggerHeight) 
    {
    	targetElement.style.display = 'block';
  	} 
  	else
  	{
    	targetElement.style.display = 'none'; // 필요 시 숨김 처리
  	}
    
    // carts_layout이 보이는 상태일 때만 category를 숨김
    if (sticky_layout.style.display === 'block') 
    {
        sticky_layout.style.display = 'none'; // display를 none으로 설정
    }
});*/