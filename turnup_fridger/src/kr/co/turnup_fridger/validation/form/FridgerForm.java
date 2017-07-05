package kr.co.turnup_fridger.validation.form;

import org.hibernate.validator.constraints.Length;
import org.hibernate.validator.constraints.NotEmpty;

public class FridgerForm {
	//자동생성(seq)
	private int fridgerId;
	@NotEmpty
	@Length(min=2, max=20)
	private String fridgerName;
	//컨트롤러 처리(권한)
	private String memberId;
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
	
	
	
	
}