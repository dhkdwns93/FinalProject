package kr.co.turnup_fridger.service.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;
import org.springframework.stereotype.Service;

import kr.co.turnup_fridger.dao.BoardFreeDao;
import kr.co.turnup_fridger.service.BoardFreeService;
import kr.co.turnup_fridger.util.PagingBean;
import kr.co.turnup_fridger.vo.BoardFree;
import kr.co.turnup_fridger.vo.BoardQnA;

@Service
public class BoardFreeServiceImpl implements BoardFreeService{

	@Autowired
	private BoardFreeDao dao;
	
	//등록
	@Override
	public void addBoardFree(BoardFree boardFree) {
		dao.insertBoardFree(boardFree);
	}
	
	//수정
	@Override
	public void updateBoardFree(BoardFree boardFree) {
		dao.updateBoardFree(boardFree);
		
	}
	
	//삭제
	@Override
	public void removeBoardFree(int id) {
		dao.deleteBoardFree(id);
		
	}
	
	//전체 리스트 
	@Override
	public Map<String, Object> selectBoardFreeList(int page) {
		HashMap<String, Object> map = new HashMap<>();
		int totalCount = dao.selectBoardFreeCount();
		PagingBean pageBean = new PagingBean(totalCount, page);
		map.put("pageBean", pageBean);
		map.put("totalCount", totalCount);
		List<BoardFree> list = dao.selectBoardFreeList(pageBean.getBeginItemInPage(), pageBean.getEndItemInPage());
		map.put("list", list);
		return map;
	}
	
	
	//조회수로 조회
	@Override
	public Map<String, Object>  selectBoardFreeByBoardFreeHits(int page) {
		HashMap<String, Object> map = new HashMap<>();
		int totalCount = dao.selectBoardFreeCount();
		PagingBean pageBean = new PagingBean(totalCount, page);
		map.put("pageBean", pageBean);
		map.put("totalCount", totalCount);
		List<BoardFree> list = dao.selectBoardFreeByBoardFreeHits(pageBean.getBeginItemInPage(), pageBean.getEndItemInPage());
		map.put("list", list);
		return map;
	}
	
	//아이디로 조회
	@Override
	public Map<String, Object> selectBoardFreeByMemberId(String memberId,int page) {
		HashMap<String, Object> map = new HashMap<>();
		int totalCount = dao.selectBoardFreeByMemberIdCount(memberId);
		PagingBean pageBean = new PagingBean(totalCount, page);
		map.put("pageBean", pageBean);
		map.put("totalCount", totalCount);
		List<BoardFree> list = dao.selectBoardFreeByMemberId(memberId, pageBean.getBeginItemInPage(), pageBean.getEndItemInPage());
		map.put("memberId", memberId);
		map.put("list", list);
		
		return map;
	}
	
	
	//제목으로 조회
	@Override
	public Map<String, Object> selectBoardFreeByTitle(String boardFreeTitle, int page) {
		HashMap<String, Object> map = new HashMap<>();
		int totalCount = dao.selectBoardFreeByTitleCount(boardFreeTitle);
		PagingBean pageBean = new PagingBean(totalCount, page);
		map.put("pageBean", pageBean);
		map.put("totalCount", totalCount);
		List<BoardFree> list = dao.selectBoardFreeByTitle(boardFreeTitle, pageBean.getBeginItemInPage(), pageBean.getEndItemInPage());
		map.put("boardFreeTitle", boardFreeTitle);
		map.put("list", list);
		return map;
	}

	//조회수 증가
	@Override
	public void increasHit(int boardFreeId, HttpSession session) throws Exception {
		long udateTime = 0;
		long currentTime = System.currentTimeMillis();
		
		if(currentTime - udateTime > 5*1000)
		{
			dao.increaseViewcnt(boardFreeId);
			
			session.setAttribute("updateTime"+boardFreeId,currentTime);
		}
	}


	//상세페이지
	@Override
	public BoardFree selectBoardFreeByboardFreeId(int boardFreeId) {
		
		return dao.selectBoardFreeByboardFreeId(boardFreeId);
	}

	@Override
	public List<BoardFree> test(String boardFreeTitle) {
		// TODO Auto-generated method stub
		return dao.test(boardFreeTitle);
	}
	
	public static void main(String[] args) {
		//ApplicationContext 객체 생성
		ApplicationContext container = new ClassPathXmlApplicationContext("kr/co/turnup_fridger/config/spring/model-context.xml");
		//Spring 컨테이너로 부터 BoardNoticeService bean 가져오기
		BoardFreeService service = (BoardFreeService)container.getBean("boardFreeServiceImpl");

		List<BoardFree> list = null;
		BoardQnA board =null;
		//list = service.findBoardQnAList();
		//System.out.println(list);
		
		//int selId = 1;
		
		//board = service.findBoardQnAById(selId);
		//System.out.println(board);
		
		String id = "id";
		//Map<String, Object> map = service.selectBoardFreeByTitle(id, 1);
		

		list = service.test(id);
		System.out.println(list);
	}
	
	
}	
