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
		
		public static String amountChange(String str){
			String danwi = "작은술/kg/ml/cc/cup/CUP/공기/마리/줄기/큐브/토막/조각/뿌리/"
							+"큰술/포기/묶음/알/쪽/모/단/톨/봉/통/L/되/덩이/캔/관/근/C/"
							+ "쪽/개/T/컵/잎/대/g/장";
			String[] danwiArr = danwi.split("/");	//단위 "/"를 구분자로 쪼개서 배열로 저장
			
			//숫자판별을 위한 배열
			char[] pattern = { '0', '1', '2', '3', '4','5','6','7','8','9','.','/' }; 	
			StringBuffer sb = new StringBuffer(str); //문자열 사이에 새로운 문자열 삽입을 위해 사용
			int idx = 0;
			int startIdx = 0;
			int endIdx = 0;
			String tempStr = "";	// 조각 내서 검사할 때 쓰는  temp
			boolean flag = true;
			
			
			for (String dan : danwiArr) {
				//플래그 초기화
				flag =true;
				tempStr = sb.toString();	// 앞전 단위 태크처리 후 저장된 문자열로 초기화
				outer:
				while(flag){
					System.out.println("단위:"+dan);
					idx = tempStr.lastIndexOf(dan);
					if(idx != -1) {	//단위가 발견됨
						endIdx = idx;	//end tag 들어갈 곳 표시
						idx--;
						inner:
						for (int i = idx; i >= 0; i--) {
							for (int p = 0; p < pattern.length; p++) {	//각 자리를 숫자판별 패턴과 비교
								if (tempStr.charAt(i)==pattern[p]) {//숫자판별 패턴과 일치하는게 발견되면 다름 문자 비교
									continue inner;
								}
							}
							//패턴이 발견되지 않으면 
							startIdx = i+1;	// 숫자였던 곳(i+1) start tag들어갈 곳 표시	
							System.out.println("startIdx:"+startIdx);
							break;	//숫자 끝
						}
						if((endIdx-startIdx) >= 1 ){
							//시작태그 넣으면 인덱스가 밀리므로 끝태크부터 넣어주기 
							sb.insert(endIdx, "</span>");	//태그는 실제 문자열에 
							sb.insert(startIdx, "<span class='amountChangable'>");
							
						}
						//사이에 아무것도 없을 때 혹은 이미 태그가 들어가서 숫자가 아닐때
						tempStr = sb.substring(0, startIdx);// 뒤쪽 자르고  같은 단위가 또 있는지 다시 체크
						continue outer;
							
					}else{//더이상 해당 단위 포함 되어있지 않다면 다음 단위로 넘어간다.
						flag = false;
						
					}//end of if-else
				}//end of while
			}//end of for	
			return sb.toString();
		}
		
		
		public static String amountIrdntChange(String str){
			String danwi = "작은술/kg/ml/cc/cup/CUP/공기/마리/줄기/큐브/토막/조각/뿌리/"
							+"큰술/포기/묶음/알/쪽/모/단/톨/봉/통/L/되/덩이/캔/관/근/C/"
							+ "쪽/개/T/컵/잎/대/g/장";
			String[] danwiArr = danwi.split("/");	//단위 "/"를 구분자로 쪼개서 배열로 저장
			System.out.println(Arrays.toString(danwiArr));
			//숫자판별을 위한 배열
			char[] pattern = { '0', '1', '2', '3', '4','5','6','7','8','9','.','/' }; 	
			StringBuffer sb = new StringBuffer(str); //문자열 사이에 새로운 문자열 삽입을 위해 사용
			int idx = 0;	
		
			for (String dan : danwiArr) {
				idx = str.lastIndexOf(dan);
				if(idx != -1) {	//단위가 발견됨
					sb.insert(idx, "</span>"); // 오픈태그 넣고 넣자
					sb.insert(0, "<span class='amountChangable'>");
					break;
				}
			}
		
			return sb.toString();
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
