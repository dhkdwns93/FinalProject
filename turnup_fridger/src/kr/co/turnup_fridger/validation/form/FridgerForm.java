package kr.co.turnup_fridger.validation.form;

import org.hibernate.validator.constraints.Length;
import org.hibernate.validator.constraints.NotEmpty;
import org.springframework.web.multipart.MultipartFile;

public class FridgerForm {
	//자동생성(seq)
	private int fridgerId;
	@NotEmpty(message="냉장고이름은 2자 이상입니다!")
	@Length(min=2, max=20)
	private String fridgerName;
	//컨트롤러 처리(권한)
	@NotEmpty(message="아이디를 넣으세여!!")
	private String memberId;
	
	private String fridgerImg;
	
	
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
	public String getFridgerImg() {
		return fridgerImg;
	}
	public void setFridgerImg(String fridgerImg) {
		this.fridgerImg = fridgerImg;
	}
	
	
	
	
	
}