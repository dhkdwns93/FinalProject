package kr.co.turnup_fridger.vo;

import java.io.Serializable;

import org.hibernate.validator.constraints.NotEmpty;
import org.hibernate.validator.constraints.Range;

public class IrdntManage implements Serializable{

	private int irdntId;
	private String irdntName;
	private String irdntCategory;
	private int roomTemPeriod;
	private int coldTemPeriod;
	private int freezeTemPeriod;
	
	private MyIrdnt myIrdnt;
	private ShareRecipeIrdnt shareRecipeIrdnt;
	private MyDislikeIrdnt myDislikeIrdnt;
	private RecipeIrdnt RecipeIrdnt;
	
	public IrdntManage(){
		
	}

	public IrdntManage(int irdntId, String irdntName, String irdntCategory, int roomTemPeriod, int coldTemPeriod,
			int freezeTemPeriod) {
		this.irdntId = irdntId;
		this.irdntName = irdntName;
		this.irdntCategory = irdntCategory;
		this.roomTemPeriod = roomTemPeriod;
		this.coldTemPeriod = coldTemPeriod;
		this.freezeTemPeriod = freezeTemPeriod;
	}

	public IrdntManage(int irdntId, String irdntName, String irdntCategory, int roomTemPeriod, int coldTemPeriod,
			int freezeTemPeriod, MyIrdnt myIrdnt, ShareRecipeIrdnt shareRecipeIrdnt, MyDislikeIrdnt myDislikeIrdnt,
			kr.co.turnup_fridger.vo.RecipeIrdnt recipeIrdnt) {
		this.irdntId = irdntId;
		this.irdntName = irdntName;
		this.irdntCategory = irdntCategory;
		this.roomTemPeriod = roomTemPeriod;
		this.coldTemPeriod = coldTemPeriod;
		this.freezeTemPeriod = freezeTemPeriod;
		this.myIrdnt = myIrdnt;
		this.shareRecipeIrdnt = shareRecipeIrdnt;
		this.myDislikeIrdnt = myDislikeIrdnt;
		RecipeIrdnt = recipeIrdnt;
	}

	public int getIrdntId() {
		return irdntId;
	}

	public void setIrdntId(int irdntId) {
		this.irdntId = irdntId;
	}

	public String getIrdntName() {
		return irdntName;
	}

	public void setIrdntName(String irdntName) {
		this.irdntName = irdntName;
	}

	public String getIrdntCategory() {
		return irdntCategory;
	}

	public void setIrdntCategory(String irdntCategory) {
		this.irdntCategory = irdntCategory;
	}

	public int getRoomTemPeriod() {
		return roomTemPeriod;
	}

	public void setRoomTemPeriod(int roomTemPeriod) {
		this.roomTemPeriod = roomTemPeriod;
	}

	public int getColdTemPeriod() {
		return coldTemPeriod;
	}

	public void setColdTemPeriod(int coldTemPeriod) {
		this.coldTemPeriod = coldTemPeriod;
	}

	public int getFreezeTemPeriod() {
		return freezeTemPeriod;
	}

	public void setFreezeTemPeriod(int freezeTemPeriod) {
		this.freezeTemPeriod = freezeTemPeriod;
	}

	public MyIrdnt getMyIrdnt() {
		return myIrdnt;
	}

	public void setMyIrdnt(MyIrdnt myIrdnt) {
		this.myIrdnt = myIrdnt;
	}

	public ShareRecipeIrdnt getShareRecipeIrdnt() {
		return shareRecipeIrdnt;
	}

	public void setShareRecipeIrdnt(ShareRecipeIrdnt shareRecipeIrdnt) {
		this.shareRecipeIrdnt = shareRecipeIrdnt;
	}

	public MyDislikeIrdnt getMyDislikeIrdnt() {
		return myDislikeIrdnt;
	}

	public void setMyDislikeIrdnt(MyDislikeIrdnt myDislikeIrdnt) {
		this.myDislikeIrdnt = myDislikeIrdnt;
	}

	public RecipeIrdnt getRecipeIrdnt() {
		return RecipeIrdnt;
	}

	public void setRecipeIrdnt(RecipeIrdnt recipeIrdnt) {
		RecipeIrdnt = recipeIrdnt;
	}

	@Override
	public String toString() {
		return "IrdntManage [irdntId=" + irdntId + ", irdntName=" + irdntName + ", irdntCategory=" + irdntCategory
				+ ", roomTemPeriod=" + roomTemPeriod + ", coldTemPeriod=" + coldTemPeriod + ", freezeTemPeriod="
				+ freezeTemPeriod + ", myIrdnt=" + myIrdnt + ", shareRecipeIrdnt=" + shareRecipeIrdnt
				+ ", myDislikeIrdnt=" + myDislikeIrdnt + ", RecipeIrdnt=" + RecipeIrdnt + "]";
	}

	@Override
	public int hashCode() {
		final int prime = 31;
		int result = 1;
		result = prime * result + ((RecipeIrdnt == null) ? 0 : RecipeIrdnt.hashCode());
		result = prime * result + coldTemPeriod;
		result = prime * result + freezeTemPeriod;
		result = prime * result + ((irdntCategory == null) ? 0 : irdntCategory.hashCode());
		result = prime * result + irdntId;
		result = prime * result + ((irdntName == null) ? 0 : irdntName.hashCode());
		result = prime * result + ((myDislikeIrdnt == null) ? 0 : myDislikeIrdnt.hashCode());
		result = prime * result + ((myIrdnt == null) ? 0 : myIrdnt.hashCode());
		result = prime * result + roomTemPeriod;
		result = prime * result + ((shareRecipeIrdnt == null) ? 0 : shareRecipeIrdnt.hashCode());
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
		IrdntManage other = (IrdntManage) obj;
		if (RecipeIrdnt == null) {
			if (other.RecipeIrdnt != null)
				return false;
		} else if (!RecipeIrdnt.equals(other.RecipeIrdnt))
			return false;
		if (coldTemPeriod != other.coldTemPeriod)
			return false;
		if (freezeTemPeriod != other.freezeTemPeriod)
			return false;
		if (irdntCategory == null) {
			if (other.irdntCategory != null)
				return false;
		} else if (!irdntCategory.equals(other.irdntCategory))
			return false;
		if (irdntId != other.irdntId)
			return false;
		if (irdntName == null) {
			if (other.irdntName != null)
				return false;
		} else if (!irdntName.equals(other.irdntName))
			return false;
		if (myDislikeIrdnt == null) {
			if (other.myDislikeIrdnt != null)
				return false;
		} else if (!myDislikeIrdnt.equals(other.myDislikeIrdnt))
			return false;
		if (myIrdnt == null) {
			if (other.myIrdnt != null)
				return false;
		} else if (!myIrdnt.equals(other.myIrdnt))
			return false;
		if (roomTemPeriod != other.roomTemPeriod)
			return false;
		if (shareRecipeIrdnt == null) {
			if (other.shareRecipeIrdnt != null)
				return false;
		} else if (!shareRecipeIrdnt.equals(other.shareRecipeIrdnt))
			return false;
		return true;
	}
	
	

	
	
	


	
	
}
