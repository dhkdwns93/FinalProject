package kr.co.turnup_fridger.validation.form;

import javax.validation.constraints.NotNull;

import org.hibernate.validator.constraints.NotEmpty;

import kr.co.turnup_fridger.vo.IrdntManage;
import kr.co.turnup_fridger.vo.RecipeInfo;

public class RecipeIrdntForm {

	//시퀀스
	private int irdntNo;
	//id가져올때 같이 가져올거야.
	@NotEmpty
	private String irdntName;
	private String irdntAmount;
	@NotNull
	private int irdntTypeCode;
	@NotEmpty
	private String irdntTypeName;
	private int recipeId;
	private int irdntId;
	private IrdntManage irdntManage;
	private RecipeInfo RecipeInfo;
	public int getIrdntNo() {
		return irdntNo;
	}
	public void setIrdntNo(int irdntNo) {
		this.irdntNo = irdntNo;
	}
	public String getIrdntName() {
		return irdntName;
	}
	public void setIrdntName(String irdntName) {
		this.irdntName = irdntName;
	}
	public String getIrdntAmount() {
		return irdntAmount;
	}
	public void setIrdntAmount(String irdntAmount) {
		this.irdntAmount = irdntAmount;
	}
	public int getIrdntTypeCode() {
		return irdntTypeCode;
	}
	public void setIrdntTypeCode(int irdntTypeCode) {
		this.irdntTypeCode = irdntTypeCode;
	}
	public String getIrdntTypeName() {
		return irdntTypeName;
	}
	public void setIrdntTypeName(String irdntTypeName) {
		this.irdntTypeName = irdntTypeName;
	}
	public int getRecipeId() {
		return recipeId;
	}
	public void setRecipeId(int recipeId) {
		this.recipeId = recipeId;
	}
	public int getIrdntId() {
		return irdntId;
	}
	public void setIrdntId(int irdntId) {
		this.irdntId = irdntId;
	}
	public IrdntManage getIrdntManage() {
		return irdntManage;
	}
	public void setIrdntManage(IrdntManage irdntManage) {
		this.irdntManage = irdntManage;
	}
	public RecipeInfo getRecipeInfo() {
		return RecipeInfo;
	}
	public void setRecipeInfo(RecipeInfo recipeInfo) {
		RecipeInfo = recipeInfo;
	}
	
	
	
	
}
