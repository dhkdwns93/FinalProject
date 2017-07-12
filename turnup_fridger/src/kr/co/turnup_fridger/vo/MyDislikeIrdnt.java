/**
 (VO)MyDislikeIrdnt
작성자 :  박연수
최초 작성일 
변경이력 
170706 (경혜) myDislikeIrdntKey없는 생성자 생성-insert용
*/
package kr.co.turnup_fridger.vo;

import java.io.Serializable;

public class MyDislikeIrdnt implements Serializable{
	private int myDislikeIrdntKey;
	private String memberId;
	private int irdntId;
	private Member member;
	
	
	public MyDislikeIrdnt() {
	}
	
	//insert용
	public MyDislikeIrdnt(String memberId, int irdntId) {
		this.myDislikeIrdntKey=-1;
		this.memberId = memberId;
		this.irdntId = irdntId;
	}

	public MyDislikeIrdnt(int myDislikeIrdntKey, String memberId, int irdntId) {
		this.myDislikeIrdntKey = myDislikeIrdntKey;
		this.memberId = memberId;
		this.irdntId = irdntId;

	}

	public MyDislikeIrdnt(int myDislikeIrdntKey, String memberId, int irdntId, Member member) {
		this.myDislikeIrdntKey = myDislikeIrdntKey;
		this.memberId = memberId;
		this.irdntId = irdntId;
		this.member = member;

	}

	public int getMyDislikeIrdntKey() {
		return myDislikeIrdntKey;
	}

	public void setMyDislikeIrdntKey(int myDislikeIrdntKey) {
		this.myDislikeIrdntKey = myDislikeIrdntKey;
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
	public String toString() {
		return "MyDislikeIrdnt [myDislikeIrdntKey=" + myDislikeIrdntKey + ", memberId=" + memberId + ", irdntId="
				+ irdntId + ", member=" + member + "]";
	}

	@Override
	public int hashCode() {
		final int prime = 31;
		int result = 1;
		result = prime * result + irdntId;
		result = prime * result + ((member == null) ? 0 : member.hashCode());
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
		if (myDislikeIrdntKey != other.myDislikeIrdntKey)
			return false;
		return true;
	}




	
}
