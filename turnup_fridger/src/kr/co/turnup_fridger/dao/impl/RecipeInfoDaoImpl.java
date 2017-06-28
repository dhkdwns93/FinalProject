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
		return session.insert(makeSql("insertRecipeInfo"),recipeInfo);
	}

	@Override
	public int updateRecipeInfo(RecipeInfo recipeInfo) {
		return session.update(makeSql("updateRecipeInfo"),recipeInfo);
	}

	@Override
	public int deleteRecipeInfo(int recipeId) {
		return session.delete(makeSql("deleteRecipeInfo"),recipeId);
	}

	@Override
	public List<RecipeInfo> selectAllRecipeInfo() {
		return session.selectList(makeSql("selectAllRecipeInfo"));
	}

	@Override
	public RecipeInfo selectRecipeInfoById(int recipeId) {
		return session.selectOne(makeSql("selectRecipeInfoById"),recipeId);
	}

	@Override
	public List<RecipeInfo> selectRecipeInfoByName(String recipeName) {
		return session.selectList(makeSql("selectRecipeInfoByName"),recipeName);
	}

	@Override
	public List<RecipeInfo> selectRecipeInfoByLevel(String recipeLevel) {
		return session.selectList(makeSql("selectRecipeInfoByLevel"),recipeLevel);
	}

	@Override
	public List<RecipeInfo> selectRecipeInfoByHits(int recipeHits) {
		return session.selectList(makeSql("selectRecipeInfoByHits"),recipeHits);
	}

	@Override
	public List<RecipeInfo> selectRecipeInfoBycalorie(String calroie) {
		return session.selectList(makeSql("selectRecipeInfoBycalorie"),calroie);
	}

	@Override
	public List<RecipeInfo> selectRecipeInfoByCategoryName(String categoryName) {
		return session.selectList(makeSql("selectRecipeInfoByCategoryName"),categoryName);
	}

	@Override
	public List<RecipeInfo> selectRecipeInfoByTypeName(String typeName) {
		return session.selectList(makeSql("selectRecipeInfoByTypeName"),typeName);
	}

	
}
