package kr.co.turnup_fridger.dao.impl;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import kr.co.turnup_fridger.dao.RecipeInfoDao;
import kr.co.turnup_fridger.vo.RecipeInfo;

@Repository
public class RecipeInfoDaoImpl implements RecipeInfoDao{

	@Autowired
	private SqlSessionTemplate session;
	private String makeSql(String id){
		return "kr.co.turnup_fridger.config.mybatis.mapper.RecipeInfo."+id;
	}
	
	@Override
	public int insertRecipeInfo(RecipeInfo recipeInfo) {
		return 0;
	}

	@Override
	public int updateRecipeInfo(RecipeInfo recipeInfo) {
		return 0;
	}

	@Override
	public int deleteRecipeInfo(int recipeId) {
		return 0;
	}

	@Override
	public List<RecipeInfo> selectAllRecipeInfo() {
		return null;
	}

	@Override
	public RecipeInfo selectRecipeInfoById() {
		return null;
	}

	@Override
	public List<RecipeInfo> selectRecipeInfoByName() {
		return null;
	}

	@Override
	public List<RecipeInfo> selectRecipeInfoByLevel() {
		return null;
	}

	@Override
	public List<RecipeInfo> selectRecipeInfoByHits() {
		return null;
	}

	@Override
	public List<RecipeInfo> selectRecipeInfoBycalorie() {
		return null;
	}

	@Override
	public List<RecipeInfo> selectRecipeInfoByCategoryName() {
		return null;
	}

	@Override
	public List<RecipeInfo> selectRecipeInfoByTypeName() {
		return null;
	}

	
}
