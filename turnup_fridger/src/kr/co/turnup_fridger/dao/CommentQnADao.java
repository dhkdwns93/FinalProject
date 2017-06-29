package kr.co.turnup_fridger.dao;

import java.util.List;

import kr.co.turnup_fridger.vo.CommentQnA;

public interface CommentQnADao {
	
	/**
	 * CommentQnA 정보를 insert 하는 메소드
	 * @param commentQnA
	 * @return
	 * 작성자 : 김장규
	 */
	int insertCommentQnA(CommentQnA commentQnA);
	
	/**
	 * CommentQnA 정보를 update 하는 메소드
	 * @param commentQnA
	 * @return
	 */
	int updateCommentQnA(CommentQnA commentQnA);
	
	/**
	 * CommentQnA 정보를 delete 하는 메소드
	 * @param id
	 * @return
	 * 작성자 : 김장규
	 */
	int deleteCommentQnA(int id);
	
	/**
	 * CommentQnA 상세정보를 보여주는 메소드
	 * @return
	 * 작성자 : 김장규
	 */
	List<CommentQnA> selectCommentQnAList();
}