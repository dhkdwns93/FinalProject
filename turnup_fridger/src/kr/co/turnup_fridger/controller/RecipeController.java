package kr.co.turnup_fridger.controller;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.validation.Valid;

import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import kr.co.turnup_fridger.exception.DuplicateRecipeException;
import kr.co.turnup_fridger.exception.NoneRecipeException;
import kr.co.turnup_fridger.service.RecipeService;
import kr.co.turnup_fridger.validation.form.RecipeCrseForm;
import kr.co.turnup_fridger.validation.form.RecipeInfoForm;
import kr.co.turnup_fridger.validation.form.RecipeIrdntForm;
import kr.co.turnup_fridger.vo.RecipeCrse;
import kr.co.turnup_fridger.vo.RecipeInfo;
import kr.co.turnup_fridger.vo.RecipeIrdnt;

@Controller
@RequestMapping("/common/")
public class RecipeController {
	
	@Autowired
	private RecipeService service;
	
	
	/***************************************************************
	 * 관리자를 위한  Recipe Handler : 등록, 삭제
	 ****************************************************************/
	@RequestMapping(value="admin/recipe/register",produces="html/text;charset=UTF-8;")
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
	
	@RequestMapping("findRecipeByRecipeName")
	public ModelAndView findRecipeByRecipeName(@RequestParam String recipeName, @RequestParam String keyword, @RequestParam(defaultValue="1") int page){

		Map<String, Object> map = service.findRecipeByRecipeName(recipeName, keyword, page);

		ModelAndView mav = new ModelAndView();
		mav.addObject("list", map.get("list"));
		mav.addObject("pageBean", map.get("pageBean"));
		mav.setViewName("레시피명검색화면");
		return mav;
	}
	
	@RequestMapping("findRecipeByCategory")
	public ModelAndView findRecipeByCategory(@RequestParam String categoryName, @RequestParam String typeName, @RequestParam String keyword, @RequestParam int page){

		Map<String,Object> map = service.findRecipeByCategory(categoryName, typeName, keyword, page);
		
		ModelAndView mav = new ModelAndView();
		mav.addObject("list", map.get("list"));
		mav.addObject("pageBean", map.get("pageBean"));
		mav.setViewName("카테고리 검색화면");
		return mav;
	}
	
	@RequestMapping("findRecipeByIrdntId")
	public ModelAndView findRecipeByIrdntId(@RequestParam List<Integer> irdntIds, @RequestParam List<Integer> hateIrdntIds, @RequestParam String keyword, @RequestParam int page){

		Map<String,Object> map = service.findRecipeByIrdntId(irdntIds, hateIrdntIds, keyword, page);
		
		ModelAndView mav = new ModelAndView();
		mav.addObject("list", map.get("list"));
		mav.addObject("pageBean", map.get("pageBean"));
		mav.setViewName("재료 검색화면");
		return mav;
	}
	
	@RequestMapping("showDetailOfRecipe")
	@ResponseBody
	public ModelAndView showDetailOfRecipe(@RequestParam int recipeId){
		RecipeInfo recipe = service.showDetailOfRecipe(recipeId);
		return new ModelAndView("상세페이지화면","recipeDetail",recipe);
	}
	
	@RequestMapping("changePortion")
	@ResponseBody
	public ModelAndView changePortion(){
		return new ModelAndView("상세페이지 + 변환된 자료가 들어오겠찌");
	}
	
}
