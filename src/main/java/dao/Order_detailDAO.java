package dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;

import vo.OrderDeliveryVO;
import vo.OrderListVO;
import vo.Order_detailVO;
import vo.RequestFormVO;
import vo.WishlistVO;

public class Order_detailDAO 
{
	SqlSession sqlSession;

	public void setSqlSession(SqlSession sqlSession) 
	{
		this.sqlSession = sqlSession;
	}
	
	public List<OrderListVO> selectDetailList(String order_id) {
		return sqlSession.selectList("od.orderDetailList",order_id);
	}
	
	
	public int orderDetail_insert(Order_detailVO vo)
	{
		int res = sqlSession.insert("od.orderDetail_insert",vo);
		return res;
	}
	public OrderDeliveryVO orderDelivery_quantity_amount(Map<String, Object> map)
	{
		OrderDeliveryVO vo = sqlSession.selectOne("od.delivery_quantity_amount",map);
		return vo;
	}
	
	
	public List<WishlistVO> selectOrderIdsByUser(int user_idx) 
	{
		List<WishlistVO> list = sqlSession.selectList("od.selectOrderIdsByUser", user_idx); 
		return list;
	}
	
	/* review-list-empty */
	public List<String> selectReviewIdsByUser(int user_idx) {
	    return sqlSession.selectList("od.selectReviewIdsByUser", user_idx);
	}
	
	public int updateStatusRequest(RequestFormVO request) {
		return sqlSession.update("od.updateRefundStatus",request);
		
	}
	
}
