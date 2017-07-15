package kr.co.turnup_fridger.dao;

import java.util.List;

import kr.co.turnup_fridger.vo.CommentFree;

public interface CommentFreeDao {
	
	//댓글 등록
	int insertCommentFree(CommentFree commentFree);
	
	//댓글수  증가
	int commentCount(int boardFreeId);
	
	int updateCommentFree(CommentFree commentFree);
	
	//댓글 수 삭제
	int commentDeleteCount(int boardFreeId);
	
	//댓글 삭제
	int deleteCommentFree(int id);
	
	//전체 댓글 수 조회
	int selectCommentFreeCount(int boardFreeId);
	
	//댓글 페이징
	List<CommentFree> selectCommentFreeListbyId(int boardFreeId, int startIndex, int endIndex);
	
	//해당 댓글 상세 정보 보기
	CommentFree selectCommentFreeById(int commentFreeId);
}
