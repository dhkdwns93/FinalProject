package kr.co.turnup_fridger.vo;

import java.util.List;

public class MemberRecipeRecommand {
	private int recommandKey;
	private int recipeId;
	private String memberId;
	
	private Member member;
	private BoardShareRecipe boardShareRecipe;
	
	public MemberRecipeRecommand(){
		
	}
	

	public MemberRecipeRecommand(int recommandKey, int recipeId, String memberId) {
		super();
		this.recommandKey = recommandKey;
		this.recipeId = recipeId;
		this.memberId = memberId;
	}
	

	public MemberRecipeRecommand(int recommandKey, int recipeId, String memberId, Member member,
			BoardShareRecipe boardShareRecipe) {
		super();
		this.recommandKey = recommandKey;
		this.recipeId = recipeId;
		this.memberId = memberId;
		this.member = member;
		this.boardShareRecipe = boardShareRecipe;
	}

	public int getRecommandKey() {
		return recommandKey;
	}

	public void setRecommandKey(int recommandKey) {
		this.recommandKey = recommandKey;
	}

	public int getRecipeId() {
		return recipeId;
	}

	public void setRecipeId(int recipeId) {
		this.recipeId = recipeId;
	}

	public String getMemberId() {
		return memberId;
	}

	public void setMemberId(String memberId) {
		this.memberId = memberId;
	}

	public Member getMember() {
		return member;
	}

	public void setMember(Member member) {
		this.member = member;
	}

	public BoardShareRecipe getBoardShareRecipe() {
		return boardShareRecipe;
	}

	public void setBoardShareRecipe(BoardShareRecipe boardShareRecipe) {
		this.boardShareRecipe = boardShareRecipe;
	}

	@Override
	public int hashCode() {
		final int prime = 31;
		int result = 1;
		result = prime * result + ((boardShareRecipe == null) ? 0 : boardShareRecipe.hashCode());
		result = prime * result + ((member == null) ? 0 : member.hashCode());
		result = prime * result + ((memberId == null) ? 0 : memberId.hashCode());
		result = prime * result + recipeId;
		result = prime * result + recommandKey;
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
		MemberRecipeRecommand other = (MemberRecipeRecommand) obj;
		if (boardShareRecipe == null) {
			if (other.boardShareRecipe != null)
				return false;
		} else if (!boardShareRecipe.equals(other.boardShareRecipe))
			return false;
		if (member == null) {
			if (other.member != null)
				return false;
		} else if (!member.equals(other.member))
			return false;
		if (memberId == null) {
			if (other.memberId != null)
				return false;
		} else if (!memberId.equals(other.memberId))
			return false;
		if (recipeId != other.recipeId)
			return false;
		if (recommandKey != other.recommandKey)
			return false;
		return true;
	}

	@Override
	public String toString() {
		return "MemberRcipeRecommand [recommandKey=" + recommandKey + ", recipeId=" + recipeId + ", memberId="
				+ memberId + ", member=" + member + ", boardShareRecipe=" + boardShareRecipe + "]";
	}
	
	
	
}
