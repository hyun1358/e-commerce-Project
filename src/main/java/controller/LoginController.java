package controller;

import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpMethod;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.LinkedMultiValueMap;
import org.springframework.util.MultiValueMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.client.RestTemplate;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.github.scribejava.core.model.OAuth2AccessToken;

import dao.UserDAO;
import google_api.GoogleLoginBean;
import kakako_api.KakaoLoginBO;
import kakako_api.KakaoVO;
import naver_api.NaverLoginBO;
import vo.GoogleUserPhone;
import vo.GoogleUserVO;
import vo.KakaoUserVO;
import vo.LocalUserVO;
import vo.NaverUserVO;
import vo.UserVO;

/**
 * Handles requests for the application home page.
 */
@Controller
public class LoginController {

	UserDAO user_dao;

	public void setUser_dao(UserDAO user_dao) {
		this.user_dao = user_dao;
	}

	/* Naver */
	private NaverLoginBO naverLoginBO;
	private String apiResult = null;

	private GoogleLoginBean googleLoginBean;

	public void setGoogleLoginBean(GoogleLoginBean googleLoginBean) {
		this.googleLoginBean = googleLoginBean;
	}

	/* 카카오 */
	private KakaoLoginBO kakaoLoginBO;

	// 네이버 BO
	public void setNaverLoginBO(NaverLoginBO naverLoginBO) { 
		this.naverLoginBO = naverLoginBO;
	}

	@RequestMapping("/local_register")
	public String local_register(LocalUserVO vo) {
		UserVO u_vo = new UserVO();

		Map<String, String> map = new HashMap<>();
		map.put("user_id", vo.getUser_id());
		map.put("email", vo.getEmail());
		u_vo = user_dao.id_email_select(map);

		if (u_vo != null) {
			return "redirect:/login_form?signup=not_equals";
		} else {
			u_vo = new UserVO();
			u_vo.setUser_id(vo.getUser_id());
			u_vo.setUser_pwd(vo.getUser_pwd());
			u_vo.setUser_name(vo.getUser_name());
			u_vo.setPhone(vo.getPhone());
			u_vo.setEmail(vo.getEmail());
			user_dao.local_user_insert(u_vo);
		}

		return "redirect:/login_form?signup=success";
	}

	@RequestMapping("/check_id")
	@ResponseBody
	public String check_id(String user_id) {
		String result = "no";
		int res = user_dao.id_check(user_id);
		if (res == 1) {
			result = "yes";
			return String.format("[{\"result\" : \"%s\"}]", result);
		}
		return String.format("[{\"result\" : \"%s\"}]", result);
	}

	// 로컬 로그인
	@RequestMapping("/login_check")
	public String local_login_check(HttpServletRequest request, String user_id, String user_pwd,
			@RequestParam(required = false) String returnUrl, HttpSession session) {
		Map<String, String> map = new HashMap<String, String>();
		map.put("user_id", user_id);
		map.put("user_pwd", user_pwd);

		UserVO vo = user_dao.local_id_pwd(map);
		if (vo != null) 
		{
			session.setAttribute("user", vo);
			System.out.println(vo.getUser_name());
			System.out.println(vo.getUser_idx());
			session.removeAttribute("guest_cart");

			String contextPath = request.getContextPath();

			if (returnUrl != null && !returnUrl.isEmpty()) {
				if (returnUrl.startsWith(contextPath + "/")) {
					returnUrl = returnUrl.substring(contextPath.length());
					System.out.println("returnUrl after removing contextPath: " + returnUrl);
				}
				System.out.println("Final redirect URL: " + contextPath + returnUrl);
				return "redirect:" + returnUrl;
			}

			// returnUrl 없으면 홈으로 (여기서 중복 안 생기게 contextPath 한 번만 붙임)
			return "redirect:/homepage";//1
		}

		return "redirect:/login_form?signup=null";
	}

	// 로그인 첫 화면 요청 메소드
	@RequestMapping(value = "/login_form", method = { RequestMethod.GET, RequestMethod.POST })
	public String login(@RequestParam(required = false) String returnUrl, Model model, HttpSession session) {

		/* 네이버아이디로 인증 URL을 생성하기 위하여 naverLoginBO클래스의 getAuthorizationUrl메소드 호출 */
		String naverAuthUrl = naverLoginBO.getAuthorizationUrl(session);

		// 구글
		String googleAuthUrl = googleLoginBean.getAuthorizationUrl(session);
		System.out.println("로그인 할때 사용한 세션 : "+(String)session.getId());

		// 카카오
		String kakaoAuthUri = KakaoLoginBO.getKakaoAuthDomain() + "?client_id=" + KakaoLoginBO.getClientId()
				+ "&redirect_uri=" + KakaoLoginBO.getRedirectUri() + "&response_type=code";

		// https://nid.naver.com/oauth2.0/authorize?response_type=code&client_id=sE***************&
		// redirect_uri=http%3A%2F%2F211.63.89.90%3A8090%2Flogin_project%2Fcallback&state=e68c269c-5ba9-4c31-85da-54c16c658125

		// 네이버
		model.addAttribute("naver_url", naverAuthUrl); 
		// 구글
		model.addAttribute("google_url", googleAuthUrl);
		// 카카오
		model.addAttribute("kakao_url", kakaoAuthUri);
		//System.out.println("returnUrllogin_form: " + returnUrl);
		model.addAttribute("returnUrl", returnUrl);

		/* 생성한 인증 URL을 View로 전달 */
		return "users/login";
	}

