package kr.co.turnup_fridger.dao.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

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

	/*
	 * QnA 등록 - 회원
	 * 작성자 - 김장규
	 */
	@Override
	public int insertBoardQnA(BoardQnA boardQnA) {
		return session.insert(makeSqlId("insertBoardQnA"),boardQnA);
	}

	/*
	 * QnA 업데이트 - 해당 글 작성자
	 * 작성자 - 김장규
	 */
	@Override
	public int updateBoardQnA(BoardQnA boardQnA) {
		return session.update(makeSqlId("updateBoardQnA"),boardQnA);
	}

	/*
	 * QnA 삭제(댓글과 함께 삭제) - 관리자, 회원
	 * 작성자 - 김장규
	 */
	@Override
	public int deleteBoardQnA(int id) {
		return session.delete(makeSqlId("deleteBoardQnA"),id);
	}

	/*
	 * QnA 전체 수 카운트
	 * 작성자 - 김장규
	 */
	@Override
	public int selectBoardQnACount() {
		return session.selectOne(makeSqlId("selectBoardQnACount"));
	}
	
	/*
	 * QnA 목록 조회
	 * 작성자 - 김장규
	 */
	@Override
	public List<BoardQnA> selectBoardQnAList(int startIndex, int endIndex) {
		Map<String, Integer> input = new HashMap<String, Integer>();
		input.put("startIndex",startIndex);
		input.put("endIndex",endIndex);
		return session.selectList(makeSqlId("selectBoardQnAList"),input);
	}

	/*
	 * 매개변수 memberID을 가진 정보 BoardQnA 수 카운트
	 * 작성자 - 김장규
	 */
	@Override
	public int selectBoardQnAByMemberIdCount(String memberId) {
		return session.selectOne(makeSqlId("selectBoardQnAByMemberIdCount"),memberId);
	}

	/*
	 * 매개변수 memberID을 가진 정보 BoardQnA 목록 조회
	 * 작성자 - 김장규
	 */
	@Override
	public List<BoardQnA> selectBoardQnAByMemberId(String memberId,int startIndex, int endIndex) {
		Map<String, Object> input = new HashMap<String, Object>();
		input.put("memberId",memberId);
		input.put("startIndex",startIndex);
		input.put("endIndex",endIndex);
		return session.selectList(makeSqlId("selectBoardQnAByMemberId"), input);
	}
	
	/*
	 * QnA 상제보기(댓글 포함) - 해당 글  작성자, 관리자
	 * 작성자 - 김장규
	 */
	@Override
	public BoardQnA selectBoardQnAById(int id) {
		return session.selectOne(makeSqlId("selectBoardQnAById"),id);
	}
			
}
