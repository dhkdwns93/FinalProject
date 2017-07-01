/**
 (DaoImpl)authorityDaoImpl
작성자 :  김경혜
최초 작성일 170630
변경이력 
*/
package kr.co.turnup_fridger.dao.impl;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import kr.co.turnup_fridger.dao.AuthorityDao;
import kr.co.turnup_fridger.vo.Authority;

@Repository
public class AuthorityDaoImpl implements AuthorityDao {

	@Autowired
	private SqlSessionTemplate session;
	
	private String makeSqlId(String id){
		return "AuthorityMapper."+id;
	}
	
	@Override
	public int insertAuthority(Authority authority) {
		// TODO Auto-generated method stub
		return session.insert(makeSqlId("insertAuthority"),authority);
	}

	@Override
	public int updateAuthority(Authority authority) {
		// TODO Auto-generated method stub
		return session.update(makeSqlId("updateAuthority"),authority);
	}

	@Override
	public int deleteAuthority(String loginId) {
		// TODO Auto-generated method stub
		return session.delete(makeSqlId("deleteAuthority"),loginId);
	}

	@Override
	public Authority selectAuthorityById(String loginId) {
		// TODO Auto-generated method stub
		return session.selectOne(makeSqlId("selectAuthorityById"),loginId);
	}
}
