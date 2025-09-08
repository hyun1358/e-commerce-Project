package controller;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.Iterator;
import java.util.List;
import java.util.stream.Collectors;

import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import dao.CartDAO;
import dao.ProductsDAO;
import vo.CartVO;
import vo.ProductVO;
import vo.UserVO;

@Controller
public class CartController {
	/* @Autowired */
	CartDAO cart_dao;
	ProductsDAO product_dao;

	public void setProduct_dao(ProductsDAO product_dao) {
		this.product_dao = product_dao;
	}

	public void setCart_dao(CartDAO cart_dao) {
		this.cart_dao = cart_dao;
	}

	// īƮ ��ȸ
	@RequestMapping("/cart_list.do")
	public String cart_list(Model model, HttpSession session) {
		UserVO user = (UserVO) session.getAttribute("user"); // �α��� ����� ����

		if (user != null) {
			int user_idx = user.getUser_idx();
			List<CartVO> list = cart_dao.selectList(user_idx);
			int total_amount = 0;
			int total_cnt = 0;

			if (list == null || list.isEmpty()) {
				model.addAttribute("cart_list", null);
			} else {
				total_amount = cart_dao.totalAmount(user_idx);
				total_cnt = cart_dao.totalCnt(user_idx);
				model.addAttribute("cart_list", list);
			}
			
			model.addAttribute("total_amount", total_amount);
			model.addAttribute("total_cnt", total_cnt);
		} else {
			// ��ȸ�� ��ٱ���
			List<CartVO> guestCart = (List<CartVO>) session.getAttribute("guest_cart");

			int total_amount = 0;
			int total_cnt = 0;
			if (guestCart != null) {
				for (CartVO vo : guestCart) {
					total_amount += vo.getAmount();
					total_cnt += vo.getQuantity();
				}
			}

			model.addAttribute("cart_list", guestCart);
			model.addAttribute("total_amount", total_amount);
			model.addAttribute("total_cnt", total_cnt);
			
		}

		return "users/shopping_cart";
	}

	// ��ٱ��� ��� ��ư�� ��������, ȸ����
	@RequestMapping("/cart_insert.do")
	@ResponseBody
	public String cart_add(CartVO vo) {

		CartVO resVO = cart_dao.selectOne(vo);// user_idx, product_id
		String result = "fail";

		if (resVO == null) {
			// cart�� ���� ��ǰ�� ������ ���� ��ǰ�� ��ٱ��Ͽ� �߰�
			int res = cart_dao.cart_insert(vo);

			if (res == 1) {
				result = "yes";
			} else {
				result = "no";
			}

		}
		return String.format("[{'result':'%s'}]", result);

	}

	// ��ٱ��� ���������� ���� �ٲٱ�, ȸ����
	@RequestMapping(value = "/cnt_update_ajax.do", method = RequestMethod.POST)
	@ResponseBody
	public String cart_update_ajax(Model model, CartVO vo) {
		String result;
		try {
			int res = cart_dao.cnt_update(vo);

			if (res == 1) {
				int total_amount = cart_dao.totalAmount(vo.getUser_idx());
				int total_cnt = cart_dao.totalCnt(vo.getUser_idx());

				/*
				 * result = String.format("[{'result':'%s'}]", "success");
				 * model.addAttribute("total_amount", total_amount);
				 * model.addAttribute("total_cnt", total_cnt);
				 */

				result = String.format("[{'result':'success', 'total_amount':%d, 'total_cnt':%d}]", total_amount,
						total_cnt);
			} else {
				/* result = String.format("[{'result':'%s'}]", "fail"); */
				CartVO original = cart_dao.selectOne(vo.getCart_id());
				result = String.format("[{'result':'fail', 'original_quantity':%d}]", original.getQuantity());
			}

		} catch (Exception e) {
			e.printStackTrace();
			result = String.format("[{'result':'%s'}]", "error");
		}

		return result;
	}

	// ��ٱ��Ͽ��� 1���� ��ǰ�� ����, ȸ����
	@RequestMapping("/cart_del_one.do")
	@ResponseBody
	public String cart_delOne(Model model, Integer cart_id, Integer user_idx) {
		// Java�� int�� null�� ���� �� ����, Integer�� null ���˴ϴ�.
		int res = cart_dao.deleteOne(cart_id);
		String str = "fail";

		if (res == 1) {
			List<CartVO> list = cart_dao.selectList(user_idx);

			if (list == null || list.isEmpty()) {
				return String.format("[{'result':'%s', 'total_amount':%d, 'total_cnt':%d}]", "success", 0, 0);

			} else {
				int total_amount = cart_dao.totalAmount(user_idx);
				int total_cnt = cart_dao.totalCnt(user_idx);
				return String.format("[{'result':'%s', 'total_amount':%d, 'total_cnt':%d}]", "success", total_amount,
						total_cnt);
			}
			/*
			 * str = String.format("[{'result':'%s'}]", "success");
			 * model.addAttribute("total_amount", total_amount);
			 * model.addAttribute("total_cnt", total_cnt);
			 */

		}

		return String.format("[{'result':'%s'}]", "fail");
	}

	// ��ٱ��Ͽ��� �������� ��ǰ�� ����, ȸ����
	@RequestMapping("/cart_del_selected.do")
	@ResponseBody
	public String cartDeleteSelected(Model model, String cart_ids, Integer user_idx) {
		if (cart_ids == null || cart_ids.trim().isEmpty() || user_idx == null) {
			return "[{'result':'fail'}]";
		}

		String[] ids = cart_ids.split(",");
		for (String id : ids) {
			try {
				int cart_id = Integer.parseInt(id.trim());
				cart_dao.deleteOne(cart_id);
			} catch (NumberFormatException e) {
				continue; // �߸��� ID�� ����
			}
		}

		List<CartVO> list = cart_dao.selectList(user_idx);
		int total_amount = 0;
		int total_cnt = 0;

		if (list != null && !list.isEmpty()) {
			total_amount = cart_dao.totalAmount(user_idx);
			total_cnt = cart_dao.totalCnt(user_idx);

		}

		return String.format("[{'result':'success', 'total_amount':%d, 'total_cnt':%d}]", total_amount, total_cnt);
	}

