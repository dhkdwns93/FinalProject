package kr.co.turnup_fridger.service;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import kr.co.turnup_fridger.vo.Fridger;
import kr.co.turnup_fridger.vo.JoinProcess;

public interface JoinProcessService {
	
	/**
	 * 냉장고(그룹) 가입 신청 처리상태 추가
	 * @param joinProcess
	 * @return
	 */
	public void requestJoinFridgerGroup(JoinProcess joinProcess) throws Exception;
	
	/**
	 * 냉장고(그룹) 초대 신청 처리상태 추가
	 * @param joinProcess
	 * @return
	 */
	public void inviteJoinFridgerGroup(JoinProcess joinProcess) throws Exception;
	
	/**
	 * 냉장고(그룹) 가입 신청 / 초대 처리상태 변경
	 * -> 승인완료가 되면 냉장고 그룹으로 insert
	 * @param joinProcess
	 * @return
	 */
	void updateJoinProcess(JoinProcess joinProcess) throws Exception;
	
	/**
	 * 냉장고(그룹) 가입 신청 / 초대 처리상태 삭제
	 * @param processNoList
	 * @return
	 */
	int removeJoinProcessByProcessNo(ArrayList<Integer> processNoList) throws Exception;
	
	/**
	 * 처리상태가  승인대기상태로 14일이 경과한 건 삭제
	 * @return
	 */
	int removeJoinProcessNotProcessedIn14Days();
	
	/**
	 * 처리상태가  승인완료상태로 6개월이 경과한 건 삭제
	 * @return
	 */
	int removeJoinProcessCompleted6MonthsBefore();


	/**
	 * 모든 가입처리 목록 조회
	 * @return
	 */
	List<JoinProcess> findJoinProcessAll();
	
	/**
	 * 냉장고Id로 가입신청/초대 처리 목록 조회
	 * @param fridgerId
	 * @return
	 */
	List<JoinProcess> findJoinProcessByFridgerId(int fridgerId);
	
	/**
	 * 특정 처리상태로 가입신청/초대 처리 목록 조회
	 * @param processState
	 * @return
	 */
	List<JoinProcess> findJoinProcessByProcessState(int processState);
	
	/**
	 * 신청회원 Id로  가입신청/초대 처리 목록 조회
	 * @param reqMemberId
	 * @return
	 */
	List<JoinProcess> findJoinProcessByRequestMemberId(String reqMemberId);
	
	/**
	 * 응답회원 Id로 가입신청/초대 처리 목록 조회
	 * @param respMemberId
	 * @return
	 */
	List<JoinProcess> findJoinProcessByResponseMemberId(String respMemberId);
	
	/**
	 * 요청일자로 가입신청/초대 처리 목록 조회
	 * @param requestDate
	 * @return
	 */
	List<JoinProcess> findJoinProcessByRequestDate(Date requestDate);
	
	/**
	 * 응답일자로 가입신청/초대 처리 목록 조회
	 * @param responseDate
	 * @return
	 */
	List<JoinProcess> findJoinProcessByResponseDate(Date responseDate);
	

}
