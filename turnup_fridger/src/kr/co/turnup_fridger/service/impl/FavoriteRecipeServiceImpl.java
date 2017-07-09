package kr.co.turnup_fridger.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.co.turnup_fridger.dao.FavoriteRecipeDao;
import kr.co.turnup_fridger.exception.DuplicateFavoriteException;
import kr.co.turnup_fridger.exception.NoneFavoriteException;
import kr.co.turnup_fridger.service.FavoriteRecipeService;
import kr.co.turnup_fridger.vo.FavoriteRecipe;

@Service
public class FavoriteRecipeServiceImpl implements FavoriteRecipeService{

	@Autowired
	private FavoriteRecipeDao dao;

	@Override
	public void createFavoriteRecipe(FavoriteRecipe recipe) throws DuplicateFavoriteException {
		//사용자가 이미 추가한 즐찾이면 못들어가게 해야해. 
		if(dao.selectFavoriteRecipeByIds(recipe.getMemberId(), recipe.getRecipeId())==null){
			throw new DuplicateFavoriteException("이미 즐겨찾기에 추가되어있습니다.");
		}
		
		//시퀀스니까 0으로 일단 설정해주고.  
		recipe.setFavoriteRecipeKey(0);
		dao.insertFavoriteRecipe(recipe);
	}

	@Override
	public void updateFavoriteRecipe(FavoriteRecipe recipe) throws NoneFavoriteException {
		//수정...? 그냥 삭제하겠지?일단 만들어두자 
		if(dao.selectFavoriteRecipeByKey(recipe.getFavoriteRecipeKey())==null){
			throw new NoneFavoriteException("없는 즐겨찾기정보입니다.");
		}
		dao.updateFavoriteRecipe(recipe);
	}

	@Override
	public void removeFavoriteRecipe(int favoriteRecipeKey) throws NoneFavoriteException {
		if(dao.selectFavoriteRecipeByKey(favoriteRecipeKey)==null){
			throw new NoneFavoriteException("없는 즐겨찾기정보입니다.");
		}
		dao.deleteFavoriteRecipe(favoriteRecipeKey);
	}

	@Override
	public List<FavoriteRecipe> findAllFavoriteRecipe() {
		return dao.selectAllFavoriteRecipe();
	}

	@Override
	public List<FavoriteRecipe> findFavoriteRecipeByMemberId(String memberId) {
		return dao.selectFavoriteRecipeByMemberId(memberId);
	}

	@Override
	public List<FavoriteRecipe> findFavoriteRecipeByRecipeId(int recipeId) {
		return dao.selectFavoriteRecipeByRecipeId(recipeId);
	}


	
	
}
