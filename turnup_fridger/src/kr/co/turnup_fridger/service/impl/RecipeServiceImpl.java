package kr.co.turnup_fridger.service.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.co.turnup_fridger.dao.RecipeCrseDao;
import kr.co.turnup_fridger.dao.RecipeInfoDao;
import kr.co.turnup_fridger.dao.RecipeIrdntDao;
import kr.co.turnup_fridger.service.RecipeService;
import kr.co.turnup_fridger.util.PagingBean;
import kr.co.turnup_fridger.vo.RecipeInfo;

@Service
public class RecipeServiceImpl implements RecipeService{

	@Autowired
	private RecipeInfoDao infoDao;
	@Autowired
	private RecipeCrseDao crseDao;
	@Autowired
	private RecipeIrdntDao irdntDao;
	
	
	@Override
	public void createRecipe(RecipeInfo recipe) throws Exception {
		if(infoDao.selectRecipeInfoById(recipe.getRecipeId())!=null){
			throw new Exception("이미 존재하는 레시피입니다.");
		}
		//3중조인된 타입으로 들어가는건가?
		infoDao.insertRecipeInfo(recipe);
		for(int i=0;i<recipe.getrecipeCrse().size();i++){
			crseDao.insertRecipeCrse(recipe.getrecipeCrse().get(i));
		}
		for(int i=0; i<recipe.getrecipeIrdnt().size();i++){
			irdntDao.insertRecipeIrdnt(recipe.getrecipeIrdnt().get(i));
		}	
	}

	@Override
	public void updateRecipe(RecipeInfo recipe) throws Exception {
		if(infoDao.selectRecipeInfoById(recipe.getRecipeId())==null){
			throw new Exception("없는 레시피입니다.");
		}
		infoDao.updateRecipeInfo(recipe);
		for(int i=0;i<recipe.getrecipeCrse().size();i++){
			crseDao.updateRecipeCrse(recipe.getrecipeCrse().get(i));
		}
		for(int i=0; i<recipe.getrecipeIrdnt().size();i++){
			irdntDao.updateRecipeIrdnt(recipe.getrecipeIrdnt().get(i));
		}	
	}

	@Override
	public void removeRecipe(int recipeId) throws Exception {
		if(infoDao.selectRecipeInfoById(recipeId)==null){
			throw new Exception("없는 레시피입니다.");
		}
		infoDao.deleteRecipeInfo(recipeId);
		//crse는 cookingno을 알아서 지울수가 있네...
		//irdnt는 irdntno로....
		//cascade로 지울수없나? on delete cascade?
	}

	@Override
	public List<RecipeInfo> findRecipeByIrdntId(List<Integer> irdntIds, List<Integer> hateIrdntIds) {
		//페이징
		//로직도 복잡....
		
		return null;
	}

	@Override
	public Map<String,Object> findRecipeByRecipeName(String recipeName,int page) {
		HashMap<String,Object> map = new HashMap<>();
		int totalCount=infoDao.selectRecipeInfoByNameCount(recipeName);
		PagingBean pageBean = new PagingBean(totalCount,page);
		
		List<RecipeInfo> list = infoDao.selectRecipeInfoByName(recipeName, pageBean.getBeginItemInPage(), pageBean.getEndItemInPage());
		map.put("pageBean", pageBean);
		map.put("list", list);
		return map;
	}

	@Override
	public List<RecipeInfo> findRecipeByCategory(String categoryName, String typeName) {
		//페이징
		return null;
	}

	@Override
	public List<RecipeInfo> RangeRecipeByKeyword(List<RecipeInfo> Recipes, String keyword) {
		//최다조회순,정확도순,칼로리낮은순, 칼로리높은순, 난이도?
		return null;
	}

	@Override
	public RecipeInfo ShowDetailOfRecipe(int recipeId) {
		return infoDao.selectThreeOfRecipesById(recipeId);

	}

	@Override
	public RecipeInfo changePortion(int portion) {
		//단위변환
		return null;
	}

	
}
