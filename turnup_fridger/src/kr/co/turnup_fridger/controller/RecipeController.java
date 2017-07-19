package kr.co.turnup_fridger.controller;

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import javax.validation.Valid;

import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import kr.co.turnup_fridger.exception.DuplicateFavoriteException;
import kr.co.turnup_fridger.exception.DuplicateRecipeException;
import kr.co.turnup_fridger.exception.NoneFavoriteException;
import kr.co.turnup_fridger.exception.NoneMyIrdntException;
import kr.co.turnup_fridger.exception.NoneRecipeException;
import kr.co.turnup_fridger.service.BoardReviewService;
import kr.co.turnup_fridger.service.BoardShareRecipeService;
import kr.co.turnup_fridger.service.FavoriteRecipeService;
import kr.co.turnup_fridger.service.FridgerGroupService;
import kr.co.turnup_fridger.service.FridgerService;
import kr.co.turnup_fridger.service.IrdntManageService;
import kr.co.turnup_fridger.service.MyDislikeIrdntService;
import kr.co.turnup_fridger.service.MyIrdntService;
import kr.co.turnup_fridger.service.impl.RecipeServiceImpl;
import kr.co.turnup_fridger.validation.form.RecipeCrseForm;
import kr.co.turnup_fridger.validation.form.RecipeInfoForm;
import kr.co.turnup_fridger.validation.form.RecipeIrdntForm;
import kr.co.turnup_fridger.vo.FavoriteRecipe;
import kr.co.turnup_fridger.vo.Fridger;
import kr.co.turnup_fridger.vo.FridgerGroup;
//github.com/dhkdwns93/FinalProject.git
import kr.co.turnup_fridger.vo.IrdntManage;
import kr.co.turnup_fridger.vo.Member;
import kr.co.turnup_fridger.vo.MyDislikeIrdnt;
import kr.co.turnup_fridger.vo.MyIrdnt;
import kr.co.turnup_fridger.vo.RecipeCrse;
import kr.co.turnup_fridger.vo.RecipeCrseUpdate;
import kr.co.turnup_fridger.vo.RecipeInfo;
import kr.co.turnup_fridger.vo.RecipeIrdnt;
import kr.co.turnup_fridger.vo.RecipeIrdntUpdate;

@Controller
@RequestMapping("/")
public class RecipeController {
	
	@Autowired
	private RecipeServiceImpl recipeService;
	@Autowired
	private BoardShareRecipeService shareService;
	@Autowired
	private IrdntManageService imService;
	@Autowired
	private MyIrdntService myService;
	@Autowired
	private MyDislikeIrdntService disService;
	@Autowired
	private BoardReviewService rvService;
	@Autowired
	private FavoriteRecipeService frService;
	@Autowired
	private FridgerGroupService fgService;
	@Autowired
	private FridgerService fService;
	
