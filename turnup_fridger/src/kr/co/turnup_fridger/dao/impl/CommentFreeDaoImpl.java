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

	/*
	 * CommentFree 정보를 insert 하는 메소드 - 회원
	 * 작성자 : 김장규
	 */
	@Override
	public int insertCommentFree(CommentFree commentFree) {
		return session.insert(makeSqlId("insertCommentFree"),commentFree);
	}

	/*
	 * BoardFree 댓글 증가 하는 메소드 
	 * 작성자 : 김장규
	 */
	@Override
	public int commentCount(int boardFreeId) {
		return session.update(makeSqlId("boardFreeCount"),boardFreeId);
	}
	
	/*
	 * CommentFree 정보를 update 하는 메소드 - 작성자
	 * 작성자 : 김장규
	 */
	@Override
	public int updateCommentFree(CommentFree commentFree) {
		return session.update(makeSqlId("updateCommentFree"),commentFree);
	}

	/*
	 * BoardFree 댓글수 감수 하는 메소드
	 * 작성자 : 김장규
	 */
	@Override
	public int commentDeleteCount(int boardFreeId) {
		return session.update(makeSqlId("boardFreeDeleteCount"),boardFreeId);
	}
	
	/*
	 * CommentFree 정보를 delete 하는 메소드 - 관리자, 작성자
	 * 작성자 : 김장규
	 */
	@Override
	public int deleteCommentFree(int id) {
		return session.update(makeSqlId("deleteCommentFree"),id);
	}


	/*
	 * CommentFree 댓글 수 반환 하는 메소드
	 * 작성자 : 김장규
	 */
	@Override
	public int selectCommentFreeCount(int boardFreeId) {
		return session.selectOne(makeSqlId("selectCommentFreeCount"),boardFreeId);
	}

	/*
	 * CommentFree 목록 조회 하는 메소드
	 * 작성자 : 김장규
	 */
	@Override
	public List<CommentFree> selectCommentFreeListbyId(int boardFreeId,int startIndex, int endIndex) {
		Map<String, Object> input = new HashMap<String, Object>();
		input.put("boardFreeId",boardFreeId);
		input.put("startIndex",startIndex);
		input.put("endIndex",endIndex);
		return session.selectList(makeSqlId("selectCommentFreeListbyId"),input);
	}

	/*
	 * CommentFree 해당 댓글 정보 상세정보 조회 하는 메소드 
	 * 작성자 : 김장규
	 */
	@Override
	public CommentFree selectCommentFreeById(int commentFreeId) {
		return session.selectOne(makeSqlId("selectCommentFreeById"),commentFreeId);
	}
	
	
}
