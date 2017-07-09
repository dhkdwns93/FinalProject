package kr.co.turnup_fridger.service.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.co.turnup_fridger.dao.BoardShareRecipeDao;
import kr.co.turnup_fridger.dao.RecipeCrseDao;
import kr.co.turnup_fridger.dao.RecipeInfoDao;
import kr.co.turnup_fridger.dao.RecipeIrdntDao;
import kr.co.turnup_fridger.exception.DuplicateRecipeException;
import kr.co.turnup_fridger.exception.NoneRecipeException;
import kr.co.turnup_fridger.service.RecipeService;
import kr.co.turnup_fridger.util.PagingBean;
import kr.co.turnup_fridger.vo.BoardShareRecipe;
import kr.co.turnup_fridger.vo.RecipeInfo;

@Service
public class RecipeServiceImpl implements RecipeService{

	@Autowired
	private RecipeInfoDao infoDao;
	@Autowired
	private RecipeCrseDao crseDao;
	@Autowired
	private RecipeIrdntDao irdntDao;
	@Autowired
	private BoardShareRecipeDao shareDao;
	
	//레시피 등록
	@Override
	public void createRecipe(RecipeInfo recipe) throws DuplicateRecipeException {
		if(infoDao.selectRecipeInfoById(recipe.getRecipeId())!=null){
			throw new DuplicateRecipeException("이미 존재하는 레시피입니다.");
		}

		infoDao.insertRecipeInfo(recipe);
		for(int i=0;i<recipe.getrecipeCrse().size();i++){
			crseDao.insertRecipeCrse(recipe.getrecipeCrse().get(i));
		}
		for(int i=0; i<recipe.getrecipeIrdnt().size();i++){
			irdntDao.insertRecipeIrdnt(recipe.getrecipeIrdnt().get(i));
		}	
	}

	//레시피 수정
	@Override
	public void updateRecipe(RecipeInfo recipe) throws NoneRecipeException {
		if(infoDao.selectRecipeInfoById(recipe.getRecipeId())==null){
			throw new NoneRecipeException("없는 레시피입니다.");
		}
		infoDao.updateRecipeInfo(recipe);
		for(int i=0;i<recipe.getrecipeCrse().size();i++){
			crseDao.updateRecipeCrse(recipe.getrecipeCrse().get(i));
		}
		for(int i=0; i<recipe.getrecipeIrdnt().size();i++){
			irdntDao.updateRecipeIrdnt(recipe.getrecipeIrdnt().get(i));
		}	
	}

	//레시피 삭제
	@Override
	public void removeRecipe(int recipeId) throws NoneRecipeException {
		if(infoDao.selectRecipeInfoById(recipeId)==null){
			throw new NoneRecipeException("없는 레시피입니다.");
		}
		//on delete cascade.
		infoDao.deleteRecipeInfo(recipeId);
	}

	//선택재료, 기피재료들 받아서 레시피 목록들 불러오는 것.+ 페이징
	@Override
	public List<RecipeInfo> findRecipeByIrdntId(List<Integer> irdntIds, List<Integer> hateIrdntIds,String keyword) {
		//페이징
		List<Integer> recipeIds = irdntDao.getRecipeCodeByIrdntIds(irdntIds, hateIrdntIds);		
		
		
	
		List<RecipeInfo> apiList = infoDao.selectRecipesInfoByIds(recipeIds, keyword);
		
		return null;
	}

	//레시피 이름으로 레시피 목록들 불러오는것.
	@Override
	public List<RecipeInfo> findRecipeByRecipeName(String recipeName,String keyword) {
		
		List<RecipeInfo> list = infoDao.selectRecipeInfoByName(recipeName,keyword);
		
		return null;
	}

	//유형분류와 음식분류로 선택해서 레시피 목록들 불러오는것. 
	@Override
	public List<RecipeInfo> findRecipeByCategory(String categoryName, String typeName,String keyword) {
		//페이징
		//infoDao.selectRecipeInfoByCategoryAndType(categoryName, typeName, keyword);
		
		List<RecipeInfo> list = infoDao.selectRecipeInfoByCategoryAndType(categoryName, typeName, keyword);
		
		return null;
	}
	
	//불러온 목록에서 하나를 선택하여 그 레시피의 상세화면을 가져오는 것.
	@Override
	public RecipeInfo showDetailOfRecipe(int recipeId) {
		return infoDao.selectThreeOfRecipesById(recipeId);
	}

	//레시피 상세화면에서 해당 레시피의 단위정보를 변환해 주는것 . 
	@Override
	public RecipeInfo changePortion(int portion) {
		//단위변환
		return null;
	}

	//전체 레시피 
	@Override
	public List<RecipeInfo> allRecipeList() {
		return infoDao.selectAllRecipeInfo();
	}

	@Override
	public List<String> getTypeNameByCategoryName(String categoryName) {
		return infoDao.selectTypeNameByCategoryName(categoryName);
	}
	

	
}
