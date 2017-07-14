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
//			System.out.println("addIrdntList 널첵:"+addIrdntList);
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
					if(rc != null )
						//System.out.println("updateRecipeCrse:"+rc);
						rc.setRecipeId(recipeId);
						crseDao.updateRecipeCrse(rc);
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
					if(rc != null )
						rc.setCookingNo((crseDao.selectRecipeCrseById(recipeId).size()+1));
						crseDao.insertRecipeCrse(rc);
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

		@Override
		public RecipeInfo findRecipeInfoByRecipeId(int recipeId) {
			return infoDao.selectRecipeInfoById(recipeId);
		}

		@Override
		public List<RecipeInfo> findTypeCodeAndNameByCategoryCode(int catagoryCode) {
			return infoDao.selectTypeCodeAndNameByCategoryCode(catagoryCode);
		}

		
		/***************************************************************
		 * 레시피 재료 중량변환 서비스으으!!!!!!!!!!!!!
		 ****************************************************************/
		public String amountChange(String str){
			//단위 조사한 것
			String danwi = "개/T/컵/잎/대/g/장/공기/마리/알/ml/쪽/모/줄기/큐브/단/토막/조각/뿌리/큰술/작은술/포기/톨/kg/ml/봉/통/L/묶음/되/덩이/캔/cc/관/단/근/C/쪽";
			String[] danwiArr = danwi.split("/");
			//System.out.println("danwiArr:"+Arrays.toString(danwiArr));
			StringBuffer sb = new StringBuffer(str);
			int idx = 0;
			char[] pattern = { '0', '1', '2', '3', '4','5','6','7','8','9','.','/' };
			
			outer:
			while(str.trim().length() != 0){
				for (String dan : danwiArr) {
					idx = str.lastIndexOf(dan);
					//System.out.println(dan);
					//System.out.println(idx);
					//System.out.println(str);
					if(idx != -1) {
						sb.insert(idx, "</span>"); // 오픈태그 넣고 넣자
						//System.out.println("sb:" + sb);
						//System.out.println("idx:" + idx);
						// System.out.println("str.charAt(--idx):"+str.charAt(--idx));
						--idx;
						inner:
						for (int i = idx; i >= 0; i--) {
							for (int p = 0; p < pattern.length; p++) {
								//System.out.println("str.charAt(" + i + "):" + str.charAt(i) + "/pattern[" + p + "]:" + pattern[p]);
								if (str.charAt(i) == pattern[p]) {
									//System.out.println("일치str.charAt(i):" + str.charAt(i));
									if(i==0){
										sb.insert(i, "<span class='amountChangable'>");
										break outer;
									}
									continue inner;
								}
							}
							//i번째 인댁스에서 해당 값이 없으면 ...스판태그 닫기 
							sb.insert(i+1, "<span class='amountChangable'>");
							//System.out.println("sb:" + sb);
							String temp = str.substring(0, i);
							str = temp;
							//System.out.println("줄어든str:"+str);
							continue outer;
						}
		
					}
				}
			str = "";	//문자열 길이 0으로 만들기
			}
		//	System.out.println("최종sb:"+ sb);
			return sb.toString();
		}

	
	
}
