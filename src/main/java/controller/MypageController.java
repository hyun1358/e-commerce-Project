package controller;

import java.util.List;

import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import dao.OrdersDAO;
import dao.UserDAO;
import vo.OrderListVO;
import vo.UserVO;

@Controller
public class MypageController 
{
	UserDAO user_dao;
	
	public void setUser_dao(UserDAO user_dao) 
	{
		this.user_dao = user_dao;
	}
	
	@RequestMapping("/delivery_progress")
	public String delivery_progress(){
		return "users/orders/delivery_progress";
	}
	
	@RequestMapping("/user_edit")
	public String mypage_user_edit(HttpSession session)
	{
		UserVO vo = (UserVO)session.getAttribute("user");
		if(vo != null)
		{
			vo = user_dao.user_select_all(vo);
			session.setAttribute("user", vo);
		}
		
		return "users/user_edit";
	}
	
	@RequestMapping("/user_update")
	public String mypage_user_update(UserVO user,RedirectAttributes ra,HttpSession session)
	{
		UserVO user_vo = (UserVO)session.getAttribute("user");
		int user_idx = user_vo.getUser_idx();
		
		UserVO user_select_vo = user_dao.user_select_idx(user_idx);
		
		String phone = user.getPhone();
		if(user.getPhone().length() == 11)
		{
			user.setPhone(phone.replaceFirst("(\\d{3})(\\d{4})(\\d{4})","$1-$2-$3"));
		}
		else if(user.getPhone().length() == 10)
		{
			user.setPhone(phone.replaceFirst("(\\d{3})(\\d{3})(\\d{4})","$1-$2-$3"));
		}
		
		if(user.getUser_name() == null || user.getUser_name().isBlank())
		{
			user.setUser_name(user_select_vo.getUser_name());
		}
		if(user.getEmail() == null || user.getEmail().isBlank())
		{
			user.setEmail(user_select_vo.getEmail());
		}
		
		int res = user_dao.user_edit_update(user);
		if(res==1)
		{
			ra.addFlashAttribute("msg","수정 완료");
		}
		return "redirect:/user_edit";
	}
	
}
