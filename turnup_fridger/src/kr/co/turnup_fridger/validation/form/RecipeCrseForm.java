package kr.co.turnup_fridger.validation.form;

import org.hibernate.validator.constraints.NotEmpty;
import org.springframework.web.multipart.MultipartFile;

public class RecipeCrseForm {

	//조인될 외래키
	private int recipeId;
	//시퀀스
	private int cookingNo;
	@NotEmpty(message="요리설명을 입력하세요.")
	private String cookingDc;
	private String stepImageUrl;
	private String stepTip;
	private MultipartFile stepImageUrlSrc;
	
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

	public MultipartFile getStepImageUrlSrc() {
		return stepImageUrlSrc;
	}
	public void setStepImageUrlSrc(MultipartFile stepImageUrlSrc) {
		this.stepImageUrlSrc = stepImageUrlSrc;
	}
	
	
}
