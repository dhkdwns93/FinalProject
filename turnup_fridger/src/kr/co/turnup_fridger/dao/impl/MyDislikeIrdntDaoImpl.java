/**
 (DAOImpl)MyDislikeIrdntDaoImpl
작성자 :  박연수
최초 작성일 
변경이력 
170706 (경혜) deleteMyDislikeIrdntByMemberId 메소드 추가
					deleteMyDislikeIrdntByIrdntId 메소드 추가
					selectMyDislikeIRdntByMemberIdAndIrdntId 메소드 추가
*/
package kr.co.turnup_fridger.dao.impl;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import kr.co.turnup_fridger.dao.MyDislikeIrdntDao;
import kr.co.turnup_fridger.vo.MyDislikeIrdnt;

@Repository
public class MyDislikeIrdntDaoImpl implements MyDislikeIrdntDao{


	@Autowired
	private SqlSessionTemplate session;
	private String makeSql(String id){
		return "MyDislikeIrdnt."+id;
	}
	
	@Override
	public int insertMyDislikeIrdnt(MyDislikeIrdnt irdnt) {
		return session.insert(makeSql("insertMyDislikeIrdnt"),irdnt);
	}

	@Override
	public int updateMyDislikeIrdnt(MyDislikeIrdnt irdnt) {
		return session.update(makeSql("updateMyDislikeIrdnt"),irdnt);
	}

	@Override
	public int deleteMyDislikeIrdnt(int myDislikeIrdntKey) {
		return session.delete(makeSql("deleteMyDislikeIrdnt"),myDislikeIrdntKey);
	}
	
	@Override
	public int deleteMyDislikeIrdntByMemberId(String memberId) {
		return session.delete(makeSql("deleteMyDislikeIrdntByMemberId"),memberId);
	}

	@Override
	public int deleteMyDislikeIrdntByIrdntId(int irdntId) {
		return session.delete(makeSql("deleteMyDislikeIrdntByIrdntId"),irdntId);
	}

	@Override
	public List<MyDislikeIrdnt> selectMyDislikeIrdntByMemberId(String memberId) {
		return session.selectList(makeSql("selectMyDislikeIrdntByMemberId"),memberId);
	}

	@Override
	public MyDislikeIrdnt selectMyDislikeIRdntByMemberIdAndIrdntId(MyDislikeIrdnt myDislikeIrdnt) {
		return session.selectOne(makeSql("selectMyDislikeIrdntByMemberIdAndIrdntId"),myDislikeIrdnt);
	}

	@Override
	public MyDislikeIrdnt selectMyDislikeIrdntByMyDislikeIrdntKey(int myDislikeIrdntKey) {
		return session.selectOne(makeSql("selectMyDislikeIrdntByMyDislikeIrdntKey"),myDislikeIrdntKey);
	}

	
	
}
