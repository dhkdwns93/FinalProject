package kr.co.turnup_fridger.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.validation.Valid;

import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
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
	private RecipeService service;
	@Autowired
	private BoardShareRecipeService shareService;
	@Autowired
	private ShareRecipeIrdntService sIrdntService;
	@Autowired
	private IrdntManageService imService;
	@Autowired
	private MyIrdntService myService;
	@Autowired
	private MyDislikeIrdntService disService;
	
	
	/***************************************************************
	 * 관리자를 위한  Recipe Handler : 등록, 삭제
	 ****************************************************************/
	@RequestMapping(value="/common/admin/recipe/register",produces="html/text;charset=UTF-8;")
	public ModelAndView createRecipe(@ModelAttribute("recipeInfo") @Valid RecipeInfoForm recipeInfoForm, BindingResult errors){
		System.out.println("createRecipe로그");
		//발리데이션은 한번에 거쳐서 들어오면, 그걸 나눠서 타입바꿔주는 작업을 하자.
		if(errors.hasErrors()){
			return new ModelAndView("common/admin/recipe/register_form");
		}

		List<RecipeCrseForm> formCrses = recipeInfoForm.getRecipeCrseForm();		
		List<RecipeCrse> recipeCrses = new ArrayList<>();
		for(int i =0; i<formCrses.size();i++){
			BeanUtils.copyProperties(formCrses.get(i), recipeCrses.get(i));
		}
		
		List<RecipeIrdntForm> formIrdnts = recipeInfoForm.getRecipeIrdntForm();		
		List<RecipeIrdnt> recipeIrdnts = new ArrayList<>();
		for(int i =0; i<formIrdnts.size();i++){
			BeanUtils.copyProperties(formIrdnts.get(i), recipeIrdnts.get(i));
		}
		
		RecipeInfo recipeInfo = new RecipeInfo();
		BeanUtils.copyProperties(recipeInfoForm, recipeInfo);
		recipeInfo.setrecipeCrse(recipeCrses);
		recipeInfo.setrecipeIrdnt(recipeIrdnts);
		
		try {
			service.createRecipe(recipeInfo);
		} catch (DuplicateRecipeException e) {
			return new ModelAndView("common/admin/recipe/register_form","errorMsg_duplicateId",e.getMessage());
		}
		return new ModelAndView("redirect:register/success.do","successMsg_create","등록성공!");
	}
	
	@RequestMapping("admin/recipe/register/success")
	public ModelAndView registerSuccess( int fridgerId ) throws Exception{
		System.out.println("로그,다");
		return new ModelAndView("common/admin/recipe/register_success.tiles","successMsg_create","등록성공!");
	}
	
	@RequestMapping("updateRecipe")
	public ModelAndView updateRecipe(@ModelAttribute("recipeInfo") @Valid RecipeInfoForm recipeInfoForm, BindingResult errors){
		
		if(errors.hasErrors()){
			return new ModelAndView("레시피 수정폼");
		}

		List<RecipeCrseForm> formCrses = recipeInfoForm.getRecipeCrseForm();		
		List<RecipeCrse> recipeCrses = new ArrayList<>();
		for(int i =0; i<formCrses.size();i++){
			BeanUtils.copyProperties(formCrses.get(i), recipeCrses.get(i));
		}
		
		List<RecipeIrdntForm> formIrdnts = recipeInfoForm.getRecipeIrdntForm();		
		List<RecipeIrdnt> recipeIrdnts = new ArrayList<>();
		for(int i =0; i<formIrdnts.size();i++){
			BeanUtils.copyProperties(formIrdnts.get(i), recipeIrdnts.get(i));
		}
		
		RecipeInfo recipeInfo = new RecipeInfo();
		BeanUtils.copyProperties(recipeInfoForm, recipeInfo);
		recipeInfo.setrecipeCrse(recipeCrses);
		recipeInfo.setrecipeIrdnt(recipeIrdnts);
		
		try {
			service.updateRecipe(recipeInfo);
		} catch (NoneRecipeException e) {
			return new ModelAndView("레시피 수정폼","errorMsg_noneId",e.getMessage());
		}
		return new ModelAndView("레시피목록","successMsg_update","수정성공!");
	}
	
	//레시피삭제
	@RequestMapping(value="removeRecipe", produces="html/text;charset=UTF-8;")
	@ResponseBody
	public String removeRecipe(@RequestParam int recipeId){
		try {
			service.removeRecipe(recipeId);
		} catch (NoneRecipeException e) {
			return "없는 재료라 삭제실패!";
		}
		return "삭제완료!";
	}
	
	//전체레시피
	@RequestMapping("allRecipeList")
	@ResponseBody
	public List<RecipeInfo> allRecipeList(){
		List<RecipeInfo> list = service.allRecipeList();
		return list;
	}
	
	@RequestMapping(value="findRecipeByRecipeName")
	@ResponseBody
	public Map findRecipeByRecipeName(@RequestParam String recipeName, @RequestParam String keyword){
		
		System.out.println("핸들러 : "+recipeName+keyword);
		List<RecipeInfo> apiList = service.findRecipeByRecipeName(recipeName, keyword);
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
		List<RecipeInfo> list = service.findRecipeByCategory(categoryName, typeName, keyword);
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
		List<RecipeInfo> apiList = service.findRecipeByIrdntId(irdntIds, hateIrdntIds, keyword);
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
	
	@RequestMapping("showDetailOfRecipe")
	public ModelAndView showDetailOfRecipe(@RequestParam int recipeId){
		RecipeInfo recipe = service.showDetailOfRecipe(recipeId);
		return new ModelAndView("상세페이지화면","recipeDetail",recipe);
	}
	
	@RequestMapping("changePortion")
	public ModelAndView changePortion(){
		return new ModelAndView("상세페이지 + 변환된 자료가 들어오겠찌");
	}
	
	@RequestMapping("getTypeNameCategory")
	@ResponseBody
	public List<String> getTypeNameCategory(@RequestParam String categoryName){
		return service.getTypeNameByCategoryName(categoryName);
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