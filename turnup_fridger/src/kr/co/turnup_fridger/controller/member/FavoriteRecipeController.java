package kr.co.turnup_fridger.controller.member;

import java.util.List;

import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import kr.co.turnup_fridger.exception.DuplicateFavoriteException;
import kr.co.turnup_fridger.exception.NoneFavoriteException;
import kr.co.turnup_fridger.service.FavoriteRecipeService;
import kr.co.turnup_fridger.validation.form.FavoriteRecipeForm;
import kr.co.turnup_fridger.vo.FavoriteRecipe;

@Controller
@RequestMapping("/common/member/favoriteRecipe/")
public class FavoriteRecipeController {
	
	@Autowired
	private FavoriteRecipeService service;
	
	@RequestMapping("createFavorite")
	public ModelAndView createFavorite(@ModelAttribute("FavoriteRecipe") FavoriteRecipeForm fRecipeForm,BindingResult errors){
		
		if(errors.hasErrors()){
			return new ModelAndView("레시피상세 페이지");
		}
		FavoriteRecipe fRecipe = new FavoriteRecipe();
		BeanUtils.copyProperties(fRecipeForm, fRecipe);
		
		try {
			service.createFavoriteRecipe(fRecipe);
		} catch (DuplicateFavoriteException e) {
			return new ModelAndView("레시피상세 페이지","errorMsg_keyDuplicate",e.getMessage());
		}
		return new ModelAndView("redirect:레시피상세 페이지");
		
	}

	
	public ModelAndView updateFavorite(@ModelAttribute("FavoriteRecipe") FavoriteRecipeForm fRecipeForm,BindingResult errors){
		if(errors.hasErrors()){
			return new ModelAndView("레시피상세 페이지");
		}
		FavoriteRecipe fRecipe = new FavoriteRecipe();
		BeanUtils.copyProperties(fRecipeForm, fRecipe);

		try {
			service.updateFavoriteRecipe(fRecipe);
		} catch (NoneFavoriteException e) {
			return new ModelAndView("레시피상세 페이지","errorMsg_keyNull",e.getMessage());
		}

		return new ModelAndView("redirect:레시피상세 페이지");
	}

	public String removeFavorite(@RequestParam int favoriteRecipeKey){
		
		try {
			service.removeFavoriteRecipe(favoriteRecipeKey);
		} catch (NoneFavoriteException e) {
			return "삭제실패!";
		}
		return "삭제성공!";
	}
	
	public List<FavoriteRecipe> findFavoriteRecipeByMemberId(@RequestParam String memberId){
		return service.findFavoriteRecipeByMemberId(memberId);
	}
	
	public List<FavoriteRecipe> findFavoriteRecipeByRecipeId(@RequestParam int recipeId){
		return service.findFavoriteRecipeByRecipeId(recipeId);
	}
}
