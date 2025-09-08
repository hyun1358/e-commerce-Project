package dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;

import vo.AdminOrderDetailVO;
import vo.Order_detailVO;

public class AdminOrderDetailDAO {

	SqlSession sqlSession;
	
	public void setSqlSession(SqlSession sqlSession) {
		this.sqlSession = sqlSession;
	}
	
	public List<AdminOrderDetailVO> selectOrderOne(String order_id){
		return sqlSession.selectList("adminorder_detail.selectOrderOne",order_id);
	}
	
}
