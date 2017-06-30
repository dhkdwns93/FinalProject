package kr.co.turnup_fridger.dao.impl;

import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import kr.co.turnup_fridger.dao.JoinProcessDao;
import kr.co.turnup_fridger.vo.JoinProcess;

@Repository
public class JoinProcessDaoImpl implements JoinProcessDao{

	@Autowired
	private SqlSessionTemplate session;
	
	private String makeSql(String tagId){
		return "joinProcessMapper."+tagId;
	}
	
	@Override
	public int insertJoinProcess(JoinProcess joinProcess) {
		return session.insert(makeSql("insertJoinProcess"), joinProcess);
	}

	@Override
	public int updateJoinProcess(JoinProcess joinProcess) {
		return session.update(makeSql("updateJoinProcess"), joinProcess);
	}

	@Override
	public int deleteJoinProcessByProcessNo(ArrayList<Integer> processNoList) {
		return session.delete(makeSql("deleteJoinProcessByProcessNo"), processNoList);
	}

	@Override
	public int deleteJoinProcessNotProcessedIn14Days() {
		return session.delete(makeSql("deleteJoinProcessNotProcessedIn14Days"));
	}

	@Override
	public int deleteJoinProcessCompleted6MonthsBefore() {
		return session.delete(makeSql("deleteJoinProcessCompleted6MonthsBefore"));
	}

	
	
	
	@Override
	public List<JoinProcess> selectJoinProcessAll() {
		return session.selectList(makeSql("selectJoinProcessAll"));
	}

	@Override
	public List<JoinProcess> selectJoinProcessByFridgerId(int fridgerId) {
		return session.selectList(makeSql("selectJoinProcessByFridgerId"), fridgerId);
	}

	@Override
	public List<JoinProcess> selectJoinProcessByProcessState(int processState) {
		return session.selectList(makeSql("selectJoinProcessByProcessState"), processState);
	}

	@Override
	public List<JoinProcess> selectJoinProcessByRequestMemberId(String reqMemberId) {
		return session.selectList(makeSql("selectJoinProcessByRequestMemberId"), reqMemberId);
	}

	@Override
	public List<JoinProcess> selectJoinProcessByResponseMemberId(String respMemberId) {
		return session.selectList(makeSql("selectJoinProcessByResponseMemberId"), respMemberId);
	}
	
	

	@Override
	public List<JoinProcess> selectJoinProcessByRequesterAndResponser(HashMap map) {
		return session.selectList(makeSql("selectJoinProcessByResponseMemberId"), map);
	}

	@Override
	public List<JoinProcess> selectJoinProcessByRequestDate(Date requestDate) {
		return session.selectList(makeSql("selectJoinProcessByRequestDate"), requestDate);
	}

	@Override
	public List<JoinProcess> selectJoinProcessByResponseDate(Date responseDate) {
		return session.selectList(makeSql("selectJoinProcessByResponseDate"), responseDate);
	}

	
}
