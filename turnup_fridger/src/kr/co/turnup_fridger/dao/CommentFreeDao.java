package kr.co.turnup_fridger.dao;

import java.util.List;

import kr.co.turnup_fridger.vo.CommentFree;

public interface CommentFreeDao {
	int insertCommentFree(CommentFree commentFree);
	int updateCommentFree(CommentFree commentFree);
	int deleteCommentFree(int id);
	
	/**
	 * MEMBER QnA의 전체수를 반환
	 * @param session
	 * @return
	 */
	int selectCommentFreeCount(int boardFreeId);
	//댓글 페이징
	List<CommentFree> selectCommentFreeListbyId(int boardFreeId, int startIndex, int endIndex);
}
