/**
 (DaoImpl)MemberDaoImpl
작성자 :  김경혜
최초 작성일 170627
변경이력 
*/
package kr.co.turnup_fridger.dao.impl;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;

import kr.co.turnup_fridger.dao.MemberDao;
import kr.co.turnup_fridger.vo.Member;

public class MemberDaoImpl implements MemberDao {
	
	private SqlSessionTemplate session;
	
	private String makeSqlId(String id){
		return "kr.co.turnup_fridger.config.mybatis.mapper.MemberMapper."+id;
	}
	
	@Override
	public int insertMember(Member member) {
		return session.insert(makeSqlId("insertMember"),member);
	}

	@Override
	public int updateMember(Member member) {
		return session.update(makeSqlId("updateMember"),member);
	}

	@Override
	public int deleteMemberById(String loginId) {
		return session.delete(makeSqlId("deleteMemberById"),loginId);
	}

	@Override
	public List<Member> selectMemberList() {
		return session.selectList(makeSqlId("selectMemberList"));
	}

	@Override
	public Member selectMemberById(String loginId) {
		return session.selectOne(makeSqlId("selectMemberById"),loginId);
	}

	@Override
	public Member selectMemberByEmail(String memberEmail) {
		return session.selectOne(makeSqlId("selectMemberByEmail"),memberEmail);
	}
}
