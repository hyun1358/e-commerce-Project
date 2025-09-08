package controller;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import dao.PaymentDAO;
import vo.PaymentVO;

@Controller
public class LinkController 
{
	
PaymentDAO payment_dao;
	
	public void setPayment_dao(PaymentDAO payment_dao) 
	{
		this.payment_dao = payment_dao;
	}
	
	@RequestMapping("/logout")
	public String logout(HttpSession session)
	{
		session.invalidate();
		return "redirect:/homepage";
	}
	@RequestMapping("/register")
	public String register()
	{
		return "users/membership_regist";
	}
	
	//아이디 찾기
	@RequestMapping("id_find_form")
	public String id_find_form(String check)
	{
		System.out.println("파라미터 : "+check);
		return "redirect:/users/id_find?check=" + check;
	}
	//아이디 찾기 파라미터
	@RequestMapping("/users/id_find")
	public String id_find_page() 
	{
	    return "users/id_find";
	}
	
	//비밀번호 찾기
	@RequestMapping("pwd_find_form")
	public String pwd_find_form(String check)
	{
		System.out.println("pwd 파라미터 : "+check);
		return "redirect:/users/pwd_find?check=" + check;
	}
	//아이디 찾기 파라미터
	@RequestMapping("/users/pwd_find")
	public String pwd_find_page() 
	{
	    return "users/pwd_find";
	}
	

	@RequestMapping("/payment")
	public String payment(String merchant_uid,Model model)
	{
		PaymentVO vo = payment_dao.payment_selectOne(merchant_uid);
		List<String> product_name = payment_dao.payment_selectAll(merchant_uid);
		
		model.addAttribute("product_name",product_name);
		model.addAttribute("payment",vo);
		return "users/orders/order_complete";
	}
	
	@RequestMapping("/admin_inquiry")
	public String admin_inquiry() {
		return "admin/inquiry_management";
	}

	@RequestMapping("/admin_inquiry_edit")
	public String admin_inquiry_edit() {
		return "admin/inquiry_edit";
	}

	@RequestMapping("/admin_notice")
	public String admin_notice() {
		return "admin/notice_management";
	}
	
	@RequestMapping("/admin_review")
	public String admin_review() {
		return "admin_customer/review_management";
	}

}
