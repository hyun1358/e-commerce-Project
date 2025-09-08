document.addEventListener("DOMContentLoaded",function()
{
	const img_input = document.getElementById("fileUpload");
	const contentTextarea = document.getElementById('content');
    const charCountSpan = document.getElementById('charCount');
    	
	// 문자 수 계산 기능
    contentTextarea.addEventListener('input', function() 
	{
        const currentLength = this.value.length;
        charCountSpan.textContent = currentLength;
    });

	// 파일 업로드 처리
    document.getElementById('fileUpload').addEventListener('change', function(e) 
	{
        const fileCount = e.target.files.length;
        document.querySelector('.file-count').textContent = `(${fileCount}/4)`;
    });

})


function read(input) 
{
    const image_container = document.getElementById("file-image-container");
    image_container.innerHTML = "";

    if (input.files && input.files.length > 0) 
	{
        for (let i = 0; i < input.files.length; i++) 
		{
            const file = input.files[i];

            if (!file.type.startsWith("image/")) continue;

            const reader = new FileReader();

            reader.onload = function(e) 
			{
                const img = document.createElement("img");
                img.src = e.target.result;
                img.style.maxWidth = "200px";
				img.style.maxHeight="200px";
                img.style.marginRight = "10px";
                image_container.appendChild(img);
            };

            reader.readAsDataURL(file);
        }//for
    }//if
}
