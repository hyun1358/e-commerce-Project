package portOne_api;

import java.util.HashMap;
import java.util.Map;

import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.web.client.RestTemplate;

public class AccessToken 
{
	public static String getAccessToken() 
	{
		RestTemplate restTemplate = new RestTemplate();

	    // 1. access_token ¹ß±Þ
	    HttpHeaders tokenHeaders = new HttpHeaders();
	    tokenHeaders.setContentType(MediaType.APPLICATION_JSON);

	    Map<String, String> tokenBody = new HashMap<>();
	    tokenBody.put("imp_key", "2737757386258437");
	    tokenBody.put("imp_secret", "kUnrqB7FBbg1JXROvjhVM9opdmNBbfBOj5flDGUEYDCw6IYXSetdlLLQ8GsifNybgF6e0CVrHq9sujZf");

	    HttpEntity<Map<String, String>> tokenRequest = new HttpEntity<>(tokenBody, tokenHeaders);

	    ResponseEntity<Map> tokenResponse = restTemplate.postForEntity("https://api.iamport.kr/users/getToken", tokenRequest, Map.class);

	    Map<String, Object> responseMap = (Map<String, Object>) tokenResponse.getBody().get("response");
	    String accessToken = (String) responseMap.get("access_token");
	    System.out.println("accessToken : "+accessToken);
	    return accessToken;
	}
	
}
