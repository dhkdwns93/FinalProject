package kr.co.turnup_fridger.service.impl;



import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import kr.co.turnup_fridger.dao.BoardNoticeDao;
import kr.co.turnup_fridger.service.BoardNoticeService;
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
	public void removeBoardNoticeById(int id) {
		dao.deleteBoardNoticeByid(id);
		
	}


	@Override
	public BoardNotice findBoardNoticeById(int id) {
		// TODO Auto-generated method stub
		return dao.selectBoardNoticeById(id);
	}


	@Override
	public List<BoardNotice> findBoardNoticeList() {
		// TODO Auto-generated method stub
		return dao.selectBoardNoticeList();
	}


	@Override
	public List<BoardNotice> findBoardNoticeByItmes(String items) {
		// TODO Auto-generated method stub
		return dao.selectBoardNoticeByItems(items);
	}
	
	
	
	
}
