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

import kr.co.turnup_fridger.exception.DuplicateRecipeException;
import kr.co.turnup_fridger.exception.NoneRecipeException;
import kr.co.turnup_fridger.service.BoardShareRecipeService;
import kr.co.turnup_fridger.service.IrdntManageService;
import kr.co.turnup_fridger.service.MyDislikeIrdntService;
import kr.co.turnup_fridger.service.MyIrdntService;
import kr.co.turnup_fridger.service.RecipeService;
import kr.co.turnup_fridger.validation.form.RecipeCrseForm;
import kr.co.turnup_fridger.validation.form.RecipeInfoForm;
import kr.co.turnup_fridger.validation.form.RecipeIrdntForm;
import kr.co.turnup_fridger.vo.BoardShareRecipe;
import kr.co.turnup_fridger.vo.IrdntManage;
import kr.co.turnup_fridger.vo.Member;
import kr.co.turnup_fridger.vo.MyDislikeIrdnt;
import kr.co.turnup_fridger.vo.MyIrdnt;
import kr.co.turnup_fridger.vo.RecipeCrse;
import kr.co.turnup_fridger.vo.RecipeInfo;
import kr.co.turnup_fridger.vo.RecipeIrdnt;

@Controller
@RequestMapping("/")
public class RecipeController {
	
