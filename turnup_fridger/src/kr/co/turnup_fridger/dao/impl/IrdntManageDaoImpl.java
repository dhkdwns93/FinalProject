package kr.co.turnup_fridger.dao.impl;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import kr.co.turnup_fridger.dao.IrdntManageDao;
import kr.co.turnup_fridger.vo.IrdntManage;

@Repository
public class IrdntManageDaoImpl implements IrdntManageDao{

	@Autowired
	private SqlSessionTemplate session;
	private String makeSql(String id){
		return "kr.co.turnup_fridger.config.mybatis.mapper.IrdntManageMapper."+id;
	}
	
	@Override
	public int insertIrdnt(IrdntManage irdnt) {
		return session.insert(makeSql("insertIrdnt"),irdnt);
	}

	@Override
	public int updateIrdnt(IrdntManage irdnt) {
		return session.update(makeSql("updateIrdnt"),irdnt);
	}

	@Override
	public int deleteIrdnt(int irdntId) {
		return session.delete(makeSql("deleteIrdnt"),irdntId);
	}

	@Override
	public List<IrdntManage> selectAllIrdnt() {
		return session.selectList(makeSql("selectAllIrdnt"));
	}

	@Override
	public List<IrdntManage> selectIrdntByName(String irdntName) {
		return session.selectList(makeSql("selectIrdntByName"),irdntName);
	}

	@Override
	public List<IrdntManage> selectIrdntByFullName(String irdntName) {
		return session.selectList(makeSql("selectIrdntByFullName"),irdntName);
	}

	@Override
	public IrdntManage selectIrdntById(int irdntId) {
		return session.selectOne(makeSql("selectIrdntById"),irdntId);
	}

	@Override
	public List<IrdntManage> selectIrdntByCategory(String irdntCategory) {
		return session.selectList(makeSql("selectIrdntByCategory"),irdntCategory);
	}

}
