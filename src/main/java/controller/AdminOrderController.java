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
import dao.AdminOrderDAO;
import dao.AdminOrderDetailDAO;
import dao.AdminPaymentDAO;
import dao.AdminReturnDAO;
import vo.AdminOrderDetailVO;
import vo.AdminOrderVO;
import vo.AdminPaymentVO;
import vo.AdminReturnVO;
import vo.OrderStatus;
import vo.OrdersVO;
import vo.RequestFormVO;
import vo.ReturnOrderIdsProductIdsVO;
import vo.SearchOrderVO;
import vo.SearchReturnVO;

@Controller
public class AdminOrderController {

	AdminOrderDAO order_dao;
	AdminOrderDetailDAO orderdetail_dao;
	AdminPaymentDAO payment_dao;
	AdminReturnDAO return_dao;

	public void setPayment_dao(AdminPaymentDAO payment_dao) {
		this.payment_dao = payment_dao;
	}

	public void setOrder_dao(AdminOrderDAO order_dao) {
		this.order_dao = order_dao;
	}

	public void setOrderdetail_dao(AdminOrderDetailDAO orderdetail_dao) {
		this.orderdetail_dao = orderdetail_dao;
	}

	public void setReturn_dao(AdminReturnDAO return_dao) {
		this.return_dao = return_dao;
	}

	@RequestMapping("/admin/order")
	public String admin_order(Model model, @RequestParam(defaultValue = "1") int page, HttpServletRequest request) {

		int blockList = 10;
		int blockPage = 5;

		int totalCount = order_dao.order_count();

		int startRow = (page - 1) * blockList + 1;
		int endRow = startRow + blockList - 1;

		List<AdminOrderVO> orders = order_dao.order_select_paging(startRow, endRow);

		// List<AdminOrderVO> list = order_dao.order_selectListAll();

		if (orders == null) {
			orders = new ArrayList<>();
		} else {
			for (AdminOrderVO vo : orders) {
				String productNames = vo.getProduct_names(); // "占쏙옙품1, 占쏙옙품2, 占쏙옙품3"
				int quantity = vo.getQuantity(); // 3

				String displayProductName = "";

				if (quantity <= 1) {
					displayProductName = productNames;
				} else {
					int commaIndex = productNames.indexOf(",");

					String firstProduct = commaIndex > 0 ? productNames.substring(0, commaIndex) : productNames;

					displayProductName = firstProduct + " 외 " + (quantity - 1) + " 건";
				}
				vo.setProduct_names(displayProductName);
			}
		}

		String pageUrl = request.getContextPath() + "/admin/order";
		String searchParam = "";
		String pagingHtml = Paging.getPaging(pageUrl, page, totalCount, searchParam, blockList, blockPage);

		model.addAttribute("order_list", orders);
		model.addAttribute("pagingHtml", pagingHtml);
		model.addAttribute("totalCount", totalCount);

		return "admin_order/order_management";
	}

	@RequestMapping("admin/order/search")
	public String searchOrders(@ModelAttribute SearchOrderVO search, Model model,
			@RequestParam(defaultValue = "1") int page, HttpServletRequest request) {
		int blockList = 10;
		int blockPage = 5;

		int totalCount = order_dao.countOrderSearch(search);
		int startRow = (page - 1) * blockList + 1;
		int endRow = startRow + blockList - 1;

		List<AdminOrderVO> orders = order_dao.searchOrdersPaging(search, startRow, endRow);

		if (orders == null) {
			orders = new ArrayList<>();
		} else {
			for (AdminOrderVO vo : orders) {
				String productNames = vo.getProduct_names();
				int quantity = vo.getQuantity(); // 3

				String displayProductName = "";

				if (quantity <= 1) {
					displayProductName = productNames;

				} else {
					int commaIndex = productNames.indexOf(",");

					String firstProduct = commaIndex > 0 ? productNames.substring(0, commaIndex) : productNames;

					displayProductName = firstProduct + " 외 " + (quantity - 1) + "건";
				}
				vo.setProduct_names(displayProductName);
				System.out.println(displayProductName);
			}
		}

		String pageUrl = request.getContextPath() + "/admin/order/search";
		String searchParam = search.toQueryString();

		String pagingHtml = Paging.getPaging(pageUrl, page, totalCount, searchParam, blockList, blockPage);

		model.addAttribute("order_list", orders);
		model.addAttribute("pagingHtml", pagingHtml);
		model.addAttribute("totalCount", totalCount);

		String requestedWith = request.getHeader("X-Requested-With");

		if ("XMLHttpRequest".equals(requestedWith)) {
			return "admin_order/adminorder_list_partial";
		} else {
			return "admin_order/order_management";
		}

	}