	/***************************************************************
	 * 관리자를 위한  Recipe Handler : 등록, 삭제
	 ****************************************************************/
	//등록
		@RequestMapping(value="common/admin/recipe/register",produces="html/text;charset=UTF-8;",  method={RequestMethod.POST,RequestMethod.GET})
		public ModelAndView registerRecipe(@ModelAttribute("recipeInfo") @Valid RecipeInfoForm recipeInfoForm, BindingResult errors, HttpServletRequest request)
				 throws IllegalStateException, IOException{
			System.out.println(recipeInfoForm.getQnt()+"인분");
			System.out.println(recipeInfoForm.toString());
			//발리데이션은 한번에 거쳐서 들어오면, 그걸 나눠서 타입바꿔주는 작업을 하자.
			if(errors.hasErrors()){
				System.out.println("BindingResult : "+errors.getAllErrors());
				return new ModelAndView("common/admin/recipe_for_admin/register_form.tiles");
				
			}
			// 1. recipeInfo객체에 검증된 recipeInfoForm 자료 넣기
			RecipeInfo recipeInfo = new RecipeInfo();
			BeanUtils.copyProperties(recipeInfoForm, recipeInfo);

			
			String fileName = null;
			long fileSize= 0;		//업로드된 파일은 임시 경로에 있음 -> 최종 저장 디렉터리에 옮기는 작업
			if(recipeInfo.getImgUrlSrc() != null && !recipeInfo.getImgUrlSrc().isEmpty()){
				fileName = recipeInfo.getImgUrlSrc().getOriginalFilename();
				fileSize= recipeInfo.getImgUrlSrc().getSize();
				System.out.printf("파일명 :%s, 파일크기 :%d%n", fileName, fileSize);
				
				//이동 : request.getServletContext().getRealPath("하위 경로") - Application의 Root경로의 실제 파일경로로 리턴
				System.out.println("request.getServletContext().getRealPath() : "+ request.getServletContext().getRealPath("/images") );
				File dest = new File(request.getServletContext().getRealPath("/images"), fileName);
				recipeInfo.setImgUrl(fileName);
				recipeInfo.getImgUrlSrc().transferTo(dest);	// Exception 던짐
			}
			
			
			// 2.레시피 과정 넣기
			List<RecipeCrse> recipeCrseList = new ArrayList<>();
			for(RecipeCrseForm rcf :recipeInfoForm.getRecipeCrseList()){
				RecipeCrse rc = new RecipeCrse();
				BeanUtils.copyProperties(rcf, rc);
				recipeCrseList.add(rc);
				
				if(rc.getStepImageUrlSrc() != null && !rc.getStepImageUrlSrc().isEmpty()){
					fileName = rc.getStepImageUrlSrc().getOriginalFilename();
					fileSize= rc.getStepImageUrlSrc().getSize();
					System.out.printf("파일명 :%s, 파일크기 :%d%n", fileName, fileSize);
					
					//이동 : request.getServletContext().getRealPath("하위 경로") - Application의 Root경로의 실제 파일경로로 리턴
					System.out.println("request.getServletContext().getRealPath() : "+ request.getServletContext().getRealPath("/images") );
					File dest = new File(request.getServletContext().getRealPath("/images"), fileName);
					rc.setStepImageUrl(fileName);
					rc.getStepImageUrlSrc().transferTo(dest);	// Exception 던짐
				}
			
			}
			
			// 3. 재료정보 넣기	
			List<RecipeIrdnt> recipeIrdntList = new ArrayList<>();
			for(RecipeIrdntForm rif : recipeInfoForm.getRecipeIrdntList()){
				RecipeIrdnt ri = new RecipeIrdnt();
				BeanUtils.copyProperties(rif, ri);
				recipeIrdntList.add(ri);
			}
			recipeInfo.setCookingTime(recipeInfoForm.getCookingTime()+"분");
			recipeInfo.setQnt(recipeInfoForm.getQnt()+"인분");
			recipeInfo.setCalorie(recipeInfoForm.getCalorie()+"Kcal");
			recipeInfo.setPrice(recipeInfoForm.getPrice()+"Kcal");
			recipeInfo.setRecipeHits(0);
			recipeInfo.setRecipeCrseList(recipeCrseList);
			recipeInfo.setRecipeIrdntList(recipeIrdntList);
			System.out.println("레시피컨트롤러 create :"+recipeInfo);
			try {
				recipeService.createRecipe(recipeInfo);
				//System.out.println("레시피컨트롤러 create - createRecipe직후:");
			} catch (DuplicateRecipeException e) {
				e.printStackTrace();
				return new ModelAndView("common/admin/recipe_for_admin/register_form.tiles","errorMsg_duplicateId",e.getMessage());
			}

			return new ModelAndView("redirect:register/success.do","recipeId",recipeInfo.getRecipeId());
		}
		
		
		@RequestMapping("common/admin/recipe/register/success")
		public ModelAndView registerRecipeSuccess( int recipeId ) throws Exception{
			return new ModelAndView("common/admin/recipe_for_admin/recipeList.tiles","successMsg_create","등록성공!");
		}
	
		
		
		
		
		
		//레시피 정보 수정전 체크
		@RequestMapping("common/admin/recipe/info/update_chk")
		public ModelAndView move2RecipeInfoUpdateForm(@RequestParam int recipeId){
			RecipeInfo ri = recipeService.showDetailOfRecipe(recipeId);
			System.out.println(ri);
			return new ModelAndView("common/admin/recipe_for_admin/info_update_form", "recipe", ri);
		}
		
