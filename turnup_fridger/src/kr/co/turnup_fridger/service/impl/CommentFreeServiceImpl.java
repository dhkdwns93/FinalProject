package kr.co.turnup_fridger.service.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.co.turnup_fridger.dao.CommentFreeDao;
import kr.co.turnup_fridger.service.CommentFreeService;
import kr.co.turnup_fridger.util.PagingBeanComment;
import kr.co.turnup_fridger.vo.CommentFree;

@Service
public class CommentFreeServiceImpl implements CommentFreeService{

	@Autowired
	private CommentFreeDao dao;

	/*
	 * 자유게시판 댓글 등록 - 회원
	 * 작성자 : 김장규
	 */
	@Override
	public void addCommentFree(CommentFree commentFree) {
		dao.insertCommentFree(commentFree);
		
	}

	/*
	 * 자유게시판 댓글수 증가
	 * 작성자 : 김장규
	 */
	@Override
	public void commentCount(int boardFreeId) {
		dao.commentCount(boardFreeId);
		
	}

	/*
	 * 자유게시판 댓글 수정 - 작성자
	 * 작성자 : 김장규
	 */
	@Override
	public void updateCommentFree(CommentFree commentFree) {
		dao.updateCommentFree(commentFree);
		
	}
	

	/*
	 * 자유게시판 댓글 삭제 - 관리자, 작성자
	 * 작성자 : 김장규
	 */
	@Override
	public void removeCommentFree(int id) {
		dao.deleteCommentFree(id);
		
	}
	
	/*
	 * 자유게시판 댓글수 감소
	 * 작성자 : 김장규
	 */
	@Override
	public void commentDeleteCount(int boardFreeId) {
		dao.commentDeleteCount(boardFreeId);
		
	}

	/*
	 * 자유게시판 댓글 목록 조회
	 * 작성자 : 김장규
	 */
	@Override
	public Map<String, Object> selectCommentFreeListbyId(int boardFreeId,int page) {
		HashMap<String, Object> map = new HashMap<>();
		int totalCount = dao.selectCommentFreeCount(boardFreeId);
		PagingBeanComment pageBean = new PagingBeanComment(totalCount, page);
		map.put("pageBean", pageBean);
		List<CommentFree> list = dao.selectCommentFreeListbyId(boardFreeId, pageBean.getBeginItemInPage(), pageBean.getEndItemInPage());
		map.put("boardFreeId", boardFreeId);
		map.put("list", list);
		
		return map;
	}

	/*
	 * 자유게시판 댓글 상세정보 조회
	 * 작성자 : 김장규
	 */
	@Override
	public CommentFree selectCommentFreeById(int commentFreeId) {
		return dao.selectCommentFreeById(commentFreeId);
	}

	

	
	
}
