package kr.co.turnup_fridger.vo;

import java.io.Serializable;

import org.springframework.web.multipart.MultipartFile;

public class RecipeCrse implements Serializable{

	private int recipeId;
	private int cookingNo;
	private String cookingDc;
	private String stepImageUrl;
	private String stepTip;
	private RecipeInfo recipeInfo;
	
	
	private MultipartFile stepImageUrlSrc;
	public RecipeCrse(){
		
	}
	
	public RecipeCrse(int recipeId, int cookingNo, String cookingDc, String stepImageUrl, String stepTip) {
		this.recipeId = recipeId;
		this.cookingNo = cookingNo;
		this.cookingDc = cookingDc;
		this.stepImageUrl = stepImageUrl;
		this.stepTip = stepTip;
	}

	public RecipeCrse(int recipeId, int cookingNo, String cookingDc, String stepImageUrl, String stepTip,
			RecipeInfo recipeInfo) {
		this.recipeId = recipeId;
		this.cookingNo = cookingNo;
		this.cookingDc = cookingDc;
		this.stepImageUrl = stepImageUrl;
		this.stepTip = stepTip;
		this.recipeInfo = recipeInfo;
	}

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

	
	public MultipartFile getStepImageUrlSrc() {
		return stepImageUrlSrc;
	}

	public void setStepImageUrlSrc(MultipartFile stepImageUrlSrc) {
		this.stepImageUrlSrc = stepImageUrlSrc;
	}

	@Override
	public String toString() {
		return "RecipeCrse [recipeId=" + recipeId + ", cookingNo=" + cookingNo + ", cookingDc=" + cookingDc
				+ ", stepImageUrl=" + stepImageUrl + ", stepTip=" + stepTip + ", recipeInfo=" + recipeInfo + "]";
	}

	@Override
	public int hashCode() {
		final int prime = 31;
		int result = 1;
		result = prime * result + ((cookingDc == null) ? 0 : cookingDc.hashCode());
		result = prime * result + cookingNo;
		result = prime * result + recipeId;
		result = prime * result + ((recipeInfo == null) ? 0 : recipeInfo.hashCode());
		result = prime * result + ((stepImageUrl == null) ? 0 : stepImageUrl.hashCode());
		result = prime * result + ((stepTip == null) ? 0 : stepTip.hashCode());
		return result;
	}

	@Override
	public boolean equals(Object obj) {
		if (this == obj)
			return true;
		if (obj == null)
			return false;
		if (getClass() != obj.getClass())
			return false;
		RecipeCrse other = (RecipeCrse) obj;
		if (cookingDc == null) {
			if (other.cookingDc != null)
				return false;
		} else if (!cookingDc.equals(other.cookingDc))
			return false;
		if (cookingNo != other.cookingNo)
			return false;
		if (recipeId != other.recipeId)
			return false;
		if (recipeInfo == null) {
			if (other.recipeInfo != null)
				return false;
		} else if (!recipeInfo.equals(other.recipeInfo))
			return false;
		if (stepImageUrl == null) {
			if (other.stepImageUrl != null)
				return false;
		} else if (!stepImageUrl.equals(other.stepImageUrl))
			return false;
		if (stepTip == null) {
			if (other.stepTip != null)
				return false;
		} else if (!stepTip.equals(other.stepTip))
			return false;
		return true;
	}
	
	
}