		@RequestMapping("common/admin/recipe/info/update")
		public ModelAndView updateRecipeInfo(@ModelAttribute("recipeInfo") @Valid RecipeInfoForm recipeInfoForm,  
														BindingResult errors, HttpServletRequest request) throws IllegalStateException, IOException{
			//System.out.println("업데이트 핸들러:"+recipeInfoForm);
			if(errors.hasErrors()){
				//System.out.println("업데이트 핸들러 errors수:"+ errors.getAllErrors());
				return new ModelAndView("common/admin/recipe_for_admin/info_update_form", "recipe", recipeInfoForm);
				
				
			}
			// 1. recipeInfo객체에 검증된 recipeInfoForm 자료 넣기
			RecipeInfo recipeInfo = new RecipeInfo();
			BeanUtils.copyProperties(recipeInfoForm, recipeInfo);
			
			String fileName = null;
			long fileSize= 0;		//업로드된 파일은 임시 경로에 있음 -> 최종 저장 디렉터리에 옮기는 작업
			if(recipeInfo.getImgUrlSrc() != null && !recipeInfo.getImgUrlSrc().isEmpty()){
				fileName = recipeInfo.getImgUrlSrc().getOriginalFilename();
				fileSize= recipeInfo.getImgUrlSrc().getSize();
				//System.out.printf("파일명 :%s, 파일크기 :%d%n", fileName, fileSize);
				
				//이동 : request.getServletContext().getRealPath("하위 경로") - Application의 Root경로의 실제 파일경로로 리턴
				//System.out.println("request.getServletContext().getRealPath() : "+ request.getServletContext().getRealPath("/images") );
				File dest = new File(request.getServletContext().getRealPath("/images"), fileName);
				//원래 저장되어 있던 것과 일관성
				recipeInfo.setImgUrl("/turnup_fridger/images/"+fileName);
				recipeInfo.getImgUrlSrc().transferTo(dest);	// Exception 던짐
			}
		
	
			recipeInfo.setCookingTime(recipeInfoForm.getCookingTime()+"분");
			recipeInfo.setQnt(recipeInfoForm.getQnt()+"인분");
			recipeInfo.setCalorie(recipeInfoForm.getCalorie()+"Kcal");
			recipeInfo.setPrice(recipeInfoForm.getPrice()+"원");
			//System.out.println("로그 업데이트 핸들러:"+ recipeInfo);
			try {
				recipeService.updateRecipeInfo(recipeInfo);
			}  catch (NoneRecipeException e)  {
				e.printStackTrace();
				return new ModelAndView("common/admin/recipe_for_admin/info_update_form","errorMsg_NoneRecipe",e.getMessage());
			}
			
			//System.out.println("레시피컨트롤러 update완료 :"+recipeInfo);
			return new ModelAndView("redirect:update/success.do","recipeId",recipeInfo.getRecipeId());
		}
		
		@RequestMapping(value={"common/admin/recipe/info/update/success", "common/admin/recipe/irdnt/update/success", "common/admin/recipe/crse/update/success"})
		public ModelAndView updateRecipeSuccess(int recipeId ) throws Exception{
			System.out.println("레시피컨트롤러 update success");
			return new ModelAndView("common/admin/recipe_for_admin/update_success","recipeId",recipeId);
		}
		
		
		
		
		@RequestMapping("common/admin/recipe/irdnt/update_chk")
		public ModelAndView move2RecipeIrdntUpdateForm(@RequestParam int recipeId){
			RecipeInfo ri = recipeService.showDetailOfRecipe(recipeId);
			System.out.println(ri);
			return new ModelAndView("common/admin/recipe_for_admin/irdnt_update_form", "recipe", ri);	
		}
		
