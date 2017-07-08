package kr.co.turnup_fridger.validation.form;

import org.hibernate.validator.constraints.NotEmpty;

import kr.co.turnup_fridger.vo.RecipeInfo;

public class RecipeCrseForm {

	//조인될 외래키
	private int recipeId;
	//시퀀스
	private int cookingNo;
	@NotEmpty(message="요리설명을 입력하세요.")
	private String cookingDc;
	private String stepImageUrl;
	private String stepTip;
	private RecipeInfo recipeInfo;
	public int getRecipeId() {
		return recipeId;
	}
	public void setRecipeId(int recipeId) {
		this.recipeId = recipeId;
	}
	public int getCookingNo() {
		return cookingNo;
	}
	public void setCookingNo(int cookingNo) {
		this.cookingNo = cookingNo;
	}
	public String getCookingDc() {
		return cookingDc;
	}
	public void setCookingDc(String cookingDc) {
		this.cookingDc = cookingDc;
	}
	public String getStepImageUrl() {
		return stepImageUrl;
	}
	public void setStepImageUrl(String stepImageUrl) {
		this.stepImageUrl = stepImageUrl;
	}
	public String getStepTip() {
		return stepTip;
	}
	public void setStepTip(String stepTip) {
		this.stepTip = stepTip;
	}
	public RecipeInfo getRecipeInfo() {
		return recipeInfo;
	}
	public void setRecipeInfo(RecipeInfo recipeInfo) {
		this.recipeInfo = recipeInfo;
	}
	
	
}
