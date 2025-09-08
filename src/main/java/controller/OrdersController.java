package controller;

import java.io.UnsupportedEncodingException;
import java.math.BigDecimal;
import java.net.URLEncoder;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import dao.CartDAO;
import dao.InquiryDAO;
import dao.Order_detailDAO;
import dao.OrdersDAO;
import dao.PaymentDAO;
import dao.ProductsDAO;
import dao.ReviewDAO;
import dao.WishlistDAO;
import thread.Deilvery_statusUpdate;
import vo.CartVO;
import vo.OrderDeliveryVO;
import vo.OrderListVO;
import vo.OrdersVO;
import vo.PaymentVO;
import vo.ProductVO;
import vo.RequestFormVO;
import vo.UserVO;

@Controller
public class OrdersController {

	OrdersDAO order_dao;
	CartDAO cart_dao;
	WishlistDAO wish_dao;
	ReviewDAO review_dao;

	PaymentDAO payment_dao;
	ProductsDAO pro_dao;
	Order_detailDAO detail_dao;
	InquiryDAO inquiry_dao;

	public void setDetail_dao(Order_detailDAO detail_dao) {
		this.detail_dao = detail_dao;
	}

	public void setPro_dao(ProductsDAO pro_dao) {
		this.pro_dao = pro_dao;
	}

	public void setOrder_dao(OrdersDAO order_dao) {
		this.order_dao = order_dao;
	}

	public void setPayment_dao(PaymentDAO payment_dao) {
		this.payment_dao = payment_dao;
	}

	public void setCart_dao(CartDAO cart_dao) {
		this.cart_dao = cart_dao;
	}

	public void setReview_dao(ReviewDAO review_dao) {
		this.review_dao = review_dao;
	}

	public void setWish_dao(WishlistDAO wish_dao) {
		this.wish_dao = wish_dao;
	}

	public void setInquiry_dao(InquiryDAO inquiry_dao) {
		this.inquiry_dao = inquiry_dao;
	}

	public String getFormattedOrderDate(String order_date) {
		if (order_date == null || order_date.length() < 10) {
			return "";
		}
		return order_date.substring(0, 10); // "2025-07-07 13:45:00" → "2025-07-07"
	}

	@RequestMapping("/mypage/check")
	public String mypage(HttpSession session, Model model) {
		UserVO user = (UserVO) session.getAttribute("user");
		if (user == null) {
			return "redirect:/login_form";
		}
		model.addAttribute("user", user);

		// 마이페이지 들어가는곳
		List<OrderListVO> latestOrder = order_dao.selectLatestOrder(user.getUser_idx());

		if (!latestOrder.isEmpty()) {
			for (OrderListVO vo : latestOrder) {
				vo.setOrder_date(getFormattedOrderDate(vo.getOrder_date()));
			}
		}

		for (OrderListVO vo : latestOrder) {
			System.out.println("리뷰 아이디 : " + vo.getReview_id());
		}

		// 주문
		int order_count = order_dao.order_count(user.getUser_idx());
		model.addAttribute("order_count", order_count);

		// 장바구니
		int cart_count = cart_dao.cart_count(user.getUser_idx());
		model.addAttribute("cart_count", cart_count);

		// 관심상품
		int wish_count = wish_dao.user_wish_count(user.getUser_idx());
		model.addAttribute("wish_count", wish_count);

		Map<String, Object> review_count = review_dao.user_view_count(user.getUser_idx());

		BigDecimal pending_review_bd = (BigDecimal) review_count.get("PENDING_REVIEW");
		int pending_review = pending_review_bd != null ? pending_review_bd.intValue() : 0;

		BigDecimal written_review_bd = (BigDecimal) review_count.get("WRITTEN_REVIEW");
		int written_review = written_review_bd != null ? written_review_bd.intValue() : 0;

		model.addAttribute("pending_review", pending_review);
		model.addAttribute("written_review", written_review);

		// 문의내역
		int inquiry = inquiry_dao.inquiry_count(user.getUser_idx());
		model.addAttribute("inquiry_count", inquiry);
		model.addAttribute("latest_order", latestOrder);

		return "users/user_mypage"; // 정상 진입 시 마이페이지 JSP 또는 타임리프
	}

