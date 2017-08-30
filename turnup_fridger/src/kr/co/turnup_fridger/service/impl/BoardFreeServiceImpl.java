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
	
	/*
	 * BoardFree 등록 - 회원
	 * 작성자 : 김장규
	 */
	@Override
	public void addBoardFree(BoardFree boardFree) {
		dao.insertBoardFree(boardFree);
	}
	
	/*
	 * BoardFree 정보를 수정 - 작성자
	 * 작성자 : 김장규
	 */
	@Override
	public void updateBoardFree(BoardFree boardFree) {
		dao.updateBoardFree(boardFree);
		
	}
	
	/*
	 * BoardFree 삭제 - 관리자, 작성자
	 * 작성자 : 김장규
	 */
	@Override
	public void removeBoardFree(int id) {
		dao.deleteBoardFree(id);
		
	}
	
	/*
	 * BoardFree 조회수 증가
	 * 작성자 : 김장규
	 */
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
	
	/*
	 * BoardFree 전체 목록 조회
	 * 작성자 : 김장규
	 */
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
	
	
	/*
	 * BoardFree 조회수로 조회
	 * 작성자 : 김장규
	 */
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
	
	/*
	 * BoardFree 아이디 조회
	 * 작성자 : 김장규
	 */
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
	
	
	/*
	 * BoardFree 제목 조회
	 * 작성자 : 김장규
	 */
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

	/*
	 * BoardFree 상세 보기
	 * 작성자 : 김장규
	 */
	@Override
	public BoardFree selectBoardFreeByboardFreeId(int boardFreeId) {
		
		return dao.selectBoardFreeByboardFreeId(boardFreeId);
	}

}	
