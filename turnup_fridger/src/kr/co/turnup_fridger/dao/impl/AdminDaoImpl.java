/**
 (DaoImpl)AdminDaoImpl
작성자 :  김경혜
최초 작성일 170630
변경이력 
*/
package kr.co.turnup_fridger.dao.impl;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import kr.co.turnup_fridger.dao.AdminDao;
import kr.co.turnup_fridger.vo.Admin;

@Repository
public class AdminDaoImpl implements AdminDao {
	
	@Autowired
	private SqlSessionTemplate session;
	
	private String makeSqlId(String id){
		return "AdminMapper."+id;
	}
	
	@Override
	public int insertAdmin(Admin admin) {
		return session.insert(makeSqlId("insertAdmin"),admin);
	}

	@Override
	public int updateAdmin(Admin admin) {
		return session.update(makeSqlId("updateAdmin"),admin);
	}

	@Override
	public int updateAuthority(Admin admin) {
		return session.update(makeSqlId("updateAuthority"),admin);
	}

	@Override
	public int deleteAdminById(String loginId) {
		return session.delete(makeSqlId("deleteAdminById"),loginId);
	}

	@Override
	public List<Admin> selectAdminList() {
		return session.selectList(makeSqlId("selectAdminList"));
	}

	@Override
	public Admin selectAdminById(String loginId) {
		return session.selectOne(makeSqlId("selectAdminById"),loginId);
	}

}
