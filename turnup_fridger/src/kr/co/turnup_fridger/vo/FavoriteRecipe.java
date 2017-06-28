package kr.co.turnup_fridger.vo;

import java.io.Serializable;

public class FavoriteRecipe implements Serializable{
	private int favoriteRecipeKey;
	private String memberId;
	private int recipeId;
	
	private Member member;
	private RecipeInfo recipeInfo;
	
	public FavoriteRecipe() {
	}

	public FavoriteRecipe(int favoriteRecipeKey, String memberId, int recipeId) {
		this.favoriteRecipeKey = favoriteRecipeKey;
		this.memberId = memberId;
		this.recipeId = recipeId;
	}

	public FavoriteRecipe(int favoriteRecipeKey, String memberId, int recipeId, Member member) {
		this.favoriteRecipeKey = favoriteRecipeKey;
		this.memberId = memberId;
		this.recipeId = recipeId;
		this.member = member;
	}

	public FavoriteRecipe(int favoriteRecipeKey, String memberId, int recipeId, RecipeInfo recipeInfo) {
		this.favoriteRecipeKey = favoriteRecipeKey;
		this.memberId = memberId;
		this.recipeId = recipeId;
		this.recipeInfo = recipeInfo;
	}

	public FavoriteRecipe(int favoriteRecipeKey, String memberId, int recipeId, Member member,
			RecipeInfo recipeInfo) {
		this.favoriteRecipeKey = favoriteRecipeKey;
		this.memberId = memberId;
		this.recipeId = recipeId;
		this.member = member;
		this.recipeInfo = recipeInfo;
	}

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

	public Member getMember() {
		return member;
	}

	public void setMember(Member member) {
		this.member = member;
	}

	public RecipeInfo getRecipeInfo() {
		return recipeInfo;
	}

	public void setRecipeInfo(RecipeInfo recipeInfo) {
		this.recipeInfo = recipeInfo;
	}

	@Override
	public int hashCode() {
		final int prime = 31;
		int result = 1;
		result = prime * result + favoriteRecipeKey;
		result = prime * result + ((memberId == null) ? 0 : memberId.hashCode());
		result = prime * result + recipeId;
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
		FavoriteRecipe other = (FavoriteRecipe) obj;
		if (favoriteRecipeKey != other.favoriteRecipeKey)
			return false;
		if (memberId == null) {
			if (other.memberId != null)
				return false;
		} else if (!memberId.equals(other.memberId))
			return false;
		if (recipeId != other.recipeId)
			return false;
		return true;
	}

	@Override
	public String toString() {
		return "FavoriteRecipe [favoriteRecipeKey=" + favoriteRecipeKey + ", memberId=" + memberId + ", recipeId="
				+ recipeId + ", member=" + member + ", recipeInfo=" + recipeInfo + "]";
	}
	
	
	
	
	
}
