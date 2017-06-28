package kr.co.turnup_fridger.vo;

import java.io.Serializable;

public class MyDislikeIrdnt implements Serializable{
	private int myDislikeIrdntKey;
	private int irdntId;
	private String memberId;
	private Member member;
	
	
	public MyDislikeIrdnt() {
	}
	


	public MyDislikeIrdnt(int myDislikeIrdntsKey, int irdntId, String memberId) {
		this.myDislikeIrdntKey = myDislikeIrdntsKey;
		this.irdntId = irdntId;
		this.memberId = memberId;
	}



	public MyDislikeIrdnt(int myDislikeIrdntsKey, int irdntId, String memberId, Member member) {
		this.myDislikeIrdntKey = myDislikeIrdntsKey;
		this.irdntId = irdntId;
		this.memberId = memberId;
		this.member = member;
	}



	public int getMyDislikeIrdntsKey() {
		return myDislikeIrdntKey;
	}



	public void setMyDislikeIrdntsKey(int myDislikeIrdntsKey) {
		this.myDislikeIrdntKey = myDislikeIrdntsKey;
	}



	public int getIrdntId() {
		return irdntId;
	}



	public void setIrdntId(int irdntId) {
		this.irdntId = irdntId;
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



	@Override
	public int hashCode() {
		final int prime = 31;
		int result = 1;
		result = prime * result + irdntId;
		result = prime * result + ((memberId == null) ? 0 : memberId.hashCode());
		result = prime * result + myDislikeIrdntKey;
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
		MyDislikeIrdnt other = (MyDislikeIrdnt) obj;
		if (irdntId != other.irdntId)
			return false;
		if (memberId == null) {
			if (other.memberId != null)
				return false;
		} else if (!memberId.equals(other.memberId))
			return false;
		if (myDislikeIrdntKey != other.myDislikeIrdntKey)
			return false;
		return true;
	}



	@Override
	public String toString() {
		return "MyDislikeIrdnt [myDislikeIrdntKey=" + myDislikeIrdntKey + ", irdntId=" + irdntId + ", memberId="
				+ memberId + ", member=" + member + "]";
	}
	
	
	
	
	
}
