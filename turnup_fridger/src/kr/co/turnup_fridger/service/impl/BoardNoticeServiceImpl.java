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
	
	
	@Override
	public void addBoardNotice(BoardNotice boardNotice) {
		dao.insertBoardNotice(boardNotice);
	}


	@Override
	public void updateBoardNotice(BoardNotice boardNotice) {
		dao.updateBoardNotice(boardNotice);
		
	}

	

	@Override
	public void updateImageNull(BoardNotice boardNotice) {
		dao.updateImageNull(boardNotice);
		
	}


	@Override
	public void removeBoardNoticeById(int id) {
		dao.deleteBoardNoticeByid(id);
		
	}


	@Override
	public BoardNotice findBoardNoticeById(int id) {
		// TODO Auto-generated method stub
		return dao.selectBoardNoticeById(id);
	}


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
