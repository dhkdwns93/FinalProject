package kr.co.turnup_fridger.validation.form;

import java.util.List;

import javax.validation.Valid;
import javax.validation.constraints.NotNull;
import javax.validation.constraints.Size;

import org.hibernate.validator.constraints.NotEmpty;

import kr.co.turnup_fridger.vo.RecipeCrse;
import kr.co.turnup_fridger.vo.RecipeIrdnt;

public class RecipeInfoForm {

	//시퀀스
	private int recipeId;
	@NotEmpty(message="레시피명을 입력하세요.")
	private String recipeName;
	@NotEmpty(message="간략한 요리설명을 입력하세요.")
	private String sumry;
	@NotNull(message="유형분류코드를 입력하세요.")
	private int categoryCode;
	@NotEmpty(message="유형분류명을 입력하세요.")
	private String categoryName;
	@NotNull(message="음식분류코드를 입력하세요.")
	private int typeCode;
	@NotEmpty(message="음식분류명을 입력하세요.")
	private String typeName;
	@NotEmpty(message="조리시간을 입력하세요.")
	private String cookingTime;
	@NotEmpty(message="칼로리를 입력하세요.")
	private String calorie;
	@NotEmpty(message="몇인분의 레시피인지 입력하세요.")
	private String Qnt;
	@NotEmpty(message="요리의 난이도를 입력하세요.")
	private String recipeLevel;
	private String irdntCode;
	private String price;
	@NotEmpty(message="대표사진을 입력하세요.")
	private String imgUrl;
	@NotEmpty(message="상세사진을 입력하세요.")
	private String detUrl;
	//조회수
	private int recipeHits;
	@Size(min=1, message="재료는 1개 이상 선택해주세요.")
	@Valid
	private List<RecipeIrdntForm> recipeIrdntForm;
	@Size(min=1, message="과정은 1개 이상 입력해주세요.")
	@Valid
	private List<RecipeCrseForm> recipeCrseForm;
	public int getRecipeId() {
		return recipeId;
	}
	public void setRecipeId(int recipeId) {
		this.recipeId = recipeId;
	}
	public String getRecipeName() {
		return recipeName;
	}
	public void setRecipeName(String recipeName) {
		this.recipeName = recipeName;
	}
	public String getSumry() {
		return sumry;
	}
	public void setSumry(String sumry) {
		this.sumry = sumry;
	}
	public int getCategoryCode() {
		return categoryCode;
	}
	public void setCategoryCode(int categoryCode) {
		this.categoryCode = categoryCode;
	}
	public String getCategoryName() {
		return categoryName;
	}
	public void setCategoryName(String categoryName) {
		this.categoryName = categoryName;
	}
	public int getTypeCode() {
		return typeCode;
	}
	public void setTypeCode(int typeCode) {
		this.typeCode = typeCode;
	}
	public String getTypeName() {
		return typeName;
	}
	public void setTypeName(String typeName) {
		this.typeName = typeName;
	}
	public String getCookingTime() {
		return cookingTime;
	}
	public void setCookingTime(String cookingTime) {
		this.cookingTime = cookingTime;
	}
	public String getCalorie() {
		return calorie;
	}
	public void setCalorie(String calorie) {
		this.calorie = calorie;
	}
	public String getQnt() {
		return Qnt;
	}
	public void setQnt(String qnt) {
		Qnt = qnt;
	}
	public String getRecipeLevel() {
		return recipeLevel;
	}
	public void setRecipeLevel(String recipeLevel) {
		this.recipeLevel = recipeLevel;
	}
	public String getIrdntCode() {
		return irdntCode;
	}
	public void setIrdntCode(String irdntCode) {
		this.irdntCode = irdntCode;
	}
	public String getPrice() {
		return price;
	}
	public void setPrice(String price) {
		this.price = price;
	}
	public String getImgUrl() {
		return imgUrl;
	}
	public void setImgUrl(String imgUrl) {
		this.imgUrl = imgUrl;
	}
	public String getDetUrl() {
		return detUrl;
	}
	public void setDetUrl(String detUrl) {
		this.detUrl = detUrl;
	}
	public int getRecipeHits() {
		return recipeHits;
	}
	public void setRecipeHits(int recipeHits) {
		this.recipeHits = recipeHits;
	}
	public List<RecipeIrdntForm> getRecipeIrdntForm() {
		return recipeIrdntForm;
	}
	public void setRecipeIrdntForm(List<RecipeIrdntForm> recipeIrdntForm) {
		this.recipeIrdntForm = recipeIrdntForm;
	}
	public List<RecipeCrseForm> getRecipeCrseForm() {
		return recipeCrseForm;
	}
	public void setRecipeCrseForm(List<RecipeCrseForm> recipeCrseForm) {
		this.recipeCrseForm = recipeCrseForm;
	}
	
	
 	
}
