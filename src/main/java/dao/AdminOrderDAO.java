package dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;

import vo.AdminOrderVO;
import vo.AdminProductVO;
import vo.OrdersVO;
import vo.SearchOrderVO;

public class AdminOrderDAO {

	SqlSession sqlSession;
	
	public void setSqlSession(SqlSession sqlSession) {
		this.sqlSession = sqlSession;
	}
	
	public int order_count() {
		return sqlSession.selectOne("adminorder.orderCount");
	}
	
	public List<AdminOrderVO> order_selectListAll(){
		return sqlSession.selectList("adminorder.order_listAll");
	}
	
	public List<AdminOrderVO> order_select_paging(int startRow, int endRow){

		Map<String, Object> map = new HashMap<String, Object>();
		map.put("startRow", startRow);
		map.put("endRow", endRow);
		
		return sqlSession.selectList("adminorder.orderPagingList",map);
		
	}
	
	public int countOrderSearch(SearchOrderVO search){
		return sqlSession.selectOne("adminorder.countOrderSearch",search);
	}
	
	public List<AdminOrderVO> searchOrdersPaging(SearchOrderVO search, int startRow, int endRow){
		Map<String, Object> paramMap = new HashMap<>();
		paramMap.put("search", search);
		paramMap.put("startRow", startRow);
		paramMap.put("endRow", endRow);
		return sqlSession.selectList("adminorder.searchOrdersPaging",paramMap);
	}
	
	public OrdersVO getOrderById(String order_id) {
		return sqlSession.selectOne("adminorder.getOrderById",order_id);
	}
	
	public int updateOrderStatus(String order_id, String orderStatus) {
		Map<String, Object> param = new HashMap<String, Object>();
		param.put("order_id", order_id);
		param.put("orderStatus", orderStatus);
		System.out.println(order_id+" updateOrderStatus "+ orderStatus);
		
	    return sqlSession.update("adminorder.updateOrderStatus", param);
	}
	
	
	//二쇰Ц �궘�젣
	public int deleteOrderById(String order_id) {
		System.out.println("dao order_id"+order_id);
		return sqlSession.delete("adminorder.deleteOrderById",order_id);
	}
	
	public int deleteReviewByOrderId(String order_id) {
	    return sqlSession.delete("adminorder.deleteReviewByOrderId", order_id);
	}
	
	public int deleteApprovalPendingByOrderId(String order_id) {
		return sqlSession.delete("adminorder.deleteApprovalPendingByOrderId", order_id); 
	}

	/*
	 * public int deleteOrderDetailByOrderId(String order_id) { return
	 * sqlSession.delete("adminorder.deleteOrderDetailByOrderId", order_id); }
	 */
}
