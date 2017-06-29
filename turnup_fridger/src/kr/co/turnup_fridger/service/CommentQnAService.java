package kr.co.turnup_fridger.service;

import java.util.List;

import kr.co.turnup_fridger.vo.CommentQnA;

public interface CommentQnAService {
	
	/**
	 * 한개의 댓글을  등록 하는 메소드
	 * 작성자 - 김장규
	 * @param commentQnA
	 */
	void addCommentQnA(CommentQnA commentQnA);
	
	/**
	 * 댓글 정보를 수정 하는 메소드
	 * 작성자 - 김장규
	 * @param commentQnA
	 */
	void updateCommentQnA(CommentQnA commentQnA);
	
	/**
	 * 댓글 정보를 삭제 하는 메소드
	 * 작성자 - 김장규
	 * @param id
	 */
	void removeCommentQnA(int id);
	
	/**
	 * 댓글 정보를 조회 하는 메소드
	 * 작성자 - 김장규
	 * @return
	 */
	List<CommentQnA> selectCommentQnAList();
}