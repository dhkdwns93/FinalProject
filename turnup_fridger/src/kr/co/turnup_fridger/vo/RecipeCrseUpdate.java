package kr.co.turnup_fridger.vo;

import java.util.List;
import java.util.Map;

public class RecipeCrseUpdate {

	int recipeId;
	List<Map> removeCrseList;
	List<RecipeCrse> addCrseList;
	
	
	
	public int getRecipeId() {
		return recipeId;
	}
	public void setRecipeId(int recipeId) {
		this.recipeId = recipeId;
	}
	public List<Map> getRemoveCrseList() {
		return removeCrseList;
	}
	public void setRemoveCrseList(List<Map> removeCrseList) {
		this.removeCrseList = removeCrseList;
	}
	public List<RecipeCrse> getAddCrseList() {
		return addCrseList;
	}
	public void setAddCrseList(List<RecipeCrse> addCrseList) {
		this.addCrseList = addCrseList;
	}
	
	
	
	
	
}

