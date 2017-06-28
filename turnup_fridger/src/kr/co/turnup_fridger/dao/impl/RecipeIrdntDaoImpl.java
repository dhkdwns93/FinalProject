package kr.co.turnup_fridger.dao.impl;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import kr.co.turnup_fridger.dao.RecipeIrdntDao;
import kr.co.turnup_fridger.vo.RecipeIrdnt;

@Repository
public class RecipeIrdntDaoImpl implements RecipeIrdntDao{

	@Autowired
	private SqlSessionTemplate session;
	private String makeSql(String id){
		return "kr.co.turnup_fridger.config.mybatis.mapper.RecipeIrdnt."+id;
	}
	
	@Override
	public int insertRecipeIrdnt(RecipeIrdnt recipeIrdnt) {
		return session.insert(makeSql("insertRecipeIrdnt"),recipeIrdnt);
	}

	@Override
	public int updateRecipeIrdnt(RecipeIrdnt recipeIrdnt) {
		return session.update(makeSql("updateRecipeIrdnt"),recipeIrdnt);
	}

	@Override
	public int deleteRecipeIrdnt(int recipeId) {
		return session.delete(makeSql("deleteRecipeIrdnt"),recipeId);
	}

	@Override
	public List<RecipeIrdnt> selectAllRecipeIrdnt() {
		return session.selectList(makeSql("selectAllRecipeIrdnt"));
	}

	@Override
	public List<RecipeIrdnt> selectRecipeIrdntById(int recipeNo) {
		return session.selectList(makeSql("selectRecipeIrdntById"),recipeNo);
	}

	@Override
	public RecipeIrdnt selectRecipeIrdntByNo(int irdntNo) {
		return session.selectOne(makeSql("selectRecipeIrdntByNo"),irdntNo);
	}

	@Override
	public List<RecipeIrdnt> selectRecipeIrdntByName(String irdntName) {
		return session.selectList(makeSql("selectRecipeIrdntByName"),irdntName);
	}

	@Override
	public List<RecipeIrdnt> getRecipeCodeByIrdntId(List irdntIds) {
		
		int irdntId=0;
		
		
		
		return session.selectList(makeSql("getRecipeCodeByIrdntId"),irdntId);
	}

	
}
