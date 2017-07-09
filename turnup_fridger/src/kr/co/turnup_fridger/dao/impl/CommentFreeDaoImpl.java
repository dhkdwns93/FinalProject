package kr.co.turnup_fridger.dao.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import kr.co.turnup_fridger.dao.CommentFreeDao;
import kr.co.turnup_fridger.vo.CommentFree;

@Repository
public class CommentFreeDaoImpl implements CommentFreeDao {
	
	@Autowired
	private SqlSessionTemplate session;

	private String makeSqlId(String id){
		return "kr.co.turnup_fridger.config.mybatis.mapper.CommentFreeMapper."+id;
	}


	@Override
	public int insertCommentFree(CommentFree commentFree) {
		return session.insert(makeSqlId("insertCommentFree"),commentFree);
	}


	@Override
	public int updateCommentFree(CommentFree commentFree) {
		return session.update(makeSqlId("updateCommentFree"),commentFree);
	}


	@Override
	public int deleteCommentFree(int id) {
		return session.update(makeSqlId("deleteCommentFree"),id);
	}


	@Override
	public int selectCommentFreeCount(int boardFreeId) {
		return session.selectOne(makeSqlId("selectCommentFreeCount"),boardFreeId);
	}


	@Override
	public List<CommentFree> selectCommentFreeListbyId(int boardFreeId,int startIndex, int endIndex) {
		Map<String, Object> input = new HashMap<String, Object>();
		input.put("boardFreeId",boardFreeId);
		input.put("startIndex",startIndex);
		input.put("endIndex",endIndex);
		return session.selectList(makeSqlId("selectCommentFreeListbyId"),input);
	}
	
	
}
