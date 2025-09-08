package dao;

import org.apache.ibatis.session.SqlSession;

import vo.AdminPaymentVO;

public class AdminPaymentDAO {
	SqlSession sqlSession;
	
	public void setSqlSession(SqlSession sqlSession) {
		this.sqlSession = sqlSession;
	}
	
	public AdminPaymentVO selectAdminPaymentById(String order_id) {
		return sqlSession.selectOne("adminpayment.getpaymentById", order_id);
	}
	
}
