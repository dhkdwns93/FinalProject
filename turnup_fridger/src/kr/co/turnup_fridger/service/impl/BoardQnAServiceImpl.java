package kr.co.turnup_fridger.service.impl;

import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;
import org.springframework.stereotype.Service;

import kr.co.turnup_fridger.dao.BoardQnADao;
import kr.co.turnup_fridger.service.BoardQnAService;
import kr.co.turnup_fridger.util.PagingBean;
import kr.co.turnup_fridger.vo.BoardQnA;

@Service
public class BoardQnAServiceImpl implements BoardQnAService {
	
	@Autowired
	private BoardQnADao dao;

	/**
	 * 한개의 QnA 등록 하는 메소드
	 * 작성자 - 김장규
	 */
	@Override
	public void addBoardQnA(BoardQnA boardQnA) {
		dao.insertBoardQnA(boardQnA);
	}

	/**
	 * QnA 정보를 수정 하는 메소드
	 * 작성자 - 김장규
	 */
	@Override
	public void updateBoardQnA(BoardQnA boardQnA) {
		dao.updateBoardQnA(boardQnA);
		
	}
	
	/**
	 * 매개변수로 받은 ID로 저장된 QnA 삭제하는 메소드(댓글 포함)
	 * 작성자 - 김장규
	 */
	@Override
	public void removeBoardQnA(int id) {
		dao.deleteBoardQnA(id);
		
	}

	/**
	 * 저장된 QnA 정보를  전체 조회 조회하는 메소드(댓글 포함)
	 * 작성자 - 김장규
	 */
	@Override
	public Map<String, Object> findBoardQnAList(int page) {
		HashMap<String, Object> map = new HashMap<>();
		int totalCount = dao.selectBoardQnACount();
		PagingBean pageBean = new PagingBean(totalCount, page);
		map.put("pageBean", pageBean);
		map.put("totalCount", totalCount);
		List<BoardQnA> list = dao.selectBoardQnAList(pageBean.getBeginItemInPage(), pageBean.getEndItemInPage());
		map.put("list", list);
		
		return map;
	}
	
	/**
	 * 저장된 QnA 정보 중 매개변수 ID를 가진 정보 조회하는 메소드(댓글 포함)
	 * 작성자 - 김장규
	 */
	@Override
	public BoardQnA findBoardQnAById(int id) {
		return dao.selectBoardQnAById(id);
	}

	/**
	 * 저장된 QnA 정보 중 매개변수 MemberId을 가진 정보 조회하는 메소드(댓글 포함)
	 * 작성자 - 김장규
	 */	
	@Override
	public Map<String, Object> findBoardQnAByMemberId(String memberId,int page) {
		HashMap<String, Object> map = new HashMap<>();
		int totalCount = dao.selectBoardQnAByMemberIdCount(memberId);
		PagingBean pageBean = new PagingBean(totalCount, page);
		map.put("pageBean", pageBean);
		map.put("totalCount", totalCount);
		List<BoardQnA> list = dao.selectBoardQnAByMemberId(memberId, pageBean.getBeginItemInPage(), pageBean.getEndItemInPage());
		map.put("memberId", memberId);
		map.put("list", list);
		
		return map;
	}

	
	/**
	 * 메소드 Test
	 * 작성자 - 김장규
	 */
	public static void main(String[] args) {
		//ApplicationContext 객체 생성
		ApplicationContext container = new ClassPathXmlApplicationContext("kr/co/turnup_fridger/config/spring/model-context.xml");
		//Spring 컨테이너로 부터 BoardNoticeService bean 가져오기
		BoardQnAService service = (BoardQnAService)container.getBean("boardQnAServiceImpl");
		//service.addBoardQnA(new BoardQnA(1, "회원수요청입니다.", "회원 수정하고 싶은데 어떻게 해야 하나요?", new Date(2017-1900,01,02), "jang"));
		//service.addBoardQnA(new BoardQnA(5, "회원탈퇴요청입니다.", "그만 이 사이트를 이용하고 싶습니다.", new Date(2017-1900,01,02), "id-3"));
		
		int upId = 1;
		//service.updateBoardQnA(new BoardQnA(upId, "궁금한게 있어요!!!", "재료추가 하고 싶은데 어떻게 하나요????", new Date(2017-1900,01,02), "jang"));
	
		int delId = 2;
		//service.removeBoardQnA(delId);
		
		
		List<BoardQnA> list = null;
		BoardQnA board =null;
		//list = service.findBoardQnAList();
		//System.out.println(list);
		
		int selId = 1;
		
		board = service.findBoardQnAById(selId);
		System.out.println(board);
		
		String id = "jang";
		//list = service.findBoardQnAByMemberId(id);
		//System.out.println(list);
	}
	
}
