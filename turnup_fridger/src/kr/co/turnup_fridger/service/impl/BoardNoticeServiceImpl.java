package kr.co.turnup_fridger.service.impl;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.co.turnup_fridger.dao.BoardNoticeDao;
import kr.co.turnup_fridger.service.BoardNoticeService;
import kr.co.turnup_fridger.util.PagingBean;
import kr.co.turnup_fridger.vo.BoardNotice;

@Service
public class BoardNoticeServiceImpl implements BoardNoticeService 
{
	@Autowired
	private BoardNoticeDao dao;
	
	/*
	 * 한개의 공지사항 정보를 등록 하는 메소드  - 관리자
	 * 작성자 - 김장규
	 */
	@Override
	public void addBoardNotice(BoardNotice boardNotice) {
		dao.insertBoardNotice(boardNotice);
	}

	/*
	 * 공지사항 정보를 수정 하는 메소드  - 관리자
	 * 작성자 - 김장규
	 */
	@Override
	public void updateBoardNotice(BoardNotice boardNotice) {
		dao.updateBoardNotice(boardNotice);
		
	}
	
	/*
	 * 매개변수로 받은 ID로 저장된 공지사항 삭제하는 메소드  - 관리자
	 * 작성자 - 김장규
	 */
	@Override
	public void removeBoardNoticeById(int id) {
		dao.deleteBoardNoticeByid(id);
		
	}

	/*
	 * 저장된 공지사항 정보 중 매개변수 ID를 가진 정보 조회하는 메소드
	 * 작성자 - 김장규
	 */
	@Override
	public BoardNotice findBoardNoticeById(int id) {
		// TODO Auto-generated method stub
		
		return dao.selectBoardNoticeById(id);
	}

	/*
	 * 저장된 공지사항 정보를  전체 조회 조회하는 메소드
	 * 작성자 - 김장규	
	 */
	@Override
	public Map<String, Object>  findBoardNoticeList(int page) {
		HashMap<String, Object> map = new HashMap<>();
		int totalCount = dao.selectBoardNoticeCount();
		PagingBean pageBean = new PagingBean(totalCount, page);
		map.put("pageBean", pageBean);
		map.put("totalCount", totalCount);
		List<BoardNotice> list = dao.selectBoardNoticeList(pageBean.getBeginItemInPage(), pageBean.getEndItemInPage());
		map.put("list", list);
		return map;
	}
	
	/*
	 * 저장된 공지사항 정보 중 매개변수 ITEMS을 가진 정보 조회하는 메소드
	 * 작성자 - 김장규
	 */
	@Override
	public Map<String, Object> findBoardNoticeByItmes(String items, int page) {
		HashMap<String, Object> map = new HashMap<>();
		int totalCount = dao.selectBoardNoticeByItmesCount(items);
		PagingBean pageBean = new PagingBean(totalCount, page);
		map.put("pageBean", pageBean);
		map.put("totalCount", totalCount);
		List<BoardNotice> list = dao.selectBoardNoticeByItems(items, pageBean.getBeginItemInPage(), pageBean.getEndItemInPage());
		map.put("items", items);
		map.put("list", list);	
		return map;
	}
	
	
	
	
}
