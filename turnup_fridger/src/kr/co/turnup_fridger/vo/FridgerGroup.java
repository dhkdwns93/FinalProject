package kr.co.turnup_fridger.vo;

import java.io.Serializable;

public class FridgerGroup implements Serializable{
	private int groupKey;
	private int groupJoinSeq;
	private String memberId;
	private int fridgerId;
	private Fridger fridger;
	private Member member;
	
	public FridgerGroup() {
	}


	public FridgerGroup(int groupKey, int groupJoinSeq, String memberId, int fridgerId) {
		this.groupKey = groupKey;
		this.groupJoinSeq = groupJoinSeq;
		this.memberId = memberId;
		this.fridgerId = fridgerId;
	}
	
	


	public FridgerGroup(int groupKey, int groupJoinSeq, String memberId, int fridgerId, Fridger fridger) {
		this.groupKey = groupKey;
		this.groupJoinSeq = groupJoinSeq;
		this.memberId = memberId;
		this.fridgerId = fridgerId;
		this.fridger = fridger;
	}
	
	
	

	public FridgerGroup(int groupKey, int groupJoinSeq, String memberId, int fridgerId, Member member) {
		this.groupKey = groupKey;
		this.groupJoinSeq = groupJoinSeq;
		this.memberId = memberId;
		this.fridgerId = fridgerId;
		this.member = member;
	}


	public FridgerGroup(int groupKey, int groupJoinSeq, String memberId, int fridgerId, Fridger fridger, Member member) {
		this.groupKey = groupKey;
		this.groupJoinSeq = groupJoinSeq;
		this.memberId = memberId;
		this.fridgerId = fridgerId;
		this.fridger = fridger;
		this.member = member;
	}


	public int getGroupKey() {
		return groupKey;
	}


	public void setGroupKey(int groupKey) {
		this.groupKey = groupKey;
	}


	public int getGroupJoinSeq() {
		return groupJoinSeq;
	}


	public void setGroupJoinSeq(int groupJoinSeq) {
		this.groupJoinSeq = groupJoinSeq;
	}


	public String getMemberId() {
		return memberId;
	}


	public void setMemberId(String memberId) {
		this.memberId = memberId;
	}


	public int getFridgerId() {
		return fridgerId;
	}


	public void setFridgerId(int fridgerId) {
		this.fridgerId = fridgerId;
	}
	

	public Fridger getfridger() {
		return fridger;
	}


	public void setfridger(Fridger fridger) {
		this.fridger = fridger;
	}
	

	public Member getMember() {
		return member;
	}


	public void setMember(Member member) {
		this.member = member;
	}
	
	
	


	@Override
	public int hashCode() {
		final int prime = 31;
		int result = 1;
		result = prime * result + fridgerId;
		result = prime * result + groupJoinSeq;
		result = prime * result + groupKey;
		result = prime * result + ((memberId == null) ? 0 : memberId.hashCode());
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
		FridgerGroup other = (FridgerGroup) obj;
		if (fridgerId != other.fridgerId)
			return false;
		if (groupJoinSeq != other.groupJoinSeq)
			return false;
		if (groupKey != other.groupKey)
			return false;
		if (memberId == null) {
			if (other.memberId != null)
				return false;
		} else if (!memberId.equals(other.memberId))
			return false;
		return true;
	}




	

	@Override
	public String toString() {
		return "FridgerGroup [groupKey=" + groupKey + ", groupJoinSeq=" + groupJoinSeq + ", memberId=" + memberId
				+ ", fridgerId=" + fridgerId + "]";
	}


	
}
