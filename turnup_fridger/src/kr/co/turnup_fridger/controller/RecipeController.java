package kr.co.turnup_fridger.controller;

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
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
import kr.co.turnup_fridger.service.ShareRecipeIrdntService;
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
	private ShareRecipeIrdntService IrdntService;
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
				System.out.println("BindingResult : "+errors.getErrorCount());
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
			recipeInfo.setQnt(recipeInfoForm.getQnt()+"인분");
			recipeInfo.setRecipeHits(0);
			recipeInfo.setRecipeCrseList(recipeCrseList);
			recipeInfo.setRecipeIrdntList(recipeIrdntList);
			System.out.println("레시피컨트롤러 create :"+recipeInfo);
			try {
				recipeService.createRecipe(recipeInfo);
				System.out.println("레시피컨트롤러 create - createRecipe직후:");
			} catch (DuplicateRecipeException e) {
				e.printStackTrace();
				return new ModelAndView("common/admin/recipe_for_admin/register_form.tiles","errorMsg_duplicateId",e.getMessage());
			}
			System.out.println("레시피컨트롤러 create - createRecipe직후:");
			return new ModelAndView("redirect:register/success.do","recipeId",recipeInfo.getRecipeId());
		}
		
		@RequestMapping("common/admin/recipe/register/success")
		public ModelAndView registerRecipeSuccess( int recipeId ) throws Exception{
			System.out.println("로그,다");
			return new ModelAndView("common/admin/recipe_for_admin/recipeList.tiles","successMsg_create","등록성공!");
		}
	
		//수정
		@RequestMapping("common/admin/recipe/update")
		public ModelAndView updateRecipe(@ModelAttribute("recipeInfo") @Valid RecipeInfoForm recipeInfoForm, BindingResult errors, HttpServletRequest request)
				 throws IllegalStateException, IOException{
			if(errors.hasErrors()){
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
				rc.setRecipeId(recipeInfo.getRecipeId());
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
				rc.setRecipeId(recipeInfo.getRecipeId());
				recipeIrdntList.add(ri);
			}
			recipeInfo.setQnt(recipeInfoForm.getQnt()+"인분");
			recipeInfo.setRecipeHits(0);
			recipeInfo.setRecipeCrseList(recipeCrseList);
			recipeInfo.setRecipeIrdntList(recipeIrdntList);
			System.out.println("레시피컨트롤러 create :"+recipeInfo);
			try {
				recipeService.createRecipe(recipeInfo);
			} catch (DuplicateRecipeException e) {
				return new ModelAndView("common/admin/recipe_for_admin/register_form.tiles","errorMsg_duplicateId",e.getMessage());
			}
			return new ModelAndView("redirect:register/success.do","recipeId",recipeInfo.getRecipeId());
		}
		
		@RequestMapping("common/admin/recipe/update/success")
		public ModelAndView updateRecipeSuccess( int recipeId ) throws Exception{
			System.out.println("로그,다");
			return new ModelAndView("common/admin/recipe/recipeList","successMsg_create","등록성공!");
		}
		
	//레시피삭제
	@RequestMapping(value="common/admin/recipe/remove", produces="html/text;charset=UTF-8;")
	@ResponseBody
	public String removeRecipe(@RequestParam int recipeId){
		try {
			recipeService.removeRecipe(recipeId);
		} catch (NoneRecipeException e) {
			return "없는 재료라 삭제실패!";
		}
		return "삭제완료!";
	}
	
	//전체레시피
	@RequestMapping("allRecipeList")
	@ResponseBody
	public List<RecipeInfo> allRecipeList(){
		List<RecipeInfo> list = recipeService.allRecipeList();
		return list;
	}
	
	@RequestMapping(value="findRecipeByRecipeName")
	@ResponseBody
	public Map findRecipeByRecipeName(@RequestParam String recipeName, @RequestParam String keyword){
		
		System.out.println("핸들러 : "+recipeName+keyword);
		List<RecipeInfo> apiList = recipeService.findRecipeByRecipeName(recipeName, keyword);
		List<BoardShareRecipe> userList = shareService.selectBoardShareRecipeByTitle(recipeName);
		HashMap map = new HashMap();
		map.put("apiList", apiList);
		map.put("userList", userList);
		System.out.println("-----------Map : "+map);
		return map;
	}
	
	@RequestMapping(value="findRecipeByCategory")
	@ResponseBody
	public List<RecipeInfo> findRecipeByCategory(@RequestParam String categoryName, @RequestParam String typeName, @RequestParam String keyword){

		System.out.println(categoryName+typeName+keyword);
		List<RecipeInfo> list = recipeService.findRecipeByCategory(categoryName, typeName, keyword);
		System.out.println(list);
		return list;
		//ModelAndView mav = new ModelAndView();
		//HashMap map = new HashMap();
		//map.put("list", list);
		//map.setViewName("카테고리 검색화면");
		//return map;
		//return mav;
	}
	
	@RequestMapping(value="findRecipeByIrdntId")
	@ResponseBody
	public Map<String,Object> findRecipeByIrdntId(@RequestParam List<Integer> irdntIds, @RequestParam List<Integer> hateIrdntIds, @RequestParam String keyword){


		System.out.println("아이디핸들러 : "+ irdntIds + "% ㄴㄴ:"+ hateIrdntIds);

		List<RecipeInfo> apiList = recipeService.findRecipeByIrdntId(irdntIds, hateIrdntIds, keyword);

		List<BoardShareRecipe> userList = shareService.findUserRecipeByIds(irdntIds, hateIrdntIds);
		
		//ModelAndView mav = new ModelAndView();
		HashMap map = new HashMap();
		map.put("apiList", apiList);
		map.put("userList", userList);	
		//map.setViewName("재료 검색화면");
		System.out.println(map);
		return map;
		//return mav;
	}
	
	//상세화면 handler
	@RequestMapping("recipe/show/detail")
	public ModelAndView showDetailOfRecipe(@RequestParam int recipeId){
		RecipeInfo recipe = recipeService.showDetailOfRecipe(recipeId);
		System.out.println(recipe);
		return new ModelAndView("common/admin/recipe_for_admin/recipe_detail.tiles","recipe",recipe);
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
		List<IrdntManage> list = imService.findAllIrdnt();
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
	public List<MyDislikeIrdnt> getMyDislikeIrdnt(){
		Member member = (Member)SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		if(member==null){
			//비회원
			return null;
		}
		List<MyDislikeIrdnt> irdnt = disService.findMyDislikeIrdntByMemberId(member.getMemberId());
		return irdnt;
	}
}