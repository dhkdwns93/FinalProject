package kr.co.turnup_fridger.dao.impl;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import kr.co.turnup_fridger.dao.CommentQnADao;
import kr.co.turnup_fridger.vo.CommentQnA;

@Repository
public class CommentQnADaoImpl implements CommentQnADao{

	//Spring Container에서 SqlSessionTemplate을 주입(주입) 받아서 instance 변수로 대입
		@Autowired
		private SqlSessionTemplate session;
		
		private String makeSqlId(String id){
			return "kr.co.turnup_fridger.config.mybatis.mapper.CommentQnAMapper."+id;
		}

	/**
	 * QnA 댓글 등록
	 * 작성자 - 김장규
	 */	
	@Override
	public int insertCommentQnA(CommentQnA commentQnA) {
		return session.insert(makeSqlId("insertCommentQnA"),commentQnA);
	}

	/**
	 * QnA 댓글 수정
	 * 작성자 - 김장규
	 */	
	@Override
	public int updateCommentQnA(CommentQnA commentQnA) {
		return session.update(makeSqlId("updateCommentQnA"), commentQnA);
	}

	/**
	 * QnA 댓글 삭제
	 * 작성자 - 김장규
	 */	
	@Override
	public int deleteCommentQnA(int id) {
		return session.update(makeSqlId("deleteCommentQnA"), id);
	}

	/**
	 * QnA 댓글 조회
	 * 작성자 - 김장규
	 */	
	@Override
	public List<CommentQnA> selectCommentQnAList() {
		return session.selectList(makeSqlId("selectCommentQnAList"));
	}
	
	
}
