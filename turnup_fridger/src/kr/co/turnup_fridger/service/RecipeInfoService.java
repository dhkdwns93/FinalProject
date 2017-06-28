package kr.co.turnup_fridger.service;

import java.util.List;

import kr.co.turnup_fridger.vo.RecipeInfo;

public interface RecipeInfoService {

	void createRecipeInfo(RecipeInfo recipeInfo);
	
	void updateRecipeInfo(RecipeInfo recipeInfo);
	
	void deleteRecipeInfo(int recipeId);
	
	List<RecipeInfo> findAllRecipeInfo();
	
	List<RecipeInfo> findRecipeInfoByrecipeId(int recipeId);
	
	List<RecipeInfo> findRecipeInfoByrecipeName(String recipeName);
	
	List<RecipeInfo> findRecipeInfoByrecipeLevel(String recipeLevel);
	
	List<RecipeInfo> findRecipeInfoByrecipeHits(int recipeHits);
	
	List<RecipeInfo> findRecipeInfoByCalorie(String calorie);
	
	List<RecipeInfo> findRecipeInfoByCategoryName(String categoryName);
	
	List<RecipeInfo> findRecipeInfoByTypeName(String typeName);
	
	
	String changePortion(String cookingDc,int recipeId,int cookingNo);
	
}