	@RequestMapping("/admin/order/edit")
	public String admin_order_edit_form(@RequestParam("order_id") String order_id, Model model) {

		List<AdminOrderDetailVO> list = orderdetail_dao.selectOrderOne(order_id);
		OrdersVO ordervo = order_dao.getOrderById(order_id);
		AdminPaymentVO paymentvo = payment_dao.selectAdminPaymentById(order_id);
		// 요청// 처리중// 거부// 완료
		// 반품//환불//취소//교환
		boolean hasRefundRequest = false;
		boolean hasExchangeRequest = false;
		boolean hasProcessingRequest = false;
		boolean hasRejectedRequest = false;

		for (AdminOrderDetailVO item : list) {

			OrderStatus status = OrderStatus.valueOf(item.getRefund_status());

			// 환불 관련 상태가 하나라도 있으면 true
			if (status.isRefundStatus()) {
				hasRefundRequest = true;
			}

			// 교환 관련 상태가 하나라도 있으면 true
			if (status.isExchangeStatus()) {
				hasExchangeRequest = true;
			}

			// '처리중' 상태가 하나라도 있으면 true
			if (status.isProcessing()) {
				hasProcessingRequest = true;
			}

			// '거절' 상태가 하나라도 있으면 true
			if (status.isRejected()) {
				hasRejectedRequest = true;
			}

		}

		model.addAttribute("hasRefundRequest", hasRefundRequest);
		model.addAttribute("hasExchangeRequest", hasExchangeRequest);
		model.addAttribute("hasProcessingRequest", hasProcessingRequest);
		model.addAttribute("hasRejectedRequest", hasRejectedRequest);

		model.addAttribute("order_details", list);
		model.addAttribute("ordervo", ordervo);
		model.addAttribute("paymentvo", paymentvo);

		return "admin_order/order_edit";

	}

	@PostMapping("/admin/order/edit/submit")
	@ResponseBody
	public Map<String, Object> admin_order_edit(@RequestParam("order_id") String order_id,
			@RequestParam("orderStatus") String orderStatus) {

		Map<String, Object> resultMap = new HashMap<>();

		System.out.println(order_id + "," + orderStatus);
		int result = order_dao.updateOrderStatus(order_id, orderStatus);

		if (result == 1) {
			resultMap.put("success", true);
		} else {
			resultMap.put("success", false);
		}

		return resultMap;
	}

	@RequestMapping("/admin/order/delete")
	@ResponseBody
	@Transactional(rollbackFor = Exception.class)
	public Map<String, Object> deleteOrder(@RequestBody String order_id) {

		order_id = order_id.trim(); // 怨듬갚 �젣嫄�

		Map<String, Object> resultMap = new HashMap<>();

		try {
			// 1. review
			order_dao.deleteReviewByOrderId(order_id);

			// 2.approval_pending
			order_dao.deleteApprovalPendingByOrderId(order_id);

			// (2.order_detail)
			// order_dao.deleteOrderDetailByOrderId(order_id);

			// 3. orders
			int result = order_dao.deleteOrderById(order_id); // �샊�떆 怨듬갚 �룷�븿�릺硫� �젣嫄�

			if (result == 1) {
				resultMap.put("success", true);
			} else {
				resultMap.put("success", false);
			}

		} catch (Exception e) {
			e.printStackTrace();
			resultMap.put("success", false);
			throw e; // rollback을 유도
		}

		return resultMap;
	}

