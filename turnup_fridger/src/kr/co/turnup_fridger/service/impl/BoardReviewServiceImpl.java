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

	
	//등록
	@Override
	public void addBoardReview(BoardReview boardReview) {
		dao.insertBoardReview(boardReview);
		
	}
	
	//이미지 삭제
	@Override
	public void updateImageNull(BoardReview boardReview) {
		dao.updateImageNull(boardReview);
	}

	//수정
	@Override
	public void updateBoardReview(BoardReview boardReview) {
		dao.updateBoardReview(boardReview);
		
	}

	//삭제
	@Override
	public void removeBoardReview(int boardReviewId) {
		dao.deleteBoardReview(boardReviewId);
		
	}

	//전체 리스트 조회
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
	
	//별점순 리스트 조회
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
	
	//레시피 이름으로 리스트 조회
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

	//아이디로 리스트 조회
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
	

	//상세 정보
	@Override
	public BoardReview selecetBoardReviewByBoardReviewId(int boardReviewId) {
		// TODO Auto-generated method stub
		return dao.selecetBoardReviewByBoardReviewId(boardReviewId);
	}
	
	
	//레시피 검색
	@Override
	public List<RecipeInfo> selectRecipeName(String recipeName) {
		// TODO Auto-generated method stub
		return dao.selectRecipeName(recipeName);
	}
	//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

	
	//레시피 아이디로 리스트조회
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
	
	public static void main(String[] args) {
		//ApplicationContext 객체 생성
		ApplicationContext container = new ClassPathXmlApplicationContext("kr/co/turnup_fridger/config/spring/model-context.xml");
		//Spring 컨테이너로 부터 BoardReviewService bean 가져오기
		BoardReviewService service = (BoardReviewService)container.getBean("boardReviewServiceImpl");

	
		int recipeId = 1;
		
		Map<String, Object> map = service.findBoardReviewByRecipeId(recipeId,1);
				
		System.out.println(map);
	}

	
}
