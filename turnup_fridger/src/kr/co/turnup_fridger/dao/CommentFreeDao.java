package kr.co.turnup_fridger.dao;

import java.util.List;

import kr.co.turnup_fridger.vo.CommentFree;

public interface CommentFreeDao {
	
	/*
	 * CommentFree 정보를 insert 하는 메소드 - 회원
	 * 작성자 : 김장규
	 */
	int insertCommentFree(CommentFree commentFree);
	
	/*
	 * BoardFree 댓글 증가 하는 메소드 
	 * 작성자 : 김장규
	 */
	int commentCount(int boardFreeId);
	
	/*
	 * CommentFree 정보를 update 하는 메소드 - 작성자
	 * 작성자 : 김장규
	 */
	int updateCommentFree(CommentFree commentFree);
	
	/*
	 * BoardFree 댓글수 감수 하는 메소드
	 * 작성자 : 김장규
	 */
	int commentDeleteCount(int boardFreeId);
	
	/*
	 * CommentFree 정보를 delete 하는 메소드 - 관리자, 작성자
	 * 작성자 : 김장규
	 */
	int deleteCommentFree(int id);
	
	/*
	 * CommentFree 댓글 수 반환 하는 메소드
	 * 작성자 : 김장규
	 */
	int selectCommentFreeCount(int boardFreeId);
	
	/*
	 * CommentFree 목록 조회 하는 메소드
	 * 작성자 : 김장규
	 */
	List<CommentFree> selectCommentFreeListbyId(int boardFreeId, int startIndex, int endIndex);
	
	
	/*
	 * CommentFree 해당 댓글 정보 상세정보 조회 하는 메소드 
	 * 작성자 : 김장규
	 */
	CommentFree selectCommentFreeById(int commentFreeId);
}
