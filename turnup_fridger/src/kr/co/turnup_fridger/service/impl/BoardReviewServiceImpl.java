package kr.co.turnup_fridger.service.impl;

import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;
import org.springframework.stereotype.Service;

import kr.co.turnup_fridger.dao.BoardReviewDao;
import kr.co.turnup_fridger.service.BoardQnAService;
import kr.co.turnup_fridger.service.BoardReviewService;
import kr.co.turnup_fridger.util.PagingBean;
import kr.co.turnup_fridger.util.PagingBeanReview;
import kr.co.turnup_fridger.vo.BoardFree;
import kr.co.turnup_fridger.vo.BoardQnA;
import kr.co.turnup_fridger.vo.BoardReview;
import kr.co.turnup_fridger.vo.RecipeInfo;

@Service
public class BoardReviewServiceImpl implements BoardReviewService{

	@Autowired
	private BoardReviewDao dao;

	
	/*
	 * 후기게시판 등록 - 회원
	 * 작성자 - 김장규
	 */
	@Override
	public void addBoardReview(BoardReview boardReview) {
		dao.insertBoardReview(boardReview);
		
	}

	/*
	 * 후기게시판 수정 - 작성자
	 * 작성자 - 김장규
	 */
	@Override
	public void updateBoardReview(BoardReview boardReview) {
		dao.updateBoardReview(boardReview);
		
	}

	/*
	 * 후기게시판 삭제 - 관리자, 작성자
	 * 작성자 - 김장규
	 */
	@Override
	public void removeBoardReview(int boardReviewId) {
		dao.deleteBoardReview(boardReviewId);
		
	}

	/*
	 * 후기게시판 전체 목록 조회
	 * 작성자 - 김장규
	 */
	@Override
	public Map<String, Object> selectBoardReviewList(int page) {
		HashMap<String, Object> map = new HashMap<>();
		int totalCount = dao.selectBoardReviewCount();
		PagingBeanReview pageBean = new PagingBeanReview(totalCount, page);
		map.put("pageBean", pageBean);
		List<BoardReview> list = dao.selectBoardReviewList(pageBean.getBeginItemInPage(), pageBean.getEndItemInPage());
		map.put("list", list);
		return map;
	}
	
	/*
	 * 후기게시판 별점순 조회
	 * 작성자 - 김장규
	 */
	@Override
	public Map<String, Object> selectBoardReviewByStarList(int page) {
		HashMap<String, Object> map = new HashMap<>();
		int totalCount = dao.selectBoardReviewCount();
		PagingBeanReview pageBean = new PagingBeanReview(totalCount, page);
		map.put("pageBean", pageBean);
		List<BoardReview> list = dao.selectBoardReviewByStarList(pageBean.getBeginItemInPage(), pageBean.getEndItemInPage());
		map.put("list", list);
		return map;
	}
	
	/*
	 * 후기게시판 레시피이름으로 조회
	 * 작성자 - 김장규
	 */
	@Override
	public Map<String, Object> selectBoardReviewByRecipeNameList(String recipeName,int page) {
		HashMap<String, Object> map = new HashMap<>();
		int totalCount = dao.selectBoardReviewByRecipeNameCount(recipeName);
		PagingBeanReview pageBean = new PagingBeanReview(totalCount, page);
		List<BoardReview> list = dao.selectBoardReviewByRecipeNameList(recipeName,pageBean.getBeginItemInPage(), pageBean.getEndItemInPage());
		map.put("recipeName", recipeName);
		map.put("list", list);
		map.put("pageBean", pageBean);
		return map;
	}

	/*
	 * 후기게시판 회원 아이디로 목록 조회
	 * 작성자 - 김장규
	 */
	@Override
	public Map<String, Object> selectBoardReviewByMemberIdList(String memberId,int page) {
		HashMap<String, Object> map = new HashMap<>();
		int totalCount = dao.selectBoardReviewByMemberIdCount(memberId);
		PagingBeanReview pageBean = new PagingBeanReview(totalCount, page);
		List<BoardReview> list = dao.selectBoardReviewByMemberIdList(memberId,pageBean.getBeginItemInPage(), pageBean.getEndItemInPage());
		map.put("memberId", memberId);
		map.put("list", list);
		map.put("pageBean", pageBean);
		return map;
	}
	

	/*
	 * 후기게시판 해당 글 상세 정보 조회
	 * 작성자 - 김장규
	 */
	@Override
	public BoardReview selecetBoardReviewByBoardReviewId(int boardReviewId) {
		// TODO Auto-generated method stub
		return dao.selecetBoardReviewByBoardReviewId(boardReviewId);
	}
	
	
	/*
	 * 후기게시판 레시피 이름으로 조회
	 * 작성자 - 김장규
	 */
	@Override
	public List<RecipeInfo> selectRecipeName(String recipeName) {
		// TODO Auto-generated method stub
		return dao.selectRecipeName(recipeName);
	}

	/*
	 * 후기게시판 레시피 아이디로 조회
	 * 작성자 - 김장규
	 */
	@Override
	public Map<String, Object> findBoardReviewByRecipeId(int recipeId,int page) {
		HashMap<String, Object> map = new HashMap<>();
		int totalCount = dao.selectRecipeIdCount(recipeId); 
		PagingBean pageBean = new PagingBean(totalCount, page);
		List<BoardReview> list = dao.selectBoardReviewByRecipeId(recipeId,pageBean.getBeginItemInPage(), pageBean.getEndItemInPage());
		map.put("recipeId", recipeId);
		map.put("list", list);
		map.put("pageBean", pageBean);
		return map;
	}	
}
