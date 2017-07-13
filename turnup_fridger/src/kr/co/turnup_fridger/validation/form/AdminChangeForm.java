/**
(validation.form)AdminChangeForm
작성자 :  김경혜
최초 작성일 170708
변경이력 
*/
package kr.co.turnup_fridger.validation.form;

public class AdminChangeForm {
	private String originalAdminPw;
	private String adminId;
	private String oldAdminPw;
	private String adminPw;
	private String adminName;
	private String adminTel;
	private String adminEmail;
	private String adminAuthority;
	
	public AdminChangeForm(){}
	public AdminChangeForm(String originalAdminPw, String adminId, String oldAdminPw, String adminPw, String adminName,
			String adminTel, String adminEmail, String adminAuthority) {
		this.originalAdminPw = originalAdminPw;
		this.adminId = adminId;
		this.oldAdminPw = oldAdminPw;
		this.adminPw = adminPw;
		this.adminName = adminName;
		this.adminTel = adminTel;
		this.adminEmail = adminEmail;
		this.adminAuthority = adminAuthority;
	}
	
	public String getOriginalAdminPw() {
		return originalAdminPw;
	}
	public void setOriginalAdminPw(String originalAdminPw) {
		this.originalAdminPw = originalAdminPw;
	}
	public String getAdminId() {
		return adminId;
	}
	public void setAdminId(String adminId) {
		this.adminId = adminId;
	}
	public String getOldAdminPw() {
		return oldAdminPw;
	}
	public void setOldAdminPw(String oldAdminPw) {
		this.oldAdminPw = oldAdminPw;
	}
	public String getAdminPw() {
		return adminPw;
	}
	public void setAdminPw(String adminPw) {
		this.adminPw = adminPw;
	}
	public String getAdminName() {
		return adminName;
	}
	public void setAdminName(String adminName) {
		this.adminName = adminName;
	}
	public String getAdminTel() {
		return adminTel;
	}
	public void setAdminTel(String adminTel) {
		this.adminTel = adminTel;
	}
	public String getAdminEmail() {
		return adminEmail;
	}
	public void setAdminEmail(String adminEmail) {
		this.adminEmail = adminEmail;
	}
	public String getAdminAuthority() {
		return adminAuthority;
	}
	public void setAdminAuthority(String adminAuthority) {
		this.adminAuthority = adminAuthority;
	}
	@Override
	public String toString() {
		return "AdminChangeForm [originalAdminPw=" + originalAdminPw + ", adminId=" + adminId + ", oldAdminPw="
				+ oldAdminPw + ", adminPw=" + adminPw + ", adminName=" + adminName + ", adminTel=" + adminTel
				+ ", adminEmail=" + adminEmail + ", adminAuthority=" + adminAuthority + "]";
	}
}
