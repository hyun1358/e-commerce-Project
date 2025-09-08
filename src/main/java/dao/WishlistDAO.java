package dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;

import vo.WishlistVO;

public class WishlistDAO 
{
    SqlSession sqlSession;
    
    public void setSqlSession(SqlSession sqlSession) 
    {
        this.sqlSession = sqlSession;
    }
    
    //유저 찜 목록에있는 상품 아이디 전부 조회
    public List<Integer> user_wishList_selectAll(List<Integer> product_idList,int user_idx)
    {
    	Map<String, Object> in_map = new HashMap<String, Object>();
    	in_map.put("user_idx", user_idx);
    	in_map.put("product_id", product_idList);
    	List<Integer> product_id = sqlSession.selectList("w.user_wishList_productId", in_map);
    	return product_id;
    }
    
    // 찜 여부 확인 (1: 있음, 0: 없음)
    public int user_wishList_selectOne(int user_idx, int product_id)
    {
        Map<String , Integer> map = new HashMap<>();
        map.put("user_idx", user_idx);
        map.put("product_id", product_id);
        Integer exists = sqlSession.selectOne("w.user_wishList_selectOne", map);
        return exists != null ? exists : 0;
    }
    
    // 찜 추가
    public int user_wishList_insert(int user_idx,int product_id)
    {
        Map<String , Integer> map = new HashMap<>();
        map.put("user_idx", user_idx);
        map.put("product_id", product_id);
        int res = sqlSession.insert("w.user_wishList_insert", map);
        return res;
    }
    
    // 찜 삭제
    public int user_wishList_delete(int user_idx,int product_id)
    {
        Map<String , Integer> map = new HashMap<>();
        map.put("user_idx", user_idx);
        map.put("product_id", product_id);
        int res = sqlSession.delete("w.user_wishList_delete", map);
        return res;
    }

	/*
	 * public List<WishlistVO> getWishlistByUser(int user_idx) { List<WishlistVO>
	 * list = sqlSession.selectList("w.selectWishlistByUser", user_idx); return
	 * list; }
	 */
    
    
    public List<WishlistVO> selectWishList(int user_idx) {
    	return sqlSession.selectList("w.selectUserAll",user_idx);
    }
    
    public int user_wish_count(int user_idx)
    {
    	int res = sqlSession.selectOne("w.wish_count",user_idx);
    	return res;
    }
    
    public int mypage_wishlist_delete(int user_idx, int product_id)
    {
    	Map<String, Integer> map = new HashMap<String, Integer>();
    	map.put("user_idx", user_idx);
    	map.put("product_id", product_id);
    	int res = sqlSession.delete("w.mypage_wishlist_delete",map);
    	return res;
    }
    
}
