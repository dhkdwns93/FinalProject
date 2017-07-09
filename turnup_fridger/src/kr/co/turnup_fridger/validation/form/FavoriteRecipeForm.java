package kr.co.turnup_fridger.validation.form;

import javax.validation.constraints.NotNull;

import org.hibernate.validator.constraints.NotEmpty;

public class FavoriteRecipeForm {

	//시퀀스
	private int favoriteRecipeKey;
	@NotEmpty(message="회원id는 필수입력사항입니다.")
	private String memberId;
	@NotNull(message="레시피코드는 필수입력사항입니다.")
	private int recipeId;
	public int getFavoriteRecipeKey() {
		return favoriteRecipeKey;
	}
	public void setFavoriteRecipeKey(int favoriteRecipeKey) {
		this.favoriteRecipeKey = favoriteRecipeKey;
	}
	public String getMemberId() {
		return memberId;
	}
	public void setMemberId(String memberId) {
		this.memberId = memberId;
	}
	public int getRecipeId() {
		return recipeId;
	}
	public void setRecipeId(int recipeId) {
		this.recipeId = recipeId;
	}
	
	
}
