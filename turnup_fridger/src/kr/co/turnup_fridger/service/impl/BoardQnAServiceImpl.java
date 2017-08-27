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

	/*
	 * QnA 등록 하는 메소드 - 회원
	 * 작성자 - 김장규
	 */
	@Override
	public void addBoardQnA(BoardQnA boardQnA) {
		dao.insertBoardQnA(boardQnA);
	}

	/*
	 * QnA 정보를 수정 하는 메소드 - 해당 글 작성자
	 * 작성자 - 김장규
	 */
	@Override
	public void updateBoardQnA(BoardQnA boardQnA) {
		dao.updateBoardQnA(boardQnA);
		
	}
	
	/*
	 * 매개변수로 받은 ID로 저장된 QnA 삭제하는 메소드(댓글 포함) - 작성자,관리자
	 * 작성자 - 김장규
	 */
	@Override
	public void removeBoardQnA(int id) {
		dao.deleteBoardQnA(id);
		
	}

	/*
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
	
	/*
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
	
	/*
	 * 저장된 QnA 정보 중 매개변수 ID를 가진 정보 조회하는 메소드(상세 보기 - 댓글 포함) - 작성자, 관리자
	 * 작성자 - 김장규
	 */
	@Override
	public BoardQnA findBoardQnAById(int id) {
		return dao.selectBoardQnAById(id);
	}
}
