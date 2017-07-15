package kr.co.turnup_fridger.vo;

import java.util.List;

public class RecipeIrdntUpdate {
	
	int recipeId;
	
	List<Integer> removeIrdntList;
	List<RecipeIrdnt> addIrdntList;
	
	
	public int getRecipeId() {
		return recipeId;
	}
	public void setRecipeId(int recipeId) {
		this.recipeId = recipeId;
	}
	public List<Integer> getRemoveIrdntList() {
		return removeIrdntList;
	}
	public void setRemoveIrdntList(List<Integer> removeIrdntList) {
		this.removeIrdntList = removeIrdntList;
	}
	public List<RecipeIrdnt> getAddIrdntList() {
		return addIrdntList;
	}
	public void setAddIrdntList(List<RecipeIrdnt> addIrdntList) {
		this.addIrdntList = addIrdntList;
	}
	@Override
	public String toString() {
		return "TestVO [recipeId=" + recipeId + ", removeIrdntList=" + removeIrdntList + ", addIrdntList="
				+ addIrdntList + "]";
	}
	
}