	@RequestMapping("/admin/return")
	public String admin_return(Model model, @RequestParam(defaultValue = "1") int page, HttpServletRequest request) {

		int blockList = 10;
		int blockPage = 5;

		int totalCount = return_dao.returnCount();

		int startRow = (page - 1) * blockList + 1;
		int endRow = startRow + blockList - 1;

		List<AdminReturnVO> returns = return_dao.return_select_paging(startRow, endRow);

		if (returns == null) {
			returns = new ArrayList<>();
		}

		String pageUrl = request.getContextPath() + "/admin/return";
		String searchParam = "";
		String pagingHtml = Paging.getPaging(pageUrl, page, totalCount, searchParam, blockList, blockPage);

		model.addAttribute("return_list", returns);
		model.addAttribute("pagingHtml", pagingHtml);
		model.addAttribute("totalCount", totalCount);

		return "admin_order/return_management";
	}

	@RequestMapping("/admin/return/edit")
	public String admin_return_edit(@RequestParam("order_id") String order_id,
			@RequestParam("product_id") String product_id, Model model) {

		if (order_id == null || order_id.isEmpty() || product_id == null || product_id.isEmpty()) {
			return "redirect:/admin/return";
		}

		String[] orderIds = order_id.split(",");
		String[] strProductIds = product_id.split(",");

		// 길이 체크 (두 배열 길이가 동일한지 확인하는 게 좋음)
		if (orderIds.length != strProductIds.length) {
			// 에러 처리 또는 예외 발생
			throw new IllegalArgumentException("order_id와 product_id 개수가 맞지 않습니다.");
		}
		int[] productIds = new int[strProductIds.length];
		for (int i = 0; i < orderIds.length; i++) {

			productIds[i] = Integer.parseInt(strProductIds[i]);
		}

		List<AdminReturnVO> list = return_dao.getReturnListByOrderProductPairs(orderIds, productIds);

		model.addAttribute("returns", list);

		return "admin_order/return_edit";
	}

	@RequestMapping("/admin/return/update")
	@ResponseBody
	public Map<String, Object> returnStatusUpdate(RequestFormVO request) {
		// String fullStatus = requestType + processStatus;
		Map<String, Object> response = new HashMap<>();
		try {
			// 처리 로직

			if (request.getRequest_type().equals("C")) {
				request.setProcess_status("");
			}
			
			request.setRefund_status(request.getRequest_type() + request.getProcess_status());
			
			int res = return_dao.updateReturnRequest(request);
			
			if (res == 1) {
				response.put("success", true);
			} else {
				response.put("success", false);
			}
		} catch (Exception e) {
			response.put("success", false);
		}
		return response;
	}

	@RequestMapping("/admin/return/search")
	public String admin_return_search(@ModelAttribute SearchReturnVO search, Model model,
			@RequestParam(defaultValue = "1") int page, HttpServletRequest request) {

		int blockList = 10;
		int blockPage = 5;

		int totalCount = return_dao.countReturnsSearch(search);
		System.out.println("search totalCount" + totalCount);

		int startRow = (page - 1) * blockList + 1;
		int endRow = startRow + blockList - 1;

		List<AdminReturnVO> returns = return_dao.searchReturnsPaging(search, startRow, endRow);

		if (returns == null) {
			returns = new ArrayList<>();
		}

		String pageUrl = request.getContextPath() + "/admin/return/search";
		String searchParam = search.toQueryString();

		String pagingHtml = Paging.getPaging(pageUrl, page, totalCount, searchParam, blockList, blockPage);

		model.addAttribute("return_list", returns);
		model.addAttribute("pagingHtml", pagingHtml);
		model.addAttribute("totalCount", totalCount);

		String requestedWith = request.getHeader("X-Requested-With");

		if ("XMLHttpRequest".equals(requestedWith)) {
			return "admin_order/return_list_partial";
		} else {
			return "admin_order/return_management";
		}

	}

