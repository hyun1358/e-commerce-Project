package dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;

import vo.CategoryVO;


public class CategoryDAO 
{
	SqlSession sqlSession;
	
	public void setSqlSession(SqlSession sqlSession) {
		this.sqlSession = sqlSession;
	}
	
	public String getCategoryName(int category_id) {
		return sqlSession.selectOne("category.select_name",category_id);
	}
	
	public List<CategoryVO> getChildrenByParentId(int parent_id){
		return sqlSession.selectList("category.getChildByParentId",parent_id);
	}
	
	public List<CategoryVO>getParentCategoryAll(){
		return sqlSession.selectList("category.getParentList");
	}
	
	public List<CategoryVO> getAllCategories(){
		return sqlSession.selectList("category.selectListAll");
	}
}
