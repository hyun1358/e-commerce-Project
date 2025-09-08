package controller;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import dao.AdminDAO;
import vo.AdminVO;

@Controller
public class AdminController {

	AdminDAO admin_dao;

	public void setAdmin_dao(AdminDAO admin_dao) {
		this.admin_dao = admin_dao;
	}

	@RequestMapping(value = { "/admin/main" })
	public String admin_main() {
		
		return "admin_homepage/admin_main"; 
	}

	@RequestMapping("/admin/login_form")
	public String admin_login(HttpSession session) {

		AdminVO adminUser = (AdminVO) session.getAttribute("adminUser");

		if (adminUser != null) {
			// 만약있다면
			return "redirect:/admin/main";
		}

		return "/admin/admin_login";
	}

	@RequestMapping("/admin/login")
	@ResponseBody
	public Map<String, Object> adminLoginSubmit(@RequestParam("admin_id") String admin_id,
			@RequestParam("admin_pwd") String admin_pwd, HttpSession session) {

		Map<String, Object> resultMap = new HashMap<>();
		
		// 1. 아이디 존재 여부 확인
		int userExists = admin_dao.existsByAdminId(admin_id);
		
		if (userExists == 0) {
			resultMap.put("success", false);
			resultMap.put("message", "id아이디 또는 비밀번호가 올바르지 않습니다.");
			return resultMap;
		}
		

		// 2. 비밀번호 체크
		AdminVO adminUser = admin_dao.checkPassword(admin_id, admin_pwd);
		
		if (adminUser != null) {
			// 로그인 성공 -> 세션에 저장 등 처리
			session.setAttribute("adminUser", adminUser);
			resultMap.put("success", true);
			resultMap.put("name", adminUser.getName()); // 이름도 같이 넘김
		} else {
			resultMap.put("success", false);
			resultMap.put("message", "pwd아이디 또는 비밀번호가 올바르지 않습니다.");
		}

		return resultMap;
	}

	@RequestMapping("/admin/logout")
	public String adminLogout(HttpSession session) {
		session.invalidate(); // 세션 비우기
		return "redirect:/admin/login_form"; // 로그인 페이지로 리다이렉트
	}

}
