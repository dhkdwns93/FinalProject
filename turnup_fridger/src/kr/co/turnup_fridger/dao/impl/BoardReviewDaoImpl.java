package kr.co.turnup_fridger.dao.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import kr.co.turnup_fridger.dao.BoardReviewDao;
import kr.co.turnup_fridger.vo.BoardReview;
import kr.co.turnup_fridger.vo.RecipeInfo;

@Repository
public class BoardReviewDaoImpl implements BoardReviewDao {

	//Spring Container에서 SqlSessionTemplate을 주입(주입) 받아서 instance 변수로 대입
	@Autowired
	private SqlSessionTemplate session;
	
	private String makeSqlId(String id){
		return "kr.co.turnup_fridger.config.mybatis.mapper.BoardReviewMapper."+id;
	}
	
	/**
	 * QnA 등록
	 * 작성자 - 김장규
	 */
	@Override
	public int insertBoardReview(BoardReview boardReview) {
		return session.insert(makeSqlId("insertBoardReview"),boardReview);
	}

	/**
	 * QnA 업데이트
	 * 작성자 - 김장규
	 */
	@Override
	public int updateBoardReview(BoardReview boardReview) {
		return session.update(makeSqlId("updateBoardReview"),boardReview);
	}

	//이미지 null
	@Override
	public int updateImageNull(BoardReview boardReview) {
		return session.update(makeSqlId("updateImageNull"),boardReview);
	}
	
	
	
	/**
	 * QnA 삭제(댓글과 함께 삭제)
	 * 작성자 - 김장규
	 */
	@Override
	public int deleteBoardReview(int boardReviewId) {
		return session.delete(makeSqlId("deleteBoardReview"),boardReviewId);
	}

	//전체 카운트
	@Override
	public int selectBoardReviewCount() {
		return session.selectOne(makeSqlId("selectBoardReviewCount"));

	}
	//전체 목록
	@Override
	public List<BoardReview> selectBoardReviewList(int startIndex, int endIndex) {
		Map<String, Integer> input = new HashMap<String, Integer>();
		input.put("startIndex",startIndex);
		input.put("endIndex",endIndex);	
		return session.selectList(makeSqlId("selectBoardReviewList"),input);
	}

	//별점순 조회
	@Override
	public List<BoardReview> selectBoardReviewByStarList(int startIndex, int endIndex) {
		Map<String, Integer> input = new HashMap<String, Integer>();
		input.put("startIndex",startIndex);
		input.put("endIndex",endIndex);	
		return session.selectList(makeSqlId("selectBoardReviewByStarList"),input);
	}

	
	//레시피 이름 카운트
	@Override
	public int selectBoardReviewByRecipeNameCount(String recipeName) {
		return session.selectOne(makeSqlId("selectBoardReviewRecipeNameCount"),recipeName);

	}
	//레시피 이름 리스트 조회
	@Override
	public List<BoardReview> selectBoardReviewByRecipeNameList(String recipeName,int startIndex, int endIndex) {
		Map<String, Object> input = new HashMap<String, Object>();
		input.put("recipeName",recipeName);
		input.put("startIndex",startIndex);
		input.put("endIndex",endIndex);
		return session.selectList(makeSqlId("selectBoardReviewByRecipeNameList"), input);
	}
	
	//아이디 카운트
	@Override
	public int selectBoardReviewByMemberIdCount(String memberId) {
		return session.selectOne(makeSqlId("selectBoardReviewMemberIdCount"),memberId);
	}

	//작성 아이디 리스트 조회
	@Override
	public List<BoardReview> selectBoardReviewByMemberIdList(String memberId,int startIndex, int endIndex) {
		Map<String, Object> input = new HashMap<String, Object>();
		input.put("memberId",memberId);
		input.put("startIndex",startIndex);
		input.put("endIndex",endIndex);		
		return session.selectList(makeSqlId("selectBoardReviewByMemberIdList"), input);
	}
	
	//해당 레시피 상세정보 조회
	@Override
	public BoardReview selecetBoardReviewByBoardReviewId(int boardReviewId) {
		// TODO Auto-generated method stub
		return session.selectOne(makeSqlId("selectBoardReviewByBoardReviewId"), boardReviewId);
	}

	//레시피 이름 검색
	@Override
	public List<RecipeInfo> selectRecipeName(String recipeName) {
		// TODO Auto-generated method stub
		return session.selectList(makeSqlId("selectRecipeName"), recipeName);
	}
	
	
}
