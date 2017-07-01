package kr.co.turnup_fridger.vo;

public class ShareRecipeIrdnt {
	private int irdntKey;
	private int recipeId;
	private int irdntId;
	
	private BoardShareRecipe boardShareRecipe;
	private IrdntManage irdntManage;
	
	public ShareRecipeIrdnt(){
		
	}

	public ShareRecipeIrdnt(int irdntKey, int recipeId, int irdntId, BoardShareRecipe boardShareRecipe,
			IrdntManage irdntManage) {
		super();
		this.irdntKey = irdntKey;
		this.recipeId = recipeId;
		this.irdntId = irdntId;
		this.boardShareRecipe = boardShareRecipe;
		this.irdntManage = irdntManage;
	}

	public int getIrdntKey() {
		return irdntKey;
	}

	public void setIrdntKey(int irdntKey) {
		this.irdntKey = irdntKey;
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

	public BoardShareRecipe getBoardShareRecipe() {
		return boardShareRecipe;
	}

	public void setBoardShareRecipe(BoardShareRecipe boardShareRecipe) {
		this.boardShareRecipe = boardShareRecipe;
	}

	public IrdntManage getIrdntManage() {
		return irdntManage;
	}

	public void setIrdntManage(IrdntManage irdntManage) {
		this.irdntManage = irdntManage;
	}

	@Override
	public int hashCode() {
		final int prime = 31;
		int result = 1;
		result = prime * result + ((boardShareRecipe == null) ? 0 : boardShareRecipe.hashCode());
		result = prime * result + irdntId;
		result = prime * result + irdntKey;
		result = prime * result + ((irdntManage == null) ? 0 : irdntManage.hashCode());
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
		ShareRecipeIrdnt other = (ShareRecipeIrdnt) obj;
		if (boardShareRecipe == null) {
			if (other.boardShareRecipe != null)
				return false;
		} else if (!boardShareRecipe.equals(other.boardShareRecipe))
			return false;
		if (irdntId != other.irdntId)
			return false;
		if (irdntKey != other.irdntKey)
			return false;
		if (irdntManage == null) {
			if (other.irdntManage != null)
				return false;
		} else if (!irdntManage.equals(other.irdntManage))
			return false;
		if (recipeId != other.recipeId)
			return false;
		return true;
	}

	@Override
	public String toString() {
		return "ShareRecipeIrdnt [irdntKey=" + irdntKey + ", recipeId=" + recipeId + ", irdntId=" + irdntId
				+ ", boardShareRecipe=" + boardShareRecipe + ", irdntManage=" + irdntManage + "]";
	}
	
	
}
