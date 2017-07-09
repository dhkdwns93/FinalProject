package kr.co.turnup_fridger.service.impl;

import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;
import org.springframework.stereotype.Service;

import kr.co.turnup_fridger.dao.BoardReviewDao;
import kr.co.turnup_fridger.service.BoardQnAService;
import kr.co.turnup_fridger.service.BoardReviewService;
import kr.co.turnup_fridger.vo.BoardQnA;
import kr.co.turnup_fridger.vo.BoardReview;

@Service
public class BoardReviewServiceImpl implements BoardReviewService{

	@Autowired
	private BoardReviewDao dao;

	
	
	@Override
	public void addBoardReview(BoardReview boardReview) {
		dao.insertBoardReview(boardReview);
		
	}
	
	@Override
	public void updateImageNull(BoardReview boardReview) {
		dao.updateImageNull(boardReview);
	}

	@Override
	public void updateBoardReview(BoardReview boardReview) {
		dao.updateBoardReview(boardReview);
		
	}

	@Override
	public void removeBoardReview(int boardReviewId) {
		dao.deleteBoardReview(boardReviewId);
		
	}

	@Override
	public List<BoardReview> selectBoardReviewList() {
		// TODO Auto-generated method stub
		return dao.selectBoardReviewList();
	}
	
	@Override
	public List<BoardReview> selectBoardReviewByMemberIdList(String memberId) {
		// TODO Auto-generated method stub
		return dao.selectBoardReviewByMemberIdList(memberId);
	}
	
	@Override
	public List<BoardReview> selectBoardReviewByStarList() {
		// TODO Auto-generated method stub
		return dao.selectBoardReviewByStarList();
	}

	@Override
	public List<BoardReview> selectBoardReviewByRecipeNameList(String recipeName) {
		// TODO Auto-generated method stub
		return dao.selectBoardReviewByRecipeNameList(recipeName);
	}

	@Override
	public BoardReview selecetBoardReviewByBoardReviewId(int boardReviewId) {
		// TODO Auto-generated method stub
		return dao.selecetBoardReviewByBoardReviewId(boardReviewId);
	}

	public static void main(String[] args) {
		//ApplicationContext 객체 생성
		ApplicationContext container = new ClassPathXmlApplicationContext("kr/co/turnup_fridger/config/spring/model-context.xml");
		//Spring 컨테이너로 부터 BoardNoticeService bean 가져오기
		BoardReviewService service = (BoardReviewService)container.getBean("boardReviewServiceImpl");
		//service.addBoardReview(new BoardReview(4, "맛없어요", "별로임.", new Date(2017-1900,01,02),null,null,3,"id-3",1));
		
		//service.updateBoardReview(new BoardReview(2, "맛없어요", "별로임.", new Date(2017-1900,01,02),null,null,3,"id-3",1));
		service.updateImageNull(new BoardReview(57, "맛없어요", "별로임.", new Date(2017-1900,01,02),null,null,3,"id-3",1));
		
		int delId = 2;
		//service.removeBoardReview(delId);
		
		
		List<BoardReview> list = null;
		BoardReview board =null;
		//list = service.selectBoardReviewList();
		//System.out.println(list);
		
		//list = service.selectBoardReviewByMemberIdList("kim");
		//System.out.println(list);
		
		list = service.selectBoardReviewByStarList();
		//System.out.println(list);
		
		list = service.selectBoardReviewByRecipeNameList("요리");
		System.out.println(list);
		
	}
}
