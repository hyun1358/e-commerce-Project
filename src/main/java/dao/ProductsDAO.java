package dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;

import vo.AllProductsVO;
import vo.BestProductVO;
import vo.LaptopSpecVO;
import vo.ProductVO;

public class ProductsDAO {
	SqlSession sqlsession;

	public void setSqlsession(SqlSession sqlsession) {
		this.sqlsession = sqlsession;
	}
	//전체 상품중 가장 판매량이 좋은 8개
	public List<BestProductVO> bestList() 
	{
		List<BestProductVO> list = sqlsession.selectList("l.best_list");
		return list;
	}
	
	/* 베스트 상품 정렬 */
		public List<BestProductVO> bestProducts_sort(String sort, List<Integer> product_ids) {
	    Map<String, Object> paramMap = new HashMap<>();
	    paramMap.put("sort", sort);
	    paramMap.put("product_ids", product_ids);
	    return sqlsession.selectList("l.bestProductsWithSort", paramMap);
	}
	
	/* 전체상품 출력 */
	public List<AllProductsVO> AllProducts_list()
	{
		List<AllProductsVO> list = sqlsession.selectList("l.all_products_list");
		return list;
	}
	
	/* 전체상품 정렬 */
	public List<AllProductsVO> AllProducts_sort(String sort) {
	    Map<String, Object> paramMap = new HashMap<>();
	    paramMap.put("sort", sort);
	    return sqlsession.selectList("l.allProductsWithSort", paramMap);
	}
	
	/* 세일 출력 */
	public List<AllProductsVO> sales_Products_list()
	{
		List<AllProductsVO> list = sqlsession.selectList("l.sales_product_list");
		return list;
	}
	
	/* 세일 상품 정렬 */
	public List<AllProductsVO> salesProducts_sort(String sort) {
	    Map<String, Object> paramMap = new HashMap<>();
	    paramMap.put("sort", sort);
	    return sqlsession.selectList("l.salesProductsWithSort", paramMap);
	}
	
	
	public List<ProductVO> getCategoryProducts(int category_id){
	    return sqlsession.selectList("l.categoryProducts", category_id);
	}
	
	public List<ProductVO> category_sort(String sort, int category_id) 
	{
		
		Map<String, Object> paramMap = new HashMap<>();
		paramMap.put("sort", sort);
		paramMap.put("category_id", category_id);
		List<ProductVO> result = sqlsession.selectList("categoryWithSort", paramMap);
		return result;
	}

	//상품 detail
	public ProductVO select_one(int product_id) 
	{
		ProductVO vo = sqlsession.selectOne("l.product_one", product_id);
		return vo;
	}

	// 노트북 스펙 dao
	public List<LaptopSpecVO> laptop_spec(List<Integer> product_ids) {
		return sqlsession.selectList("l.laptop_spec_list", product_ids);
	}

	//노트북 재고, 판매량 업데이트
	public int laptop_stock_salseValue_update(Map<String, Object> map)
	{
		int res = sqlsession.update("l.laptop_update",map);
		return res;
	}
	
	public List<ProductVO> searchProducts(String keyword){
		
		List<ProductVO> list = sqlsession.selectList("l.product_search",keyword);
		
		return list ;
	}
	
	public List<ProductVO> search_sort(String sort,String keyword){
		Map<String, Object> paramMap = new HashMap<>();
		paramMap.put("sort", sort);
		paramMap.put("keyword", keyword);
		List<ProductVO> result = sqlsession.selectList("searchWithSort", paramMap);
		return result;
	}
	
	public AllProductsVO main_select_one(int product_id) 
	{
		AllProductsVO vo = sqlsession.selectOne("l.main_product_one", product_id);
		return vo;
	}
	


}

