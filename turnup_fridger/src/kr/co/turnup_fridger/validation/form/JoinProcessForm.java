package kr.co.turnup_fridger.validation.form;

import java.io.Serializable;
import java.util.Date;

import javax.validation.constraints.NotNull;

import org.hibernate.validator.constraints.NotEmpty;

public class JoinProcessForm implements Serializable{
	private int processNo;
	@NotNull
	private int processFridgerId;
	@NotNull
	private int processState;
	private Date reqDate;
	private Date respDate;
	private String reqMemberId;
	@NotEmpty(message="아이디를 넣으세여!!")
	private String respMemberId;


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


	
}
