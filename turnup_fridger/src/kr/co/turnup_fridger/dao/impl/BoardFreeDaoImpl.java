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
	
	
	//등록
	@Override
	public int insertBoardFree(BoardFree boardFree) {
		return session.insert(makeSqlId("insertBoardFree"), boardFree);
	}

	//수정
	@Override
	public int updateBoardFree(BoardFree boardFree) {
		return session.update(makeSqlId("updateBoardFree"), boardFree);
	}

	//삭제
	@Override
	public int deleteBoardFree(int id) {
		return session.delete(makeSqlId("deleteBoardFree"),id);
	}

	
	//조회수 체크
	@Override
	public int increaseViewcnt(int boardFreeId) {
		return session.update(makeSqlId("increaseViewcnt"),boardFreeId);
	}

	//전체수 카운트
	@Override
	public int selectBoardFreeCount() {
		return session.selectOne(makeSqlId("selectBoardFreeCount"));
	}

	
	//전체 목록
	@Override
	public List<BoardFree> selectBoardFreeList(int startIndex, int endIndex) {
		Map<String, Integer> input = new HashMap<String, Integer>();
		input.put("startIndex",startIndex);
		input.put("endIndex",endIndex);		
		return session.selectList(makeSqlId("selectBoardFreeList"),input);
	}

	//조회수 검색
	@Override
	public List<BoardFree> selectBoardFreeByBoardFreeHits(int startIndex, int endIndex) {
		Map<String, Integer> input = new HashMap<String, Integer>();
		input.put("startIndex",startIndex);
		input.put("endIndex",endIndex);				
		return session.selectList(makeSqlId("selectBoardFreeByBoardFreeHits"),input);
	}
	
	
	//아이디 수 조회
	@Override
	public int selectBoardFreeByMemberIdCount(String memberId) {
		return session.selectOne(makeSqlId("selectBoardFreeByMemberIdCount"),memberId);
	}


	//아이디로 조회
	@Override
	public List<BoardFree> selectBoardFreeByMemberId(String memberId, int startIndex, int endIndex) {
		Map<String, Object> input = new HashMap<String, Object>();
		input.put("memberId",memberId);
		input.put("startIndex",startIndex);
		input.put("endIndex",endIndex);
		return session.selectList(makeSqlId("selectBoardFreeByMemberId"),input);
	}
	
	
	//제목 수 조회
	@Override
	public int selectBoardFreeByTitleCount(String boardFreeTitle) {
		// TODO Auto-generated method stub
		return session.selectOne(makeSqlId("selectBoardFreeByTitleCount"),boardFreeTitle);
	}

	//제목으로 조회
	@Override
	public List<BoardFree> selectBoardFreeByTitle(String boardFreeTitle, int startIndex, int endIndex) {
		Map<String, Object> input = new HashMap<String, Object>();
		input.put("boardFreeTitle",boardFreeTitle);
		input.put("startIndex",startIndex);
		input.put("endIndex",endIndex);
		return session.selectList(makeSqlId("selectBoardFreeByTitle"),input);
	}


	//상세페이지
	@Override
	public BoardFree selectBoardFreeByboardFreeId(int boardFreeId) {
		return session.selectOne(makeSqlId("selectBoardFreeById"),boardFreeId);
	}


	@Override
	public List<BoardFree> test(String boardFreeTitle) {
		// TODO Auto-generated method stub
		return session.selectList(makeSqlId("test"),boardFreeTitle);
	}




	
	
	
	
	
}
