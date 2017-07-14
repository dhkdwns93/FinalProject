package kr.co.turnup_fridger.dao.impl;

import java.util.HashMap;
import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import kr.co.turnup_fridger.dao.FavoriteRecipeDao;
import kr.co.turnup_fridger.vo.FavoriteRecipe;

@Repository
public class FavoriteRecipeDaoImpl implements FavoriteRecipeDao{

	@Autowired
	private SqlSessionTemplate session;

	private String makeSql(String id){
		return "kr.co.turnup_fridger.config.mybatis.mapper.favoriteRecipeMapper."+id;
	}
	
	@Override
	public int insertFavoriteRecipe(FavoriteRecipe recipe) {
		return session.insert(makeSql("insertFavoriteRecipe"),recipe);
	}

	@Override
	public int updateFavoriteRecipe(FavoriteRecipe recipe) {
		return session.update(makeSql("updateFavoriteRecipe"),recipe);
	}

	@Override
	public int deleteFavoriteRecipe(int favoriteRecipeKey) {
		return session.delete(makeSql("deleteFavoriteRecipe"),favoriteRecipeKey);
	}

	@Override
	public List<FavoriteRecipe> selectAllFavoriteRecipe() {
		return session.selectList(makeSql("selectAllFavoriteRecipe"));
	}

	@Override
	public List<FavoriteRecipe> selectFavoriteRecipeByMemberId(String memberId) {
		return session.selectList(makeSql("selectFavoriteRecipeByMemberId"),memberId);
	}

	@Override
	public List<FavoriteRecipe> selectFavoriteRecipeByRecipeId(int recipeId) {
		return session.selectList(makeSql("selectFavoriteRecipeByRecipeId"),recipeId);
	}

	@Override
	public FavoriteRecipe selectFavoriteRecipeByIds(String memberId, int recipeId) {
		HashMap map = new HashMap();
		map.put("memberId", memberId);
		map.put("recipeId", recipeId);
		return session.selectOne(makeSql("selectFavoriteRecipeByIds"),map);
	}

	@Override
	public FavoriteRecipe selectFavoriteRecipeByKey(int favoriteRecipeKey) {
		return session.selectOne(makeSql("selectFavoriteRecipeByKey"),favoriteRecipeKey);
	}
	
	

	
}
