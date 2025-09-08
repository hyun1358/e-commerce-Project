function m_send(f)
{
	let id = f.user_id.value.trim();
	let id_pattern = /^[a-zA-Z0-9!@#$%^&*()_+{}\[\]:;<>,.?~\\/\-]{4,}$/;
	
	let pwd = f.user_pwd.value.trim();
	let pwd_pattern = /^[a-zA-Z0-9!@#$%^&*()_+{}\[\]:;<>,.?~\\/\-]{5,}$/;
	
	
	if(id === "" || !id_pattern.test(id))
	{
		alert("아이디에 한글이 포함되어 있습니다.");
		return;
	}
	
	if(pwd === "")
	{
		alert("비밀번호는 5글자 이상입니다");
		return;
	}
	if( !pwd_pattern.test(pwd))
	{
		alert("비밀번호에는 영문,숫자,특수문자만 입력이 가능합니다");
		return;
	}
	
	f.submit();
	
}