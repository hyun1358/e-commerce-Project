package dao;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;

import vo.AdminReturnVO;
import vo.RequestFormVO;
import vo.SearchReturnVO;

public class AdminReturnDAO {
	SqlSession sqlSession;

	public void setSqlSession(SqlSession sqlSession) {
		this.sqlSession = sqlSession;
	}

	public int returnCount() {
		return sqlSession.selectOne("adminreturn.returnCount");
	}

	public List<AdminReturnVO> return_select_paging(int startRow, int endRow) {

		Map<String, Object> map = new HashMap<String, Object>();
		map.put("startRow", startRow);
		map.put("endRow", endRow);

		return sqlSession.selectList("adminreturn.returnPagingList", map);
	}

	public List<AdminReturnVO> getReturnListByOrderProductPairs(String[] orderIds, int[] productIds) {
		List<Map<String, Object>> pairList = new ArrayList<>();

		for (int i = 0; i < orderIds.length; i++) {
			Map<String, Object> pair = new HashMap<>();
			pair.put("order_id", orderIds[i]);
			pair.put("product_id", productIds[i]);
			pairList.add(pair);
		}

		return sqlSession.selectList("adminreturn.getReturnListByOrderProductPairs", pairList);
	}

	/*
	 * 나중에 수정해볼거 public List<AdminReturnVO>
	 * getReturnListByOrderProductPairs(List<String> orderIds, List<Integer>
	 * productIds) { List<Map<String, Object>> pairList = new ArrayList<>();
	 * 
	 * for (int i = 0; i < orderIds.size(); i++) { Map<String, Object> pair = new
	 * HashMap<>(); pair.put("order_id", orderIds.get(i)); pair.put("product_id",
	 * productIds.get(i)); pairList.add(pair); }
	 * 
	 * return sqlSession.selectList("adminreturn.getReturnListByOrderProductPairs",
	 * pairList); }
	 */

	public int updateReturnRequest(RequestFormVO request) {
		return sqlSession.update("adminreturn.updateReturnStatus", request);
	}

	public int countReturnsSearch(SearchReturnVO vo) {
		return sqlSession.selectOne("adminreturn.countReturnsSearch", vo);
	}

	public List<AdminReturnVO> searchReturnsPaging(SearchReturnVO search, int startRow, int endRow) {
		Map<String, Object> resultMap = new HashMap<String, Object>();
		resultMap.put("search", search);
		resultMap.put("startRow", startRow);
		resultMap.put("endRow", endRow);

		return sqlSession.selectList("adminreturn.searchReturnsPaging", resultMap);
	}

	// delete1
	public int deleteReviewItems(List<Map<String, Object>> pair) {
		return sqlSession.delete("adminreturn.deleteReviewItems", pair);
	}

	// delete2
	public int deleteApprovalPendingItems(List<Map<String, Object>> pair) {
		return sqlSession.delete("adminreturn.deleteApprovalPendingItems", pair);
	}

	// delete3
	public int deleteReturnItems(List<Map<String, Object>> pair) {
		return sqlSession.delete("adminreturn.deleteReturnItems", pair);
	}

	public String getProcessStatus(String order_id, int product_id) {
		Map<String, Object> paramMap = new HashMap<>();
		paramMap.put("order_id", order_id);
		paramMap.put("product_id", product_id);
		return sqlSession.selectOne("adminreturn.checkProcessStatus", paramMap);
	}
	
	
}
