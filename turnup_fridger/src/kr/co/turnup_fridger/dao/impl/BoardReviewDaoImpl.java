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
	
	/*
	 * 후기 등록 - 회원
	 * 작성자 - 김장규
	 */
	@Override
	public int insertBoardReview(BoardReview boardReview) {
		return session.insert(makeSqlId("insertBoardReview"),boardReview);
	}

	/*
	 * 후기 업데이트 - 작성자
	 * 작성자 - 김장규
	 */
	@Override
	public int updateBoardReview(BoardReview boardReview) {
		return session.update(makeSqlId("updateBoardReview"),boardReview);
	}

	/*
	 * 후기 삭제(댓글과 함께 삭제) - 관리자, 작성자
	 * 작성자 - 김장규
	 */
	@Override
	public int deleteBoardReview(int boardReviewId) {
		return session.delete(makeSqlId("deleteBoardReview"),boardReviewId);
	}

	/*
	 * 후기 전체 목록 수
	 * 작성자 - 김장규
	 */
	@Override
	public int selectBoardReviewCount() {
		return session.selectOne(makeSqlId("selectBoardReviewCount"));

	}
	/*
	 * 후기 전체 목록 조회
	 * 작성자 - 김장규
	 */
	@Override
	public List<BoardReview> selectBoardReviewList(int startIndex, int endIndex) {
		Map<String, Integer> input = new HashMap<String, Integer>();
		input.put("startIndex",startIndex);
		input.put("endIndex",endIndex);	
		return session.selectList(makeSqlId("selectBoardReviewList"),input);
	}

	/*
	 * 후기 별점 순 조회
	 * 작성자 - 김장규
	 */
	@Override
	public List<BoardReview> selectBoardReviewByStarList(int startIndex, int endIndex) {
		Map<String, Integer> input = new HashMap<String, Integer>();
		input.put("startIndex",startIndex);
		input.put("endIndex",endIndex);	
		return session.selectList(makeSqlId("selectBoardReviewByStarList"),input);
	}

	
	/*
	 * 후기 해당 레시피 이름 수 카운트
	 * 작성자 - 김장규
	 */
	@Override
	public int selectBoardReviewByRecipeNameCount(String recipeName) {
		return session.selectOne(makeSqlId("selectBoardReviewRecipeNameCount"),recipeName);

	}
	/*
	 * 후기 해당 레시피 이름 조회
	 * 작성자 - 김장규
	 */
	@Override
	public List<BoardReview> selectBoardReviewByRecipeNameList(String recipeName,int startIndex, int endIndex) {
		Map<String, Object> input = new HashMap<String, Object>();
		input.put("recipeName",recipeName);
		input.put("startIndex",startIndex);
		input.put("endIndex",endIndex);
		return session.selectList(makeSqlId("selectBoardReviewByRecipeNameList"), input);
	}
	
	/*
	 * 후기 해당 아이디 수 카운트
	 * 작성자 - 김장규
	 */
	@Override
	public int selectBoardReviewByMemberIdCount(String memberId) {
		return session.selectOne(makeSqlId("selectBoardReviewMemberIdCount"),memberId);
	}

	/*
	 * 후기 해당 아이디 목록 조회
	 * 작성자 - 김장규
	 */
	@Override
	public List<BoardReview> selectBoardReviewByMemberIdList(String memberId,int startIndex, int endIndex) {
		Map<String, Object> input = new HashMap<String, Object>();
		input.put("memberId",memberId);
		input.put("startIndex",startIndex);
		input.put("endIndex",endIndex);		
		return session.selectList(makeSqlId("selectBoardReviewByMemberIdList"), input);
	}
	
	/*
	 * 후기 해당 레시피 상세정보 조회
	 * 작성자 - 김장규
	 */
	@Override
	public BoardReview selecetBoardReviewByBoardReviewId(int boardReviewId) {
		return session.selectOne(makeSqlId("selectBoardReviewByBoardReviewId"), boardReviewId);
	}

	/*
	 * 후기 해당 레시피 이름 조회
	 * 작성자 - 김장규
	 */
	@Override
	public List<RecipeInfo> selectRecipeName(String recipeName) {
		return session.selectList(makeSqlId("selectRecipeName"), recipeName);
	}
		
	/*
	 * 후기 레시피ID 수 카운트
	 * 작성자 - 김장규
	 */
	@Override
	public int selectRecipeIdCount(int recipeId) {
		return session.selectOne(makeSqlId("selectRecipeIdCount"), recipeId);
	}
	
	/*
	 * 후기 레시피ID 목록 조회
	 * 작성자 - 김장규
	 */
	@Override
	public List<BoardReview> selectBoardReviewByRecipeId(int recipeId,int startIndex,int endIndex) {
		Map<String, Object> input = new HashMap<String, Object>();
		input.put("recipeId",recipeId);
		input.put("startIndex",startIndex);
		input.put("endIndex",endIndex);		
		return session.selectList(makeSqlId("selectBoardReviewByRecipeId"), input);
	}

	/*
	 * 후기 레시피ID 상세정보 조회
	 * 작성자 - 김장규
	 */
	@Override
	public BoardReview selectBoardReviewByBoardReviewId(int boardReviewId) {
		return session.selectOne(makeSqlId("selectBoardReviewByBoardReviewId"),boardReviewId);
	}

	
}