		@RequestMapping("common/admin/recipe/irdnt/update")
		/*
		public ModelAndView updateRecipeIrdntHandler(@RequestParam int recipeId, @RequestParam(value="removeIrdntList", required=false)  List<Integer> removeIrdntList,
													@RequestParam(value="addIrdntList" , required=false) List<RecipeIrdnt> addIrdntList,  
												 HttpServletRequest request) throws IllegalStateException, IOException{
		*/
		public ModelAndView updateRecipeIrdntHandler(@ModelAttribute RecipeIrdntUpdate riu, BindingResult errors, HttpServletRequest request){
			System.out.println("업데이트 핸들러: recipeId - "+riu.getRecipeId()+"/removeIrdntList:"+riu.getRemoveIrdntList()+"/addIrdntList:"+riu.getAddIrdntList());
			//if(errors.hasErrors()){
				//System.out.println("업데이트 핸들러 errors수:"+ errors.getAllErrors());
			//	return new ModelAndView("common/admin/recipe_for_admin/info_update_form", "recipe", recipeInfoForm);
	
			// 2.레시피 재료 수정하기(삭제와 추가 리스트에 넣기)
			Map<String, List> recipeIrdnt = new HashMap<>();
			//삭제할거는 recipeId와 cookingNo를 Map로 받아온다 -> 그대로 넘기고 , 
			recipeIrdnt.put("removeIrdntList", riu.getRemoveIrdntList());
				//추가할 것 레시피 아이디 세팅해서 넘겨주기 
			
			if(riu.getAddIrdntList() != null){
				for(RecipeIrdnt ri : riu.getAddIrdntList()){
					ri.setRecipeId(riu.getRecipeId());
				}
				recipeIrdnt.put("addIrdntList", riu.getAddIrdntList());
			}
			
						
						
			try {
				recipeService.updateRecipeIrdnt(recipeIrdnt);
			}  catch (NoneRecipeException e)  {
				e.printStackTrace();
				return new ModelAndView("common/admin/recipe_for_admin/info_update_form","errorMsg_NoneRecipe",e.getMessage());
			}
			
			//System.out.println("레시피컨트롤러 update완료 :"+recipeInfo);
			return new ModelAndView("redirect:update/success.do","recipeId", riu.getRecipeId());
		}
		
		
		@RequestMapping("common/admin/recipe/crse/update_chk")
		public ModelAndView move2RecipeCrseUpdateForm(@RequestParam int recipeId){
			RecipeInfo ri = recipeService.showDetailOfRecipe(recipeId);
			System.out.println(ri);
			return new ModelAndView("common/admin/recipe_for_admin/crse_update_form", "recipe", ri);
			
		}
		
