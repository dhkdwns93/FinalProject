package kr.co.turnup_fridger.vo;

import java.io.Serializable;
import java.util.List;

import org.springframework.web.multipart.MultipartFile;

public class Fridger implements Serializable{
	
	
	private int fridgerId;
	private String fridgerName;
	private String memberId;
	
	private String fridgerImg;
	private MultipartFile fridgerImgSrc;
	
	private List<FridgerGroup> fridgerGroupList;
	private List<MyIrdnt> myIrdntList;
	
	private String resultCode;
	
	public Fridger() {
	}
	
	
	
	public Fridger(String fridgerName, String memberId) {
		this.fridgerName = fridgerName;
		this.memberId = memberId;
	}



	public Fridger(int fridgerId, String fridgerName, String memberId) {
		this.fridgerId = fridgerId;
		this.fridgerName = fridgerName;
		this.memberId = memberId;
	}
	
	

	public Fridger(int fridgerId, String fridgerName, String memberId, String fridgerImg) {
		this.fridgerId = fridgerId;
		this.fridgerName = fridgerName;
		this.memberId = memberId;
		this.fridgerImg = fridgerImg;
	}



	public Fridger(int fridgerId, String fridgerName, String memberId, List<FridgerGroup> fridgerGroupList) {
		this.fridgerId = fridgerId;
		this.fridgerName = fridgerName;
		this.memberId = memberId;
		this.fridgerGroupList = fridgerGroupList;
	}

	public Fridger(int fridgerId, String fridgerName, String memberId, List<FridgerGroup> fridgerGroupList,
			List<MyIrdnt> myIrdntList) {
		this.fridgerId = fridgerId;
		this.fridgerName = fridgerName;
		this.memberId = memberId;
		this.fridgerGroupList = fridgerGroupList;
		this.myIrdntList = myIrdntList;
	}
	
	
	public String getResultCode() {
		return resultCode;
	}



	public void setResultCode(String resultCode) {
		this.resultCode = resultCode;
	}

	
	


	public MultipartFile getFridgerImgSrc() {
		return fridgerImgSrc;
	}



	public void setFridgerImgSrc(MultipartFile fridgerImgSrc) {
		this.fridgerImgSrc = fridgerImgSrc;
	}


	public int getFridgerId() {
		return fridgerId;
	}
	public void setFridgerId(int fridgerId) {
		this.fridgerId = fridgerId;
	}
	public String getFridgerName() {
		return fridgerName;
	}
	public void setFridgerName(String fridgerName) {
		this.fridgerName = fridgerName;
	}
	public String getMemberId() {
		return memberId;
	}
	public void setMemberId(String memberId) {
		this.memberId = memberId;
	}
	public List<FridgerGroup> getFridgerGroupList() {
		return fridgerGroupList;
	}
	public void setFridgerGroupList(List<FridgerGroup> fridgerGroupList) {
		this.fridgerGroupList = fridgerGroupList;
	}
	public List<MyIrdnt> getMyIrdntList() {
		return myIrdntList;
	}
	public void setMyIrdntList(List<MyIrdnt> myIrdntList) {
		this.myIrdntList = myIrdntList;
	}
		
	public String getFridgerImg() {
		return fridgerImg;
	}

	public void setFridgerImg(String fridgerImg) {
		this.fridgerImg = fridgerImg;
	}



	@Override
	public String toString() {
		return "Fridger [fridgerId=" + fridgerId + ", fridgerName=" + fridgerName + ", memberId=" + memberId
				+ ", fridgerImg=" + fridgerImg + ", fridgerGroupList=" + fridgerGroupList + ", myIrdntList="
				+ myIrdntList + ", resultCode=" + resultCode + "]";
	}
	
	
	@Override
	public int hashCode() {
		final int prime = 31;
		int result = 1;
		result = prime * result + ((fridgerGroupList == null) ? 0 : fridgerGroupList.hashCode());
		result = prime * result + fridgerId;
		result = prime * result + ((fridgerName == null) ? 0 : fridgerName.hashCode());
		result = prime * result + ((memberId == null) ? 0 : memberId.hashCode());
		result = prime * result + ((myIrdntList == null) ? 0 : myIrdntList.hashCode());
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
		Fridger other = (Fridger) obj;
		if (fridgerGroupList == null) {
			if (other.fridgerGroupList != null)
				return false;
		} else if (!fridgerGroupList.equals(other.fridgerGroupList))
			return false;
		if (fridgerId != other.fridgerId)
			return false;
		if (fridgerName == null) {
			if (other.fridgerName != null)
				return false;
		} else if (!fridgerName.equals(other.fridgerName))
			return false;
		if (memberId == null) {
			if (other.memberId != null)
				return false;
		} else if (!memberId.equals(other.memberId))
			return false;
		if (myIrdntList == null) {
			if (other.myIrdntList != null)
				return false;
		} else if (!myIrdntList.equals(other.myIrdntList))
			return false;
		return true;
	}
	
}
