package kr.co.turnup_fridger.service.impl;



import java.sql.Date;
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
	
	/**
	 * 한개의 공지사항 정보를 등록 하는 메소드
	 * 작성자 - 김장규
	 */
	@Override
	public void addBoardNotice(BoardNotice boardNotice) {
		dao.insertBoardNotice(boardNotice);
	}

	/**
	 * 공지사항 정보를 수정 하는 메소드
	 * 작성자 - 김장규
	 */
	@Override
	public void updateBoardNotice(BoardNotice boardNotice) {
		dao.updateBoardNotice(boardNotice);
		
	}

	/**
	 * 매개변수로 받은 ID로 저장된 공지사항 삭제하는 메소드
	 * 작성자 - 김장규
	 */
	@Override
	public void removeBoardNoticeById(int id) {
		dao.deleteBoardNoticeByid(id);
		
	}

	/**
	 * 저장된 공지사항 정보 중 매개변수 ID를 가진 정보 조회하는 메소드
	 * 작성자 - 김장규
	 * @param id
	 */
	@Override
	public BoardNotice findBoardNoticeById(int id) {
		// TODO Auto-generated method stub
		return dao.selectBoardNoticeById(id);
	}

	
	/**
	 * 저장된 공지사항 정보를  전체 조회 조회하는 메소드
	 * 작성자 - 김장규
	 */
	@Override
	public List<BoardNotice> findBoardNoticeList() {
		// TODO Auto-generated method stub
		return dao.selectBoardNoticeList();
	}

	/**
	 * 저장된 공지사항 정보 중 매개변수 ITEMS을 가진 정보 조회하는 메소드
	 * 작성자 - 김장규
	 */
	@Override
	public List<BoardNotice> findBoardNoticeByItmes(String items) {
		// TODO Auto-generated method stub
		return dao.selectBoardNoticeByItems(items);
	}
	
	
	/**
	 * 메소드 Test
	 * 작성자 - 김장규
	 */
	public static void main(String[] args)
	{
		//ApplicationContext 객체 생성
		ApplicationContext container = new ClassPathXmlApplicationContext("kr/co/turnup_fridger/config/spring/model-context.xml");
		//Spring 컨테이너로 부터 BoardNoticeService bean 가져오기
		BoardNoticeService exam = (BoardNoticeService)container.getBean("boardNoticeServiceImpl");
		//등록
		//exam.addBoardNotice(new BoardNotice(3,"뉴스","왕준은 지드래곤이다","자신이 지드래곤보다 옷을 잘 입는다고 한다.","ddd",new Date(2017-1900,01,02)));
		//exam.addBoardNotice(new BoardNotice(4,"공지사항","공지사항 입니다.","공지사항 입니다.","ddd",new Date(2017-1900,01,02)));

		//수정
		int upId = 1;
		BoardNotice boardNotice = new BoardNotice(upId,"뉴스","양요섭은 누구인가","자신이 지드래곤보다 옷을 잘 입는다고 한다.","ddd",new Date(2017-1900,01,02));
		//exam.updateBoardNotice(boardNotice);
		
		//삭제
		int delId = 1;
		exam.removeBoardNoticeById(delId);
		
		//Id 조회
		int selId = 1;
		boardNotice = exam.findBoardNoticeById(selId);
		System.out.println(boardNotice);
		
		//전체 조회
		List<BoardNotice> list = exam.findBoardNoticeList();
		System.out.println(list);
		
		
		//items 조회
		String items = "공지사항";
		
		list = exam.findBoardNoticeByItmes(items);
		System.out.println(list);
	}
	
	
}
