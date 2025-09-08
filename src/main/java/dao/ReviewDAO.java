package dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;

import vo.ReviewVO;

public class ReviewDAO {
	SqlSession sqlsession;
	
	public void setSqlSession(SqlSession sqlsession) {
		this.sqlsession = sqlsession;
	}
	
	public List<ReviewVO> selectList(int product_id){
		List<ReviewVO> list = sqlsession.selectList("r.review_list",product_id);
		return list;
	}
	
	public double review_avg(int product_id) {
		Double avg = sqlsession.selectOne("r.review_avg",product_id);
		double review_avg = (avg != null) ? avg: 0.0;
		return review_avg;
	}
	
	public int review_cnt(int product_id) {
		int cnt= sqlsession.selectOne("r.review_cnt",product_id);
		return cnt;
	}
	
	public int review_insert(ReviewVO vo) {
		int res = sqlsession.insert("r.review_insert", vo);
		return res;
	}
	
	public ReviewVO review_selectOne(ReviewVO vo) {
		ReviewVO res = sqlsession.selectOne("r.review_selectone",vo);
		return res;
	}
	
	public int review_modify(ReviewVO vo) {
		int res = sqlsession.update("r.review_modify", vo);
		return res;
	}
	public List<ReviewVO> selectPaging(int product_id, int start, int end) 
	{
	    Map<String, Integer> param = new HashMap<>();
	    param.put("product_id", product_id);
	    param.put("start", start);
	    param.put("end", end);
	    return sqlsession.selectList("r.review_paging", param);
	}

	/* ∏Æ∫‰ « ≈Õ + ∆‰¿Ã¬° */
	public List<ReviewVO> select_filter_Paging(int product_id, int start, int end, String sort) 
	{
	    Map<String, Object> param = new HashMap<>();
	    param.put("product_id", product_id);
	    param.put("start", start);
	    param.put("end", end);
	    param.put("sort", sort);
	    return sqlsession.selectList("r.review_filter_paging", param);
	}
	
	public Map<String, Object> user_view_count(int user_idx)
	{
		Map<String, Object> map = sqlsession.selectOne("r.user_view_count",user_idx);
		return map;
	}
	
	/* review-list-empty */
	public List<String> selectOrderIdsByUser(int user_idx) {
	    return sqlsession.selectList("od.selectOrderIdsByUser", user_idx);
	}
	
}
