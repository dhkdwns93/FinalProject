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

	//댓글 추가
	@Override
	public int insertCommentFree(CommentFree commentFree) {
		return session.insert(makeSqlId("insertCommentFree"),commentFree);
	}

	//댓글 수 증가 
	@Override
	public int commentCount(int boardFreeId) {
		return session.update(makeSqlId("boardFreeCount"),boardFreeId);
	}
	
	//댓글 수정
	@Override
	public int updateCommentFree(CommentFree commentFree) {
		return session.update(makeSqlId("updateCommentFree"),commentFree);
	}

	//댓글 수 감소
	@Override
	public int commentDeleteCount(int boardFreeId) {
		return session.update(makeSqlId("boardFreeDeleteCount"),boardFreeId);
	}
	
	//댓글 삭제
	@Override
	public int deleteCommentFree(int id) {
		return session.update(makeSqlId("deleteCommentFree"),id);
	}

	//댓글 전체 수 조회
	@Override
	public int selectCommentFreeCount(int boardFreeId) {
		return session.selectOne(makeSqlId("selectCommentFreeCount"),boardFreeId);
	}

	//댓글 목록 조회(페이징)
	@Override
	public List<CommentFree> selectCommentFreeListbyId(int boardFreeId,int startIndex, int endIndex) {
		Map<String, Object> input = new HashMap<String, Object>();
		input.put("boardFreeId",boardFreeId);
		input.put("startIndex",startIndex);
		input.put("endIndex",endIndex);
		return session.selectList(makeSqlId("selectCommentFreeListbyId"),input);
	}

	//해당 댓글 상세 정보 조회
	@Override
	public CommentFree selectCommentFreeById(int commentFreeId) {
		// TODO Auto-generated method stub
		return session.selectOne(makeSqlId("selectCommentFreeById"),commentFreeId);
	}
	
	
}
