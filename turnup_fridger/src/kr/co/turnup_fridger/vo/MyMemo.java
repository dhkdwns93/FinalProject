package kr.co.turnup_fridger.vo;

import java.io.Serializable;
import java.util.Date;

public class MyMemo implements Serializable{

	private int memoId;
	private String memoName;
	private String memoText;
	private String memberId;
	private Date registeredDate;
	
	public MyMemo() {
		super();
	}

	public MyMemo(int memoId, String memoName, String memoText, String memberId, Date registeredDate) {
		super();
		this.memoId = memoId;
		this.memoName = memoName;
		this.memoText = memoText;
		this.memberId = memberId;
		this.registeredDate = registeredDate;
	}

	
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
	public String getMemoText() {
		return memoText;
	}
	public void setMemoText(String memoText) {
		this.memoText = memoText;
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

	@Override
	public int hashCode() {
		final int prime = 31;
		int result = 1;
		result = prime * result + ((memberId == null) ? 0 : memberId.hashCode());
		result = prime * result + memoId;
		result = prime * result + ((memoName == null) ? 0 : memoName.hashCode());
		result = prime * result + ((memoText == null) ? 0 : memoText.hashCode());
		result = prime * result + ((registeredDate == null) ? 0 : registeredDate.hashCode());
		return result;
	}

	@Override
	public boolean equals(Object obj) {
		if (this == obj)
			return true;
		if (obj == null)
			return false;
		if (!(obj instanceof MyMemo))
			return false;
		MyMemo other = (MyMemo) obj;
		if (memberId == null) {
			if (other.memberId != null)
				return false;
		} else if (!memberId.equals(other.memberId))
			return false;
		if (memoId != other.memoId)
			return false;
		if (memoName == null) {
			if (other.memoName != null)
				return false;
		} else if (!memoName.equals(other.memoName))
			return false;
		if (memoText == null) {
			if (other.memoText != null)
				return false;
		} else if (!memoText.equals(other.memoText))
			return false;
		if (registeredDate == null) {
			if (other.registeredDate != null)
				return false;
		} else if (!registeredDate.equals(other.registeredDate))
			return false;
		return true;
	}

	@Override
	public String toString() {
		return "MyMemo [memoId=" + memoId + ", memoName=" + memoName + ", memoText=" + memoText + ", memberId="
				+ memberId + ", registeredDate=" + registeredDate + "]";
	}

}
