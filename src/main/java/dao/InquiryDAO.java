package dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;

import vo.InquiryVo;

public class InquiryDAO 
{
	SqlSession sqlsession;
	
	public void setSqlsession(SqlSession sqlsession) 
	{
		this.sqlsession = sqlsession;
	}
	
	public int inquiry_insert(InquiryVo vo)
	{
		int res = sqlsession.insert("i.inquiry_insert",vo);
		return res;
	}
	
	public List<InquiryVo> inquiry_list(int user_idx)
	{
		return sqlsession.selectList("i.inquiry_list",user_idx);
	}
	
	public int inquiry_count(int user_idx)
	{
		return sqlsession.selectOne("i.inquiry_count",user_idx);
	}
}