		@RequestMapping("common/admin/recipe/crse/update")
		public ModelAndView updateRecipeCrseHandler(@ModelAttribute RecipeCrseUpdate rcu, BindingResult errors, HttpServletRequest request) throws IllegalStateException, IOException{
			// 3. 래시피 과정 수정하기(삭제와 추가 리스트에 넣기)+수정
			

			System.out.println("업데이트 핸들러: recipeId - "+rcu.getRecipeId()+"/removeCrseList:"+rcu.getRemoveCrseList()+"/addCrseList:"+rcu.getAddCrseList()+"/CurrentCrseList:"+rcu.getCurrentCrseList());
			// 수정 목록 사진처리
			String fileName = null;
			long fileSize= 0;
			if(rcu.getCurrentCrseList() != null && !rcu.getCurrentCrseList().isEmpty()){
				for(RecipeCrse rc : rcu.getCurrentCrseList()){
					if(rc != null){
					rc.setRecipeId(rcu.getRecipeId());
					
						if(rc.getStepImageUrlSrc() != null && !rc.getStepImageUrlSrc().isEmpty()){
							fileName = rc.getStepImageUrlSrc().getOriginalFilename();
							fileSize= rc.getStepImageUrlSrc().getSize();
							System.out.printf("파일명 :%s, 파일크기 :%d%n", fileName, fileSize);
							
							//이동 : request.getServletContext().getRealPath("하위 경로") - Application의 Root경로의 실제 파일경로로 리턴
							System.out.println("request.getServletContext().getRealPath() : "+ request.getServletContext().getRealPath("/images") );
							File dest = new File(request.getServletContext().getRealPath("/images"), fileName);
							rc.setStepImageUrl("/turnup_fridger/images/"+fileName);
							rc.getStepImageUrlSrc().transferTo(dest);	// Exception 던짐
						}
					
					}
				}
			}
			
			
			
			//추가목록 사진 처리
			if(rcu.getAddCrseList() != null && !rcu.getAddCrseList().isEmpty()){
				for(RecipeCrse rc : rcu.getAddCrseList()){
					if(rc != null){
					rc.setRecipeId(rcu.getRecipeId());
					
						if(rc.getStepImageUrlSrc() != null && !rc.getStepImageUrlSrc().isEmpty()){
							fileName = rc.getStepImageUrlSrc().getOriginalFilename();
							fileSize= rc.getStepImageUrlSrc().getSize();
							System.out.printf("파일명 :%s, 파일크기 :%d%n", fileName, fileSize);
							
							//이동 : request.getServletContext().getRealPath("하위 경로") - Application의 Root경로의 실제 파일경로로 리턴
							System.out.println("request.getServletContext().getRealPath() : "+ request.getServletContext().getRealPath("/images") );
							File dest = new File(request.getServletContext().getRealPath("/images"), fileName);
							rc.setStepImageUrl(fileName);
							rc.getStepImageUrlSrc().transferTo(dest);	// Exception 던짐
						}
					
					}
				}
			}
			
			List<Integer> removeCrseList = new ArrayList<Integer>();
			if(rcu.getRemoveCrseList()!= null && !rcu.getRemoveCrseList().isEmpty()){
				for(RecipeCrse rc : rcu.getRemoveCrseList()){
					removeCrseList.add(rc.getCookingNo());
				}
			}
			
			
			try {
				recipeService.updateRecipeCrse(rcu.getRecipeId(), rcu.getAddCrseList(), removeCrseList, rcu.getCurrentCrseList());
			}  catch (NoneRecipeException e)  {
				e.printStackTrace();
				return new ModelAndView("common/admin/recipe_for_admin/crse_update_form","errorMsg_NoneRecipe",e.getMessage());
			}
			
			//System.out.println("레시피컨트롤러 update완료 :"+recipeInfo);
			return new ModelAndView("redirect:update/success.do","recipeId", rcu.getRecipeId());
		}
		
		
		/*@RequestMapping("common/admin/recipe/update")
		public ModelAndView updateRecipe(@ModelAttribute("recipeInfo") @Valid RecipeInfoForm recipeInfoForm,  BindingResult errors, 
											ArrayList<Integer> removeIrdntList, ArrayList<RecipeIrdnt> addIrdntList, 
											ArrayList<Map> removeCrseList, ArrayList<RecipeCrse> addCrseList,
											HttpServletRequest request)
				 throws IllegalStateException, IOException{
			if(errors.hasErrors()){
				return new ModelAndView("common/admin/recipe_for_admin/update_form");
			}
			// 1. recipeInfo객체에 검증된 recipeInfoForm 자료 넣기
			RecipeInfo recipeInfo = new RecipeInfo();
			BeanUtils.copyProperties(recipeInfoForm, recipeInfo);
			
			String fileName = null;
			long fileSize= 0;		//업로드된 파일은 임시 경로에 있음 -> 최종 저장 디렉터리에 옮기는 작업
			if(recipeInfo.getImgUrlSrc() != null && !recipeInfo.getImgUrlSrc().isEmpty()){
				fileName = recipeInfo.getImgUrlSrc().getOriginalFilename();
				fileSize= recipeInfo.getImgUrlSrc().getSize();
				System.out.printf("파일명 :%s, 파일크기 :%d%n", fileName, fileSize);
				
				//이동 : request.getServletContext().getRealPath("하위 경로") - Application의 Root경로의 실제 파일경로로 리턴
				System.out.println("request.getServletContext().getRealPath() : "+ request.getServletContext().getRealPath("/images") );
				File dest = new File(request.getServletContext().getRealPath("/images"), fileName);
				recipeInfo.setImgUrl(fileName);
				recipeInfo.getImgUrlSrc().transferTo(dest);	// Exception 던짐
			}
		
			
			// 2.레시피 재료 수정하기(삭제와 추가 리스트에 넣기)
			Map<String, ArrayList> recipeIrdnt = new HashMap<>();
			//삭제할거는 recipeId와 cookingNo를 Map로 받아온다 -> 그대로 넘기고 , 
			recipeIrdnt.put("removeIrdntList", removeIrdntList);
				//추가할 것 레시피 아이디 세팅해서 넘겨주기
			for(RecipeIrdnt ri : addIrdntList){
				ri.setRecipeId(recipeInfo.getRecipeId());
			}
			recipeIrdnt.put("addIrdntList", addIrdntList);
			
			
			
			
			// 3. 래시피 과정 수정하기(삭제와 추가 리스트에 넣기)
			Map<String, ArrayList> recipeCrse = new HashMap<>();
				//삭제할거는 recipeId와 cookingNo를 Map로 받아온다 -> 그대로 넘기고 , 
			recipeCrse.put("removeCrseList", removeCrseList);
				//추가할 것 레시피 아이디 세팅, 사진 파일 저장해서 넘겨주기
			for(RecipeCrse rc : addCrseList){
				rc.setRecipeId(recipeInfo.getRecipeId());
				
				if(rc.getStepImageUrlSrc() != null && !rc.getStepImageUrlSrc().isEmpty()){
					fileName = rc.getStepImageUrlSrc().getOriginalFilename();
					fileSize= rc.getStepImageUrlSrc().getSize();
					System.out.printf("파일명 :%s, 파일크기 :%d%n", fileName, fileSize);
					
					//이동 : request.getServletContext().getRealPath("하위 경로") - Application의 Root경로의 실제 파일경로로 리턴
					System.out.println("request.getServletContext().getRealPath() : "+ request.getServletContext().getRealPath("/images") );
					File dest = new File(request.getServletContext().getRealPath("/images"), fileName);
					rc.setStepImageUrl(fileName);
					rc.getStepImageUrlSrc().transferTo(dest);	// Exception 던짐
				}
				
			}
			recipeCrse.put("addCrseList", addCrseList);
			
			
			recipeInfo.setCookingTime(recipeInfoForm.getCookingTime()+"분");
			recipeInfo.setQnt(recipeInfoForm.getQnt()+"인분");
			recipeInfo.setCalorie(recipeInfoForm.getCalorie()+"Kcal");
			recipeInfo.setPrice(recipeInfoForm.getPrice()+"원");
			System.out.println("레시피컨트롤러 update 직전:"+recipeInfo);
	
			try {
				recipeService.updateRecipe(recipeInfo, recipeIrdnt, recipeCrse);
			}  catch (NoneRecipeException e)  {
				return new ModelAndView("common/admin/recipe_for_admin/update_form","errorMsg_NoneRecipe",e.getMessage());
			}
			
			System.out.println("레시피컨트롤러 update완료 :"+recipeInfo);
			return new ModelAndView("redirect:update/success.do","recipeId",recipeInfo.getRecipeId());
		}
	*/
		