	@RequestMapping("/orderhistory")
	public String orderhistory(HttpSession session, Model model) {

		if (session.getAttribute("user") == null) {
			return "redirect:/login_form";
		}

		UserVO user = (UserVO) session.getAttribute("user"); // 로그인 사용자 정보;

		List<OrderListVO> list = order_dao.selectListOrder(user.getUser_idx());

		// 날짜순 정렬 등 입력순서를 유지하기 위해 ListHashMap을 사용
//		Map<String, List<OrderListVO>> orderMap = new LinkedHashMap<>();// 주문번호를 기준으로 묶을 Map
		// List를 Map<주문번호,List> 형태로 바꾸기 위해
//		for (OrderListVO vo : list) 
//		{
//			String order_id = vo.getOrder_id();
//
//			if (!orderMap.containsKey(order_id)) 
//			{
//				// orderMap에 없는 키값(주문번호)라면 새 List 생성
//				orderMap.put(order_id, new ArrayList<>());
//			}
//			String formatted = getFormattedOrderDate(vo.getOrder_date());
//			vo.setOrder_date(formatted);
//			orderMap.get(order_id).add(vo);// orderMap에 있는 키값(주문번호)라면 기존의 리스트에 add
//		}
//
//		model.addAttribute("orderMap", orderMap);

		// 스트림으로 변경 코드가 너무 김

		// 리스트 전체의 날짜 형식을 변경
		list.forEach(vo -> vo.setOrder_date(getFormattedOrderDate(vo.getOrder_date())));

		Map<String, List<OrderListVO>> orderMap = list.stream()
				.collect(Collectors.groupingBy(OrderListVO::getOrder_id, LinkedHashMap::new, Collectors.toList()));

		model.addAttribute("orderMap", orderMap);
		return "users/orders/order_history";
	}

	@RequestMapping("orderhistory_filter")
	@ResponseBody
	public Map<String, List<OrderListVO>> orderHistory_filter(@RequestParam String status, HttpSession session,
			Model model) {
		UserVO user = (UserVO) session.getAttribute("user"); // 로그인 사용자 정보;
		Map<String, Object> map = new HashMap<String, Object>();
		List<OrderListVO> list;

		if (status.equals("all") || status.equals("ordered")) {
			list = order_dao.selectListOrder(user.getUser_idx());
			Map<String, List<OrderListVO>> orderMap = list.stream()
					.collect(Collectors.groupingBy(OrderListVO::getOrder_id, LinkedHashMap::new, Collectors.toList()));
			return orderMap;
		} else if (status.equals("preparing")) {
			status = "상품준비중";
		} else if (status.equals("shipping")) {
			status = "배송중";
		} else if (status.equals("delivered")) {
			status = "배송완료";
		}

		map.put("user_idx", user.getUser_idx());
		map.put("status", status);
		list = order_dao.selectListOrderStatus(map);

		Map<String, List<OrderListVO>> orderMap = list.stream()
				.collect(Collectors.groupingBy(OrderListVO::getOrder_id, LinkedHashMap::new, Collectors.toList()));
		return orderMap;
	}

	@RequestMapping("/order/detail")
	public String orderOneDetail(HttpSession session, Model model, String order_id) {
		UserVO user = (UserVO) session.getAttribute("user");

		OrdersVO orderVO = order_dao.selectOrderOne(order_id);// orders 정보 가져옴

		if (orderVO == null || orderVO.getUser_idx() != user.getUser_idx()) {
			// 주문이 존재하지 않거나 다른 사람의 주문
			return "redirect:/homepage";
		}

		List<OrderListVO> list = detail_dao.selectDetailList(order_id);// 주문한 상품 내역 가져옴
		if (!list.get(0).getStatus().equals("배송완료")) {
			new Deilvery_statusUpdate(order_id, order_dao, payment_dao).start(); // 10초후 status 자동 업데이트
		}
		PaymentVO paymentVO = payment_dao.payment_selectOne(order_id);// 결제 정보 가져옴
		int paid_total_amount = payment_dao.payment_selectTotalpaid(order_id);// 결제한 금액 가져옴

		orderVO.setOrder_date(getFormattedOrderDate(orderVO.getOrder_date()));
		model.addAttribute("orderVO", orderVO);
		model.addAttribute("order_list", list);
		model.addAttribute("paymentVO", paymentVO);
		model.addAttribute("total_amount", paid_total_amount);

		return "users/orders/order_detail";
	}

	@RequestMapping("/order/delivery")
	public String orderDelivery(Model model, String order_id, int product_id) {
		OrdersVO orderVo = order_dao.selectOrderOne(order_id);
		ProductVO proVo = pro_dao.select_one(product_id);
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("order_id", order_id);
		map.put("product_id", product_id);

		OrderDeliveryVO DelVo = detail_dao.orderDelivery_quantity_amount(map);

		model.addAttribute("product", proVo);
		model.addAttribute("order", orderVo);
		model.addAttribute("detail", DelVo);
		return "users/orders/delivery_status";
	}

