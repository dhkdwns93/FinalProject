package kr.co.turnup_fridger.validation.form;

import javax.validation.constraints.NotNull;

import org.hibernate.validator.constraints.Length;
import org.hibernate.validator.constraints.NotEmpty;
import org.hibernate.validator.constraints.Range;

import kr.co.turnup_fridger.vo.MyDislikeIrdnt;
import kr.co.turnup_fridger.vo.MyIrdnt;
import kr.co.turnup_fridger.vo.RecipeIrdnt;
import kr.co.turnup_fridger.vo.ShareRecipeIrdnt;

public class IrdntManageForm {

	//시퀀스
	private int irdntId;
	@NotEmpty(message="식재료 이름을 꼭 입력하세요.")
	private String irdntName;
	private String irdntCategory;
	@Range(min=1,max=1001)
	@NotNull
	private int roomTemPeriod;
	@Range(min=1,max=1001)
	@NotNull
	private int coldTemPeriod;
	@Range(min=1,max=1001)
	@NotNull
	private int freezeTemPeriod;
	private String note;
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
	public String getIrdntCategory() {
		return irdntCategory;
	}
	public void setIrdntCategory(String irdntCategory) {
		this.irdntCategory = irdntCategory;
	}
	public int getRoomTemPeriod() {
		return roomTemPeriod;
	}
	public void setRoomTemPeriod(int roomTemPeriod) {
		this.roomTemPeriod = roomTemPeriod;
	}
	public int getColdTemPeriod() {
		return coldTemPeriod;
	}
	public void setColdTemPeriod(int coldTemPeriod) {
		this.coldTemPeriod = coldTemPeriod;
	}
	public int getFreezeTemPeriod() {
		return freezeTemPeriod;
	}
	public void setFreezeTemPeriod(int freezeTemPeriod) {
		this.freezeTemPeriod = freezeTemPeriod;
	}
	public String getNote() {
		return note;
	}
	public void setNote(String note) {
		this.note = note;
	}
	
	
	
}
