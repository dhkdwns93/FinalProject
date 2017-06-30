package kr.co.turnup_fridger.service.impl;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;

import kr.co.turnup_fridger.dao.JoinProcessDao;
import kr.co.turnup_fridger.service.JoinProcessService;
import kr.co.turnup_fridger.vo.Fridger;
import kr.co.turnup_fridger.vo.JoinProcess;

public class JoinProcessServiceImpl implements JoinProcessService{

	@Autowired
	private JoinProcessDao dao;
	
	
	

	@Override
	public void requestJoinFridgerGroup(String reqMemberId, Fridger fridger) throws Exception {
		//존재하는 냉장고인지 체크
		if(dao.selectJoinProcessByFridgerId(fridger.getFridgerId()) == null || dao.selectJoinProcessByFridgerId(fridger.getFridgerId()).isEmpty()){
			throw new Exception("존재하지 않는 냉장고 입니다.");
		}
		//한 냉장고(그룹)에 대해 중복요청인지 체크
		// (1)냉장고 id로 검색된 가입처리 목록 가져오기
		for(JoinProcess jp : dao.selectJoinProcessByFridgerId(fridger.getFridgerId())){
			
			if(jp.getReqMemberId().equals(reqMemberId) && jp.getProcessState() == 10){
				//(2)목록의 신청자에 id가 있고, 처리상태가 10(가입승인대기)일 때
				throw new Exception("이미 가입승인대기중인 냉장고입니다.");
			}
		}
		//(3)목록의 신청자가 아니라면 -> 가입처리 목록에 가입승인대기(10) 상태로 추가
		dao.insertJoinProcess(new JoinProcess(0, fridger.getFridgerId(), 10, new Date(), null, reqMemberId, fridger.getMemberId() ));
	}

	@Override
	public void inviteJoinFridgerGroup(Fridger fridger, String respMemberId) throws Exception {
		// 존재하는 회원인지 체크
		/*if (){
		}*/
		
		// 같은 회원(그룹)에 대해 중복요청인지 체크
		// (1)냉장고 id로 검색된 가입처리 목록 가져오기
		for (JoinProcess jp : dao.selectJoinProcessByFridgerId(fridger.getFridgerId())) {
			if (jp.getRespMemberId().equals(respMemberId) && jp.getProcessState() == 20) {
				// (2)목록의 신청자에 id가 있고, 처리상태가 20(초대승인대기)일 때
				throw new Exception("이미 초대승인대기중인 회원입니다.");
			}
		}
		// (3)목록의 응답자가 아니라면 -> 가입처리 목록에 초대승인대기(20) 상태로 추가
		dao.insertJoinProcess(
				new JoinProcess(0, fridger.getFridgerId(), 20, new Date(), null, fridger.getMemberId(), respMemberId));
	}

	@Override
	public void updateJoinProcess(JoinProcess joinProcess) throws Exception {
		// TODO Auto-generated method stub
		
	}

	@Override
	public int removeJoinProcessByProcessNo(ArrayList<Integer> processNoList) throws Exception {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public int removeJoinProcessNotProcessedIn14Days() {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public int removeJoinProcessCompleted6MonthsBefore() {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public List<JoinProcess> findJoinProcessAll() {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public List<JoinProcess> findJoinProcessByFridgerId(int fridgerId) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public List<JoinProcess> findJoinProcessByProcessState(int processState) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public List<JoinProcess> findJoinProcessByRequestMemberId(String reqMemberId) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public List<JoinProcess> findJoinProcessByResponseMemberId(String respMemberId) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public List<JoinProcess> findJoinProcessByRequestDate(Date requestDate) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public List<JoinProcess> findJoinProcessByResponseDate(Date responseDate) {
		// TODO Auto-generated method stub
		return null;
	}

	
	
}
