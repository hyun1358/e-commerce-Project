package dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;

import vo.CartVO;

public class CartDAO {
	
	SqlSession sqlsession;
	
	public void setSqlsession(SqlSession sqlsession) 
	{
		this.sqlsession = sqlsession;
	}
	
	
	//장바구니 목록
	public List<CartVO> selectList(int user_idx){
		List<CartVO> list = sqlsession.selectList("c.cart_list",user_idx);
		return list;
	}
	//카트아이디로 찾음
	public CartVO selectOne(int cart_id) {
		CartVO vo = sqlsession.selectOne("c.cart_selectone",cart_id);
		return vo;
	}
	//상품이랑 유저번호로 카트를 찾음
	public CartVO selectOne(CartVO vo) {
		CartVO result = sqlsession.selectOne("c.cart_selectVO",vo);
		return result;
	}
	
	//장바구니 상품의 총합 가격
	public int totalAmount(int user_idx){
		int res = sqlsession.selectOne("c.total_amount", user_idx);	
		return res;
	}
	
	//장바구니 상품의 총합
	public int totalCnt(int user_idx) {
		int res = sqlsession.selectOne("c.total_cnt",user_idx);
		return res;
	}
	
	//장바구니 수량 업데이트
	public int cnt_update(CartVO vo) {
		int res = sqlsession.update("c.cnt_update",vo);
		return res;
	}
	
	//상품삭제
	public int deleteOne(int cart_id) {
		
		int res = sqlsession.delete("c.cart_delOne",cart_id);
		return res;
	}
	
	public int cart_insert(CartVO vo) {
		int res = sqlsession.insert("c.cart_add",vo);
		
		return res;
	}
	
	public int cart_delete(Map<String, Object> map)
	{
		int res = sqlsession.delete("c.cart_user_list_delete",map);
		return res;
	}
	
	public int cart_count(int user_idx)
	{
		int res = sqlsession.selectOne("c.cart_count",user_idx);
		return res;
	}
	
	public int mypage_cart_insert(int user_idx,int product_id)
	{
		Map<String, Integer> map = new HashMap<String, Integer>();
		map.put("user_idx", user_idx);
		map.put("product_id", product_id);
		int res = sqlsession.insert("c.mypage_cart_insert",map);
		return res;
	}
	
}
