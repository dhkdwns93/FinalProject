package kr.co.turnup_fridger.service.impl;

import java.lang.reflect.Array;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

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
			if(infoDao.selectRecipeInfoByFullName(recipe.getRecipeName())!=null){
				throw new DuplicateRecipeException("이미 존재하는 레시피명입니다.");
			}

			infoDao.insertRecipeInfo(recipe);
			
			int cnt = 1;
			for(RecipeCrse rc : recipe.getRecipeCrseList()){
				rc.setRecipeId(recipe.getRecipeId());
				rc.setCookingNo(cnt++);
				crseDao.insertRecipeCrse(rc);
			}
			for(RecipeIrdnt ri : recipe.getRecipeIrdntList()){
				ri.setRecipeId(recipe.getRecipeId());
				irdntDao.insertRecipeIrdnt(ri);
			}	
		}

		//레시피 수정
		@Override
		public void updateRecipeInfo(RecipeInfo recipeInfo) throws NoneRecipeException {
			//기본정보
			if(infoDao.selectRecipeInfoById(recipeInfo.getRecipeId())==null){
				throw new NoneRecipeException("없는 레시피입니다.");
			}
			infoDao.updateRecipeInfo(recipeInfo);
		}
			
			

		
		@Override
		public void updateRecipeIrdnt(Map<String, List> recipeIrdnt) throws NoneRecipeException {
			//재거할 목록
			List<Integer> removeIrdntList = recipeIrdnt.get("removeIrdntList");	//삭제할 재료
			if(removeIrdntList != null && removeIrdntList.size()> 0 && !removeIrdntList.isEmpty()){
				for(int i=0;i<removeIrdntList.size();i++){
					if(removeIrdntList.get(i) != null )
					irdntDao.deleteRecipeIrdnt(removeIrdntList.get(i));
				}
			}
			
			//추가할 목록
			List<RecipeIrdnt> addIrdntList = recipeIrdnt.get("addIrdntList");	//추가할 재료
			if(addIrdntList != null && addIrdntList.size() > 0 && !addIrdntList.isEmpty()){
				for(int i=0;i<addIrdntList.size();i++){
					if(addIrdntList.get(i) != null )
						irdntDao.insertRecipeIrdnt(addIrdntList.get(i));
				}
			}
		}

		@Override
		public void updateRecipeCrse(int recipeId, List<RecipeCrse> addCrseList, 
									List<Integer> removeCrseList, 
									List<RecipeCrse> currentCrseList) throws NoneRecipeException {
			
			//업뎃할 목록:currentCrseList
			if(currentCrseList != null && !currentCrseList.isEmpty() && currentCrseList.size() > 0){
				for(RecipeCrse rc : currentCrseList){
					if(rc != null ){
						rc.setRecipeId(recipeId);
						crseDao.updateRecipeCrse(rc);
					}
				}
			}
			
			//제거할 목록 :removeCrseList
			//삭제할 과정(cookingNo)
			if(removeCrseList != null && !removeCrseList.isEmpty() && removeCrseList.size() > 0){
				for(int cookingNo : removeCrseList){
					if(cookingNo != -1 )
					crseDao.deleteRecipeCrse(recipeId, cookingNo);
				}
			}
			
			//추가할 목록 :addCrseList
			//추가할 과정
			if(addCrseList != null && !addCrseList.isEmpty() && addCrseList.size() > 0){
				for(RecipeCrse rc : addCrseList){
					if(rc != null ){
						rc.setCookingNo((crseDao.selectRecipeCrseById(recipeId).size()+1));
						crseDao.insertRecipeCrse(rc);
					}
				}
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
		public Map findRecipeByIrdntId(List<Integer> irdntIds, List<Integer> hateIrdntIds,String keyword,int page) {
			
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
			
			int totalCount = infoDao.selectRecipesInfoByIdsCount(recipeIds, keyword);
			PagingBean pageBean = new PagingBean(totalCount,page);
					
			List<RecipeInfo> apiList = infoDao.selectRecipesInfoByIds(recipeIds, keyword,pageBean.getBeginItemInPage(),pageBean.getEndItemInPage());
			
			apiMap.put("apiList", apiList);
			apiMap.put("countList", countList);
			apiMap.put("pageBean", pageBean);
			//System.out.println(apiMap);
			
			return apiMap;
		}

		//레시피 이름으로 레시피 목록들 불러오는것.
		@Override
		public Map findRecipeByRecipeName(String recipeName,String keyword,int page) {
			HashMap map = new HashMap();
			int totalCount=infoDao.selectRecipeInfoByNameCount(recipeName, keyword);
			PagingBean pageBean = new PagingBean(totalCount,page);
			
			List<RecipeInfo> list = infoDao.selectRecipeInfoByName(recipeName,keyword,pageBean.getBeginItemInPage(),pageBean.getEndItemInPage());
			map.put("pageBean", pageBean);
			map.put("list", list);
			return map;
		}

		//유형분류와 음식분류로 선택해서 레시피 목록들 불러오는것. 
		@Override
		public Map findRecipeByCategory(String categoryName, String typeName,String keyword,int page) {
			HashMap map = new HashMap();
			int totalCount = infoDao.selectRecipeInfoByCategoryAndTypeCount(categoryName, typeName, keyword);
			PagingBean pageBean = new PagingBean(totalCount,page);
			
			List<RecipeInfo> list = 
					infoDao.selectRecipeInfoByCategoryAndType(categoryName, typeName, keyword,pageBean.getBeginItemInPage(),pageBean.getEndItemInPage());
			map.put("pageBean", pageBean);
			map.put("list", list);
			
			return map;
		}
		
		//불러온 목록에서 하나를 선택하여 그 레시피의 상세화면을 가져오는 것.
		@Override
		public RecipeInfo showDetailOfRecipe(int recipeId) {
			return infoDao.selectThreeOfRecipesById(recipeId);
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

		@Override
		public RecipeInfo findRecipeInfoByRecipeId(int recipeId) {
			return infoDao.selectRecipeInfoById(recipeId);
		}

		@Override
		public List<RecipeInfo> findTypeCodeAndNameByCategoryCode(int catagoryCode) {
			return infoDao.selectTypeCodeAndNameByCategoryCode(catagoryCode);
		}

		
		@Override
		public void increaseHits(int recipeId, HttpSession session) {
			//세션에 저장된 조회시간 검색
			long updateTime = 0;
			//최초로 조회할 경우 세션에 저장된 값이 없기때문에 if문은 실행x
			if(session.getAttribute("updateTime"+recipeId)!=null){
				updateTime = (long)session.getAttribute("updateTime"+recipeId);
			}
			//시스템의 현재시간을 currentTime에 저장
			long currentTime= System.currentTimeMillis();
			//시스템 현재시간 - 열람시간 > 일정시간(조회수 증가가 가능하도록 지정한 시간)
			if(currentTime - updateTime > 5*1000){
				infoDao.increaseHits(recipeId);
				//세션에 시간을 저장 : updateTime+recipeId는 다른변수와 중복되지 않게 정한것.
				session.setAttribute("updateTime"+recipeId, currentTime);
			}
		}
		
		
	
	
}
