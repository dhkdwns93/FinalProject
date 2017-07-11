package kr.co.turnup_fridger.service.impl;

import java.util.ArrayList;
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
import kr.co.turnup_fridger.vo.RecipeCrse;
import kr.co.turnup_fridger.vo.RecipeInfo;
import kr.co.turnup_fridger.vo.RecipeIrdnt;

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
			System.out.println("레시피서비스createRecipe 실행:"+recipe.getRecipeName());
			if(infoDao.selectRecipeInfoByFullName(recipe.getRecipeName())!=null){
				throw new DuplicateRecipeException("이미 존재하는 레시피명입니다.");
			}

			infoDao.insertRecipeInfo(recipe);
			System.out.println("레시피 서비스 createRecipe: "+recipe);
			
			int cnt = 1;
			for(RecipeCrse rc : recipe.getRecipeCrseList()){
				rc.setRecipeId(recipe.getRecipeId());
				rc.setCookingNo(cnt++);
				System.out.println(rc);
				crseDao.insertRecipeCrse(rc);
			}
			for(RecipeIrdnt ri : recipe.getRecipeIrdntList()){
				ri.setRecipeId(recipe.getRecipeId());
				System.out.println(ri);
				irdntDao.insertRecipeIrdnt(ri);
			}	
		}

		//레시피 수정	
		@Override
		public void updateRecipe(RecipeInfo recipe) throws NoneRecipeException {
			if(infoDao.selectRecipeInfoById(recipe.getRecipeId())==null){
				throw new NoneRecipeException("없는 레시피입니다.");
			}
			infoDao.updateRecipeInfo(recipe);
			for(int i=0;i<recipe.getRecipeCrseList().size();i++){
				crseDao.updateRecipeCrse(recipe.getRecipeCrseList().get(i));
			}
			for(int i=0; i<recipe.getRecipeIrdntList().size();i++){
				irdntDao.updateRecipeIrdnt(recipe.getRecipeIrdntList().get(i));
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
		public Map findRecipeByIrdntId(List<Integer> irdntIds, List<Integer> hateIrdntIds,String keyword) {
			//페이징
			
			//재료id들을 줘서 recipeid들과 count수 의 map을 받은 list.
			List recipeMap = irdntDao.getRecipeCodeByIrdntIds(irdntIds, hateIrdntIds);	
			
			List recipeIds= new ArrayList();
			List countList = new ArrayList();
			HashMap apiMap = new HashMap();
			
			//recipeId들만 넣은 recipeIds추출,  id들과 count들을 함께넣은 countList추출.
			for(int i=0; i<recipeMap.size();i++){
				HashMap map = (HashMap)recipeMap.get(i);
				recipeIds.add(map.get("recipe_id"));
				countList.add(map);			
			}
			//recipeId들을 줘서 recipeInfo들을 받아옴
			List<RecipeInfo> apiList = infoDao.selectRecipesInfoByIds(recipeIds, keyword);
			
			apiMap.put("apiList", apiList);
			apiMap.put("countList", countList);
			return apiMap;
		}

		//레시피 이름으로 레시피 목록들 불러오는것.
		@Override
		public List<RecipeInfo> findRecipeByRecipeName(String recipeName,String keyword) {
			
			System.out.println("레시피서비스임플"+recipeName+keyword);
			List<RecipeInfo> list = infoDao.selectRecipeInfoByName(recipeName,keyword);
			System.out.println("레시피서비스임플"+list);
			return list;
		}

		//유형분류와 음식분류로 선택해서 레시피 목록들 불러오는것. 
		@Override
		public List<RecipeInfo> findRecipeByCategory(String categoryName, String typeName,String keyword) {
			//페이징
			//infoDao.selectRecipeInfoByCategoryAndType(categoryName, typeName, keyword);
			
			List<RecipeInfo> list = infoDao.selectRecipeInfoByCategoryAndType(categoryName, typeName, keyword);
			
			return list;
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