	//레시피삭제
	@RequestMapping(value="common/admin/recipe/remove", produces="html/text;charset=UTF-8;")
	@ResponseBody
	public String removeRecipe(@RequestParam int recipeId){
		try {
			recipeService.removeRecipe(recipeId);
		} catch (NoneRecipeException e) {
			return "0";
		}
		return "1";
	}
	
	
	
	/***************************************************************
	 * 모든 유저(비회원/회원/관리자)를 위한  Recipe Handler : 조회
	 ****************************************************************/
	//전체레시피
	@RequestMapping("allRecipeList")
	@ResponseBody
	public List<RecipeInfo> allRecipeList(){
		List<RecipeInfo> list = recipeService.allRecipeList();
		return list;
	}
	
	@RequestMapping(value="findApiRecipeByRecipeName")
	@ResponseBody
	public Map findApiRecipeByRecipeName(@RequestParam String recipeName, @RequestParam String keyword,@RequestParam(defaultValue = "1") int page ){
		
		Map apiList = recipeService.findRecipeByRecipeName(recipeName, keyword,page);
		HashMap map = new HashMap();
		map.put("apiList", apiList); // 이안에 페이징빈이랑 리스트 두개 들어있다.
		return map;
	}
	
	@RequestMapping(value="findUserRecipeByRecipeName")
	@ResponseBody
	public Map findUserRecipeByRecipeName(@RequestParam String recipeName,@RequestParam(defaultValue = "1") int page ){
	
		Map userList = shareService.selectBoardShareRecipeByTitle(page,recipeName);
		HashMap map = new HashMap();
		map.put("userList", userList); // 이거 안에도 페이징빈이랑 리스트 두개 
		return map;
	}
	
	@RequestMapping(value="findRecipeByCategory")
	@ResponseBody
	public Map findRecipeByCategory(@RequestParam String categoryName, @RequestParam String typeName, @RequestParam String keyword,
			@RequestParam(defaultValue = "1") int page ){
		Map list = recipeService.findRecipeByCategory(categoryName, typeName, keyword,page);
		return list;
	}
	
