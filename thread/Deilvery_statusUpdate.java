package thread;

import java.util.HashMap;
import java.util.Map;

import dao.OrdersDAO;
import dao.PaymentDAO;

public class Deilvery_statusUpdate extends Thread 
{
	private String order_id;
	private OrdersDAO order_dao;
	private PaymentDAO payment_dao;
	
	public Deilvery_statusUpdate(String order_id, OrdersDAO order_dao,PaymentDAO payment_dao) 
	{
		this.order_id = order_id;
		this.order_dao = order_dao;
		this.payment_dao = payment_dao;
	}
	
	@Override
	public void run() 
	{
		try 
		{
			String[] statuses = { "결제완료", "상품준비중", "배송중", "배송완료" };
			Map<String, Object> map = new HashMap<String, Object>();
			map.put("order_id", order_id);
			map.put("merchant_uid", order_id);
			for(String status : statuses)
			{
				System.out.println("시작: " +status);
				map.put("status", status);
				order_dao.thread_ststus_update(map);
				System.out.println("order ststus update");
				payment_dao.thread_ststus_update(map);
				System.out.println("payment ststus update");
				Thread.sleep(10000); //10초
				System.out.println("status: " +status);
			}
		} 
		catch (Exception e) 
		{
			e.printStackTrace();
		}
	}
}
