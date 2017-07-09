/**
 (ServiceImpl)MyDislikeIrdntServiceImpl
작성자 :  박연수
최초 작성일 
변경이력 
170706 (경혜) removeMyDislikeIrdntByMemberId 메소드 추가
					removeMyDislikeIrdntByIrdntId 메소드 추가
*/
package kr.co.turnup_fridger.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.co.turnup_fridger.dao.MyDislikeIrdntDao;
import kr.co.turnup_fridger.service.MyDislikeIrdntService;
import kr.co.turnup_fridger.vo.MyDislikeIrdnt;

@Service("MyDislikeIrdntService")
public class MyDislikeIrdntServiceImpl implements MyDislikeIrdntService{

	@Autowired
	private MyDislikeIrdntDao dao;

	@Override
	public void createMyDislikeIrdnt(MyDislikeIrdnt myDislikeIrdnt) throws Exception {
		if(dao.selectMyDislikeIRdntByMemberIdAndIrdntId(myDislikeIrdnt)!=null){
			throw new Exception ("이미 등록된 기피재료입니다.");
		}
		dao.insertMyDislikeIrdnt(myDislikeIrdnt);
	}

	@Override
	public void updateMyDislikeIrdnt(MyDislikeIrdnt irdnt) throws Exception {
		if(dao.selectMyDislikeIrdntByMyDislikeIrdntKey(irdnt.getMyDislikeIrdntsKey())==null){
			throw new Exception("등록되지 않은 기피재료 입니다.");
		}
		dao.updateMyDislikeIrdnt(irdnt);		
	}

	@Override
	public void removeMyDislikeIrdnt(int myDislikeIrdntKey) throws Exception {
		if(dao.selectMyDislikeIrdntByMyDislikeIrdntKey(myDislikeIrdntKey)==null){
			throw new Exception("등록되지 않은 기피재료 입니다.");
		}
		dao.deleteMyDislikeIrdnt(myDislikeIrdntKey);
//		System.out.println("삭제완료");
	}

	@Override
	public void removeMyDislikeIrdntByMemberId(String memberId){
		/*if(dao.selectMyDislikeIrdntByMemberId(memberId)==null){
			throw new Exception("해당 ID의 기피재료가 없습니다. 입니다.");
		}*/
		dao.deleteMyDislikeIrdntByMemberId(memberId);
		//System.out.println("삭제완료-회원ID로 조회");
	}

	@Override
	public void removeMyDislikeIrdntByIrdntId(int irdntId) throws Exception {
		dao.deleteMyDislikeIrdntByIrdntId(irdntId);
//		System.out.println("삭제완료-재료ID로 조회");
	}

	@Override
	public List<MyDislikeIrdnt> findMyDislikeIrdntByMemberId(String memberId) {
		return dao.selectMyDislikeIrdntByMemberId(memberId);
	}

	@Override
	public MyDislikeIrdnt findMyDislikeIrdntBymyDislikeIrdntKey(int myDislikeIrdntKey) {
		return dao.selectMyDislikeIrdntByMyDislikeIrdntKey(myDislikeIrdntKey);
	}

	
}