	// 네이버 로그인 성공시 callback호출 메소드
	@RequestMapping(value = "/naver_callback", method = { RequestMethod.GET, RequestMethod.POST })
	public String naver_callback(Model model, @RequestParam String code, @RequestParam String state,
			HttpSession session) throws IOException {
		OAuth2AccessToken oauthToken;
		oauthToken = naverLoginBO.getAccessToken(code, state);
		// 로그인 사용자 정보를 읽어온다.
		apiResult = naverLoginBO.getUserProfile(oauthToken);
		System.out.println("유저 정보를 가지고있는 : " + apiResult);

		ObjectMapper mapper = new ObjectMapper();

		NaverUserVO n_vo = mapper.readValue(apiResult, NaverUserVO.class);

		UserVO u_vo = new UserVO();

		Map<String, String> map = new HashMap<>();
		map.put("user_id", n_vo.getResponse().getId());
		map.put("email", n_vo.getResponse().getEmail());

		u_vo = user_dao.id_email_select(map);

		if (u_vo != null && n_vo.getResponse().getId().equals(u_vo.getUser_id())) {
			session.setAttribute("user", u_vo);
			session.removeAttribute("guest_cart");
			
			return "redirect:/homepage";//2
		}

		else if (u_vo != null) {
			return "redirect:/login_form?signup=not_equals";
		} else {
			u_vo = new UserVO();
			u_vo.setUser_id(n_vo.getResponse().getId());
			u_vo.setUser_name(n_vo.getResponse().getName());
			u_vo.setEmail(n_vo.getResponse().getEmail());
			if(n_vo.getResponse().getMobile() != null)
			{
				u_vo.setPhone(n_vo.getResponse().getMobile());
			}
			else
			{
				u_vo.setPhone(" ");
			}
			u_vo.setGender(n_vo.getResponse().getGender());

			user_dao.naver_user_insert(u_vo);
			System.out.println("네이버 유저 DB 추가 성공");
		}
		/* 네이버 로그인 성공 페이지 View 호출 */
		return "redirect:/login_form?signup=success";
	}

