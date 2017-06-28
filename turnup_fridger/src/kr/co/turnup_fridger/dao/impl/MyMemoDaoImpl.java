package kr.co.turnup_fridger.dao.impl;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import kr.co.turnup_fridger.dao.MyMemoDao;
import kr.co.turnup_fridger.vo.MyMemo;

@Repository
public class MyMemoDaoImpl implements MyMemoDao{
	
	@Autowired
	private SqlSessionTemplate session;

	String sql="kr.co.turnUp_fridger.config.mybatis.mapper.myMemoMapper.";
	
	@Override
	public int insertMemo(MyMemo memo) {
		return session.insert(sql+"insertMemo", memo);
	}

	@Override
	public int updateMemo(MyMemo memo) {
		return session.update(sql+"updateMemo", memo);
	}

	@Override
	public int deleteMemo(int memoId) {
		return session.delete(sql+"deleteMemo", memoId);
	}

	@Override
	public List<MyMemo> selectMemoList(String memberId) {
		return session.selectList(sql+"selectMemoList", memberId);
	}

	@Override
	public MyMemo selectOneMemo(int memoId) {
		return session.selectOne(sql+"selectOneMemo", memoId);
	}

	@Override
	public int selectMemoCount(String memberId) {
		return session.selectOne(sql+"selectMemoCount", memberId);
	}

	
}
