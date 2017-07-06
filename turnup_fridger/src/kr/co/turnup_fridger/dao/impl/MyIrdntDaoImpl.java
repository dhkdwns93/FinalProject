package kr.co.turnup_fridger.dao.impl;

import java.util.Date;
import java.util.HashMap;
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
		return "MyIrdnt."+id;
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
	public MyIrdnt selectMyIrdntByKey(int irdntKey) {
		return session.selectOne(makeSql("selectMyIrdntByKey"),irdntKey);
	}

	@Override
	public List<MyIrdnt> selectMyIrdntByName(String irdntName,int fridgerId) {
		HashMap map = new HashMap();
		map.put("irdntName",irdntName);
		map.put("fridgerId",fridgerId);
		return session.selectList(makeSql("selectMyIrdntByName"),map);
	}

	@Override
	public List<MyIrdnt> selectMyStaleIrdnt(String freshLevel,int fridgerId) {
		HashMap map = new HashMap();
		map.put("freshLevel",freshLevel);
		map.put("fridgerId",fridgerId);
		return session.selectList(makeSql("selectMyStaleIrdnt"),map);
	}

	@Override
	public List<MyIrdnt> selectSoonExpireMyIrdnt(Date endDate,int fridgerId) {
		HashMap map = new HashMap();
		map.put("endDate",endDate);
		map.put("fridgerId",fridgerId);
		return session.selectList(makeSql("selectSoonExpireMyIrdnt"),map);
	}

	@Override
	public List<MyIrdnt> selectMyIrdntByStartDate(Date StartDate,int fridgerId) {
		HashMap map = new HashMap();
		map.put("StartDate",StartDate);
		map.put("fridgerId",fridgerId);
		return session.selectList(makeSql("selectMyIrdntByStartDate"),map);
	}

	@Override
	public int selectCountAllMyIrdnts(int fridgerId) {
		return session.selectOne(makeSql("selectCountAllMyIrdnts"),fridgerId);
	}

	@Override
	public List<MyIrdnt> selectMyIrdntByFridgerId(int fridgerId) {
		return session.selectList(makeSql("selectMyIrdntByFridgerId"),fridgerId);
	}
	@Override
	public List<MyIrdnt> selectMyIrdntByFreshLevelAndIrdntName(String freshLevel, String irdntName,int fridgerId) {
		HashMap map = new HashMap();
		map.put("irdntName", irdntName);
		map.put("freshLevel", freshLevel);
		map.put("fridgerId", fridgerId);
		return session.selectList(makeSql("selectMyIrdntByFreshLevelAndIrdntName"),map);
	}

	
	
}
