package kr.co.turnup_fridger.dao.impl;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import kr.co.turnup_fridger.dao.BoardNoticeDao;
import kr.co.turnup_fridger.vo.BoardNotice;

@Repository
public class BoardNoticeDaoImpl implements BoardNoticeDao
{

	//Spring Container에서 SqlSessionTemplate을 주입(주입) 받아서 instance 변수로 대입
	@Autowired
	private SqlSessionTemplate session;
	
	
	
	private String makeSqlId(String id){
		return "kr.co.turnup_fridger.config.mybatis.mapper.BoardNoticeMapper."+id;
	}
	
	
	/**
	 * 공지사항 등록
	 * 작성자 - 김장규
	 */
	@Override
	public int insertBoardNotice(BoardNotice boardNotice) {
		return session.insert(makeSqlId("insertBoardNotice"),boardNotice);
	}

	/**
	 * 공지사항 업데이트
	 * 작성자 - 김장규
	 */
	@Override
	public int updateBoardNotice(BoardNotice boardNotice) {
		return session.update(makeSqlId("updateBoardNotice"), boardNotice);
	}

	/**
	 * 공지사항 삭제
	 * 작성자 - 김장규
	 */
	@Override
	public int deleteBoardNoticeByid(int id) {
		return session.delete(makeSqlId("deleteBoardNotice"),id);
	}

	/**
	 * 공지사항 전체 조회
	 * 작성자 - 김장규
	 */
	@Override
	public List<BoardNotice> selectBoardNoticeList() {
		return session.selectList(makeSqlId("selectBoardNoticeList"));
	}

	/**
	 * 공지사항 ID로 조회
	 * 작성자 - 김장규
	 */
	@Override
	public BoardNotice selectBoardNoticeById(int id) {
		// TODO Auto-generated method stub
		return session.selectOne(makeSqlId("selectBoardNoticeById"),id);
	}

	/**
	 * 공지사항 ITMES로 조회
	 * 작성자 - 김장규
	 */
	@Override
	public List<BoardNotice> selectBoardNoticeByItems(String items) {
		// TODO Auto-generated method stub 
		return session.selectList(makeSqlId("selectBoardNoticeByItems"), items);
	}

}
