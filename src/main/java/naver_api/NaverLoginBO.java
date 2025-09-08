package naver_api;

import java.io.IOException;
import java.util.UUID;
 
import javax.servlet.http.HttpSession;
 
import org.springframework.util.StringUtils;
 
import com.github.scribejava.core.builder.ServiceBuilder;
import com.github.scribejava.core.model.OAuth2AccessToken;
import com.github.scribejava.core.model.OAuthRequest;
import com.github.scribejava.core.model.Response;
import com.github.scribejava.core.model.Verb;
import com.github.scribejava.core.oauth.OAuth20Service;
 
public class NaverLoginBO 
{
 
	HttpSession session;
	
    private final static String CLIENT_ID = "";
    private final static String CLIENT_SECRET = "";
    private final static String REDIRECT_URI = "";
    private final static String SESSION_STATE = "oauth_state";
    private final static String PROFILE_API_URL = "https://openapi.naver.com/v1/nid/me";
    
    public String getAuthorizationUrl(HttpSession session) 
    {
    	this.session=session;
        String state = generateRandomString();
        setSession(session,state);        
        System.out.println("session state = " + this.session.getAttribute("oauth_state"));
        System.out.println("Session ID: " + this.session.getId());


        OAuth20Service oauthService = new ServiceBuilder()                                                   
                .apiKey(CLIENT_ID)
                .apiSecret(CLIENT_SECRET)
                .callback(REDIRECT_URI)
                .state(state)
                .build(NaverLoginApi.instance());
 
        return oauthService.getAuthorizationUrl();
    }
 
    /* ���̹����̵�� Callback ó�� ��  AccessToken ȹ�� Method */
    public OAuth2AccessToken getAccessToken(String code, String state) throws IOException
    {
        /* Callback���� ���޹��� ���������� �������� ���ǿ� ����Ǿ��ִ� ���� ��ġ�ϴ��� Ȯ�� */
        String sessionState = getSession(session);
        System.out.println("session state (from session): " + sessionState);
        System.out.println("state (from Naver callback): " + state);
        System.out.println("Session ID: " + session.getId());

        // Add a null check here to prevent NullPointerException
        if (sessionState == null || !StringUtils.pathEquals(sessionState, state)) {
            System.err.println("Error: Session state is null or does not match. sessionState: " + sessionState + ", state: " + state);
            return null; // Or throw an exception to be handled by LoginController
        }

        if(StringUtils.pathEquals(sessionState, state)){
 
            OAuth20Service oauthService = new ServiceBuilder()
                    .apiKey(CLIENT_ID)
                    .apiSecret(CLIENT_SECRET)
                    .callback(REDIRECT_URI)
                    .state(state)
                    .build(NaverLoginApi.instance());
 
            /* Scribe���� �����ϴ� AccessToken ȹ�� ������� �׾Ʒ� Access Token�� ȹ�� */
            OAuth2AccessToken accessToken = oauthService.getAccessToken(code);
            return accessToken;
        }
        return null;
    }
 
    /* ���� ��ȿ�� ������ ���� ���� ������ */
    private String generateRandomString() {
        return UUID.randomUUID().toString();
    }
 
    /* http session�� ������ ���� */
    private void setSession(HttpSession session,String state){
        session.setAttribute(SESSION_STATE, state);     
    }
 
    /* http session���� ������ �������� */ 
    private String getSession(HttpSession session){
        return (String) session.getAttribute(SESSION_STATE);
    }
    /* Access Token�� �̿��Ͽ� ���̹� ����� ������ API�� ȣ�� */
    public String getUserProfile(OAuth2AccessToken oauthToken) throws IOException{
 
        OAuth20Service oauthService =new ServiceBuilder()
                .apiKey(CLIENT_ID)
                .apiSecret(CLIENT_SECRET)
                .callback(REDIRECT_URI).build(NaverLoginApi.instance());
 
            OAuthRequest request = new OAuthRequest(Verb.GET, PROFILE_API_URL, oauthService);
        oauthService.signRequest(oauthToken, request);
        Response response = request.send();
        return response.getBody();
    }
 
}
