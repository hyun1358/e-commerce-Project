package google_api;

import com.github.scribejava.core.builder.api.DefaultApi20;

public class GoogleLoginApi extends DefaultApi20  
{
	public GoogleLoginApi() 
	{
		
	}
	
	private static class InstanceHolder
	{
		private static final GoogleLoginApi INSTANCE = new GoogleLoginApi();
	}
	
	static GoogleLoginApi instance()
	{
		return InstanceHolder.INSTANCE;
	}
	
	@Override
	public String getAccessTokenEndpoint() 
	{
		return "https://accounts.google.com/o/oauth2/token";
	}
	
	@Override
	protected String getAuthorizationBaseUrl() 
	{
		
		return "https://accounts.google.com/o/oauth2/v2/auth";
	}
}
