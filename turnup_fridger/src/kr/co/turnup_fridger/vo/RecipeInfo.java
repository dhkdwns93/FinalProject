package kr.co.turnup_fridger.vo;

import java.io.Serializable;
import java.util.List;

public class RecipeInfo implements Serializable{

	private int recipeId;
	private String recipeName;
	private String sumry;
	private int categoryCode;
	private String categoryName;
	private int typeCode;
	private String typeName;
	private String cookingTime;
	private String calorie;
	private String Qnt;
	private String recipeLevel;
	private String irdntCode;
	private String price;
	private String imgUrl;
	private String detUrl;
	private int recipeHits;
	private List<RecipeIrdnt> recipeIrdnt;
	private List<RecipeCrse> recipeCrse;
 	
	public RecipeInfo(){
		
	}

	public RecipeInfo(int recipeId, String recipeName, String sumry, int categoryCode, String categoryName,
			int typeCode, String typeName, String cookingTime, String calorie, String qnt, String recipeLevel,
			String irdntCode, String price, String imgUrl, String detUrl, int recipeHits,
			List<RecipeIrdnt> recipeIrdnt, List<RecipeCrse> recipeCrse) {
		this.recipeId = recipeId;
		this.recipeName = recipeName;
		this.sumry = sumry;
		this.categoryCode = categoryCode;
		this.categoryName = categoryName;
		this.typeCode = typeCode;
		this.typeName = typeName;
		this.cookingTime = cookingTime;
		this.calorie = calorie;
		Qnt = qnt;
		this.recipeLevel = recipeLevel;
		this.irdntCode = irdntCode;
		this.price = price;
		this.imgUrl = imgUrl;
		this.detUrl = detUrl;
		this.recipeHits = recipeHits;
		this.recipeIrdnt = recipeIrdnt;
		this.recipeCrse = recipeCrse;
	}

	public int getRecipeId() {
		return recipeId;
	}

	public void setRecipeId(int recipeId) {
		this.recipeId = recipeId;
	}

	public String getRecipeName() {
		return recipeName;
	}

	public void setRecipeName(String recipeName) {
		this.recipeName = recipeName;
	}

	public String getSumry() {
		return sumry;
	}

	public void setSumry(String sumry) {
		this.sumry = sumry;
	}

	public int getCategoryCode() {
		return categoryCode;
	}

	public void setCategoryCode(int categoryCode) {
		this.categoryCode = categoryCode;
	}

	public String getCategoryName() {
		return categoryName;
	}

	public void setCategoryName(String categoryName) {
		this.categoryName = categoryName;
	}

	public int getTypeCode() {
		return typeCode;
	}

	public void setTypeCode(int typeCode) {
		this.typeCode = typeCode;
	}

	public String getTypeName() {
		return typeName;
	}

	public void setTypeName(String typeName) {
		this.typeName = typeName;
	}

	public String getCookingTime() {
		return cookingTime;
	}

	public void setCookingTime(String cookingTime) {
		this.cookingTime = cookingTime;
	}

	public String getCalorie() {
		return calorie;
	}

	public void setCalorie(String calorie) {
		this.calorie = calorie;
	}

	public String getQnt() {
		return Qnt;
	}

	public void setQnt(String qnt) {
		Qnt = qnt;
	}

	public String getRecipeLevel() {
		return recipeLevel;
	}

	public void setRecipeLevel(String recipeLevel) {
		this.recipeLevel = recipeLevel;
	}

	public String getIrdntCode() {
		return irdntCode;
	}

	public void setIrdntCode(String irdntCode) {
		this.irdntCode = irdntCode;
	}

	public String getPrice() {
		return price;
	}

	public void setPrice(String price) {
		this.price = price;
	}

	public String getImgUrl() {
		return imgUrl;
	}

	public void setImgUrl(String imgUrl) {
		this.imgUrl = imgUrl;
	}

	public String getDetUrl() {
		return detUrl;
	}

	public void setDetUrl(String detUrl) {
		this.detUrl = detUrl;
	}

	public int getRecipeHits() {
		return recipeHits;
	}

	public void setRecipeHits(int recipeHits) {
		this.recipeHits = recipeHits;
	}

	public List<RecipeIrdnt> getrecipeIrdnt() {
		return recipeIrdnt;
	}

	public void setrecipeIrdnt(List<RecipeIrdnt> recipeIrdnt) {
		this.recipeIrdnt = recipeIrdnt;
	}

	public List<RecipeCrse> getrecipeCrse() {
		return recipeCrse;
	}

	public void setrecipeCrse(List<RecipeCrse> recipeCrse) {
		this.recipeCrse = recipeCrse;
	}

