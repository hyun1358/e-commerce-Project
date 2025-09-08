package controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

//HTTP 통신 관련
import org.apache.http.HttpResponse;
import org.apache.http.NameValuePair;
import org.apache.http.client.HttpClient;
import org.apache.http.client.entity.UrlEncodedFormEntity;
import org.apache.http.client.methods.HttpPost;
import org.apache.http.impl.client.HttpClientBuilder;
import org.apache.http.message.BasicNameValuePair;
import org.apache.http.util.EntityUtils;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

//JSON 파싱 관련
import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;

import dao.CartDAO;
import dao.Order_detailDAO;
import dao.OrdersDAO;
import dao.PaymentDAO;
import dao.ProductsDAO;
import portOne_api.AccessToken;
import vo.Order_detailVO;
import vo.PaymentVO;
import vo.UserVO;

@RestController
public class PaymentController 
{
	PaymentDAO payment_dao;
	OrdersDAO order_dao;
	Order_detailDAO orderDetail_dao;
	ProductsDAO product_dao;
	CartDAO cart_dao;
	
	public void setCart_dao(CartDAO cart_dao) 
	{
		this.cart_dao = cart_dao;
	}

	public void setPayment_dao(PaymentDAO payment_dao) 
	{
		this.payment_dao = payment_dao;
	}
	
	public void setOrder_dao(OrdersDAO order_dao) 
	{
		this.order_dao = order_dao;
	}
	
	public void setOrderDetail_dao(Order_detailDAO orderDetail_dao) 
	{
		this.orderDetail_dao = orderDetail_dao;
	}
	
	public void setProduct_dao(ProductsDAO product_dao) 
	{
		this.product_dao = product_dao;
	}
	
	@Transactional
    @PostMapping("/pay_test")
    public String payTest(@RequestBody PaymentVO vo,HttpSession session)  
    {
		
		System.out.println("나paytest고 paymentvo:"+vo.getImp_uid()+vo.getMerchant_uid());
		if(vo.getDeliveryRequest() == null || vo.getDeliveryRequest().trim().isEmpty())
		{
			vo.setDeliveryRequest("요청사항 없음");
		}
		
		if(vo.getCard_name() == null)  
		{
			vo.setCard_name("간편결제");
		}
		
		//orders�� ���� ����
		UserVO u_vo = (UserVO)session.getAttribute("user");
		if(u_vo == null)
		{
			System.out.println("user 객체 null");
		}
		int user_idx = u_vo.getUser_idx();
		System.out.println("user_idx : "+user_idx);

		Map<String, Object> map = new HashMap<String, Object>();
		
		map.put("order_id", vo.getMerchant_uid());
		map.put("user_idx", user_idx);
		map.put("status", "pending");
		int res = order_dao.insertOrders(map);
		System.out.println("res:"+res);
		if(res == 1)
		{
		    List<PaymentVO.Product> products = vo.getProducts();
		    System.out.println("vo.getProducts(): " + vo.getProducts());
		    
		    for (PaymentVO.Product p : products) 
		    {
		        PaymentVO p_vo = new PaymentVO();
		        
		        System.out.println("paymentvo생성");

		        // 공통 결제 정보 복사
		        p_vo.setImp_uid(vo.getImp_uid());
		        p_vo.setMerchant_uid(vo.getMerchant_uid());
		        p_vo.setPay_method(vo.getPay_method());
		        p_vo.setCurrency(vo.getCurrency());
		        p_vo.setPaid_amount(p.getAmount());
		        p_vo.setPaid_at(vo.getPaid_at());
		        if(vo.getStatus().equals("paid"))
		        {
			        p_vo.setStatus("결제완료");
		        }
		        p_vo.setCard_name(vo.getCard_name());
		        p_vo.setCard_number(vo.getCard_number());
		        p_vo.setBuyer_name(vo.getBuyer_name());
		        p_vo.setBuyer_tel(vo.getBuyer_tel());
		        p_vo.setBuyer_addr(vo.getBuyer_addr());
		        p_vo.setBuyer_postcode(vo.getBuyer_postcode());
		        p_vo.setReceipt_url(vo.getReceipt_url());
		        p_vo.setDeliveryRequest(vo.getDeliveryRequest());
		        // 상품별 정보 세팅
		        p_vo.setProduct_name(p.getProductName()); // 또는 p.getProduct_id()
		        
		        // 👇 추가: 별도 필드 만들어서 넣고 싶으면 아래처럼
		        p_vo.setProduct_id(p.getProduct_id());
		        p_vo.setQuantity(p.getQuantity());
				
				/*
				 * System.out.println("paytest2 insert전"+p_vo.getMerchant_uid()+"payment_id:"+
				 * p_vo.getImp_uid()); System.out.println(">> DB에 넣기 전 PaymentVO 상태 확인");
				 * System.out.println(vo.toString()); // toString 안되어 있으면 직접 getXxx 출력
				 * System.out.println(p_vo.toString());
				 */
				 
		        int res11 = payment_dao.payment_insert(p_vo);
				/* System.out.println("res11"+res11); */
		        //orders_detail
		        Order_detailVO od = new Order_detailVO();
		        od.setOrder_id(vo.getMerchant_uid());
		        od.setProduct_id(p.getProduct_id());
		        od.setQuantity(p.getQuantity());
		        od.setAmount(p.getAmount());
		        od.setNote(null);
		        od.setRefund_requested_at(null);
		        od.setRefund_status("N");
		        
		        int res2 = orderDetail_dao.orderDetail_insert(od); 
		        if(res2 != 1)
		        {
		            throw new RuntimeException("Order Detail Insert 실패");
		        }
		        
		        Map<String, Object> lpatop_map = new HashMap<String, Object>();
		        lpatop_map.put("product_id", p.getProduct_id());
		        lpatop_map.put("stock", p.getQuantity());
		        
		        int p_res = product_dao.laptop_stock_salseValue_update(lpatop_map);
		        if(p_res == 1)
		        {
		        	System.out.println("재고 및 판매량 업데이트 완료");
		        }
		        
		    }//for
		}
		
		for(int i = 0; i<vo.getProducts().size(); i++)
		{
			Map<String, Object> cartDel = new HashMap<String, Object>();
			cartDel.put("user_idx", user_idx);
			cartDel.put("product_id", vo.getProducts().get(i).getProduct_id());
			int cart_res = cart_dao.cart_delete(cartDel);
			if(cart_res == 1)
			{
				System.out.println("유저 카트 리스트 삭제");
			}
		}
		
		

		
        return vo.getMerchant_uid();
        
    }//public
	
