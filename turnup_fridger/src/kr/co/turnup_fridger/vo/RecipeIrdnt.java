package kr.co.turnup_fridger.vo;

import java.io.Serializable;

public class RecipeIrdnt implements Serializable{

	private int irdntNo;
	private String irdntName;
	private String irdntAmount;
	private int irdntTypeCode;
	private String irdntTypeName;
	private int recipeId;
	private int irdntId;
	
	private IrdntManage irdntManage;
	private RecipeInfo RecipeInfo;
	
	public RecipeIrdnt(){
		
	}

	public RecipeIrdnt(int irdntNo, String irdntName, String irdntAmount, int irdntTypeCode, String irdntTypeName,
			int recipeId, int irdntId) {
		this.irdntNo = irdntNo;
		this.irdntName = irdntName;
		this.irdntAmount = irdntAmount;
		this.irdntTypeCode = irdntTypeCode;
		this.irdntTypeName = irdntTypeName;
		this.recipeId = recipeId;
		this.irdntId = irdntId;
	}

	public RecipeIrdnt(int irdntNo, String irdntName, String irdntAmount, int irdntTypeCode, String irdntTypeName,
			int recipeId, int irdntId, IrdntManage irdntManage,RecipeInfo recipeInfo) {
		this.irdntNo = irdntNo;
		this.irdntName = irdntName;
		this.irdntAmount = irdntAmount;
		this.irdntTypeCode = irdntTypeCode;
		this.irdntTypeName = irdntTypeName;
		this.recipeId = recipeId;
		this.irdntId = irdntId;
		this.irdntManage = irdntManage;
		RecipeInfo = recipeInfo;
	}

	
	
	public RecipeIrdnt(String irdntName, String irdntAmount, int irdntTypeCode, String irdntTypeName, int recipeId,
			int irdntId) {
		this.irdntName = irdntName;
		this.irdntAmount = irdntAmount;
		this.irdntTypeCode = irdntTypeCode;
		this.irdntTypeName = irdntTypeName;
		this.recipeId = recipeId;
		this.irdntId = irdntId;
	}

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

	public String getirdntAmount() {
		return irdntAmount;
	}

	public void setirdntAmount(String irdntAmount) {
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

	@Override
	public String toString() {
		return "RecipeIrdnt [irdntNo=" + irdntNo + ", irdntName=" + irdntName + ", irdntAmount=" + irdntAmount
				+ ", irdntTypeCode=" + irdntTypeCode + ", irdntTypeName=" + irdntTypeName + ", recipeId=" + recipeId
				+ ", irdntId=" + irdntId + ", irdntManage=" + irdntManage + ", RecipeInfo=" + RecipeInfo + "]";
	}

	@Override
	public int hashCode() {
		final int prime = 31;
		int result = 1;
		result = prime * result + ((RecipeInfo == null) ? 0 : RecipeInfo.hashCode());
		result = prime * result + ((irdntAmount == null) ? 0 : irdntAmount.hashCode());
		result = prime * result + irdntId;
		result = prime * result + ((irdntManage == null) ? 0 : irdntManage.hashCode());
		result = prime * result + ((irdntName == null) ? 0 : irdntName.hashCode());
		result = prime * result + irdntNo;
		result = prime * result + irdntTypeCode;
		result = prime * result + ((irdntTypeName == null) ? 0 : irdntTypeName.hashCode());
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
		RecipeIrdnt other = (RecipeIrdnt) obj;
		if (RecipeInfo == null) {
			if (other.RecipeInfo != null)
				return false;
		} else if (!RecipeInfo.equals(other.RecipeInfo))
			return false;
		if (irdntAmount == null) {
			if (other.irdntAmount != null)
				return false;
		} else if (!irdntAmount.equals(other.irdntAmount))
			return false;
		if (irdntId != other.irdntId)
			return false;
		if (irdntManage == null) {
			if (other.irdntManage != null)
				return false;
		} else if (!irdntManage.equals(other.irdntManage))
			return false;
		if (irdntName == null) {
			if (other.irdntName != null)
				return false;
		} else if (!irdntName.equals(other.irdntName))
			return false;
		if (irdntNo != other.irdntNo)
			return false;
		if (irdntTypeCode != other.irdntTypeCode)
			return false;
		if (irdntTypeName == null) {
			if (other.irdntTypeName != null)
				return false;
		} else if (!irdntTypeName.equals(other.irdntTypeName))
			return false;
		if (recipeId != other.recipeId)
			return false;
		return true;
	}
	
	
}
