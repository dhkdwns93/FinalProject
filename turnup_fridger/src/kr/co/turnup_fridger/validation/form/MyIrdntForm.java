package kr.co.turnup_fridger.validation.form;

import java.util.Date;

import javax.validation.constraints.NotNull;

import org.hibernate.validator.constraints.NotEmpty;
import org.springframework.format.annotation.DateTimeFormat;

public class MyIrdntForm {

	
	private int myIrdntKey;
	@DateTimeFormat(pattern = "yyyy-MM-dd")
	@NotNull(message="보관시작일을 입력해주세요.")
	private Date startDate;
	@DateTimeFormat(pattern = "yyyy-MM-dd")
	private Date endDate;
	private String freshLevel;//동적으로 관리될 식품의 신선도상태
	private String irdntCount;
	//@NotNull(message ="재료id는 필수항목입니다.")
	private int irdntId;
	@NotEmpty(message ="재료명은 필수항목입니다. ")
	private String irdntName;
	@NotNull(message = "냉장고id는 필수항목입니다.")
	private int fridgerId;
	@NotEmpty(message ="보관시작시 상태를 입력해주세요.")
	private String startFreshLevel;//시작시 입력받을 식품의 상태
	@NotEmpty(message="보관장소를 입력해주세요.")
	private String storgePlace;
	
	public int getMyIrdntKey() {
		return myIrdntKey;
	}
	public void setMyIrdntKey(int myIrdntKey) {
		this.myIrdntKey = myIrdntKey;
	}
	public Date getStartDate() {
		return startDate;
	}
	public void setStartDate(Date startDate) {
		this.startDate = startDate;
	}
	public Date getEndDate() {
		return endDate;
	}
	public void setEndDate(Date endDate) {
		this.endDate = endDate;
	}
	public String getFreshLevel() {
		return freshLevel;
	}
	public void setFreshLevel(String freshLevel) {
		this.freshLevel = freshLevel;
	}
	public String getIrdntCount() {
		return irdntCount;
	}
	public void setIrdntCount(String irdntCount) {
		this.irdntCount = irdntCount;
	}
	public int getIrdntId() {
		return irdntId;
	}
	public void setIrdntId(int irdntId) {
		this.irdntId = irdntId;
	}
	public String getIrdntName() {
		return irdntName;
	}
	public void setIrdntName(String irdntName) {
		this.irdntName = irdntName;
	}
	public int getFridgerId() {
		return fridgerId;
	}
	public void setFridgerId(int fridgerId) {
		this.fridgerId = fridgerId;
	}
	public String getStartFreshLevel() {
		return startFreshLevel;
	}
	public void setStartFreshLevel(String startFreshLevel) {
		this.startFreshLevel = startFreshLevel;
	}
	public String getStorgePlace() {
		return storgePlace;
	}
	public void setStorgePlace(String storgePlace) {
		this.storgePlace = storgePlace;
	}
	
	
	
}
