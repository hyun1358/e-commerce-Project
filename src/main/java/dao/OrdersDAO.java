package dao;

import java.util.Arrays;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;

import vo.CartVO;
import vo.OrderListVO;
import vo.Order_detailVO;
import vo.OrdersVO;

public class OrdersDAO {

	SqlSession sqlSession;

	public void setSqlSession(SqlSession sqlSession) {
		this.sqlSession = sqlSession;
	}

	public List<OrderListVO> selectListOrder(int user_idx) {
		List<OrderListVO> list = sqlSession.selectList("o.selectOrderList", user_idx);
		return list;
	}

	public OrdersVO selectOrderOne(String order_id) {
		return sqlSession.selectOne("o.selectOrderOne", order_id);
	}

	/* ststus 상태에따른 조회 */
	public List<OrderListVO> selectListOrderStatus(Map<String, Object> map)
	{
		List<OrderListVO> list = sqlSession.selectList("o.selectStatusList",map);
		return list;
	}
	
	public List<CartVO> getSelectedCartItems(int user_idx, String[] cartIdArray) {
		Map<String, Object> cart_map = new HashMap<String, Object>();
		cart_map.put("user_idx", user_idx);
		cart_map.put("cart_ids", Arrays.asList(cartIdArray));

		List<CartVO> list = sqlSession.selectList("o.selectedCartItems", cart_map);

		return list;
	}

	// 주문 추가
	public int insertOrders(Map<String, Object> map) {
		int res = sqlSession.insert("o.insert_Orders", map);
		return res;
	}

	// 주문 update
	public int updateOrders(OrdersVO vo) {
		int res = sqlSession.update("o.order_update", vo);
		return res;
	}

	// 주문상품 추가
	public int insertOrderDetail(Order_detailVO vo) {
		int res = sqlSession.insert("o.insertOrderDetail", vo);
		return res;
	}
	
	public List<OrderListVO> selectLatestOrder(int user_idx) {
		return sqlSession.selectList("latestOrderOne", user_idx);
	}
	/* status 자동 update(Thread사용)*/
	public void thread_ststus_update(Map<String, Object> map)
	{
		sqlSession.update("o.thread_ststus_update",map);
	}

	public int order_count(int user_idx)
	{
		int res = sqlSession.selectOne("o.order_count",user_idx);
		return res;
	}
}