	@RequestMapping("/payment_page.do")
	public String payment_page(Model model, int user_idx, String cart_ids, Integer product_id, Integer quantity) {

		if (product_id != null) {// 상품상세에서 결제하기 버튼을 눌렀을때

			ProductVO product = pro_dao.select_one(product_id);

			CartVO cart = new CartVO();
			cart.setProduct_id(product.getProduct_id());
			cart.setProduct_name(product.getProduct_name());
			cart.setFinal_price(product.getFinal_price());
			cart.setQuantity(quantity);
			cart.setAmount(quantity * product.getFinal_price());
			cart.setCompany(product.getCompany());
			cart.setImage1(product.getImage1());
			cart.setUser_idx(user_idx);

			// JSP로 전달
			model.addAttribute("cart_list", List.of(cart));
			model.addAttribute("total_amount", cart.getAmount());
			model.addAttribute("total_cnt", cart.getQuantity());
			model.addAttribute("user_idx", user_idx);

			return "users/orders/order_payment";
		} else {// 장바구니에서 결제하기 버튼을 눌렀을때
			if (cart_ids == null || cart_ids.trim().isEmpty()) {
				return "redirect:/cart_list.do";
			}

			String[] cartIdArray = cart_ids.split(",");

			// 2. DB에서 장바구니 항목들 조회
			List<CartVO> cartList = order_dao.getSelectedCartItems(user_idx, cartIdArray);

			// 3. 총 금액, 총 수량 계산
			int totalAmount = 0;
			int totalCnt = 0;
			for (CartVO c : cartList) {
				totalAmount += c.getAmount(); // 수량 * 단가
				totalCnt += c.getQuantity();
			}

			// 4. JSP로 전달
			model.addAttribute("cart_list", cartList);
			model.addAttribute("total_amount", totalAmount);
			model.addAttribute("total_cnt", totalCnt);
			model.addAttribute("user_idx", user_idx);

			if (cartList.size() > 1) {
				System.out.println("vo" + totalCnt + cartList.get(0).getProduct_name());
			}

			return "users/orders/order_payment";
		}

	}

	@RequestMapping("/orders_udapte")
	public String orders_udate(String merchant_uid, HttpSession session) throws UnsupportedEncodingException {
		PaymentVO p_vo = payment_dao.payment_selectOne(merchant_uid);
		if (p_vo != null) {
			UserVO u_vo = (UserVO) session.getAttribute("user");
			OrdersVO vo = new OrdersVO();
			vo.setOrder_id(p_vo.getMerchant_uid());
			vo.setStatus(p_vo.getStatus());
			vo.setShipping_phone(p_vo.getBuyer_tel());
			vo.setShipping_name(p_vo.getBuyer_name());
			vo.setZipcode(p_vo.getBuyer_postcode());
			vo.setAddress1(p_vo.getBuyer_addr());
			vo.setRequest(p_vo.getDeliveryRequest());
			vo.setCardname(p_vo.getCard_name());
			vo.setCardnumber(p_vo.getCard_number());
			int res = order_dao.updateOrders(vo);
			if (res == 1) {
				System.out.println("order DB추가 완");
			} else {
				System.out.println("order DB추가 실");
			}
		} // if
		return "redirect:/payment?merchant_uid=" + URLEncoder.encode(p_vo.getMerchant_uid(), "UTF-8");
	}// �޼���

	@RequestMapping("/user/request_from")
	public String userRequestform(String order_id, int product_id, String product_name, String request_type,
			Model model) {

		model.addAttribute("order_id", order_id);
		model.addAttribute("product_id", product_id);
		model.addAttribute("product_name", product_name);
		model.addAttribute("request_type", request_type);

		return "users/orders/return_request";
	}

	@RequestMapping("user/request")
	@ResponseBody
	@Transactional(rollbackFor = Exception.class)
	public Map<String, Object> userRequestSubmit(RequestFormVO request, HttpSession session) {

		Map<String, Object> resultMap = new HashMap<String, Object>();
		UserVO user = (UserVO) session.getAttribute("user");
		
		try {
			
			int result = detail_dao.updateStatusRequest(request);
			
			if (result == 1) {
				resultMap.put("success", true);
			} else {
				resultMap.put("success", false);
				//resultMap.put("message", "저장 실패");
			}

		} catch (Exception e) {
			e.printStackTrace();
			resultMap.put("success", false);
			//resultMap.put("message", "예외 발생: " + e.getMessage());
			throw e;
		}

		return resultMap;
	}

}
