package kr.co.turnup_fridger.validation.form;

import java.util.List;


import kr.co.turnup_fridger.vo.MyDislikeIrdnt;

public class MemberChangeForm{
	private String originalMemberPw;
	private String memberId;	
	private String oldMemberPw;
	private String memberPw;
	private String memberName;
	private String memberAddress;
	private String memberEmail;
	private String memberTel;
	private String memberSex;
	
	private String memberAuthority="ROLE_MEMBER";
	private List<MyDislikeIrdnt> myDislikeIrdntList;
	
	public MemberChangeForm(){}
	
	public MemberChangeForm(String originalMemberPw, String memberId, String oldMemberPw, String memberPw,
			String memberName, String memberAddress, String memberEmail, String memberTel, String memberSex,
			String memberAuthority, List<MyDislikeIrdnt> myDislikeIrdntList) {
		super();
		this.originalMemberPw = originalMemberPw;
		this.memberId = memberId;
		this.oldMemberPw = oldMemberPw;
		this.memberPw = memberPw;
		this.memberName = memberName;
		this.memberAddress = memberAddress;
		this.memberEmail = memberEmail;
		this.memberTel = memberTel;
		this.memberSex = memberSex;
		this.memberAuthority = memberAuthority;
		this.myDislikeIrdntList = myDislikeIrdntList;
	}

	public String getOriginalMemberPw() {
		return originalMemberPw;
	}

	public void setOriginalMemberPw(String originalMemberPw) {
		this.originalMemberPw = originalMemberPw;
	}

	public String getMemberId() {
		return memberId;
	}
	public void setMemberId(String memberId) {
		this.memberId = memberId;
	}
	public String getOldMemberPw() {
		return oldMemberPw;
	}
	public void setOldMemberPw(String oldMemberPw) {
		this.oldMemberPw = oldMemberPw;
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
	public String getMemberAuthority() {
		return memberAuthority;
	}
	public void setMemberAuthority(String memberAuthority) {
		this.memberAuthority = memberAuthority;
	}
	public List<MyDislikeIrdnt> getMyDislikeIrdntList() {
		return myDislikeIrdntList;
	}
	public void setMyDislikeIrdntList(List<MyDislikeIrdnt> myDislikeIrdntList) {
		this.myDislikeIrdntList = myDislikeIrdntList;
	}

	@Override
	public String toString() {
		return "MemberChangeForm [originalMemberPw=" + originalMemberPw + ", memberId=" + memberId + ", oldMemberPw="
				+ oldMemberPw + ", memberPw=" + memberPw + ", memberName=" + memberName + ", memberAddress="
				+ memberAddress + ", memberEmail=" + memberEmail + ", memberTel=" + memberTel + ", memberSex="
				+ memberSex + ", memberAuthority=" + memberAuthority + ", myDislikeIrdntList=" + myDislikeIrdntList
				+ "]";
	}
	

	
}