	@Override
	public String toString() {
		return "RecipeInfo [recipeId=" + recipeId + ", recipeName=" + recipeName + ", sumry=" + sumry
				+ ", categoryCode=" + categoryCode + ", categoryName=" + categoryName + ", typeCode=" + typeCode
				+ ", typeName=" + typeName + ", cookingTime=" + cookingTime + ", calorie=" + calorie + ", Qnt=" + Qnt
				+ ", recipeLevel=" + recipeLevel + ", irdntCode=" + irdntCode + ", price=" + price + ", imgUrl="
				+ imgUrl + ", detUrl=" + detUrl + ", recipeHits=" + recipeHits + ", recipeIrdnt=" + recipeIrdnt
				+ ", recipeCrse=" + recipeCrse + "]";
	}

	@Override
	public int hashCode() {
		final int prime = 31;
		int result = 1;
		result = prime * result + ((Qnt == null) ? 0 : Qnt.hashCode());
		result = prime * result + ((calorie == null) ? 0 : calorie.hashCode());
		result = prime * result + categoryCode;
		result = prime * result + ((categoryName == null) ? 0 : categoryName.hashCode());
		result = prime * result + ((cookingTime == null) ? 0 : cookingTime.hashCode());
		result = prime * result + ((detUrl == null) ? 0 : detUrl.hashCode());
		result = prime * result + ((imgUrl == null) ? 0 : imgUrl.hashCode());
		result = prime * result + ((irdntCode == null) ? 0 : irdntCode.hashCode());
		result = prime * result + ((price == null) ? 0 : price.hashCode());
		result = prime * result + ((recipeCrse == null) ? 0 : recipeCrse.hashCode());
		result = prime * result + recipeHits;
		result = prime * result + recipeId;
		result = prime * result + ((recipeIrdnt == null) ? 0 : recipeIrdnt.hashCode());
		result = prime * result + ((recipeLevel == null) ? 0 : recipeLevel.hashCode());
		result = prime * result + ((recipeName == null) ? 0 : recipeName.hashCode());
		result = prime * result + ((sumry == null) ? 0 : sumry.hashCode());
		result = prime * result + typeCode;
		result = prime * result + ((typeName == null) ? 0 : typeName.hashCode());
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
		RecipeInfo other = (RecipeInfo) obj;
		if (Qnt == null) {
			if (other.Qnt != null)
				return false;
		} else if (!Qnt.equals(other.Qnt))
			return false;
		if (calorie == null) {
			if (other.calorie != null)
				return false;
		} else if (!calorie.equals(other.calorie))
			return false;
		if (categoryCode != other.categoryCode)
			return false;
		if (categoryName == null) {
			if (other.categoryName != null)
				return false;
		} else if (!categoryName.equals(other.categoryName))
			return false;
		if (cookingTime == null) {
			if (other.cookingTime != null)
				return false;
		} else if (!cookingTime.equals(other.cookingTime))
			return false;
		if (detUrl == null) {
			if (other.detUrl != null)
				return false;
		} else if (!detUrl.equals(other.detUrl))
			return false;
		if (imgUrl == null) {
			if (other.imgUrl != null)
				return false;
		} else if (!imgUrl.equals(other.imgUrl))
			return false;
		if (irdntCode == null) {
			if (other.irdntCode != null)
				return false;
		} else if (!irdntCode.equals(other.irdntCode))
			return false;
		if (price == null) {
			if (other.price != null)
				return false;
		} else if (!price.equals(other.price))
			return false;
		if (recipeCrse == null) {
			if (other.recipeCrse != null)
				return false;
		} else if (!recipeCrse.equals(other.recipeCrse))
			return false;
		if (recipeHits != other.recipeHits)
			return false;
		if (recipeId != other.recipeId)
			return false;
		if (recipeIrdnt == null) {
			if (other.recipeIrdnt != null)
				return false;
		} else if (!recipeIrdnt.equals(other.recipeIrdnt))
			return false;
		if (recipeLevel == null) {
			if (other.recipeLevel != null)
				return false;
		} else if (!recipeLevel.equals(other.recipeLevel))
			return false;
		if (recipeName == null) {
			if (other.recipeName != null)
				return false;
		} else if (!recipeName.equals(other.recipeName))
			return false;
		if (sumry == null) {
			if (other.sumry != null)
				return false;
		} else if (!sumry.equals(other.sumry))
			return false;
		if (typeCode != other.typeCode)
			return false;
		if (typeName == null) {
			if (other.typeName != null)
				return false;
		} else if (!typeName.equals(other.typeName))
			return false;
		return true;
	}
	
	
}
