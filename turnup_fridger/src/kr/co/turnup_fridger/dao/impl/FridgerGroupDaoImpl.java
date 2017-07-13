package kr.co.turnup_fridger.dao.impl;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import kr.co.turnup_fridger.dao.FridgerGroupDao;
import kr.co.turnup_fridger.vo.FridgerGroup;

@Repository
public class FridgerGroupDaoImpl implements FridgerGroupDao{

	@Autowired
	private SqlSessionTemplate session;
	
	private String sql = "kr.co.turnup_fridger.config.mybatis.mapper.fridgerGroupMapper.";
	
	@Override
	public int insertFridgerGroup(FridgerGroup fg) {
		return session.insert(sql+"insertFridgerGroup", fg);
	}
	
	@Override
	public int deleteFridgerGroup(String groupMemberId) {
		return session.delete(sql+"deleteFridgerGroup", groupMemberId);
	}

	
	@Override
	public int deleteFridgerGroupByFridgerId(int groupFridgerId) {
		return session.delete(sql+"deleteFridgerGroupByFridgerId", groupFridgerId);
	}

	@Override
	public List<FridgerGroup> selectFridgerGroupByGroupMemberId(String groupMemberId) {
		return session.selectList(sql+"selectFridgerGroupByGroupMemberId", groupMemberId);
	}

	@Override
	public List<FridgerGroup> selectFridgerGroupByFridgerId(int fridgerId) {
		return session.selectList(sql+"selectFridgerGroupByFridgerId", fridgerId);
	}

	@Override
	public int selectFridgerGroupCount(int fridgerId) {
		return session.selectOne(sql+"selectFridgerGroupCount", fridgerId);
	}

	
}
