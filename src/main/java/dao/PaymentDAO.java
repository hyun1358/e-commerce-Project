package dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;

import vo.PaymentVO;

public class PaymentDAO 
{
	SqlSession sqlSession;
	
	public void setSqlsession(SqlSession sqlSession) 
	{
		this.sqlSession = sqlSession;
	}
	
	//결제완료후 정보추가
	public int payment_insert(PaymentVO vo)
	{
		int res = sqlSession.insert("p.payment_insert",vo);
		return res;
	}
	
	//imp_uid를 이용하여 조회
	public PaymentVO payment_selectOne(String merchant_uid)
	{
		PaymentVO vo = sqlSession.selectOne("p.payment_select_one",merchant_uid);
		return vo;
	}
	//상품이름 List담을려고 씀
	public List<String> payment_selectAll(String merchant_uid)
	{
		List<String> list = sqlSession.selectList("p.payemnt_productName_selectAll",merchant_uid);
		return list;
	}
	
	public int payment_selectTotalpaid(String merchant_uid) {
		return sqlSession.selectOne("p.paid_total_amount",merchant_uid);
	}
	
	public void thread_ststus_update(Map<String, Object> map)
	{
		sqlSession.update("p.thread_ststus_update",map);
	}
	
}
