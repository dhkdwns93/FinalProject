package kr.co.turnup_fridger.vo;

import java.io.Serializable;
import java.util.List;

public class Fridger implements Serializable{
	
	
	private int fridgerId;
	private String fridgerName;
	private String memberId;
	private List<FridgerGroup> fridgerGroupList;
	private List<MyIrdnt> myIrdntList;
	
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
	@Override
	public String toString() {
		return "Fridger [fridgerId=" + fridgerId + ", fridgerName=" + fridgerName + ", memberId=" + memberId
				+ ", fridgerGroupList=" + fridgerGroupList + ", myIrdntList=" + myIrdntList + "]";
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
