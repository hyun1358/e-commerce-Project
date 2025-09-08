package dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;

import vo.NoticeVO;

public class NoticeDAO 
{
	SqlSession sqlsession;
	
	public void setSqlsession(SqlSession sqlsession) 
	{
		this.sqlsession = sqlsession;
	}
	
	public int notice_count()
	{
		return sqlsession.selectOne("n.notice_count");
	}
	
	public List<NoticeVO> notice_paging(int startRow,int endRow,String sort)
	{
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("startRow", startRow);
		map.put("endRow", endRow);
		map.put("sort", sort);
		List<NoticeVO> list = sqlsession.selectList("n.notice_paging",map);
		return list;
	}
}