	@RequestMapping("/guest_cart_insert.do")
	@ResponseBody
	public String guestCartInsert(@RequestParam("product_id") int product_id, HttpSession session) {
		try {
			List<CartVO> guestCart = (List<CartVO>) session.getAttribute("guest_cart");

			if (guestCart == null) {
				guestCart = new ArrayList<>();
				session.setAttribute("guest_cart", guestCart);
			}

			for (CartVO vo : guestCart) {
				if (vo.getProduct_id() == product_id) {
					return "exists";
				}
			}

			ProductVO product = product_dao.select_one(product_id);
			if (product == null)
				return "fail";

			CartVO cart = new CartVO();
			cart.setProduct_id(product_id);
			cart.setProduct_name(product.getProduct_name());
			cart.setCompany(product.getCompany());
			cart.setImage1(product.getImage1());
			cart.setPrice(product.getPrice());
			cart.setSale_price(product.getSale_price());
			cart.setFinal_price(product.getFinal_price());
			cart.setQuantity(1);
			cart.setAmount(product.getFinal_price());
			cart.setStock(product.getStock());
			cart.setIs_visible("Y");

			guestCart.add(cart);

			return "added";

		} catch (Exception e) {
			e.printStackTrace();
			return "error";
		}
	}

	// ��ٱ��� ���������� ���� �ٲٱ�, ��ȸ����
	@RequestMapping("/guest/cart/update")
	@ResponseBody
	public String guestUpdateupdateGuestCart(@RequestParam("product_id") int product_id,
			@RequestParam("quantity") int quantity, HttpSession session) {

		List<CartVO> guestCart = (List<CartVO>) session.getAttribute("guest_cart");
		int total_amount = 0;
		int total_cnt = 0;

		if (guestCart != null) {
			for (CartVO item : guestCart) {
				 System.out.println("Before update - cart_id: " + item.getCart_id() + ", quantity: " + item.getQuantity() + ", amount: " + item.getAmount() + ", final_price: " + item.getFinal_price());
				if (item.getProduct_id() == product_id) {
					item.setQuantity(quantity);
					item.setAmount(item.getFinal_price() * quantity); // ����* ����
				}
				total_amount += item.getAmount();
				total_cnt += item.getQuantity();
				  System.out.println("After update - cart_id: " + item.getCart_id() + ", quantity: " + item.getQuantity() + ", amount: " + item.getAmount());
			}
			// session.setAttribute("guest_cart", guestCart); //�ٽ� ����, ���ص� ����
		}

		System.out.println("total_amount=" + total_amount + ", total_cnt=" + total_cnt);
		return String.format("[{'result':'success', 'total_amount':%d, 'total_cnt':%d}]", total_amount, total_cnt);
	}

	@RequestMapping("/guest/cart/delete")
	@ResponseBody
	public String guestDelete(@RequestParam("product_id") int product_id, HttpSession session) {
		List<CartVO> guestCart = (List<CartVO>) session.getAttribute("guest_cart");

		int total_amount = 0;
		int total_cnt = 0;

		if (guestCart != null) {
			guestCart.removeIf(item -> item.getProduct_id() == product_id);

			// ���� �� ���� ����
			for (CartVO item : guestCart) {
				total_amount += item.getAmount();
				total_cnt += item.getQuantity();
			}

			session.setAttribute("guest_cart", guestCart);
		}

		return String.format("[{'result':'%s', 'total_amount':%d, 'total_cnt':%d}]", "success", total_amount,
				total_cnt);
	}
	
	@RequestMapping("/guest/cart/deleteSelected")
	@ResponseBody
	public String deleteGuestSelected(@RequestParam("product_ids") String productIdsStr, HttpSession session) {
	    List<CartVO> guestCart = (List<CartVO>) session.getAttribute("guest_cart");

	    int total_amount = 0;
	    int total_cnt = 0;

	    if (guestCart != null) {
	        List<Integer> productIds = Arrays.stream(productIdsStr.split(","))//"3,7,12" �� ["3", "7", "12"]
	                                         .map(Integer::parseInt)//[3, 7, 12]
	                                         .collect(Collectors.toList());//List�� ��Ƽ� ��ȯ ���� ����� List<Integer> [3, 7, 12]

	        guestCart.removeIf(item -> productIds.contains(item.getProduct_id()));//productIds �ȿ� ���Ե� �׸��� ����, guestCart�ȿ���

	        for (CartVO item : guestCart) {
	            total_amount += item.getAmount();
	            total_cnt += item.getQuantity();
	        }

	        session.setAttribute("guest_cart", guestCart);
	    }

	    return String.format("[{'result':'success', 'total_amount':%d, 'total_cnt':%d}]", total_amount, total_cnt);
	}
	
	@RequestMapping("/mypage/cart/insert")
	public String mypage_cart_insert(int product_id, HttpSession session, RedirectAttributes redirectAttributes)
	{
		System.out.println("product_id : "+product_id);
		UserVO vo = (UserVO)session.getAttribute("user");
		int user_idx = vo.getUser_idx();
		
		cart_dao.mypage_cart_insert(user_idx, product_id);
		redirectAttributes.addFlashAttribute("msg", "��ٱ��Ͽ� �߰��Ǿ����ϴ�.");
		return "redirect:/wishlist";
	}

}
