package kr.co.turnup_fridger.vo;

import java.io.Serializable;
import java.util.Date;

public class JoinProcess implements Serializable{
	private int processNo;
	private int processFridgerId;
	private int processState;
	private Date reqDate;
	private Date respDate;
	private String reqMemberId;
	private String respMemberId;
	



	public JoinProcess() {
	}

	
	
	public JoinProcess(int processNo, int processState, Date respDate) {
		this.processNo = processNo;
		this.processState = processState;
		this.respDate = respDate;
	}

	


	public JoinProcess(int processNo, int processFridgerId, Date reqDate, String reqMemberId) {
		this.processNo = processNo;
		this.processFridgerId = processFridgerId;
		this.reqDate = reqDate;
		this.reqMemberId = reqMemberId;
	}
	
	



	public JoinProcess(int processNo, int processFridgerId, int processState, Date reqDate, String reqMemberId,
			String respMemberId) {
		this.processNo = processNo;
		this.processFridgerId = processFridgerId;
		this.processState = processState;
		this.reqDate = reqDate;
		this.reqMemberId = reqMemberId;
		this.respMemberId = respMemberId;
	}


	public JoinProcess(int processNo, int processFridgerId, int processState, Date reqDate, Date respDate,
			String reqMemberId, String respMemberId) {
		this.processNo = processNo;
		this.processFridgerId = processFridgerId;
		this.processState = processState;
		this.reqDate = reqDate;
		this.respDate = respDate;
		this.reqMemberId = reqMemberId;
		this.respMemberId = respMemberId;
	}



	



	public int getProcessNo() {
		return processNo;
	}

	public void setProcessNo(int processNo) {
		this.processNo = processNo;
	}

	public int getProcessFridgerId() {
		return processFridgerId;
	}

	public void setProcessFridgerId(int processFridgerId) {
		this.processFridgerId = processFridgerId;
	}

	public int getProcessState() {
		return processState;
	}

	public void setProcessState(int processState) {
		this.processState = processState;
	}

	public Date getReqDate() {
		return reqDate;
	}


	public void setReqDate(Date reqDate) {
		this.reqDate = reqDate;
	}


	public Date getRespDate() {
		return respDate;
	}


	public void setRespDate(Date respDate) {
		this.respDate = respDate;
	}


	public String getReqMemberId() {
		return reqMemberId;
	}

	public void setReqMemberId(String reqMemberId) {
		this.reqMemberId = reqMemberId;
	}

	public String getRespMemberId() {
		return respMemberId;
	}

	public void setRespMemberId(String respMemberId) {
		this.respMemberId = respMemberId;
	}


	

	@Override
	public int hashCode() {
		final int prime = 31;
		int result = 1;
		result = prime * result + processFridgerId;
		result = prime * result + processNo;
		result = prime * result + processState;
		result = prime * result + ((reqDate == null) ? 0 : reqDate.hashCode());
		result = prime * result + ((reqMemberId == null) ? 0 : reqMemberId.hashCode());
		result = prime * result + ((respDate == null) ? 0 : respDate.hashCode());
		result = prime * result + ((respMemberId == null) ? 0 : respMemberId.hashCode());
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
		if (processState != other.processState)
			return false;
		if (reqDate == null) {
			if (other.reqDate != null)
				return false;
		} else if (!reqDate.equals(other.reqDate))
			return false;
		if (reqMemberId == null) {
			if (other.reqMemberId != null)
				return false;
		} else if (!reqMemberId.equals(other.reqMemberId))
			return false;
		if (respDate == null) {
			if (other.respDate != null)
				return false;
		} else if (!respDate.equals(other.respDate))
			return false;
		if (respMemberId == null) {
			if (other.respMemberId != null)
				return false;
		} else if (!respMemberId.equals(other.respMemberId))
			return false;
		return true;
	}


	@Override
	public String toString() {
		return "JoinProcess [processNo=" + processNo + ", processFridgerId=" + processFridgerId + ", processState="
				+ processState + ", reqDate=" + reqDate + ", respDate=" + respDate + ", reqMemberId=" + reqMemberId
				+ ", respMemberId=" + respMemberId + "]";
	}
	
	
}
