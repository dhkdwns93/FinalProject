package kr.co.turnup_fridger.vo;

import java.io.Serializable;

public class RecipeIrdnt implements Serializable{

	private int irdntNo;
	private String irdntName;
	private String indntAmount;
	private int irdntTypeCode;
	private String irdntTyprName;
	private int recipeId;
	private int irdntId;
	private IrdntManage irdntManage;
	private RecipeInfo RecipeInfo;
	
	public RecipeIrdnt(){
		
	}

	public RecipeIrdnt(int irdntNo, String irdntName, String indntAmount, int irdntTypeCode, String irdntTyprName,
			int recipeId, int irdntId, IrdntManage irdntManage, kr.co.turnup_fridger.vo.RecipeInfo recipeInfo) {
		this.irdntNo = irdntNo;
		this.irdntName = irdntName;
		this.indntAmount = indntAmount;
		this.irdntTypeCode = irdntTypeCode;
		this.irdntTyprName = irdntTyprName;
		this.recipeId = recipeId;
		this.irdntId = irdntId;
		this.irdntManage = irdntManage;
		RecipeInfo = recipeInfo;
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

	public String getIndntAmount() {
		return indntAmount;
	}

	public void setIndntAmount(String indntAmount) {
		this.indntAmount = indntAmount;
	}

	public int getIrdntTypeCode() {
		return irdntTypeCode;
	}

	public void setIrdntTypeCode(int irdntTypeCode) {
		this.irdntTypeCode = irdntTypeCode;
	}

	public String getIrdntTyprName() {
		return irdntTyprName;
	}

	public void setIrdntTyprName(String irdntTyprName) {
		this.irdntTyprName = irdntTyprName;
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
		return "RecipeIrdnt [irdntNo=" + irdntNo + ", irdntName=" + irdntName + ", indntAmount=" + indntAmount
				+ ", irdntTypeCode=" + irdntTypeCode + ", irdntTyprName=" + irdntTyprName + ", recipeId=" + recipeId
				+ ", irdntId=" + irdntId + ", irdntManage=" + irdntManage + ", RecipeInfo=" + RecipeInfo + "]";
	}

	@Override
	public int hashCode() {
		final int prime = 31;
		int result = 1;
		result = prime * result + ((RecipeInfo == null) ? 0 : RecipeInfo.hashCode());
		result = prime * result + ((indntAmount == null) ? 0 : indntAmount.hashCode());
		result = prime * result + irdntId;
		result = prime * result + ((irdntManage == null) ? 0 : irdntManage.hashCode());
		result = prime * result + ((irdntName == null) ? 0 : irdntName.hashCode());
		result = prime * result + irdntNo;
		result = prime * result + irdntTypeCode;
		result = prime * result + ((irdntTyprName == null) ? 0 : irdntTyprName.hashCode());
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
		if (indntAmount == null) {
			if (other.indntAmount != null)
				return false;
		} else if (!indntAmount.equals(other.indntAmount))
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
		if (irdntTyprName == null) {
			if (other.irdntTyprName != null)
				return false;
		} else if (!irdntTyprName.equals(other.irdntTyprName))
			return false;
		if (recipeId != other.recipeId)
			return false;
		return true;
	}
	
	
}
