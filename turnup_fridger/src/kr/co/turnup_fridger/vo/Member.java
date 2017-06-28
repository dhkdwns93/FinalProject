package kr.co.turnup_fridger.vo;

import java.io.Serializable;
import java.util.List;

public class Member implements Serializable{
	private String memberId;
	private String memberPw;
	private String memberName;
	private String memberAddress;
	private String memberEmail;
	private String memberTel;
	private String memberSex;
	
	//작성자 - 김장규
	private List<BoardQnA> boardQnAList;
	
	public Member(){}
	
	
	public Member(String memberId, String memberPw, String memberName, String memberAddress, String memberEmail,
			String memberTel, String memberSex) {
		this.memberId = memberId;
		this.memberPw = memberPw;
		this.memberName = memberName;
		this.memberAddress = memberAddress;
		this.memberEmail = memberEmail;
		this.memberTel = memberTel;
		this.memberSex = memberSex;
	}
	

	//작성자 - 김장규
	public Member(String memberId, String memberPw, String memberName, String memberAddress, String memberEmail,
			String memberTel, String memberSex, List<BoardQnA> boardQnAList) {
		this.memberId = memberId;
		this.memberPw = memberPw;
		this.memberName = memberName;
		this.memberAddress = memberAddress;
		this.memberEmail = memberEmail;
		this.memberTel = memberTel;
		this.memberSex = memberSex;
		this.boardQnAList = boardQnAList;
	}


	public String getMemberId() {
		return memberId;
	}


	public void setMemberId(String memberId) {
		this.memberId = memberId;
	}


	public String getMemberPw() {
		return memberPw;
	}


	public void setMemberPw(String memberPw) {
		this.memberPw = memberPw;
	}


	public String getMemberName() {
		return memberName;
	}


	public void setMemberName(String memberName) {
		this.memberName = memberName;
	}


	public String getMemberAddress() {
		return memberAddress;
	}


	public void setMemberAddress(String memberAddress) {
		this.memberAddress = memberAddress;
	}


	public String getMemberEmail() {
		return memberEmail;
	}


	public void setMemberEmail(String memberEmail) {
		this.memberEmail = memberEmail;
	}


	public String getMemberTel() {
		return memberTel;
	}


	public void setMemberTel(String memberTel) {
		this.memberTel = memberTel;
	}


	public String getMemberSex() {
		return memberSex;
	}


	public void setMemberSex(String memberSex) {
		this.memberSex = memberSex;
	}


	public List<BoardQnA> getBoardQnAList() {
		return boardQnAList;
	}


	public void setBoardQnAList(List<BoardQnA> boardQnAList) {
		this.boardQnAList = boardQnAList;
	}


	@Override
	public String toString() {
		return "Member [memberId=" + memberId + ", memberPw=" + memberPw + ", memberName=" + memberName
				+ ", memberAddress=" + memberAddress + ", memberEmail=" + memberEmail + ", memberTel=" + memberTel
				+ ", memberSex=" + memberSex + ", boardQnAList=" + boardQnAList + "]";
	}


	@Override
	public int hashCode() {
		final int prime = 31;
		int result = 1;
		result = prime * result + ((boardQnAList == null) ? 0 : boardQnAList.hashCode());
		result = prime * result + ((memberAddress == null) ? 0 : memberAddress.hashCode());
		result = prime * result + ((memberEmail == null) ? 0 : memberEmail.hashCode());
		result = prime * result + ((memberId == null) ? 0 : memberId.hashCode());
		result = prime * result + ((memberName == null) ? 0 : memberName.hashCode());
		result = prime * result + ((memberPw == null) ? 0 : memberPw.hashCode());
		result = prime * result + ((memberSex == null) ? 0 : memberSex.hashCode());
		result = prime * result + ((memberTel == null) ? 0 : memberTel.hashCode());
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
		Member other = (Member) obj;
		if (boardQnAList == null) {
			if (other.boardQnAList != null)
				return false;
		} else if (!boardQnAList.equals(other.boardQnAList))
			return false;
		if (memberAddress == null) {
			if (other.memberAddress != null)
				return false;
		} else if (!memberAddress.equals(other.memberAddress))
			return false;
		if (memberEmail == null) {
			if (other.memberEmail != null)
				return false;
		} else if (!memberEmail.equals(other.memberEmail))
			return false;
		if (memberId == null) {
			if (other.memberId != null)
				return false;
		} else if (!memberId.equals(other.memberId))
			return false;
		if (memberName == null) {
			if (other.memberName != null)
				return false;
		} else if (!memberName.equals(other.memberName))
			return false;
		if (memberPw == null) {
			if (other.memberPw != null)
				return false;
		} else if (!memberPw.equals(other.memberPw))
			return false;
		if (memberSex == null) {
			if (other.memberSex != null)
				return false;
		} else if (!memberSex.equals(other.memberSex))
			return false;
		if (memberTel == null) {
			if (other.memberTel != null)
				return false;
		} else if (!memberTel.equals(other.memberTel))
			return false;
		return true;
	}
}
