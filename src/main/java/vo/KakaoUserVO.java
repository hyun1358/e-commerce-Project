package vo;

public class KakaoUserVO {
    private Long id;
    private String connected_at;
    private KakaoAccount kakao_account;
    private String synched_at;

    public Long getId() { return id; }
    public void setId(Long id) { this.id = id; }

    public String getConnected_at() { return connected_at; }
    public void setConnected_at(String connected_at) { this.connected_at = connected_at; }

    public KakaoAccount getKakao_account() { return kakao_account; }
    public void setKakao_account(KakaoAccount kakao_account) { this.kakao_account = kakao_account; }

    public String getSynched_at() {
		return synched_at;
	}
	public void setSynched_at(String synched_at) {
		this.synched_at = synched_at;
	}

	// KakaoAccount ��ø Ŭ���� (public�� �ƴϸ� ��)
    public static class KakaoAccount 
    {
        private boolean name_needs_agreement;
        private String name;
        private boolean has_email;
        private boolean email_needs_agreement;
        private boolean is_email_valid;
        private boolean is_email_verified;
        private String email;
        private boolean has_phone_number;
        private boolean phone_number_needs_agreement;
        private String phone_number;
        private boolean has_birthyear;
        private boolean birthyear_needs_agreement;
        private String birthyear;
        private boolean has_gender;
        private boolean gender_needs_agreement;
        private String gender;

        // getter, setter ���� ���������� �ۼ� ����
        public boolean isName_needs_agreement() { return name_needs_agreement; }
        public void setName_needs_agreement(boolean name_needs_agreement) { this.name_needs_agreement = name_needs_agreement; }

        public String getName() { return name; }
        public void setName(String name) { this.name = name; }

        public boolean isHas_email() { return has_email; }
        public void setHas_email(boolean has_email) { this.has_email = has_email; }

        public boolean isEmail_needs_agreement() { return email_needs_agreement; }
        public void setEmail_needs_agreement(boolean email_needs_agreement) { this.email_needs_agreement = email_needs_agreement; }

        public boolean isIs_email_valid() { return is_email_valid; }
        public void setIs_email_valid(boolean is_email_valid) { this.is_email_valid = is_email_valid; }

        public boolean isIs_email_verified() { return is_email_verified; }
        public void setIs_email_verified(boolean is_email_verified) { this.is_email_verified = is_email_verified; }

        public String getEmail() { return email; }
        public void setEmail(String email) { this.email = email; }

        public boolean isHas_phone_number() { return has_phone_number; }
        public void setHas_phone_number(boolean has_phone_number) { this.has_phone_number = has_phone_number; }

        public boolean isPhone_number_needs_agreement() { return phone_number_needs_agreement; }
        public void setPhone_number_needs_agreement(boolean phone_number_needs_agreement) { this.phone_number_needs_agreement = phone_number_needs_agreement; }

        public String getPhone_number() { return phone_number; }
        public void setPhone_number(String phone_number) { this.phone_number = phone_number; }

        public boolean isHas_birthyear() { return has_birthyear; }
        public void setHas_birthyear(boolean has_birthyear) { this.has_birthyear = has_birthyear; }

        public boolean isBirthyear_needs_agreement() { return birthyear_needs_agreement; }
        public void setBirthyear_needs_agreement(boolean birthyear_needs_agreement) { this.birthyear_needs_agreement = birthyear_needs_agreement; }

        public String getBirthyear() { return birthyear; }
        public void setBirthyear(String birthyear) { this.birthyear = birthyear; }

        public boolean isHas_gender() { return has_gender; }
        public void setHas_gender(boolean has_gender) { this.has_gender = has_gender; }

        public boolean isGender_needs_agreement() { return gender_needs_agreement; }
        public void setGender_needs_agreement(boolean gender_needs_agreement) { this.gender_needs_agreement = gender_needs_agreement; }

        public String getGender() { return gender; }
        public void setGender(String gender) { this.gender = gender; }
    }
}
