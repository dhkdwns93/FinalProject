package kr.co.turnup_fridger.vo;

import java.io.Serializable;
import java.util.Date;

import javax.servlet.annotation.MultipartConfig;

import org.springframework.web.multipart.MultipartFile;

import com.fasterxml.jackson.databind.annotation.JsonSerialize;

import kr.co.turnup_fridger.util.DateJSONSerializer;

public class BoardReview implements Serializable{
	
	private int boardReviewId;
	private String boardReviewTitle;
	private String boardReviewTxt;
	@JsonSerialize(using=DateJSONSerializer.class)
	private Date boardReviewDate;
	private String imageName;
	private String imageSaveName;
	private int boardReviewStar;
	private String recipeName;
	
	private MultipartFile upImage;
	
	private String memberId;
	private Member member;
	
	private int recipeId;
	private RecipeInfo recipeInfo;
	
	public BoardReview(){}

	public BoardReview(int boardReviewId, String boardReviewTitle, String boardReviewTxt, Date boardReviewDate,
			String imageName, String imageSaveName, int boardReviewStar, String recipeName, MultipartFile upImage,
			String memberId, int recipeId) {
		super();
		this.boardReviewId = boardReviewId;
		this.boardReviewTitle = boardReviewTitle;
		this.boardReviewTxt = boardReviewTxt;
		this.boardReviewDate = boardReviewDate;
		this.imageName = imageName;
		this.imageSaveName = imageSaveName;
		this.boardReviewStar = boardReviewStar;
		this.recipeName = recipeName;
		this.upImage = upImage;
		this.memberId = memberId;
		this.recipeId = recipeId;
	}

	public int getBoardReviewId() {
		return boardReviewId;
	}

	public void setBoardReviewId(int boardReviewId) {
		this.boardReviewId = boardReviewId;
	}

	public String getBoardReviewTitle() {
		return boardReviewTitle;
	}

	public void setBoardReviewTitle(String boardReviewTitle) {
		this.boardReviewTitle = boardReviewTitle;
	}

	public String getBoardReviewTxt() {
		return boardReviewTxt;
	}

	public void setBoardReviewTxt(String boardReviewTxt) {
		this.boardReviewTxt = boardReviewTxt;
	}

	public Date getBoardReviewDate() {
		return boardReviewDate;
	}

	public void setBoardReviewDate(Date boardReviewDate) {
		this.boardReviewDate = boardReviewDate;
	}

	public String getImageName() {
		return imageName;
	}

	public void setImageName(String imageName) {
		this.imageName = imageName;
	}

	public String getImageSaveName() {
		return imageSaveName;
	}

	public void setImageSaveName(String imageSaveName) {
		this.imageSaveName = imageSaveName;
	}

	public int getBoardReviewStar() {
		return boardReviewStar;
	}

	public void setBoardReviewStar(int boardReviewStar) {
		this.boardReviewStar = boardReviewStar;
	}

	public String getRecipeName() {
		return recipeName;
	}

	public void setRecipeName(String recipeName) {
		this.recipeName = recipeName;
	}

	public MultipartFile getUpImage() {
		return upImage;
	}

	public void setUpImage(MultipartFile upImage) {
		this.upImage = upImage;
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

	public int getRecipeId() {
		return recipeId;
	}

	public void setRecipeId(int recipeId) {
		this.recipeId = recipeId;
	}

	public RecipeInfo getRecipeInfo() {
		return recipeInfo;
	}

	public void setRecipeInfo(RecipeInfo recipeInfo) {
		this.recipeInfo = recipeInfo;
	}

	@Override
	public String toString() {
		return "BoardReview [boardReviewId=" + boardReviewId + ", boardReviewTitle=" + boardReviewTitle
				+ ", boardReviewTxt=" + boardReviewTxt + ", boardReviewDate=" + boardReviewDate + ", imageName="
				+ imageName + ", imageSaveName=" + imageSaveName + ", boardReviewStar=" + boardReviewStar
				+ ", recipeName=" + recipeName + ", upImage=" + upImage + ", memberId=" + memberId + ", member="
				+ member + ", recipeId=" + recipeId + ", recipeInfo=" + recipeInfo + "]";
	}

	@Override
	public int hashCode() {
		final int prime = 31;
		int result = 1;
		result = prime * result + ((boardReviewDate == null) ? 0 : boardReviewDate.hashCode());
		result = prime * result + boardReviewId;
		result = prime * result + boardReviewStar;
		result = prime * result + ((boardReviewTitle == null) ? 0 : boardReviewTitle.hashCode());
		result = prime * result + ((boardReviewTxt == null) ? 0 : boardReviewTxt.hashCode());
		result = prime * result + ((imageName == null) ? 0 : imageName.hashCode());
		result = prime * result + ((imageSaveName == null) ? 0 : imageSaveName.hashCode());
		result = prime * result + ((member == null) ? 0 : member.hashCode());
		result = prime * result + ((memberId == null) ? 0 : memberId.hashCode());
		result = prime * result + recipeId;
		result = prime * result + ((recipeInfo == null) ? 0 : recipeInfo.hashCode());
		result = prime * result + ((recipeName == null) ? 0 : recipeName.hashCode());
		result = prime * result + ((upImage == null) ? 0 : upImage.hashCode());
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
		BoardReview other = (BoardReview) obj;
		if (boardReviewDate == null) {
			if (other.boardReviewDate != null)
				return false;
		} else if (!boardReviewDate.equals(other.boardReviewDate))
			return false;
		if (boardReviewId != other.boardReviewId)
			return false;
		if (boardReviewStar != other.boardReviewStar)
			return false;
		if (boardReviewTitle == null) {
			if (other.boardReviewTitle != null)
				return false;
		} else if (!boardReviewTitle.equals(other.boardReviewTitle))
			return false;
		if (boardReviewTxt == null) {
			if (other.boardReviewTxt != null)
				return false;
		} else if (!boardReviewTxt.equals(other.boardReviewTxt))
			return false;
		if (imageName == null) {
			if (other.imageName != null)
				return false;
		} else if (!imageName.equals(other.imageName))
			return false;
		if (imageSaveName == null) {
			if (other.imageSaveName != null)
				return false;
		} else if (!imageSaveName.equals(other.imageSaveName))
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
		if (recipeInfo == null) {
			if (other.recipeInfo != null)
				return false;
		} else if (!recipeInfo.equals(other.recipeInfo))
			return false;
		if (recipeName == null) {
			if (other.recipeName != null)
				return false;
		} else if (!recipeName.equals(other.recipeName))
			return false;
		if (upImage == null) {
			if (other.upImage != null)
				return false;
		} else if (!upImage.equals(other.upImage))
			return false;
		return true;
	}
	
	

	
}
