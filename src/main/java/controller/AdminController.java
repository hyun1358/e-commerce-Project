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
			// �����ִٸ�
			return "redirect:/admin/main";
		}

		return "/admin/admin_login";
	}

	@RequestMapping("/admin/login")
	@ResponseBody
	public Map<String, Object> adminLoginSubmit(@RequestParam("admin_id") String admin_id,
			@RequestParam("admin_pwd") String admin_pwd, HttpSession session) {

		Map<String, Object> resultMap = new HashMap<>();
		
		// 1. ���̵� ���� ���� Ȯ��
		int userExists = admin_dao.existsByAdminId(admin_id);
		
		if (userExists == 0) {
			resultMap.put("success", false);
			resultMap.put("message", "id���̵� �Ǵ� ��й�ȣ�� �ùٸ��� �ʽ��ϴ�.");
			return resultMap;
		}
		

		// 2. ��й�ȣ üũ
		AdminVO adminUser = admin_dao.checkPassword(admin_id, admin_pwd);
		
		if (adminUser != null) {
			// �α��� ���� -> ���ǿ� ���� �� ó��
			session.setAttribute("adminUser", adminUser);
			resultMap.put("success", true);
			resultMap.put("name", adminUser.getName()); // �̸��� ���� �ѱ�
		} else {
			resultMap.put("success", false);
			resultMap.put("message", "pwd���̵� �Ǵ� ��й�ȣ�� �ùٸ��� �ʽ��ϴ�.");
		}

		return resultMap;
	}

	@RequestMapping("/admin/logout")
	public String adminLogout(HttpSession session) {
		session.invalidate(); // ���� ����
		return "redirect:/admin/login_form"; // �α��� �������� �����̷�Ʈ
	}

}
