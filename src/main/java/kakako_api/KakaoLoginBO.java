package kakako_api;

public class KakaoLoginBO 
{
	private final static String KAKAO_AUTH_DOMAIN = "https://kauth.kakao.com/oauth/authorize"; //������
	private final static String CLIENT_ID = ""; //REST API
	private final static String REDIRECT_URI = ""; //Redirect URI
	
	public static String getKakaoAuthDomain() {
		return KAKAO_AUTH_DOMAIN;
	}
	public static String getClientId() {
		return CLIENT_ID;
	}
	public static String getRedirectUri() {
		return REDIRECT_URI;
	}
}
