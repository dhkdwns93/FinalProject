package kr.co.turnup_fridger.dao;

import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;

import kr.co.turnup_fridger.vo.JoinProcess;

public interface JoinProcessDao {
	/**
	 * 가입처리 insert
	 * @param joinProcess
	 * @return
	 */
	int insertJoinProcess(JoinProcess joinProcess);
	
	/**
	 * 가입처리 상태 update
	 * @param joinProcess
	 * @return
	 */
	int updateJoinProcess(JoinProcess joinProcess);
	
	/**
	 * 선택된 처리번호 delete
	 * @param processNoList
	 * @return
	 */
	int deleteJoinProcessByProcessNo(ArrayList<Integer> processNoList);
	
	/**
	 * 특정냉장고에대한 처리목록 delete
	 * @param fridgerId
	 * @return
	 */
	int deleteJoinProcessByFridgerId(int fridgerId);
	
	/**
	 * 승인대기상태로 14일이 경과한 건 delete 
	 * @return
	 */
	int deleteJoinProcessNotProcessedIn14Days();
	
	/**
	 * 승인완료상태로 6개월이 경과한 건 delete
	 * @return
	 */
	int deleteJoinProcessCompleted6MonthsBefore();

	/**
	 * 처리번호로 select
	 * @param processNo
	 * @return
	 */
	JoinProcess selectJoinProcessByProcessNo(int processNo);

	/**
	 * 모든 가입처리 목록 select
	 * @return
	 */
	List<JoinProcess> selectJoinProcessAll();
	
	/**
	 * 특정 냉장고 가입처리 목록 select
	 * @param fridgerId
	 * @return
	 */
	List<JoinProcess> selectJoinProcessByFridgerId(int fridgerId);
	
	/**
	 * 특정 처리상태로 가입처리 목록 select
	 * @param processState
	 * @return
	 */
	List<JoinProcess> selectJoinProcessByProcessState(int processState);
	
	/**
	 * 신청회원 Id로 목록 select
	 * @param reqMemberId
	 * @return
	 */
	List<JoinProcess> selectJoinProcessByRequestMemberId(String reqMemberId);
	
	/**
	 * 응답회원 Id로 목록 select
	 * @param respMemberId
	 * @return
	 */
	List<JoinProcess> selectJoinProcessByResponseMemberId(String respMemberId);

	/**
	 * 요청 회원과 응답회원으로 select
	 * @param reqMemberId
	 * @param respMemberId
	 * @return
	 */
	List<JoinProcess> selectJoinProcessByRequesterAndResponser(HashMap map);
	
	/**
	 * 신청일자로 select
	 * @param requestDate
	 * @return
	 */
	List<JoinProcess> selectJoinProcessByRequestDate(Date requestDate);
	
	/**
	 * 응답일자로 select
	 * @param responseDate
	 * @return
	 */
	List<JoinProcess> selectJoinProcessByResponseDate(Date responseDate);
	
}
