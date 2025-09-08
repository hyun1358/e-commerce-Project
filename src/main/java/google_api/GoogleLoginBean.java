package google_api;

import java.io.IOException;
import java.util.UUID;

import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Component;
import org.springframework.util.StringUtils;

import com.github.scribejava.core.builder.ServiceBuilder;
import com.github.scribejava.core.model.OAuth2AccessToken;
import com.github.scribejava.core.model.OAuthRequest;
import com.github.scribejava.core.model.Response;
import com.github.scribejava.core.model.Verb;
import com.github.scribejava.core.oauth.OAuth20Service;


public class GoogleLoginBean 
{
	private final static String GOOGLE_CLIENT_ID = "";
    private final static String GOOGLE_CLIENT_SECRET = "";
    private final static String GOOGLE_REDIRECT_URI = "";
    private final static String GOOGLE_SCOPE = "email openid profile https://www.googleapis.com/auth/user.phonenumbers.read";
    private final static String PROFILE_API_URL ="https://www.googleapis.com/oauth2/v2/userinfo";
    private final static String PHONE_API_URL = "https://people.googleapis.com/v1/people/me?personFields=phoneNumbers";
	private static final String SESSION_STATE="googleSessionState";
	
	//      API      (code stae)  
	public String getAuthorizationUrl(HttpSession session) 
	{
		//   
		String state=UUID.randomUUID().toString();
		//    
		session.setAttribute(SESSION_STATE, state);
		session.setMaxInactiveInterval(60 * 60); 
		
		//    ϱ     OAuth20Service  
		OAuth20Service oauthService=new ServiceBuilder()
				.apiKey(GOOGLE_CLIENT_ID)
				.apiSecret(GOOGLE_CLIENT_SECRET)
				.callback(GOOGLE_REDIRECT_URI)
				.state(state)
				.scope(GOOGLE_SCOPE)
				.build(GoogleLoginApi.instance());
		
		//  URL
		String authorizationUrl = oauthService.getAuthorizationUrl();
		
		return authorizationUrl;
	}
	
	// α ó  α   ū ߱޹޴ API ȣ ->   ū ȯ
	public OAuth2AccessToken getAccessToken(HttpSession session, String code, String state) throws IOException 
	{
		String sessionState=(String)session.getAttribute(SESSION_STATE);
		
		// Ű   ǿ   ٸ 
		if(!StringUtils.pathEquals(sessionState, state)) 
		{
			return null;
		}
		
		//   ū ߱ ޱ    OAuth20Service ü 
		OAuth20Service oAuth20Service=new ServiceBuilder()
				.apiKey(GOOGLE_CLIENT_ID)
				.apiSecret(GOOGLE_CLIENT_SECRET)
				.callback(GOOGLE_REDIRECT_URI)
				.state(state)
				.scope(GOOGLE_SCOPE)
				.build(GoogleLoginApi.instance());
		
		//   ū ߱ϴ API ûϿ ū ߱޹޾ 
		OAuth2AccessToken accessToken=oAuth20Service.getAccessToken(code);
		
		return accessToken;
	}
	
	//   ū Ͽ   ϴ API ȣ
	public String getUserProfile(OAuth2AccessToken oauthToken) throws IOException{
		if (oauthToken == null) {
			return null; // Or throw an exception
		}
		OAuth20Service oauthService=new ServiceBuilder()
				.apiKey(GOOGLE_CLIENT_ID)
				.apiSecret(GOOGLE_CLIENT_SECRET)
				.callback(GOOGLE_REDIRECT_URI)
				.scope(GOOGLE_SCOPE)
				.build(GoogleLoginApi.instance());
		
		//   ϴ API ûϱ  ü 
		OAuthRequest request = new OAuthRequest(Verb.GET, PROFILE_API_URL, oauthService);
		//   ū API û ü Ͽ α   û
		oauthService.signRequest(oauthToken, request);
		//   
		Response response = request.send();
		String responseBody = response.getBody();
		
		return responseBody;
	}
	
	public String getUserPhoneNumbers(OAuth2AccessToken oauthToken) throws IOException {
	    if (oauthToken == null) {
			return null; // Or throw an exception
		}
	    OAuth20Service oauthService = new ServiceBuilder()
	            .apiKey(GOOGLE_CLIENT_ID)
	            .apiSecret(GOOGLE_CLIENT_SECRET)
	            .callback(GOOGLE_REDIRECT_URI)
	            .scope(GOOGLE_SCOPE)
	            .build(GoogleLoginApi.instance());

	    OAuthRequest request = new OAuthRequest(Verb.GET, PHONE_API_URL, oauthService);
	    oauthService.signRequest(oauthToken, request);
	    Response response = request.send();
	    return response.getBody();
	}

}