	@RequestMapping(value="findApiRecipeByIrdntId")
	@ResponseBody
	public Map<String,Object> findApiRecipeByIrdntId(@RequestParam List<Integer> irdntIds, @RequestParam List<Integer> hateIrdntIds, @RequestParam String keyword,
			@RequestParam(defaultValue = "1") int page ){

		Map apiMap = recipeService.findRecipeByIrdntId(irdntIds, hateIrdntIds, keyword,page);
		HashMap map = new HashMap();
		map.put("apiMap", apiMap);//여기안에 count랑 리스트, 페이징빈 들어있다. 
		return map;
	}
	
	@RequestMapping(value="findUserRecipeByIrdntId")
	@ResponseBody
	public Map<String,Object> findUserRecipeByIrdntId(@RequestParam List<Integer> irdntIds, @RequestParam List<Integer> hateIrdntIds,@RequestParam(defaultValue = "1") int page ){

		Map userMap = shareService.findUserRecipeByIds(irdntIds, hateIrdntIds,page);
		HashMap map = new HashMap();
		map.put("userMap", userMap);//여기에 리스트랑 페이징빈 들어있다. 
		return map;
	}
	
	//상세화면 handler
	@RequestMapping("recipe/show/detail")
	public ModelAndView showDetailOfRecipe(@RequestParam int recipeId){
		RecipeInfo recipe = recipeService.showDetailOfRecipe(recipeId);
		//레시피 재료 중량변환
		for(RecipeIrdnt ri : recipe.getRecipeIrdntList()){
			ri.setIrdntName(recipeService.amountChange(ri.getirdntAmount()));
		}
		//레시피 과정 중량변환
		for(RecipeCrse rc : recipe.getRecipeCrseList()){
			rc.setCookingDc(recipeService.amountChange(rc.getCookingDc()));
			rc.setStepTip(recipeService.amountChange(rc.getStepTip()));
		}
		return new ModelAndView("recipe_for_user/recipe_detail.tiles","recipe",recipe);
	}
	
	@RequestMapping("recipe/show/detail/review")
	@ResponseBody
	public Map showDetailOfRecipeReview(@RequestParam int recipeId, @RequestParam(defaultValue="1") int page ){
		//System.out.println("컨트롤러 : " +recipeId+","+page);
		Map<String,Object> map =  rvService.findBoardReviewByRecipeId(recipeId, page);
		//System.out.println(map);
		return map;
	}			
	
	
	@RequestMapping("recipe/show/detailOfBoard")
	public ModelAndView showDetailOfUserRecipe(@RequestParam int recipeId, HttpSession session) throws Exception{
		//조회수 증가처리
		shareService.increaseHit(recipeId, session);
		
		ModelAndView mav = new ModelAndView();
		
		mav.addObject("boardView", shareService.boardRead(recipeId));
		mav.setViewName("recipe_for_user/boardRecipe_view.tiles");
		return mav;
	}
	
	@RequestMapping("changePortion")
	public ModelAndView changePortion(){
		return new ModelAndView("상세페이지 + 변환된 자료가 들어오겠찌");
	}
	
	@RequestMapping("getTypeNameCategory")
	@ResponseBody
	public List<String> getTypeNameCategory(@RequestParam String categoryName){
		return recipeService.getTypeNameByCategoryName(categoryName);
	}
	
	@RequestMapping("getTypeCodeAndName")
	@ResponseBody
	public List<RecipeInfo> getTypeCodeAndName(@RequestParam int categoryCode){
		return recipeService.findTypeCodeAndNameByCategoryCode(categoryCode);
	}
	
	@RequestMapping("getIrdntList")
	@ResponseBody
	public List<IrdntManage> allIrdntList(){
		List<IrdntManage> list = imService.fingAllIrdntNotPaging();
		return list;
	}
	
