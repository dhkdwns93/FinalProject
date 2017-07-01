/**
 (vo)authority
작성자 :  김경혜
최초 작성일 170630
변경이력 
*/
package kr.co.turnup_fridger.vo;

import java.io.Serializable;

public class Authority implements Serializable{
	private String logId;
	private String loginPw;
	private String loginAuthority;
	
	public Authority(){}
	public Authority(String logId, String loginPw, String loginAuthority) {
		this.logId = logId;
		this.loginPw = loginPw;
		this.loginAuthority = loginAuthority;
	}
	public String getLogId() {
		return logId;
	}
	public void setLogId(String logId) {
		this.logId = logId;
	}
	public String getLoginPw() {
		return loginPw;
	}
	public void setLoginPw(String loginPw) {
		this.loginPw = loginPw;
	}
	public String getLoginAuthority() {
		return loginAuthority;
	}
	public void setLoginAuthority(String loginAuthority) {
		this.loginAuthority = loginAuthority;
	}
	@Override
	public String toString() {
		return "Authority [logId=" + logId + ", loginPw=" + loginPw + ", loginAuthority=" + loginAuthority + "]";
	}
	@Override
	public int hashCode() {
		final int prime = 31;
		int result = 1;
		result = prime * result + ((logId == null) ? 0 : logId.hashCode());
		result = prime * result + ((loginAuthority == null) ? 0 : loginAuthority.hashCode());
		result = prime * result + ((loginPw == null) ? 0 : loginPw.hashCode());
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
		Authority other = (Authority) obj;
		if (logId == null) {
			if (other.logId != null)
				return false;
		} else if (!logId.equals(other.logId))
			return false;
		if (loginAuthority == null) {
			if (other.loginAuthority != null)
				return false;
		} else if (!loginAuthority.equals(other.loginAuthority))
			return false;
		if (loginPw == null) {
			if (other.loginPw != null)
				return false;
		} else if (!loginPw.equals(other.loginPw))
			return false;
		return true;
	}
	
}
