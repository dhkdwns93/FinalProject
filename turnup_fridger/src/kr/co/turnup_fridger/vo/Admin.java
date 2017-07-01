/**
 (VO)admin
작성자 :  김경혜
최초 작성일 170627
변경이력 
*/
package kr.co.turnup_fridger.vo;

import java.io.Serializable;

public class Admin implements Serializable {
	private String loginId;
	private String loginPw;
	private String adminName;
	private String adminTel;
	private String adminEmail;
	private String adminAuthority;
	
	public Admin(){}
	
	
	public Admin(String loginId, String adminAuthority) {
		this.loginId = loginId;
		this.adminAuthority = adminAuthority;
	}


	public Admin(String loginId, String loginPw, String adminName, String adminTel, String adminEmail,
			String adminAuthority) {
		this.loginId = loginId;
		this.loginPw = loginPw;
		this.adminName = adminName;
		this.adminTel = adminTel;
		this.adminEmail = adminEmail;
		this.adminAuthority = adminAuthority;
	}
	

	public String getLoginId() {
		return loginId;
	}

	public void setLoginId(String loginId) {
		this.loginId = loginId;
	}

	public String getLoginPw() {
		return loginPw;
	}

	public void setLoginPw(String loginPw) {
		this.loginPw = loginPw;
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
		return "Admin [loginId=" + loginId + ", loginPw=" + loginPw + ", adminName=" + adminName + ", adminTel="
				+ adminTel + ", adminEmail=" + adminEmail + ", adminAuthority=" + adminAuthority + "]";
	}

	@Override
	public int hashCode() {
		final int prime = 31;
		int result = 1;
		result = prime * result + ((adminAuthority == null) ? 0 : adminAuthority.hashCode());
		result = prime * result + ((adminEmail == null) ? 0 : adminEmail.hashCode());
		result = prime * result + ((loginId == null) ? 0 : loginId.hashCode());
		result = prime * result + ((adminName == null) ? 0 : adminName.hashCode());
		result = prime * result + ((loginPw == null) ? 0 : loginPw.hashCode());
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
		if (loginId == null) {
			if (other.loginId != null)
				return false;
		} else if (!loginId.equals(other.loginId))
			return false;
		if (adminName == null) {
			if (other.adminName != null)
				return false;
		} else if (!adminName.equals(other.adminName))
			return false;
		if (loginPw == null) {
			if (other.loginPw != null)
				return false;
		} else if (!loginPw.equals(other.loginPw))
			return false;
		if (adminTel == null) {
			if (other.adminTel != null)
				return false;
		} else if (!adminTel.equals(other.adminTel))
			return false;
		return true;
	}
	
	
	
}
