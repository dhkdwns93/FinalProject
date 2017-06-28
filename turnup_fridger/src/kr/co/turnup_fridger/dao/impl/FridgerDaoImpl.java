package kr.co.turnup_fridger.dao.impl;

import java.io.File;
import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import kr.co.turnup_fridger.dao.FridgerDao;
import kr.co.turnup_fridger.vo.Fridger;

@Repository
public class FridgerDaoImpl implements FridgerDao{

	@Autowired
	private SqlSessionTemplate session;
	
	private String makeSql(String tagId){
		return "fridgerMapper."+tagId;
	}
	
	
	@Override
	public int insertFridger(Fridger fridger) {
		return session.insert(makeSql("insertFridger"), fridger);
	}

	@Override
	public int updateFridger(Fridger fridger) {
		return session.update(makeSql("updateFridger"), fridger);
	}

	@Override
	public int deleteFridger(int fridgerId) {
		return session.delete(makeSql("deleteFridger"), fridgerId);
	}

	
	

	@Override
	public List<Fridger> selectFridgerAll() {
		return session.selectList(makeSql("selectFridgerAll"));
	}
	
	@Override
	public Fridger selectFridgerByFridgerId(int fridgerId) {
		return session.selectOne(makeSql("selectFridgerByFridgerId"), fridgerId);
	}

	@Override
	public Fridger selectFridgerAndIrdntByFridgerId(int fridgerId) {
		return session.selectOne(makeSql("selectFridgerAndIrdntByFridgerId"), fridgerId);
	}

	@Override
	public Fridger selectFridgerAndFridgerGroupByFridgerId(int fridgerId) {
		return session.selectOne(makeSql("selectFridgerAndFridgerGroupByFridgerId"), fridgerId);
	}


	@Override
	public List<Fridger> selectFridgerByFridgerFullName(String fridgerName) {
		return session.selectList(makeSql("selectFridgerByFridgerFullName"), fridgerName);
	}

	@Override
	public List<Fridger> selectFridgerByFridgerName(String FridgerName) {
		return session.selectList(makeSql("selectFridgerByFridgerName"), FridgerName);
	}

	@Override
	public List<Fridger> selectFridgerAndIrdntByFridgerName(String FridgerName) {
		return session.selectList(makeSql("selectFridgerAndIrdntByFridgerName"), FridgerName);
	}

	@Override
	public List<Fridger> selectFridgerAndFridgerGroupByFridgerName(String FridgerName) {
		return session.selectList(makeSql("selectFridgerAndFridgerGroupByFridgerName"), FridgerName);
	}



	
}
