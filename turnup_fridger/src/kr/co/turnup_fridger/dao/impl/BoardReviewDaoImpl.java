package kr.co.turnup_fridger.dao.impl;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import kr.co.turnup_fridger.dao.BoardReviewDao;
import kr.co.turnup_fridger.vo.BoardReview;

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

	/**
	 * QnA 삭제(댓글과 함께 삭제)
	 * 작성자 - 김장규
	 */
	@Override
	public int deleteBoardReview(int boardReviewId) {
		return session.delete(makeSqlId("deleteBoardReview"),boardReviewId);
	}

	@Override
	public List<BoardReview> selectBoardReviewList() {
		// TODO Auto-generated method stub
		return session.selectList(makeSqlId("selectBoardReviewList"));
	}

	@Override
	public List<BoardReview> selectBoardReviewByMemberIdList(String memberId) {
		// TODO Auto-generated method stub
		return session.selectList(makeSqlId("selectBoardReviewByMemberIdList"), memberId);
	}

	@Override
	public List<BoardReview> selectBoardReviewByStarList() {
		// TODO Auto-generated method stub
		return session.selectList(makeSqlId("selectBoardReviewByStarList"));
	}

	@Override
	public List<BoardReview> selectBoardReviewByRecipeNameList(String recipeName) {
		// TODO Auto-generated method stub
		return session.selectList(makeSqlId("selectBoardReviewByRecipeNameList"), recipeName);
	}
	
	
}
