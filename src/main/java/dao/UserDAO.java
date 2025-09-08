package dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;

import vo.LocalUserVO;
import vo.UserVO;

public class UserDAO 
{
	SqlSession sqlsession;
	
	public void setSqlsession(SqlSession sqlsession) 
	{
		this.sqlsession = sqlsession;
	}
	
	public List<UserVO> user_select_all()
	{
		List<UserVO> list = sqlsession.selectList("u.user_select_listAll");
		return list;
	}
	
	public void google_user_insert(UserVO vo)
	{
		sqlsession.insert("u.google_user_insert",vo);
	}
	
	public void kakao_user_insert(UserVO vo)
	{
		sqlsession.insert("u.kakao_user_insert",vo);
	}
	
	public void naver_user_insert(UserVO vo)
	{
		sqlsession.insert("u.naver_user_insert",vo);
	}
	
	//���� ȸ������
	public void local_user_insert(UserVO vo)
	{
		sqlsession.insert("u.local_user_insert",vo);
	}
	
	//���̵� �̸��� ��ȸ
	public UserVO id_email_select(Map<String, String> map)
	{
		UserVO vo = sqlsession.selectOne("u.user_id_email_select",map);
		return vo;
	}
	
	//ȸ������ �ҋ� ���̵� üũ ajax����
	public int id_check(String user_id)
	{
		int res = sqlsession.selectOne("u.user_id_check",user_id);
		return res;
	}
	
	//���� �α��� üũ
	public UserVO local_id_pwd(Map<String, String> map)
	{
		UserVO vo = sqlsession.selectOne("u.user_id_pwd_check",map);
		return vo;
	}
	
	//���̵� ã��
	public UserVO find(String email)
	{
		UserVO vo = sqlsession.selectOne("u.user_id_find",email);
		return vo;
	}
	
	public int pwd_reset(Map<String, String> map)
	{
		int res = sqlsession.update("u.pwd_reset",map);
		return res;
	}
	
	//���� ���� ������Ʈ
	public int user_edit_update(UserVO user)
	{
		int res = sqlsession.update("u.user_edit_update",user);
		return res;
	}
	
	public UserVO user_select_all(UserVO vo)
	{
		UserVO u_vo = sqlsession.selectOne("u.user_select", vo);
		return u_vo;
	}
	
	public UserVO user_select_idx(int user_idx)
	{
		UserVO vo = sqlsession.selectOne("u.select_user_idx",user_idx);
		return vo;
	}
}
