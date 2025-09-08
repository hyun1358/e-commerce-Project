package controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import common.Paging;
import dao.AdminUserDAO;
import vo.SearchCustomerVO;
import vo.UserVO;

@Controller
public class AdminCustomerController {
	
	AdminUserDAO user_dao;

	public void setUser_dao(AdminUserDAO user_dao) {
		this.user_dao = user_dao;
	}

	@RequestMapping("/admin/customer")
	public String admin_customerList(Model model, @RequestParam(defaultValue = "1") int page,  HttpServletRequest request) {
		//List<UserVO> list = user_dao.user_select_all();

		int blockList = 5; // 占쏙옙 占쏙옙占쏙옙占쏙옙占쏙옙 占쏙옙占쏙옙占쏙옙 회占쏙옙 占쏙옙
		int blockPage = 5;  // 占쏙옙 화占썽에 占쏙옙占쏙옙占쏙옙 占쏙옙占쏙옙占쏙옙 占쏙옙크 占쏙옙

		// 占쏙옙체 회占쏙옙 占쏙옙 占쏙옙占쏙옙占쏙옙占쏙옙
		int totalCount = user_dao.user_count();

		// 占쏙옙占쏙옙 / 占쏙옙 占쏙옙 占쏙옙호 占쏙옙占�
		int startRow = (page - 1) * blockList + 1;
		int endRow = startRow + blockList - 1;
		
		// 占쏙옙占쏙옙징占쏙옙 회占쏙옙 占쏙옙占쏙옙트 占쏙옙회
		List<UserVO> list = user_dao.user_select_paging(startRow, endRow);
		if (list == null) list = new ArrayList<>();

		// 占쏙옙占쏙옙징 HTML 占쏙옙占쏙옙占�
		String pageUrl = request.getContextPath() + "/admin/customer";
		String searchParam = ""; // 占싯삼옙占쏙옙占쏙옙 占쌩곤옙 占쏙옙 占쏙옙占썩에 占쌍깍옙
		String pagingHtml = Paging.getPaging(pageUrl, page, totalCount, searchParam, blockList, blockPage);

		
		model.addAttribute("user_list", list);
		model.addAttribute("pagingHtml", pagingHtml);
		model.addAttribute("totalCount",totalCount);
		return "admin_customer/customer_management";
	}

	@RequestMapping("/admin/customer/edit")
	public String admin_customer_edit(@RequestParam("user_idx") String user_idx, Model model) {
		if (user_idx == null || user_idx.isEmpty()) {
			return "redirect:/admin/customer";
		}

		String[] strUserIds = user_idx.split(",");
		int[] user_ids = new int[strUserIds.length];

		for (int i = 0; i < strUserIds.length; i++) {
			user_ids[i] = Integer.parseInt(strUserIds[i]);
		}

		List<UserVO> users = user_dao.getUserById(user_ids);
		model.addAttribute("users", users);

		return "admin_customer/customer_edit";
	}

	@PostMapping("/admin/customer/edit/submit")
	@ResponseBody
	public Map<String, Object> editCustomer(@RequestBody UserVO vo) {

		Map<String, Object> result = new HashMap<>();

		try {
			int res = user_dao.updateUser(vo);
			result.put("success", res == 1);
		} catch (Exception e) {
			e.printStackTrace(); // 占쏙옙占쏙옙 占싸깍옙 占쏙옙占�
			result.put("success", false);
			result.put("error", e.getMessage());
		}
		return result;
	}

	@RequestMapping("/admin/customer/search")
	public String searchCustomer(@ModelAttribute SearchCustomerVO search, Model model,@RequestParam(defaultValue = "1") int page, HttpServletRequest request){
		
		switch (search.getCustomerStatus()) {
		case "active":
			search.setCustomerStatusInteger(1);
			break;
		case "sleep":
			search.setCustomerStatusInteger(2);
			break;
		case "withdrawn":
			search.setCustomerStatusInteger(3);
			break;
		case "all":
		default:
			search.setCustomerStatusInteger(null);
		}
		
		int blockList = 5;
		int blockPage = 5;

		int totalCount = user_dao.countSearchUser(search);

		int startRow = (page - 1) * blockList + 1;
		int endRow = startRow + blockList - 1;


		//List<UserVO> customers = user_dao.searchCustomers(search);
		List<UserVO> customers = user_dao.searchUsersPaging(search, startRow, endRow);

		if (customers == null)
			customers = new ArrayList<>();

		String pageUrl = request.getContextPath() +"/admin/customer/search";
		// search 占쏙옙占실울옙 占쏙옙占쏙옙 searchParam 占쏙옙占쏙옙占� (占쏙옙: name=xxx&type=yyy)
		String searchParam = search.toQueryString(); // 占싱곤옙 SearchProductVO占쏙옙占쏙옙 占쏙옙占쏙옙 占십울옙

		//String searchParam = ""; // 占싯삼옙占쏙옙占쏙옙 占쌩곤옙 占쏙옙 占쏙옙占썩에 占쌍깍옙
		String pagingHtml = Paging.getPaging(pageUrl, page, totalCount, searchParam, blockList, blockPage);

		model.addAttribute("user_list", customers);
		model.addAttribute("pagingHtml", pagingHtml);
		model.addAttribute("totalCount",totalCount);
		
		
		String requestedWith = request.getHeader("X-Requested-With");
		if ("XMLHttpRequest".equals(requestedWith)) {
			// ajax 占쏙옙청: 占싸븝옙 jsp 占쏙옙환
			return "admin_customer/customer_list_partial";
		} else {
			// 占싹뱄옙 占쏙옙청: 占쏙옙체 jsp 占쏙옙환
			return "admin_customer/customer_management";
		}
		 // JSP 占쏙옙占쏙옙
	}

	@PostMapping("/admin/customer/delete")
	@ResponseBody
	@Transactional(rollbackFor = Exception.class)
	public Map<String, Object> deleteCustomer(@RequestBody Map<String, List<Integer>> param) {
		Map<String, Object> result = new HashMap<>();

		try {
			List<Integer> userIds = param.get("userIds");

			//1.review
			user_dao.deleteReview(userIds);
			
			//2.cart
			user_dao.deleteCart(userIds);
			
			//3.favorite
			user_dao.deleteFavorite(userIds);
			
			//4.inquiry
			user_dao.deleteInquiry(userIds);
			
			//5.approval_pending
			user_dao.deleteApprovalPending(userIds);			
			
			//6.users 
			int res = user_dao.deleteCustomers(userIds);

			if (res == userIds.size()) {//占쏙옙占쏙옙占쏙옙占쏙옙 占쏙옙환占실억옙 占쏙옙占싣울옙
			    result.put("success", true);
			} else {
			    result.put("success", false);
			}

		} catch (Exception e) {
			e.printStackTrace(); // 혹占쏙옙 Logger 占쏙옙占�
			result.put("success", false);
			result.put("error", e.getMessage());
			throw e; // rollback을 유도
			
		}

		return result;
	}

}
