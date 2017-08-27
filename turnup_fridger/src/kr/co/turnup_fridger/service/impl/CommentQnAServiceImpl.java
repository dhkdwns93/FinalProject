package kr.co.turnup_fridger.service.impl;

import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;
import org.springframework.stereotype.Service;

import kr.co.turnup_fridger.dao.CommentQnADao;
import kr.co.turnup_fridger.service.CommentQnAService;
import kr.co.turnup_fridger.vo.CommentQnA;

@Service
public class CommentQnAServiceImpl implements CommentQnAService{

	@Autowired
	private CommentQnADao dao;
	
	/*
	 * 한개의 QnA 댓글을 등록 하는 메소드
	 * 작성자 - 김장규
	 */
	@Override
	public void addCommentQnA(CommentQnA commentQnA) {
		dao.insertCommentQnA(commentQnA);
		
	}

	/*
	 * 댓글수 증가 하는 메소드
	 * 작성자 - 김장규
	 */
	@Override
	public void commentCount(int boardQnAId) {
		dao.commentCount(boardQnAId);
	}

	/*
	 * QnA 댓글을 수정 하는 메소드
	 * 작성자 - 김장규
	 */
	@Override
	public void updateCommentQnA(CommentQnA commentQnA) {
		dao.updateCommentQnA(commentQnA);
		
	}
	
	
	/*
	 * 댓글수 감소 하는 메소드
	 * 작성자 - 김장규
	 */
	@Override
	public void commentDeleteCount(int boardQnAId) {
		dao.commentDeleteCount(boardQnAId);
		
	}

	/*
	 * QnA 댓글을 삭제 하는 메소드
	 * 작성자 - 김장규
	 */
	@Override
	public void removeCommentQnA(int id) {
		dao.deleteCommentQnA(id);
		
	}

	/*
	 * QnA 댓글을 조회 하는 메소드
	 * 작성자 - 김장규
	 */
	@Override
	public List<CommentQnA> selectCommentQnAList() {
		return dao.selectCommentQnAList();
	}
	
	/*
	 * QnA 댓글 상세정보 조회 하는 메소드
	 * 작성자 - 김장규
	 */
	@Override
	public CommentQnA selectCommentQnAById(int commentQnAId) {
		return dao.selectCommentQnAById(commentQnAId);
	}
	
	/*
	 * QnA 댓글 목록 조회 하는 메소드
	 * 작성자 - 김장규
	 */
	@Override
	public List<CommentQnA> selectCommentQnAByboardQnAId(int boardQnAId) {
		return dao.selectCommentQnAByboardQnAId(boardQnAId);
	}
}
