package dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;

import vo.AdminProductVO;
import vo.ProductListViewVO;
import vo.ProductUploadVO;
import vo.ProductVO;
import vo.SearchProductVO;
import vo.UserVO;

public class AdminProductDAO {
	SqlSession sqlSession;
	
	public void setSqlSession(SqlSession sqlSession) {
		this.sqlSession = sqlSession;
	}
	
	public List<AdminProductVO> product_selectListAll() {
		List<AdminProductVO> list = sqlSession.selectList("adminproduct.product_listAll");
		return list;
	}
	
	public int product_count() {
		return sqlSession.selectOne("adminproduct.productCount");
	}
	
	public List<AdminProductVO> product_select_paging(int startRow, int endRow){

		Map<String, Object> map = new HashMap<String, Object>();
		map.put("startRow", startRow);
		map.put("endRow", endRow);
		
		return sqlSession.selectList("adminproduct.productPagingList",map);
		
	}
	
	public List<ProductUploadVO> getProductById(int[] product_ids){
		List<ProductUploadVO> list = sqlSession.selectList("adminproduct.get_productById", product_ids);
		return list;
	}
	
	public int updateProduct(ProductUploadVO vo) {
	    return sqlSession.update("adminproduct.updateProduct",vo); // imagePaths[] 占쏙옙占쌉듸옙 VO 占쌓댐옙占� 占쏙옙占쏙옙
	   
	}
	
	public List<ProductListViewVO> getProductListWithCategory(Map<String, Object> filters) {
	    return sqlSession.selectList("adminproduct.getFilteredProductList", filters);
	}
	
	public int insertProduct(ProductUploadVO vo) {
		return sqlSession.insert("adminproduct.insertProduct", vo);
	}
	
	public List<AdminProductVO> searchProducts(SearchProductVO search){
		return sqlSession.selectList("adminproduct.searchProductWithFillter", search);
	}
	
	public int countSearchResults(SearchProductVO search) {
	    return sqlSession.selectOne("adminproduct.countSearchResults", search);
	}

	public List<AdminProductVO> searchProductsPaging(SearchProductVO search, int startRow, int endRow) {
	    Map<String, Object> map = new HashMap<>();
	    map.put("search", search);
	    map.put("startRow", startRow);
	    map.put("endRow", endRow);

	    return sqlSession.selectList("adminproduct.searchProductsPaging", map);
	}
	
	// 7. �젣�뭹 �궘�젣
	public int deleteProducts(List<Integer> list) {
		return sqlSession.delete("adminproduct.deleteProduct",list);
	}
	// 1. 由щ럭 �궘�젣
	public int deleteReview(List<Integer> list) {
		return sqlSession.delete("adminproduct.deleteReview",list);
	}
	// 2. 二쇰Ц �긽�꽭 �궘�젣
	public int deleteOrderDetail(List<Integer> list) {
		return sqlSession.delete("adminproduct.deleteOrderDetail",list);
	}
	// 3. �옣諛붽뎄�땲 �궘�젣
	public int deleteCart(List<Integer> list) {
		return sqlSession.delete("adminproduct.deleteCart",list);
	}
	// 4. 利먭꺼李얘린 �궘�젣
	public int deleteFavorite(List<Integer> list) {
		return sqlSession.delete("adminproduct.deleteFavorite",list);
	}
	// 5. 臾몄쓽湲� �궘�젣
	public int deleteInquiry(List<Integer> list) {
		return sqlSession.delete("adminproduct.deleteInquiry",list);
	}
	// 6. �끂�듃遺� �궗�뼇 �궘�젣
	/*
	 * public int deleteLaptopSpec(List<Integer> list) { return
	 * sqlSession.delete("adminproduct.deleteLaptopSpec",list); }
	 */
	
	//6.
	public int deleteApprovalPending(List<Integer> list) {
		return sqlSession.delete("adminproduct.deleteApprovalPending",list);
	}

}
