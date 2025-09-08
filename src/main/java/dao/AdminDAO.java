package dao;

import java.util.HashMap;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;

import vo.AdminVO;

public class AdminDAO {
	SqlSession sqlSession;
	
	public void setSqlSession(SqlSession sqlSession) {
		this.sqlSession = sqlSession;
	}
	
	public int existsByAdminId(String admin_id) {
		return sqlSession.selectOne("admin.existsByAdminId", admin_id);
	}
	
	public AdminVO checkPassword(String admin_id, String admin_pwd) {
		
		Map<String, String> param = new HashMap<String, String>();
		param.put("admin_id", admin_id);
		param.put("admin_pwd", admin_pwd);
		
		return sqlSession.selectOne("admin.checkPassword", param);
	}
}
