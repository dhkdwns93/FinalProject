package kr.co.turnup_fridger.service;

import java.util.List;
import java.util.Map;

import kr.co.turnup_fridger.vo.CommentFree;

public interface CommentFreeService  {

	/*
	 * 자유게시판 댓글 등록 - 회원
	 * 작성자 : 김장규
	 */
	void addCommentFree(CommentFree commentFree);
	
	/*
	 * 자유게시판 댓글수 증가
	 * 작성자 : 김장규
	 */
	void commentCount(int boardFreeId);
	
	/*
	 * 자유게시판 댓글 수정 - 작성자
	 * 작성자 : 김장규
	 */
	void updateCommentFree(CommentFree commentFree);
	
	/*
	 * 자유게시판 댓글 삭제 - 관리자, 작성자
	 * 작성자 : 김장규
	 */
	void removeCommentFree(int id);
	
	/*
	 * 자유게시판 댓글수 감소
	 * 작성자 : 김장규
	 */
	void commentDeleteCount(int boardFreeId);
	
	
	/*
	 * 자유게시판 댓글 목록 조회
	 * 작성자 : 김장규
	 */
	Map<String, Object> selectCommentFreeListbyId(int id,int page);
	
	/*
	 * 자유게시판 댓글 상세정보 조회
	 * 작성자 : 김장규
	 */
	CommentFree selectCommentFreeById(int commentFreeId);
}