	@Autowired
	private RecipeService recipeService;
	@Autowired
	private BoardShareRecipeService shareService;
	@Autowired
	private IrdntManageService imService;
	@Autowired
	private MyIrdntService myService;
	@Autowired
	private MyDislikeIrdntService disService;
	
	
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
			RecipeCrse rc = new RecipeCrse();
			for(RecipeCrseForm rcf :recipeInfoForm.getRecipeCrseList()){
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
			RecipeIrdnt ri = new RecipeIrdnt();
			for(RecipeIrdntForm rif : recipeInfoForm.getRecipeIrdntList()){
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
		public ModelAndView updateRecipeIrdntHandler(@RequestParam int recipeId, @RequestParam(value="removeIrdntList")  List<Integer> removeIrdntList,
													@RequestParam(value="addIrdntList" , required=false) List<RecipeIrdnt> addIrdntList,  
												 HttpServletRequest request) throws IllegalStateException, IOException{
			System.out.println("업데이트 핸들러: recipeId -"+recipeId+"/"+removeIrdntList);
			//System.out.println("업데이트 핸들러:"+recipeInfoForm);
			//if(errors.hasErrors()){
				//System.out.println("업데이트 핸들러 errors수:"+ errors.getAllErrors());
			//	return new ModelAndView("common/admin/recipe_for_admin/info_update_form", "recipe", recipeInfoForm);
			// 2.레시피 재료 수정하기(삭제와 추가 리스트에 넣기)
			Map<String, List> recipeIrdnt = new HashMap<>();
			//삭제할거는 recipeId와 cookingNo를 Map로 받아온다 -> 그대로 넘기고 , 
			recipeIrdnt.put("removeIrdntList", removeIrdntList);
				//추가할 것 레시피 아이디 세팅해서 넘겨주기
			
			if(addIrdntList != null){
				for(RecipeIrdnt ri : addIrdntList){
					ri.setRecipeId(recipeId);
				}
				recipeIrdnt.put("addIrdntList", addIrdntList);
			}
			
						
						
			try {
				recipeService.updateRecipeIrdnt(recipeIrdnt);
			}  catch (NoneRecipeException e)  {
				e.printStackTrace();
				return new ModelAndView("common/admin/recipe_for_admin/info_update_form","errorMsg_NoneRecipe",e.getMessage());
			}
			
			//System.out.println("레시피컨트롤러 update완료 :"+recipeInfo);
			return new ModelAndView("redirect:update/success.do","recipeId",recipeId);
		}
		
		
		
		
		
		
		@RequestMapping("common/admin/recipe/crse/update_chk")
		public ModelAndView move2RecipeCrseUpdateForm(@RequestParam int recipeId){
			RecipeInfo ri = recipeService.showDetailOfRecipe(recipeId);
			System.out.println(ri);
			return new ModelAndView("common/admin/recipe_for_admin/crse_update_form", "recipe", ri);
			
		}
		
		@RequestMapping("common/admin/recipe/crse/update")
		public ModelAndView updateRecipeCrseHandler(int recipeId, @RequestParam(value="removeCrseList") List<Map> removeCrseList,
														@RequestParam(value="addCrseList", required=false) List<RecipeCrse> addCrseList,
				HttpServletRequest request) throws IllegalStateException, IOException{
			// 3. 래시피 과정 수정하기(삭제와 추가 리스트에 넣기)
			Map<String, List> recipeCrse = new HashMap<>();
				//삭제할거는 recipeId와 cookingNo를 Map로 받아온다 -> 그대로 넘기고 , 
			recipeCrse.put("removeCrseList", removeCrseList);
				//추가할 것 레시피 아이디 세팅, 사진 파일 저장해서 넘겨주기
			String fileName = null;
			long fileSize= 0;	
			for(RecipeCrse rc : addCrseList){
				rc.setRecipeId(recipeId);
				
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
						
			try {
				recipeService.updateRecipeCrse(recipeCrse);
			}  catch (NoneRecipeException e)  {
				e.printStackTrace();
				return new ModelAndView("common/admin/recipe_for_admin/info_update_form","errorMsg_NoneRecipe",e.getMessage());
			}
			
			//System.out.println("레시피컨트롤러 update완료 :"+recipeInfo);
			return new ModelAndView("redirect:update/success.do","recipeId",recipeId);
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
	
	@RequestMapping(value="findRecipeByRecipeName")
	@ResponseBody
	public Map findRecipeByRecipeName(@RequestParam String recipeName, @RequestParam String keyword,@RequestParam(defaultValue = "1") int page ){
		
		Map apiList = recipeService.findRecipeByRecipeName(recipeName, keyword,page);
		Map userList = shareService.selectBoardShareRecipeByTitle(recipeName,page);
		HashMap map = new HashMap();
		map.put("apiList", apiList); // 이안에 페이징빈이랑 리스트 두개 들어있다.
		map.put("userList", userList); // 이거 안에도 페이징빈이랑 리스트 두개 
		System.out.println(map);
		return map;
	}
	
	@RequestMapping(value="findRecipeByCategory")
	@ResponseBody
	public Map findRecipeByCategory(@RequestParam String categoryName, @RequestParam String typeName, @RequestParam String keyword,
			@RequestParam(defaultValue = "1") int page ){
		Map list = recipeService.findRecipeByCategory(categoryName, typeName, keyword,page);
		return list;
	}
	
	@RequestMapping(value="findRecipeByIrdntId")
	@ResponseBody
	public Map<String,Object> findRecipeByIrdntId(@RequestParam List<Integer> irdntIds, @RequestParam List<Integer> hateIrdntIds, @RequestParam String keyword,
			@RequestParam(defaultValue = "1") int page ){

		//System.out.println(irdntIds);
		//System.out.println(hateIrdntIds);
		//System.out.println(keyword + page);
		Map apiMap = recipeService.findRecipeByIrdntId(irdntIds, hateIrdntIds, keyword,page);
		Map userMap = shareService.findUserRecipeByIds(irdntIds, hateIrdntIds,page);
	
		System.out.println("컨트롤러 apiMap: "+ apiMap);
		System.out.println("컨트롤러 userMap: "+userMap);
		HashMap map = new HashMap();
		map.put("apiMap", apiMap);//여기안에 count랑 리스트, 페이징빈 들어있다. 
		map.put("userMap", userMap);//여기에 리스트랑 페이징빈 들어있다. 
		return map;
	}
	
	
	
	//상세화면 handler
	@RequestMapping("recipe/show/detail")
	public ModelAndView showDetailOfRecipe(@RequestParam int recipeId){
		RecipeInfo recipe = recipeService.showDetailOfRecipe(recipeId);
		return new ModelAndView("recipe_for_user/recipe_detail.tiles","recipe",recipe);
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
	
	
	@RequestMapping("getIrdntTable")
	@ResponseBody
	public Map getIrdntTable(){
		HashMap map = new HashMap();
		//List<myIrdnt> = 
		
		return map;
	}
	
	@RequestMapping("getIrdntList")
	@ResponseBody
	public List<IrdntManage> allIrdntList(){
		List<IrdntManage> list = imService.fingAllIrdntNotPaging();
		return list;
	}
	
	@RequestMapping("getMyIrdntList")
	@ResponseBody
	public List<MyIrdnt> allMyIrdntList(@RequestParam int fridgerId){
		Member member = (Member)SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		if(member==null){
			//비회원
			return null;
		}
		List<MyIrdnt> list = myService.findAllMyIrdntByFridgerId(fridgerId);
		return list;
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
}