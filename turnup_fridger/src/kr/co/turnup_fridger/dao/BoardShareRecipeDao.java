package kr.co.turnup_fridger.dao;

import java.util.HashMap;
import java.util.List;

import kr.co.turnup_fridger.vo.BoardShareRecipe;
import kr.co.turnup_fridger.vo.MemberRecipeRecommand;

public interface BoardShareRecipeDao {
	
	//등록
	/**
	 * insert로 레시피 공유게시판 등록
	 * @param boradShareRecipe
	 * @return
	 */
	int insertBoardShareRecipe(BoardShareRecipe boardShareRecipe);
	/**
	 * 게시물 조회수 증가
	 * @param recipeId
	 * @return
	 */
	int increaseHit(int recipeId);
	//삭제
	/**
	 * recipeId로 레시피 공유게시판 삭제
	 * @param recipeId
	 * @return
	 */
	int deleteBoardShareRecipe(int recipeId);
	
	//수정
	/**
	 * recipeId로 레시피 공유게시판 수정
	 * @param recipeId
	 * @return
	 */
	int updateBoardShareRecipeByRecipeId(BoardShareRecipe boardShareRecipe);
	
	//recipeId로 조회
	/**
	 * 게시물 상세보기
	 * @param recipeId
	 * @return
	 */
	BoardShareRecipe boardRead(int recipeId);
	
	//title로 조회
		/**
		 * 제목으로 레시피 공유 게시판 조회
		 * @param title
		 * @return
		 */
		List<BoardShareRecipe> selectBoardShareRecipeByTitle(String title);
	/**
	 * 모든 게시판의 전체수를 반환
	 * @return
	 */
		int selectBoardCount();
		
		//전체조회
		/**
		 * 전체조회
		 * @return
		 */
		List<BoardShareRecipe> selectBoardShareRecipeByAll(int startIndex, int endIndex);	
		/**
		 * 추천수 메소드
		 * @param recipeId
		 * @return
		 */
		int updateBoardRecommand(int recipeId);
		/**
		 * 추천수 등록 메소드
		 * @param memberRecipeRecommand
		 * @return
		 */
		int insertRecommand(MemberRecipeRecommand memberRecipeRecommand); 
		/**
		 * 추천수 조회 메소드
		 * @param recipeId
		 * @param memberId
		 * @return
		 */
		MemberRecipeRecommand selectRecommand(int recipeId, String memberId);
		/**
		 * 게시물 삭제와 동시에 추천 테이블 삭제 메소드
		 * @param recipeId
		 * @return
		 */
		int deleteRecommand(int recipeId);
		/**
		 * 게시판 제목으로 조회 메소드
		 * @param startIndex
		 * @param endIndex
		 * @param keyword
		 * @return
		 */
		List<BoardShareRecipe> boardSearchByTitle(int startIndex, int endIndex ,String keyword);
		
		
		/**
		 * 게시판 내용으로 조회 메소드 
		 * @param startIndex
		 * @param endIndex
		 * @param keyword
		 * @return
		 */
		List<BoardShareRecipe> boardSearchByTxt(int startIndex, int endIndex ,String keyword);
		
		/**
		 * 게시판 회원 id로 조회 메소드
		 * @param startIndex
		 * @param endIndex
		 * @param keyword
		 * @return
		 */
		List<BoardShareRecipe> boardSearchByMemberId(int startIndex, int endIndex ,String keyword);
		/**
		 * TOP4 조회 메소드
		 * @return
		 */
		List<BoardShareRecipe> selectBoardTop4();
		/***********************************재료명Dao************************************/
		
		/**
		 * 재료명
		 * @return
		 */
		List<BoardShareRecipe> selectBoardShareRecipeByRecipeIdToIrdnt(int recipeId);
	
		/***********************************imageDao************************************/
		/**
		 * 사진
		 * @return
		 */
		List<String> selectBoardShareRecipeByRecipeIdToImg(int recipeId); 
		
		/**
		 * 이미지 등록
		 * @param image
		 * @return
		 */
		int insertBoardShareRecipeImg(HashMap map);
		
		/**
		 * 이미지 선택 삭제
		 * @param BoardShareRecipeImgKey
		 * @return
		 */
		int deleteBoardShareRecipeImgByKey(int boardShareRecipeImgKey);
		
		
		/**
		 * 이미지 전체 삭제
		 * @param recipeId\
		 * @return
		 */
		int deleteBoardShareRecipeImgAll(int recipeId);
		/**
		 * recipeId로 이미지 조회
		 * @param recipeId
		 * @return
		 */
		List<String> selectBoardShareRecipeImg(int recipeId);
		
		
}
