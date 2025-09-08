package vo;

public class NaverUserVO 
{
    private String resultcode, message;
    private response response;  // 내부 response 객체 필드 추가

    public String getResultcode() { return resultcode; }
    public void setResultcode(String resultcode) { this.resultcode = resultcode; }

    public String getMessage() { return message; }
    public void setMessage(String message) { this.message = message; }

    public response getResponse() { return response; }
    public void setResponse(response response) { this.response = response; }

    public static class response 
    {
        private String id, gender, email, mobile, mobile_e164, name, birthyear;

        public String getId() { return id; }
        public void setId(String id) { this.id = id; }

        public String getGender() { return gender; }
        public void setGender(String gender) { this.gender = gender; }

        public String getEmail() { return email; }
        public void setEmail(String email) { this.email = email; }

        public String getMobile() { return mobile; }
        public void setMobile(String mobile) { this.mobile = mobile; }

        public String getMobile_e164() { return mobile_e164; }
        public void setMobile_e164(String mobile_e164) { this.mobile_e164 = mobile_e164; }

        public String getName() { return name; }
        public void setName(String name) { this.name = name; }

        public String getBirthyear() { return birthyear; }
        public void setBirthyear(String birthyear) { this.birthyear = birthyear; }
    }
}
