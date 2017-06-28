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
		return 0;
	}

	@Override
	public int updateRecipeIrdnt(RecipeIrdnt recipeIrdnt) {
		return 0;
	}

	@Override
	public int deleteRecipeIrdnt(int recipeId) {
		return 0;
	}

	@Override
	public List<RecipeIrdnt> selectAllRecipeIrdnt() {
		return null;
	}

	@Override
	public List<RecipeIrdnt> selectRecipeIrdntById(int recipeId) {
		return null;
	}

	@Override
	public RecipeIrdnt selectRecipeIrdntByNo(int irdntNo) {
		return null;
	}

	@Override
	public List<RecipeIrdnt> selectRecipeIrdntByName(String irdntName) {
		return null;
	}

	@Override
	public List<RecipeIrdnt> getRecipeCodeByIrdntId(List irdntIds) {
		return null;
	}

	
}
