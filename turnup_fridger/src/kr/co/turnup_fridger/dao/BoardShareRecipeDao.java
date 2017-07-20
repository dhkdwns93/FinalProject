package kr.co.turnup_fridger.dao;

import java.util.List;

import kr.co.turnup_fridger.vo.BoardShareRecipe;
import kr.co.turnup_fridger.vo.IrdntManage;
import kr.co.turnup_fridger.vo.MemberRecipeRecommand;

public interface BoardShareRecipeDao {
	
	//등록
		/**
		 * BoardShareRecipe 정보를 insert하는 메소드 - 회원
		 * @param boradShareRecipe
		 * @return
		 */
		int insertBoardShareRecipe(BoardShareRecipe boardShareRecipe);
		/**
		 * 상세보기 들어갈경우  조회수 증가
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
		/**
		 * 사진 update하는 메소드
		 * @param boardShareRecipe
		 * @return
		 */
		int updateImageNull(BoardShareRecipe boardShareRecipe);
		//recipeId로 조회
		/**
		 * 게시물 상세보기 보여주는 메소드
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
	List<BoardShareRecipe> selectBoardShareRecipeByTitle(String title,int startIndex, int endIndex);
	/**
	 * 모든 게시판의 전체수를 반환
	 * @return
	 */
		int selectBoardCount();
		/**
		 * 모든 게시판의 제목 수 반환
		 * @param title
		 * @return
		 */
		int selectBoardByTitileCount(String title);
		/**
		 * 모든 게시판의 아이디 수 반환
		 * @param memberId
		 * @return
		 */
		int selectBoardByMemberIdCount(String memberId);
		/**
		 * 모든 게시판의 내용 수 반환
		 * @param txt
		 * @return
		 */
		int selectBoardByTxtCount(String txt);
		
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
		 * recipeId로 추천현황 전체 조회
		 * @param recipeId
		 * @return
		 */
		List<MemberRecipeRecommand> selectRecommandByRecipeId(int recipeId);
		
		MemberRecipeRecommand	selectRecommandOne(int recipeId);
		/**
		 * 게시판 제목으로 조회 메소드
		 * @param startIndex
		 * @param endIndex
		 * @param keyword
		 * @return
		 */
		List<BoardShareRecipe> boardSearchByTitle(int startIndex, int endIndex ,String title);
		
		
		/**
		 * 게시판 내용으로 조회 메소드 
		 * @param startIndex
		 * @param endIndex
		 * @param keyword
		 * @return
		 */
		List<BoardShareRecipe> boardSearchByTxt(int startIndex, int endIndex ,String txt);
		
		/**
		 * 게시판 회원 id로 조회 메소드
		 * @param startIndex
		 * @param endIndex
		 * @param keyword
		 * @return
		 */
		List<BoardShareRecipe> boardSearchByMemberId(int startIndex, int endIndex ,String memberId);
		/**
		 * TOP4 조회 메소드
		 * @return
		 */
		List<BoardShareRecipe> selectBoardTop4();
		/***********************************재료명Dao************************************/
		
		/**
		 * 2개 조인(공유게시판, 공유재료) 
		 * recipeId로 상세조회
		 * @param recipeId
		 * @return
		 */
		BoardShareRecipe selectBoardShareRecipeByRecipeIdToIrdnt(int recipeId);
	
	
		/**
		 * 레시피 id들로 여러개의 글객체들 불러오기 
		 * @param recipeIds
		 * @return
		 */

//		List<BoardShareRecipe> selectBoardShareRecipeById(List<Integer> recipeIds);
		


		List<BoardShareRecipe> selectBoardShareRecipeById(List<Integer> recipeIds,int startIndex, int endIndex);
		
		/**
		 * 레시피id 여러개로 불러오는 글들의 수 
		 * @param recipeIds
		 * @return
		 */
		int selectBoardShareRecipeByIdCount(List<Integer> recipeIds);
		
		/**
		 * 제목으로 부분조회된 레시피들의 수 
		 * @param title
		 * @param startIndex
		 * @param endIndex
		 * @return
		 */
		int selectBoardShareRecipeByTitleCount(String title);

}
