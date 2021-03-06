package kr.co.turnup_fridger.dao.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
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
		System.out.println("여기는 dao, 받아온 냉장고id="+fridgerId);
		return session.selectOne(makeSql("selectFridgerAndIrdntByFridgerId"), fridgerId);
	}

	@Override
	public Fridger selectFridgerAndFridgerGroupByFridgerId(int fridgerId) {
		return session.selectOne(makeSql("selectFridgerAndFridgerGroupByFridgerId"), fridgerId);
	}


	@Override
	public Fridger selectFridgerByFridgerFullName(String fridgerName) {
		return session.selectOne(makeSql("selectFridgerByFridgerFullName"), fridgerName);
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


	@Override
	public List<Fridger> selectFridgerByOwnerId(String memberId) {
		return session.selectList(makeSql("selectFridgerByOwnerId"), memberId);
	}


	@Override
	public List<Fridger> selectFridgerAndFridgerGroupByOwnerId(String memberId) {
		return session.selectList(makeSql("selectFridgerAndFridgerGroupByOwnerId"), memberId);
	}


	@Override
	public List<Fridger> selectFridgerAndIrdntByOwnerId(String memberId) {
		return session.selectList(makeSql("selectFridgerAndIrdntByOwnerId"), memberId);
	}


	
	/**************************페이지 처리*************************/

	@Override
	public List<Fridger> selectFridgerByFridgerNamePaging(String fridgerName, int startIndex, int endIndex) {
		Map<String, Object> input = new HashMap<String,Object>();
		input.put("fridgerName", fridgerName);
		input.put("startIndex", startIndex);
		input.put("endIndex", endIndex);
		return session.selectList(makeSql("selectFridgerByFridgerNamePaging"), input);
	}


	@Override
	public List<Fridger> selectFridgerByOwnerIdPaging(String memberId, int startIndex, int endIndex) {
		Map<String, Object> input = new HashMap<String,Object>();
		input.put("memberId", memberId);
		input.put("startIndex", startIndex);
		input.put("endIndex", endIndex);
		return session.selectList(makeSql("selectFridgerByOwnerIdPaging"), input);
	}


	@Override
	public int selectCountFridgerByFridgerName(String fridgerName) {
		return session.selectOne(makeSql("selectCountFridgerByFridgerName"), fridgerName);
	}


	@Override
	public int selectCountFridgerByOwnerId(String memberId) {
		return session.selectOne(makeSql("selectCountFridgerByOwnerId"), memberId);
	}


	
	
}
