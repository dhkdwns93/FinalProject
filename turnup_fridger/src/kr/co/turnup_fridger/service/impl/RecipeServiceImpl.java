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
		//on delete cascade.
		infoDao.deleteRecipeInfo(recipeId);
	}

	@Override
	public Map<String,Object> findRecipeByIrdntId(List<Integer> irdntIds, List<Integer> hateIrdntIds,String keyword,int page) {
		//페이징
		List<Integer> recipeIds = irdntDao.getRecipeCodeByIrdntIds(irdntIds, hateIrdntIds);
		
		HashMap<String,Object> map = new HashMap<>();
		int totalCount= infoDao.selectRecipesInfoByIdsCount(recipeIds, keyword);
		PagingBean pageBean = new PagingBean(totalCount,page);
		List<RecipeInfo> list = infoDao.selectRecipesInfoByIds(recipeIds, keyword, pageBean.getBeginItemInPage(), pageBean.getEndItemInPage());
		map.put("pageBean", pageBean);
		map.put("list", list);
		return map;
	}

	@Override
	public Map<String,Object> findRecipeByRecipeName(String recipeName,String keyword,int page) {
		HashMap<String,Object> map = new HashMap<>();
		int totalCount=infoDao.selectRecipeInfoByNameCount(recipeName,keyword);
		PagingBean pageBean = new PagingBean(totalCount,page);
		
		List<RecipeInfo> list = infoDao.selectRecipeInfoByName(recipeName,keyword,pageBean.getBeginItemInPage(), pageBean.getEndItemInPage());
		map.put("pageBean", pageBean);
		map.put("list", list);
		return map;
	}

	@Override
	public Map<String,Object> findRecipeByCategory(String categoryName, String typeName,String keyword,int page) {
		//페이징
		//infoDao.selectRecipeInfoByCategoryAndType(categoryName, typeName, keyword);
		HashMap<String,Object> map = new HashMap<>();
		int totalCount=infoDao.selectRecipeInfoByCategoryAndTypeCount(categoryName, typeName, keyword);
		PagingBean pageBean = new PagingBean(totalCount,page);
		
		List<RecipeInfo> list = infoDao.selectRecipeInfoByCategoryAndType(categoryName, typeName, keyword, pageBean.getBeginItemInPage(), pageBean.getEndPage());
		map.put("pageBean", pageBean);
		map.put("list", list);
		return map;
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
