package kr.co.turnup_fridger.dao.impl;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import kr.co.turnup_fridger.dao.BoardQnADao;
import kr.co.turnup_fridger.vo.BoardQnA;

@Repository
public class BoardQnADaoImpl implements BoardQnADao{

	//Spring Container에서 SqlSessionTemplate을 주입(주입) 받아서 instance 변수로 대입
	@Autowired
	private SqlSessionTemplate session;
	
	private String makeSqlId(String id){
		return "kr.co.turnup_fridger.config.mybatis.mapper.BoardQnAMapper."+id;
	}

	/**
	 * QnA 등록
	 * 작성자 - 김장규
	 */
	@Override
	public int insertBoardQnA(BoardQnA boardQnA) {
		return session.insert(makeSqlId("insertBoardQnA"),boardQnA);
	}

	/**
	 * QnA 업데이트
	 * 작성자 - 김장규
	 */
	@Override
	public int updateBoardQnA(BoardQnA boardQnA) {
		return session.update(makeSqlId("updateBoardQnA"),boardQnA);
	}

	/**
	 * QnA 삭제(댓글과 함께 삭제)
	 * 작성자 - 김장규
	 */
	@Override
	public int deleteBoardQnA(int id) {
		return session.delete(makeSqlId("deleteBoardQnA"),id);
	}

	/**
	 * QnA 목록 조회(댓글 포함)
	 * 작성자 - 김장규
	 */
	@Override
	public List<BoardQnA> selectBoardQnAList() {
		return session.selectList(makeSqlId("selectBoardQnAList"));
	}

	/**
	 * QnA 상제보기(댓글 포함)
	 * 작성자 - 김장규
	 */
	@Override
	public BoardQnA selectBoardQnAById(int id) {
		return session.selectOne(makeSqlId("selectBoardQnAById"),id);
	}

	/**
	 * QnA MemberId로 조회(댓글 포함)
	 * 작성자 - 김장규
	 */
	@Override
	public List<BoardQnA> selectBoardQnAByMemberId(String id) {
		return session.selectList(makeSqlId("selectBoardQnAByMemberId"), id);
	}
	
	
			
}
