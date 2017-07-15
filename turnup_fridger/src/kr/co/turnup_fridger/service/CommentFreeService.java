package kr.co.turnup_fridger.service;

import java.util.List;
import java.util.Map;

import kr.co.turnup_fridger.vo.CommentFree;

public interface CommentFreeService  {

	//댓글 등록
	void addCommentFree(CommentFree commentFree);
	//댓글수 증가
	void commentCount(int boardFreeId);
	
	//댓글 수정
	void updateCommentFree(CommentFree commentFree);
	//댓글 삭제
	void removeCommentFree(int id);
	//댓글수 감소
	void commentDeleteCount(int boardFreeId);
	
	
	//전체 댓글 조회
	Map<String, Object> selectCommentFreeListbyId(int id,int page);
	//해당 댓글 상세 조회
	CommentFree selectCommentFreeById(int commentFreeId);
}