	@RequestMapping("/kakao_callback")
	public String kakao_callback(Model model, @RequestParam("code") String code, HttpSession session) {
		System.out.println("카카오 인가코드 : " + code);

		// 카카오에서 요구하는 Contenet-type -> application/x-www-form-urlencoded;charset=utf-8
		HttpHeaders httpHeaders = new HttpHeaders();
		httpHeaders.add("Content-Type", "application/x-www-form-urlencoded;charset=utf-8");

		MultiValueMap<String, String> params = new LinkedMultiValueMap<String, String>();

		params.add("grant_type", "authorization_code");
		params.add("client_id", KakaoLoginBO.getClientId());
		params.add("redirect_uri", KakaoLoginBO.getRedirectUri());
		params.add("code", code);

		HttpEntity<MultiValueMap<String, String>> httpEntity = new HttpEntity<MultiValueMap<String, String>>(params,
				httpHeaders);

		RestTemplate restTemplate = new RestTemplate();
		ResponseEntity<String> response = restTemplate.exchange("https://kauth.kakao.com/oauth/token", HttpMethod.POST,
				httpEntity, String.class);

		ObjectMapper objectMapper = new ObjectMapper();
		KakaoVO oAuthToken = null;

		try {
			oAuthToken = objectMapper.readValue(response.getBody(), KakaoVO.class);
		} catch (Exception e) {
			e.printStackTrace();
		}

		RestTemplate restTemplate2 = new RestTemplate();
		HttpHeaders headers2 = new HttpHeaders();

		headers2.add("Content-type", "application/x-www-form-urlencoded;charset=utf-8");
		headers2.add("Authorization", "Bearer " + oAuthToken.getAccess_token());

		HttpEntity<MultiValueMap<String, String>> kakaoProfileRequest = new HttpEntity<>(headers2);

		ResponseEntity<String> response2 = restTemplate2.exchange("https://kapi.kakao.com/v2/user/me", HttpMethod.GET,
				kakaoProfileRequest, String.class);

		ObjectMapper mapper = new ObjectMapper();
		try {
			KakaoUserVO k_vo = mapper.readValue(response2.getBody(), KakaoUserVO.class);
			UserVO u_vo = new UserVO();

			// kakao_account 내부 필드 접근
			if (k_vo.getKakao_account() != null) {
				String id = String.valueOf(k_vo.getId());

				Map<String, String> map = new HashMap<>();

				map.put("user_id", id);
				map.put("email", k_vo.getKakao_account().getEmail());

				u_vo = user_dao.id_email_select(map);

				if (u_vo != null && id.equals(u_vo.getUser_id())) {
					session.setAttribute("user", u_vo);
					session.removeAttribute("guest_cart");
					return "redirect:/homepage"; /// 3
				} // in if
				else if (u_vo != null) {
					return "redirect:/login_form?signup=not_equals";
				} else {
					u_vo = new UserVO();

					u_vo.setUser_id(id);
					u_vo.setUser_name(k_vo.getKakao_account().getName());

					String rawPhone = k_vo.getKakao_account().getPhone_number();
					if (rawPhone != null) {
						String cleanPhone = rawPhone.replaceAll("[\\s\\-]", ""); // 공백, 하이픈 제거
						if (cleanPhone.startsWith("+8210")) {
							String num = cleanPhone.replace("+8210", "010");
							u_vo.setPhone(num.substring(0, 3) + "-" + num.substring(3, 7) + "-" + num.substring(7));
						} else {
							u_vo.setPhone(rawPhone); // 포맷 조건에 안 맞으면 원본 그대로 저장
						}
					}

					u_vo.setEmail(k_vo.getKakao_account().getEmail());

					String gender = k_vo.getKakao_account().getGender();
					if ("male".equalsIgnoreCase(gender)) {
						u_vo.setGender("M");
					} else if ("female".equalsIgnoreCase(gender)) {
						u_vo.setGender("F");
					} else {
						u_vo.setGender(null); // 또는 기본값 처리
					}
					user_dao.kakao_user_insert(u_vo);
					System.out.println("카카오 유저 DB 추가 성공");
				} // else

			} // out in
		} // try
		catch (Exception e) {
			e.printStackTrace();
		}
		return "redirect:/login_form?signup=success";
	}// kakao_callback

	@RequestMapping(value = "/google_callback", method = { RequestMethod.GET, RequestMethod.POST })
	public String google_callback(@RequestParam String code, @RequestParam String state, HttpSession session) throws IOException 
	{
		OAuth2AccessToken oauthToken = null;
		
		oauthToken = googleLoginBean.getAccessToken(session, code, state);

		if (oauthToken == null) {
			return "redirect:/login_form?error=token_is_null";
		}

		apiResult = googleLoginBean.getUserProfile(oauthToken);

		if (apiResult == null || apiResult.isEmpty()) {
			return "redirect:/login_form?error=profile_is_null";
		}

		ObjectMapper mapper = new ObjectMapper();
		GoogleUserVO g_vo1 = mapper.readValue(apiResult, GoogleUserVO.class);

		apiResult = googleLoginBean.getUserPhoneNumbers(oauthToken);

		GoogleUserPhone g_vo2 = null;
		if (apiResult != null && !apiResult.isEmpty()) 
		{
			try 
			{
				g_vo2 = mapper.readValue(apiResult, GoogleUserPhone.class);
			} 
			catch (Exception e) 
			{
				e.printStackTrace();
			}
		} 

		UserVO u_vo = new UserVO();
		Map<String, String> map = new HashMap<>();
		map.put("user_id", g_vo1.getId());
		map.put("email", g_vo1.getEmail());
		u_vo = user_dao.id_email_select(map);

		if (u_vo != null && g_vo1.getId().equals(u_vo.getUser_id())) {
			session.setAttribute("user", u_vo);
			session.removeAttribute("guest_cart");
			return "redirect:/homepage";
		} else if (u_vo != null && !g_vo1.getId().equals(u_vo.getUser_id())) {
			return "redirect:/login_form?signup=not_equals";
		} else {
			u_vo = new UserVO();
			u_vo.setUser_id(g_vo1.getId());
			u_vo.setUser_name(g_vo1.getName());
			u_vo.setEmail(g_vo1.getEmail());

			if (g_vo2 == null || g_vo2.getPhoneNumbers() == null || g_vo2.getPhoneNumbers().isEmpty()) {
				u_vo.setPhone(" ");
			} else {
				u_vo.setPhone(g_vo2.getPhoneNumbers().get(0).getValue());
			}

			user_dao.google_user_insert(u_vo);
		}
		return "redirect:/login_form?signup=success";
	}
}
