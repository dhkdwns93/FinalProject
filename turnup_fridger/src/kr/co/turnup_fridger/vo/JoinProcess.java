package kr.co.turnup_fridger.vo;

public class JoinProcess {
	private int processNo;
	private int processSn;
	private int processFridgerId;
	private String processState;
	private String reqMemberId;
	private String resqMemberId;
	
	public JoinProcess() {
	}

	public JoinProcess(int processNo, int processSn, int processFridgerId, String processState, String reqMemberId,
			String resqMemberId) {
		this.processNo = processNo;
		this.processSn = processSn;
		this.processFridgerId = processFridgerId;
		this.processState = processState;
		this.reqMemberId = reqMemberId;
		this.resqMemberId = resqMemberId;
	}

	public int getProcessNo() {
		return processNo;
	}

	public void setProcessNo(int processNo) {
		this.processNo = processNo;
	}

	public int getProcessSn() {
		return processSn;
	}

	public void setProcessSn(int processSn) {
		this.processSn = processSn;
	}

	public int getProcessFridgerId() {
		return processFridgerId;
	}

	public void setProcessFridgerId(int processFridgerId) {
		this.processFridgerId = processFridgerId;
	}

	public String getProcessState() {
		return processState;
	}

	public void setProcessState(String processState) {
		this.processState = processState;
	}

	public String getReqMemberId() {
		return reqMemberId;
	}

	public void setReqMemberId(String reqMemberId) {
		this.reqMemberId = reqMemberId;
	}

	public String getResqMemberId() {
		return resqMemberId;
	}

	public void setResqMemberId(String resqMemberId) {
		this.resqMemberId = resqMemberId;
	}

	@Override
	public int hashCode() {
		final int prime = 31;
		int result = 1;
		result = prime * result + processFridgerId;
		result = prime * result + processNo;
		result = prime * result + processSn;
		result = prime * result + ((processState == null) ? 0 : processState.hashCode());
		result = prime * result + ((reqMemberId == null) ? 0 : reqMemberId.hashCode());
		result = prime * result + ((resqMemberId == null) ? 0 : resqMemberId.hashCode());
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
		JoinProcess other = (JoinProcess) obj;
		if (processFridgerId != other.processFridgerId)
			return false;
		if (processNo != other.processNo)
			return false;
		if (processSn != other.processSn)
			return false;
		if (processState == null) {
			if (other.processState != null)
				return false;
		} else if (!processState.equals(other.processState))
			return false;
		if (reqMemberId == null) {
			if (other.reqMemberId != null)
				return false;
		} else if (!reqMemberId.equals(other.reqMemberId))
			return false;
		if (resqMemberId == null) {
			if (other.resqMemberId != null)
				return false;
		} else if (!resqMemberId.equals(other.resqMemberId))
			return false;
		return true;
	}

	@Override
	public String toString() {
		return "JoinProcess [processNo=" + processNo + ", processSn=" + processSn + ", processFridgerId="
				+ processFridgerId + ", processState=" + processState + ", reqMemberId=" + reqMemberId
				+ ", resqMemberId=" + resqMemberId + "]";
	}
	
	
	
	
	
	
}
