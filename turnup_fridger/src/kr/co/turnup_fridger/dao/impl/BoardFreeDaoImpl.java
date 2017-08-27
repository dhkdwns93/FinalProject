package kr.co.turnup_fridger.dao.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import kr.co.turnup_fridger.dao.BoardFreeDao;
import kr.co.turnup_fridger.vo.BoardFree;

@Repository
public class BoardFreeDaoImpl implements BoardFreeDao{
	
	//Spring Container에서 SqlSessionTemplate을 주입(주입) 받아서 instance 변수로 대입
	@Autowired
	private SqlSessionTemplate session;
	
	private String makeSqlId(String id){
		return "kr.co.turnup_fridger.config.mybatis.mapper.BoardFreeMapper."+id;
	}
	
	
	/*
	 * BoardFree 등록 - 회원
	 * 작성자 : 김장규
	 */
	@Override
	public int insertBoardFree(BoardFree boardFree) {
		return session.insert(makeSqlId("insertBoardFree"), boardFree);
	}

	/*
	 * BoardFree 정보를 수정 - 작성자
	 * 작성자 : 김장규
	 */
	@Override
	public int updateBoardFree(BoardFree boardFree) {
		return session.update(makeSqlId("updateBoardFree"), boardFree);
	}

	/*
	 * BoardFree 삭제 - 관리자, 작성자
	 * 작성자 : 김장규
	 */
	@Override
	public int deleteBoardFree(int id) {
		return session.delete(makeSqlId("deleteBoardFree"),id);
	}

	
	/*
	 * BoardFree 조회수 증가
	 * 작성자 : 김장규
	 */
	@Override
	public int increaseViewcnt(int boardFreeId) {
		return session.update(makeSqlId("increaseViewcnt"),boardFreeId);
	}

	/*
	 * BoardFree 전체 목록 수 반환
	 * 작성자 : 김장규
	 */
	@Override
	public int selectBoardFreeCount() {
		return session.selectOne(makeSqlId("selectBoardFreeCount"));
	}

	
	/*
	 * BoardFree 전체 목록 조회
	 * 작성자 : 김장규
	 */
	@Override
	public List<BoardFree> selectBoardFreeList(int startIndex, int endIndex) {
		Map<String, Integer> input = new HashMap<String, Integer>();
		input.put("startIndex",startIndex);
		input.put("endIndex",endIndex);		
		return session.selectList(makeSqlId("selectBoardFreeList"),input);
	}

	/*
	 * BoardFree 조회수로 조회
	 * 작성자 : 김장규
	 */
	@Override
	public List<BoardFree> selectBoardFreeByBoardFreeHits(int startIndex, int endIndex) {
		Map<String, Integer> input = new HashMap<String, Integer>();
		input.put("startIndex",startIndex);
		input.put("endIndex",endIndex);				
		return session.selectList(makeSqlId("selectBoardFreeByBoardFreeHits"),input);
	}
	
	
	/*
	 * BoardFree 아이디 수 반환 조회
	 * 작성자 : 김장규
	 */
	@Override
	public int selectBoardFreeByMemberIdCount(String memberId) {
		return session.selectOne(makeSqlId("selectBoardFreeByMemberIdCount"),memberId);
	}

	/*
	 * BoardFree 아이디 조회
	 * 작성자 : 김장규
	 */
	@Override
	public List<BoardFree> selectBoardFreeByMemberId(String memberId, int startIndex, int endIndex) {
		Map<String, Object> input = new HashMap<String, Object>();
		input.put("memberId",memberId);
		input.put("startIndex",startIndex);
		input.put("endIndex",endIndex);
		return session.selectList(makeSqlId("selectBoardFreeByMemberId"),input);
	}
	
	
	/*
	 * BoardFree 제목 수 반환 조회
	 * 작성자 : 김장규
	 */
	@Override
	public int selectBoardFreeByTitleCount(String boardFreeTitle) {
		
		return session.selectOne(makeSqlId("selectBoardFreeByTitleCount"),boardFreeTitle);
	}

	/*
	 * BoardFree 제목 조회
	 * 작성자 : 김장규
	 */
	@Override
	public List<BoardFree> selectBoardFreeByTitle(String boardFreeTitle, int startIndex, int endIndex) {
		Map<String, Object> input = new HashMap<String, Object>();
		input.put("boardFreeTitle",boardFreeTitle);
		input.put("startIndex",startIndex);
		input.put("endIndex",endIndex);
		return session.selectList(makeSqlId("selectBoardFreeByTitle"),input);
	}


	/*
	 * BoardFree 상세 보기
	 * 작성자 : 김장규
	 */
	@Override
	public BoardFree selectBoardFreeByboardFreeId(int boardFreeId) {
		return session.selectOne(makeSqlId("selectBoardFreeById"),boardFreeId);
	}
	
}
