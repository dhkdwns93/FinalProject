/**
 (VO)admin
작성자 :  김경혜
최초 작성일 170627
변경이력 
170703 변수이름
*/
package kr.co.turnup_fridger.vo;

import java.io.Serializable;

public class Admin implements Serializable {
	private String adminId;
	private String adminPw;
	private String adminName;
	private String adminTel;
	private String adminEmail;
	private String adminAuthority="admin";//default = 기본관리자로 설정
	
	public Admin(){}
	public Admin(String adminId, String adminPw, String adminName, String adminTel, String adminEmail,
			String adminAuthority) {
		this.adminId = adminId;
		this.adminPw = adminPw;
		this.adminName = adminName;
		this.adminTel = adminTel;
		this.adminEmail = adminEmail;
		this.adminAuthority = adminAuthority;
	}
	//권한제외
	public Admin(String adminId, String adminPw, String adminName, String adminTel, String adminEmail) {
		this.adminId = adminId;
		this.adminPw = adminPw;
		this.adminName = adminName;
		this.adminTel = adminTel;
		this.adminEmail = adminEmail;
	}
	
	public String getAdminId() {
		return adminId;
	}
	public void setAdminId(String adminId) {
		this.adminId = adminId;
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
		return "Admin [adminId=" + adminId + ", adminPw=" + adminPw + ", adminName=" + adminName + ", adminTel="
				+ adminTel + ", adminEmail=" + adminEmail + ", adminAuthority=" + adminAuthority + "]";
	}
	@Override
	public int hashCode() {
		final int prime = 31;
		int result = 1;
		result = prime * result + ((adminAuthority == null) ? 0 : adminAuthority.hashCode());
		result = prime * result + ((adminEmail == null) ? 0 : adminEmail.hashCode());
		result = prime * result + ((adminId == null) ? 0 : adminId.hashCode());
		result = prime * result + ((adminName == null) ? 0 : adminName.hashCode());
		result = prime * result + ((adminPw == null) ? 0 : adminPw.hashCode());
		result = prime * result + ((adminTel == null) ? 0 : adminTel.hashCode());
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
		Admin other = (Admin) obj;
		if (adminAuthority == null) {
			if (other.adminAuthority != null)
				return false;
		} else if (!adminAuthority.equals(other.adminAuthority))
			return false;
		if (adminEmail == null) {
			if (other.adminEmail != null)
				return false;
		} else if (!adminEmail.equals(other.adminEmail))
			return false;
		if (adminId == null) {
			if (other.adminId != null)
				return false;
		} else if (!adminId.equals(other.adminId))
			return false;
		if (adminName == null) {
			if (other.adminName != null)
				return false;
		} else if (!adminName.equals(other.adminName))
			return false;
		if (adminPw == null) {
			if (other.adminPw != null)
				return false;
		} else if (!adminPw.equals(other.adminPw))
			return false;
		if (adminTel == null) {
			if (other.adminTel != null)
				return false;
		} else if (!adminTel.equals(other.adminTel))
			return false;
		return true;
	}
}

