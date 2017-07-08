package kr.co.turnup_fridger.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import kr.co.turnup_fridger.service.RecipeService;
import kr.co.turnup_fridger.vo.RecipeInfo;

@Controller
public class RecipeController {
	
	@Autowired
	private RecipeService service;
	
	@RequestMapping("createRecipe")
	public ModelAndView createRecipe(){
	
		return null;
	}
	
	@RequestMapping("updateRecipe")
	public ModelAndView updateRecipe(){
		return null;
	}
	
	@RequestMapping("removeRecipe")
	public String removeRecipe(){
		return null;
	}
	
	@RequestMapping("findRecipeByRecipeName")
	public List<RecipeInfo> findRecipeByRecipeName(){
		
		return null;
	}
	
	@RequestMapping("findRecipeByCategory")
	public List<RecipeInfo> findRecipeByCategory(){
		
		return null;
	}
	
	@RequestMapping("findRecipeByIrdntId")
	public List<RecipeInfo> findRecipeByIrdntId(){
		return null;
	}
	
	@RequestMapping("showDetailOfRecipe")
	public ModelAndView showDetailOfRecipe(){
		
		return null;
	}
	
	@RequestMapping("changePortion")
	public ModelAndView changePortion(){
		return null;
	}
	
}