	@RequestMapping("/pay_refund")
	public String pay_refund()
	{
	    final String IMPORT_CANCEL_URL = "https://api.iamport.kr/payments/cancel";

	    String imp_uid = "imp_482393132825"; //고유번호를 여기다 넣으면됨

	    String token = AccessToken.getAccessToken();

	    try 
	    {
	        HttpClient client = HttpClientBuilder.create().build();
	        HttpPost post = new HttpPost(IMPORT_CANCEL_URL);
	        post.setHeader("Authorization", token);

	        Map<String, String> map = new HashMap<>();
	        map.put("imp_uid", imp_uid);

	        post.setEntity(new UrlEncodedFormEntity(convertParameter(map), "UTF-8"));

	        HttpResponse res = client.execute(post);
	        String responseStr = EntityUtils.toString(res.getEntity());

	        ObjectMapper mapper = new ObjectMapper();
	        JsonNode rootNode = mapper.readTree(responseStr);
	        JsonNode responseNode = rootNode.get("response");

	        if (responseNode == null || responseNode.isNull()) 
	        {
	            System.err.println("ȯ�� ����");
	        } 
	        else 
	        {
	            String status = responseNode.get("status").asText();
	            System.out.println("ȯ�� ����, ����: " + status);
	        }
	    } 
	    catch (Exception e) 
	    {
	        e.printStackTrace();
	    }

	    return "";//refund
	}
	
	private List<NameValuePair> convertParameter(Map<String, String> paramMap) {
	    List<NameValuePair> paramList = new ArrayList<>();
	    for (Map.Entry<String, String> entry : paramMap.entrySet()) {
	        paramList.add(new BasicNameValuePair(entry.getKey(), entry.getValue()));
	    }
	    return paramList;
	}
	
}