	@RequestMapping("getFridgers")
	@ResponseBody
	public List allFridgerByMemberId(){
		
		//회원아이디로 속한 냉장고 그룹들을 가져옴. 
		Member member = (Member)SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		if(member==null){
			//비회원처리.어떻게하나?
			return null;
		}
		
		List<FridgerGroup> groupList = fgService.selectFridgerGroupByGroupMemberId(member.getMemberId());
		
		List<Fridger> fridgerList = new ArrayList<>();
		
		for(int i=0; i<groupList.size();i++){
			//id로 찾은 냉장고 객체를 냉장고 리스트에 넣는작업. 
			fridgerList.add(fService.findFridgerAndFridgerGroupByFridgerId(groupList.get(i).getFridgerId()));
		}
		
		return fridgerList;
	}
	
	@RequestMapping("getMyIrdntList")
	@ResponseBody
	public List<MyIrdnt> allMyIrdntList(@RequestParam int fridgerId){
		return myService.findAllMyIrdntByFridgerId(fridgerId);
	}

	@RequestMapping("getMyDislikeIrdnt")
	@ResponseBody
	public Map getMyDislikeIrdnt(){
		Member member = (Member)SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		if(member==null){
			//비회원
			return null;
		}
		List<MyDislikeIrdnt> dislikeIrdnt = disService.findMyDislikeIrdntByMemberId(member.getMemberId());
		
		HashMap map = new HashMap();
		HashMap irdntMap = new HashMap();
		List irdntList = new ArrayList();
		
		for(int i=0; i<dislikeIrdnt.size();i++){
			String irdntName = imService.findIrdntByIrdntId(dislikeIrdnt.get(i).getIrdntId()).getIrdntName();
			irdntMap.put("irdntName", irdntName);
			irdntMap.put("irdntId",dislikeIrdnt.get(i).getIrdntId());
			irdntList.add(irdntMap);
		}
		map.put("dislikeIrdnt", dislikeIrdnt);
		map.put("irdntList", irdntList);
		
		return map;
	}
	

	@RequestMapping(value="removeMyIrdnt", produces="html/text;charset=UTF-8;")
	@ResponseBody
	public String removeMyIrdnt(@RequestParam int myIrdntKey){
		Member member = (Member)SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		if(member==null){
			return "회원이 아닙니다.";
		}
		try {
			myService.removeMyIrdnt(myIrdntKey);
		} catch (NoneMyIrdntException e) {
			return "삭제안돼앵~"+e.getMessage();
		}
		return "삭제완료!";
	}
	
	@RequestMapping("addFavoriteRecipe")
	//@ResponseBody
	public ModelAndView addFavoriteRecipe(@RequestParam int recipeId){
		Member member = (Member)SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		
		try {
			frService.createFavoriteRecipe(new FavoriteRecipe(0,member.getMemberId(),recipeId));
		} catch (DuplicateFavoriteException e) {
			return new ModelAndView("recipe_for_user/recipe_detail.tiles","error_msg",e.getMessage());
		}
		
	
		return new ModelAndView("redirect:recipe/show/detail.do","recipeId",recipeId);
	}
	
	@RequestMapping("removeFavorite")
	@ResponseBody
	public ModelAndView removeFavorite(@RequestParam int recipeId){
		Member member = (Member)SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		int favoriteRecipeKey = frService.findFavoriteRecipeByIds(member.getMemberId(), recipeId).getFavoriteRecipeKey();
		try {
			frService.removeFavoriteRecipe(favoriteRecipeKey);
		} catch (NoneFavoriteException e) {
			return new ModelAndView("recipe_for_user/recipe_detail.tiles","error_msg",e.getMessage());
		}
		
		return new ModelAndView("redirect:recipe/show/detail.do","recipeId",recipeId);
	}
	
	@RequestMapping("findFavoriteRecipeByIds")
	@ResponseBody
	public int findFavoriteRecipeByIds(@RequestParam int recipeId){
		Member member = (Member)SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		if(frService.findFavoriteRecipeByIds(member.getMemberId(), recipeId)==null){
			return 0;
		}
		return 1;
	}

	@RequestMapping("findMatchIrdnt")
	@ResponseBody
	public List<MyIrdnt> findMatchIrdnt(@RequestParam int recipeId){
		Member member = (Member)SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		List<MyIrdnt> list = myService.findMatchIrdnt(recipeId, member.getMemberId());
		return list;
	}
	
	@RequestMapping("timer")
	public ModelAndView timer(){
		return new ModelAndView("recipe_for_user/timer");
	}

}