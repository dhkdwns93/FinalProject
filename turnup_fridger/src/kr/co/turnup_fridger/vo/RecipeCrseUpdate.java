package kr.co.turnup_fridger.vo;

import java.util.List;
import java.util.Map;

public class RecipeCrseUpdate {

	int recipeId;
	List<RecipeCrse> removeCrseList;
	List<RecipeCrse> addCrseList;
	List<RecipeCrse> currentCrseList;
	
	
	public int getRecipeId() {
		return recipeId;
	}
	public void setRecipeId(int recipeId) {
		this.recipeId = recipeId;
	}
	
	public List<RecipeCrse> getRemoveCrseList() {
		return removeCrseList;
	}
	public void setRemoveCrseList(List<RecipeCrse> removeCrseList) {
		this.removeCrseList = removeCrseList;
	}
	public List<RecipeCrse> getAddCrseList() {
		return addCrseList;
	}
	public void setAddCrseList(List<RecipeCrse> addCrseList) {
		this.addCrseList = addCrseList;
	}
	public List<RecipeCrse> getCurrentCrseList() {
		return currentCrseList;
	}
	public void setCurrentCrseList(List<RecipeCrse> currentCrseList) {
		this.currentCrseList = currentCrseList;
	}
	
	
	
	
	
}

