const Error = document.getElementById("userIdError"); //콜백에 

let user_id_c = false;
let user_name_c = false; //이름확인
let user_pwd_c = false; //비밀번호가 일치한지 확인
let user_phone_c = false; //휴대폰 확인
 
let auth_code_Sensation = false; //인증코드란에 있는 내용이 바뀌면
let email_p = false; //이메일 형식

let auth_code=""; //인증코드
let auth_code_input = ""; //인증코드입력란
let user_pwd = ""; //비밀번호 확인란
let pwd_c = "" ; //비빌번호 확인란


//위에 있는게 모두 true이여야만 회원가입 가능

//아이디 체크하는부분
document.addEventListener("DOMContentLoaded", function () 
{
	//아이디
    document.getElementById("user_id").addEventListener("input", function () 
	{
		user_id_c = false;
        let id = this.value.trim();
		let id_pattern = /^[a-zA-Z0-9!@#$%^&*()_+{}\[\]:;<>,.?~\\/\-]{6,}$/;
        if (id === "") 
		{
			user_id_c = false;
			Error.style.color = "red";
            document.getElementById("userIdError").innerHTML = "아이디를 입력하세요";
            return;
        }

		if(!id_pattern.test(id) && id.length < 6)
		{
			user_id_c = false;
			Error.style.color = "red";
            document.getElementById("userIdError").innerHTML = "❗ 아이디는 <strong>영문, 숫자, 특수문자</strong>만 포함할 수 있으며 <strong>6자 이상</strong>이어야 합니다.";
			return;
		}	
			
		let url = "check_id";
		let param = "user_id="+encodeURIComponent(id);
		sendRequest(url, param, checkCallback, "post");

    });
	//비밀번호 란
	document.getElementById("user_pwd").addEventListener("input", function () 
	{
	    user_pwd = this.value.trim();
		let pwd_pattern = /^[a-zA-Z0-9!@#$%^&*()_+{}\[\]:;<>,.?~\\/\-]{6,}$/;

	    let error = document.getElementById("userPwd_check_error");
	
		
	
	    if (user_pwd === "" || user_pwd.length === 0) {
	        user_pwd_c = false;
	        error.style.color = "red";
	        error.innerHTML = "비밀번호를 입력하세요";
	        return;
	    }
	
	    if (!pwd_pattern.test(user_pwd) && user_pwd.length < 6) 
		{
	        user_pwd_c = false;
	        error.style.color = "red";
	        error.innerHTML = "❗ 비밀번호는 <strong>6자 이상</strong>이며, <strong>영문, 숫자, 특수문자만 사용</strong>해야 합니다.";
	        return;
	    }
	
	    // 길이 통과 후, 비밀번호 확인 값과 일치하는지 체크
	    if (user_pwd === pwd_c) 
		{
	        user_pwd_c = true;
	        error.style.color = "green";
	        error.innerHTML = "확인되었습니다";
	    } 
		else 
		{
	        user_pwd_c = false;
	        error.style.color = "red";
	        error.innerHTML = "비밀번호가 일치하지 않습니다";
	    }
	});

	
	//비밀번호확인 란
	document.getElementById("user_pwd_check").addEventListener("input", function () 
	{
		pwd_c = this.value.trim();
		let pwd_pattern = /^[a-zA-Z0-9!@#$%^&*()_+{}\[\]:;<>,.?~\\/\-]{6,}$/;
		
		let error = document.getElementById("userPwd_check_error");
		
		if(pwd_c === "" || pwd_c.length == 0)
		{
			user_pwd_c =false;
			error.style.color="red";
			error.innerHTML="비밀번호를 입력하세요";
			return;
		}
		
		if (!pwd_pattern.test(pwd_c) || user_pwd === "" || user_pwd.length < 6) 
		{
		    user_pwd_c = false;
		    error.style.color = "red";
		    error.innerHTML = "❗ 비밀번호는 <strong>6자 이상</strong>이며, <strong>영문, 숫자, 특수문자만 사용</strong>해야 합니다.";
		    return;
		}

		
		if(user_pwd === pwd_c)
		{
			user_pwd_c = true;
			error.style.color="green";
			error.innerHTML="확인되었습니다";
			return;	
		}
		if(user_pwd != pwd_c)
		{
			user_pwd_c = false;
			error.style.color="red";
			error.innerHTML="비밀번호가 일치하지 않습니다";
			return;	
		}
    });
	//이름
	document.getElementById("user_name").addEventListener("input", function () 
	{
        let name = this.value.trim();
		let name_err = document.getElementById("userNameError");
		
		let name_pattern = /^[가-힣a-zA-Z\s]{1,30}$/;
		if(name === "")
		{
			user_name_c = false;
			name_err.style.color="red";
			name_err.innerHTML="이름을 입력하세요";
			return;
		}
		if (!name_pattern.test(name))
		{
			user_name_c = false;
			name_err.style.color="red";
			name_err.innerHTML="이름을 입력하세요";
			return;
		}
		else
		{
			user_name_c = true;
			name_err.innerHTML="";
			return;
		}
	});
	
	//휴대폰
	document.getElementById("phone").addEventListener("input", function () 
	{
        let phone = this.value.trim();
		let phone_err = document.getElementById("phoneError");
		let phone_pattern = /^\d{8,11}$/;
	
		if(phone == "")
		{
			user_phone_c = false;
			phone_err.style.color="red";
			phone_err.innerHTML="휴대폰번호를 입력하세요(숫자만 입력하세요)";
		}
		if(!phone_pattern.test(phone))
		{
			user_phone_c = false;
			phone_err.style.color="red";
			phone_err.innerHTML="휴대폰번호를 입력하세요(숫자만 입력하세요)";
			return;
		}
		else
		{
			user_phone_c = true;
			phone_err.innerHTML="";
			return;
		}
	});

	//인증번호란
	document.getElementById("auth_code").addEventListener("input", function () 
	{
		auth_code_input = this.value.trim();
		auth_code_Sensation = false;
		if(auth_code_input == autu_code)
		{
			auth_code_Sensation = true;	
		}
    });

	//이메일
	document.getElementById("email").addEventListener("input", function () 
	{	
		email = this.value.trim();
		let email_error = document.getElementById("email_error");
		
		let email_pattern = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
		
		if(email_pattern.test(email))
		{
			email_p = true;
			email_error.innerHTML="";
			return;
		}
		else if(!email_pattern.test(email))
		{
			email_p = false;
			email_error.style.color="red";
			email_error.innerHTML="이메일 형식으로 작성해주세요";
		}
    });
});

function checkCallback()
{
	
	if(xhr.readyState == 4 && xhr.status == 200)
	{
		let data = xhr.responseText;
		let json = JSON.parse(data);
		if(json[0].result == "yes")
		{
			user_id_c = false;
			Error.style.color = "red";
			Error.innerHTML = "사용할 수 없는 아이디 입니다";
		}
		if(json[0].result == "no")
		{
			user_id_c = true;
			Error.style.color = "green";
			Error.innerHTML = "사용 가능한 아이디 입니다";
		}
	}
}
//아이디 체크 끝

//네이버 이메일 인증코드
function verification_send()
{
	if(email_p == false)
	{
		alert("이메일 형식으로 작성해 주세요");
		return;
	}
	let email = document.getElementById("email").value;
	
	let url = "email_ver";
	let param = "email="+encodeURIComponent(email);
	sendRequest(url, param, emailCallback, "post");
}


function emailCallback()
{
	if(xhr.readyState == 4 && xhr.status == 200)
	{
		alert("입력하신 이메일로 인증 코드를 전송했습니다. 인증 코드는 5분 동안만 유효하니, 시간 내에 입력해 주세요.");
		let data = xhr.responseText;
		let json = JSON.parse(data);
		auth_code = json.auth_code;
	}	
}

let email_auth_code = document.getElementById("email_auth_code_error");
//인증코드 확인
function verification_code()
{
	if(auth_code === auth_code_input)
	{
		auth_code_Sensation = true;
		alert("확인되었습니다");
		return;
	}
	else
	{
		auth_code_Sensation = false;
		alert("인증코드가 다릅니다");
		return;
	}
}

function m_send( f )
{
	if(user_name_c == true && 
	   user_pwd_c == true && 
	   user_phone_c == true && 
       auth_code_Sensation == true &&
       email_p == true &&
	   user_id_c)
	{
		f.submit();
	}//if
	else
	{
		alert("조건이 맞지 않습니다. 다시 시도해 주세요");
		return;
	}
}
