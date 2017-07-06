package kr.co.turnup_fridger.service.impl;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.co.turnup_fridger.dao.FridgerDao;
import kr.co.turnup_fridger.dao.JoinProcessDao;
import kr.co.turnup_fridger.dao.MemberDao;
import kr.co.turnup_fridger.exception.FindMemberFailException;
import kr.co.turnup_fridger.exception.JoinProcessFailException;
import kr.co.turnup_fridger.exception.FindFridgerFailException;
import kr.co.turnup_fridger.service.JoinProcessService;
import kr.co.turnup_fridger.vo.Fridger;
import kr.co.turnup_fridger.vo.JoinProcess;

@Service("joinProcessService")
public class JoinProcessServiceImpl implements JoinProcessService{
	

	@Autowired
	private JoinProcessDao jdao;
	
	@Autowired
	private FridgerDao fdao;
	
	@Autowired
	private MemberDao mdao;

	@Override
	public void requestJoinFridgerGroup(JoinProcess joinProcess) throws FindFridgerFailException, JoinProcessFailException {
		//존재하는 냉장고인지 체크
		if(fdao.selectFridgerByFridgerId(joinProcess.getProcessFridgerId()) == null){
			throw new FindFridgerFailException("존재하지 않는 냉장고 입니다.");
		}
		
		//회원이 자기의 냉장고 가입신청으로 접근했을 때
		if(joinProcess.getReqMemberId().equals(joinProcess.getRespMemberId())){
			throw new JoinProcessFailException("이미 주인인 냉장고입니다!");
		}
		
		//한 냉장고(그룹)에 대해 중복요청인지 체크
		// (1)냉장고 id로 검색된 가입처리 목록 가져오기
		for(JoinProcess jp : jdao.selectJoinProcessByFridgerId(joinProcess.getProcessFridgerId())){
			if(jp.getReqMemberId().equals(joinProcess.getReqMemberId()) && jp.getProcessState() == 10){
				//목록의 요청자에 신청하는 회원 id가 있고, 처리상태가 10(가입승인대기)일 때
				throw new JoinProcessFailException("이미 가입승인대기중인 냉장고입니다!");
			}
		}
		//(2)목록의 신청자가 아니라면 -> 가입처리 목록에 가입승인대기(10) 상태로 추가
		joinProcess.setReqDate(new Date());
		jdao.insertJoinProcess(joinProcess);
	}

	@Override
	public void inviteJoinFridgerGroup(JoinProcess joinProcess) throws JoinProcessFailException, FindMemberFailException {
		// 존재하는 회원인지 체크
		if (mdao.selectMemberById(joinProcess.getRespMemberId()) == null){
			throw new FindMemberFailException("존재하지 회원 ID입니다.");
		}
		// 회원이 자기의 냉장고  초대로 접근했을 때
		if(joinProcess.getReqMemberId().equals(joinProcess.getRespMemberId())){
			throw new JoinProcessFailException("이미 주인인 냉장고입니다!");
		}
		
		// 같은 회원(그룹)에 대해 중복요청인지 체크
		// (1)냉장고 id로 검색된 가입처리 목록 가져오기
		for (JoinProcess jp : jdao.selectJoinProcessByFridgerId(joinProcess.getProcessFridgerId())) {
			if (jp.getRespMemberId().equals(joinProcess.getRespMemberId()) && jp.getProcessState() == 20) {
				//목록의 응답자에 초대할 회원id가 있고, 처리상태가 20(초대승인대기)일 때
				throw new JoinProcessFailException("이미 초대승인대기중인 회원입니다.");
			}
		}
		// (2)목록의 응답자가 아니라면 -> 가입처리 목록에 초대승인대기(20) 상태로 추가
		jdao.insertJoinProcess(joinProcess);
	}

	@Override
	public void updateJoinProcess(JoinProcess joinProcess) throws Exception {
		//처리번호 오류
		if(jdao.selectJoinProcessByProcessNo(joinProcess.getProcessNo()) == null){
			throw new Exception("처리번호가 존재하지 않습니다!");
		}
		jdao.updateJoinProcess(joinProcess);
		
	}

	@Override
	public int removeJoinProcessByProcessNo(ArrayList<Integer> processNoList){
		
		return jdao.deleteJoinProcessByProcessNo(processNoList);
	}

	@Override
	public int removeJoinProcessNotProcessedIn14Days() {
		return jdao.deleteJoinProcessNotProcessedIn14Days();
	}

	@Override
	public int removeJoinProcessCompleted6MonthsBefore() {
		return jdao.deleteJoinProcessCompleted6MonthsBefore();
	}
	
	
	
	

	@Override
	public JoinProcess findJoinProcessByProcessNo(int processNo) {
		return jdao.selectJoinProcessByProcessNo(processNo);
	}

	@Override
	public List<JoinProcess> findJoinProcessAll() {
		return jdao.selectJoinProcessAll();
	}

	@Override
	public List<JoinProcess> findJoinProcessByFridgerId(int fridgerId) {
		return jdao.selectJoinProcessByFridgerId(fridgerId);
	}

	@Override
	public List<JoinProcess> findJoinProcessByProcessState(int processState) {
		return jdao.selectJoinProcessByProcessState(processState);
	}

	@Override
	public List<JoinProcess> findJoinProcessByRequestMemberId(String reqMemberId) {

		return jdao.selectJoinProcessByRequestMemberId(reqMemberId);
	}

	@Override
	public List<JoinProcess> findJoinProcessByResponseMemberId(String respMemberId) {

		return jdao.selectJoinProcessByResponseMemberId(respMemberId);
	}

	@Override
	public List<JoinProcess> findJoinProcessByRequestDate(Date requestDate) {
		return jdao.selectJoinProcessByRequestDate(requestDate);
	}

	@Override
	public List<JoinProcess> findJoinProcessByResponseDate(Date responseDate) {
		return jdao.selectJoinProcessByResponseDate(responseDate);
	}

	
	
}
