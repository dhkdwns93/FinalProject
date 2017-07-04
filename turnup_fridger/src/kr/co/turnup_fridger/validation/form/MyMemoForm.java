package kr.co.turnup_fridger.validation.form;

import java.io.Serializable;
import java.util.Date;

import org.hibernate.validator.constraints.NotEmpty;

public class MyMemoForm implements Serializable{

	private int memoId;
	private String memoName;
	@NotEmpty(message="내용을 입력해주세요.")
	private String memoTxt;
	private String memberId;
	private Date registeredDate;

	
	public int getMemoId() {
		return memoId;
	}

	public void setMemoId(int memoId) {
		this.memoId = memoId;
	}

	public String getMemoName() {
		return memoName;
	}
	public void setMemoName(String memoName) {
		this.memoName = memoName;
	}
	public String getmemoTxt() {
		return memoTxt;
	}
	public void setmemoTxt(String memoTxt) {
		this.memoTxt = memoTxt;
	}
	public String getMemberId() {
		return memberId;
	}
	public void setMemberId(String memberId) {
		this.memberId = memberId;
	}
	
	public Date getRegisteredDate() {
		return registeredDate;
	}

	public void setRegisteredDate(Date registeredDate) {
		this.registeredDate = registeredDate;
	}
}
