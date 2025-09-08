package dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;

import vo.AdminProductVO;
import vo.SearchCustomerVO;
import vo.SearchProductVO;
import vo.UserVO;

public class AdminUserDAO {
	SqlSession sqlSession;

	public void setSqlSession(SqlSession sqlSession) {
		this.sqlSession = sqlSession;
	}

	public List<UserVO> user_select_all() {
		List<UserVO> list = sqlSession.selectList("adminuser.user_select_listAll");
		return list;
	}
	
	public int user_count() {
		return sqlSession.selectOne("adminuser.userCount");
	}
	
	public List<UserVO> user_select_paging(int startRow, int endRow){

		Map<String, Object> map = new HashMap<String, Object>();
		map.put("startRow", startRow);
		map.put("endRow", endRow);
		
		return sqlSession.selectList("adminuser.userPagingList",map);
		
	}

	public List<UserVO> getUserById(int[] user_ids) {

		List<UserVO> list = sqlSession.selectList("adminuser.get_userById", user_ids);
		return list;
	}
	
	public int updateUser(UserVO vo) {
		int res = sqlSession.update("adminuser.updateUser",vo);
		return res;
	}
	
	public int countSearchUser(SearchCustomerVO search) {
	    return sqlSession.selectOne("adminuser.searchUserCount", search);
	}

	public List<UserVO> searchUsersPaging(SearchCustomerVO search, int startRow, int endRow) {
	    Map<String, Object> map = new HashMap<>();
	    map.put("search", search);
	    map.put("startRow", startRow);
	    map.put("endRow", endRow);

	    return sqlSession.selectList("adminuser.searchUserPaging", map);
	}
	
	
	public List<UserVO> searchCustomers(SearchCustomerVO vo){
		
		List<UserVO> list = sqlSession.selectList("adminuser.searchUserWithFillter", vo);
		return list;
	}
	
	public int deleteCustomers(List<Integer> list) {
		return sqlSession.delete("adminuser.deleteUser", list);
	}
	
	//1.review
	public int deleteReview(List<Integer> list) {
		return sqlSession.delete("adminuser.deleteReview", list);
	}
	
	//2.cart
	public int deleteCart(List<Integer> list) {
		return sqlSession.delete("adminuser.deleteCart", list);
	}
	
	//3.favorite
	public int deleteFavorite(List<Integer> list) {
		return sqlSession.delete("adminuser.deleteFavorite", list);
	}
	
	//4.inquiry
	public int deleteInquiry(List<Integer> list) {
		return sqlSession.delete("adminuser.deleteInquiry", list);
	}
	
	//5.approval_pending
	public int deleteApprovalPending(List<Integer> list) {
		return sqlSession.delete("adminuser.deleteApprovalPending", list);
	}
}
