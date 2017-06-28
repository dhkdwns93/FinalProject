package kr.co.turnup_fridger.dao.impl;

import java.util.Date;
import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import kr.co.turnup_fridger.dao.MyIrdntDao;
import kr.co.turnup_fridger.vo.MyIrdnt;

@Repository
public class MyIrdntDaoImpl implements MyIrdntDao{

	@Autowired
	private SqlSessionTemplate session;
	private String makeSql(String id){
		return "kr.co.turnup_fridger.config.mybatis.mapper.MyIrdnt."+id;
	}
	
	@Override
	public int insertMyIrdnt(MyIrdnt irdnt) {
		return session.insert(makeSql("insertMyIrdnt"),irdnt);
	}

	@Override
	public int updateMyIrdnt(MyIrdnt irdnt) {
		return session.update(makeSql("updateMyIrdnt"),irdnt);
	}

	@Override
	public int deleteMyIrdnt(int irdntKey) {
		return session.delete(makeSql("deleteMyIrdnt"),irdntKey);
	}

	@Override
	public List<MyIrdnt> selectAllInfoMyIrdnt() {
		return session.selectList(makeSql("selectAllInfoMyIrdnt"));
	}

	@Override
	public MyIrdnt selectMyIrdntById(int irdntId) {
		return session.selectOne(makeSql("selectMyIrdntById"),irdntId);
	}

	@Override
	public List<MyIrdnt> selectMyIrdntByName(String irdntName) {
		return session.selectList(makeSql("selectMyIrdntByName"),irdntName);
	}

	@Override
	public List<MyIrdnt> selectMyStaleIrdnt(String freshLevel) {
		return session.selectList(makeSql("selectMyStaleIrdnt"),freshLevel);
	}

	@Override
	public List<MyIrdnt> selectSoonExpireMyIrdnt(Date endDate) {
		return session.selectList(makeSql("selectSoonExpireMyIrdnt"),endDate);
	}

	@Override
	public List<MyIrdnt> selectMyIrdntByStartDate(Date StartDate) {
		return session.selectList(makeSql("selectMyIrdntByStartDate"),StartDate);
	}

	@Override
	public int selectCountAllMyIrdnts() {
		return session.selectOne(makeSql("selectCountAllMyIrdnts"));
	}

	
}