	@RequestMapping("/admin/return/delete")
	@ResponseBody
	@Transactional(rollbackFor = Exception.class)
	public Map<String, Object> adminReturnDelete(@RequestBody ReturnOrderIdsProductIdsVO param) {

		List<String> orderIds = param.getOrderIds();
		List<Integer> productIds = param.getProductIds();

		Map<String, Object> resultMap = new HashMap<>();

		try {

			if (orderIds.size() != productIds.size()) {
				throw new IllegalArgumentException("orderIds와 productIds 길이가 다릅니다.");
			}
			System.out.println("order_id size : " + orderIds.size() + productIds.size());

			List<Map<String, Object>> pairList = new ArrayList<>();
			for (int i = 0; i < orderIds.size(); i++) {
				Map<String, Object> pair = new HashMap<>();
				pair.put("order_id", orderIds.get(i));
				pair.put("product_id", productIds.get(i));
				System.out.println("order_id" + i + " : " + orderIds.get(i));
				System.out.println("product_id:" + i + " : " + productIds.get(i));
				pairList.add(pair);
			}

			// 1 review
			return_dao.deleteReviewItems(pairList);

			// 2 approval pending
			return_dao.deleteApprovalPendingItems(pairList);

			// 3 order_detail
			int result = return_dao.deleteReturnItems(pairList);

			if (result == pairList.size()) {
				resultMap.put("success", true);

			} else {
				resultMap.put("success", false);

			}

		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
			resultMap.put("success", false);
			System.out.println("실패");
			throw e; // rollback을 유도
		}

		return resultMap;

	}

	@RequestMapping("/admin/return/updateStatus/single")
	@ResponseBody
	public Map<String, Object> adminReturnApproveSingle(@RequestBody RequestFormVO vo) {
		Map<String, Object> resultMap = new HashMap<String, Object>();

		try {
			String currentStatus = return_dao.getProcessStatus(vo.getOrder_id(), vo.getProduct_id());
			System.out.println("order_id1: " + vo.getOrder_id());
			System.out.println("product_id: " + vo.getProduct_id());
			System.out.println("currentStatus: " + currentStatus);
			System.out.println("request_type: " + vo.getRequest_type());
			System.out.println("process_status: " + vo.getProcess_status());
			System.out.println("refund_status: " + vo.getRefund_status());
			//System.out.println("expectedRefundStatus: " + expectedRefundStatus);
			if (currentStatus != null && !"".equals(currentStatus) && !"P".equals(currentStatus)) {
			//if (!(currentStatus == null || "".equals(currentStatus) || "P".equals(currentStatus))) {
				resultMap.put("success", false);
				resultMap.put("message", "현재 상태가 접수 또는 처리중이 아니므로 처리할 수 없습니다.");
				return resultMap;
			}
			System.out.println("order_id2: " + vo.getOrder_id());
			System.out.println("product_id: " + vo.getProduct_id());
			System.out.println("currentStatus: " + currentStatus);
			System.out.println("request_type: " + vo.getRequest_type());
			System.out.println("process_status: " + vo.getProcess_status());
			System.out.println("refund_status: " + vo.getRefund_status());
			//System.out.println("expectedRefundStatus: " + expectedRefundStatus);

			String expectedRefundStatus = vo.getProcess_status();
			if (!expectedRefundStatus.equals(vo.getRefund_status())) {
				resultMap.put("success", false);
				resultMap.put("message", "요청된 상태와 실제 상태가 일치하지 않습니다.");
				return resultMap;
			}
			System.out.println("order_i3: " + vo.getOrder_id());
			System.out.println("product_id: " + vo.getProduct_id());
			System.out.println("currentStatus: " + currentStatus);
			System.out.println("request_type: " + vo.getRequest_type());
			System.out.println("process_status: " + vo.getProcess_status());
			System.out.println("refund_status: " + vo.getRefund_status());
			System.out.println("expectedRefundStatus: " + expectedRefundStatus);
			
			int res = return_dao.updateReturnRequest(vo);
			if (res > 0) {
				resultMap.put("success", true);
			} else {
				resultMap.put("success", false);
				resultMap.put("message", "상태 변경에 실패했습니다.");
			}
		} catch (Exception e) {
			e.printStackTrace();
			resultMap.put("success", false);
			resultMap.put("message", "서버 오류 발생");
		}

		return resultMap;
	}

}
