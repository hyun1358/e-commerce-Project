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
