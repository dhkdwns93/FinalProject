package kr.co.turnup_fridger.service.impl;

import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;
import org.springframework.stereotype.Service;

import kr.co.turnup_fridger.dao.CommentQnADao;
import kr.co.turnup_fridger.service.CommentQnAService;
import kr.co.turnup_fridger.vo.CommentQnA;

@Service
public class CommentQnAServiceImpl implements CommentQnAService{

	@Autowired
	private CommentQnADao dao;
	
	/**
	 * 한개의 QnA 댓글을 등록 하는 메소드
	 * 작성자 - 김장규
	 */
	@Override
	public void addCommentQnA(CommentQnA commentQnA) {
		dao.insertCommentQnA(commentQnA);
		
	}
	
	/**
	 * QnA 댓글을 수정 하는 메소드
	 * 작성자 - 김장규
	 */
	@Override
	public void updateCommentQnA(CommentQnA commentQnA) {
		dao.updateCommentQnA(commentQnA);
		
	}
	
	/**
	 * QnA 댓글을 삭제 하는 메소드
	 * 작성자 - 김장규
	 */
	@Override
	public void removeCommentQnA(int id) {
		dao.deleteCommentQnA(id);
		
	}

	/**
	 * QnA 댓글을 조회 하는 메소드
	 * 작성자 - 김장규
	 */
	@Override
	public List<CommentQnA> selectCommentQnAList() {
		return dao.selectCommentQnAList();
	}
	
	@Override
	public CommentQnA selectCommentQnAById(int commentQnAId) {
		return dao.selectCommentQnAById(commentQnAId);
	}
	
	
	/**
	 * 메소드 Test
	 * 작성자 - 김장규
	 */
	public static void main(String[] args) {
		//ApplicationContext 객체 생성
		ApplicationContext container = new ClassPathXmlApplicationContext("kr/co/turnup_fridger/config/spring/model-context.xml");
		//Spring 컨테이너로 부터 CommentQnAService bean 가져오기
		CommentQnAService service = (CommentQnAService)container.getBean("commentQnAServiceImpl");
		service.addCommentQnA(new CommentQnA(3,"댓글입니다",new Date(2017-1900,11,1),"kingjun",null,2));
		//service.addCommentQnA(new CommentQnA(4,"싫어요",new Date(2017-1900,11,1),"kingjun",null,1));
		//service.addCommentQnA(new CommentQnA(5,"좋아요",new Date(2017-1900,11,1),null,"jang",1));
	
		int upId = 3;
		//service.updateCommentQnA(new CommentQnA(3,"이렇게 하면 되요",new Date(2017-1900,11,1),"kingjun",null,2));
	
		int delId = 3;
		//service.removeCommentQnA(delId);
		
		List<CommentQnA> list = service.selectCommentQnAList();
		//System.out.println(list);
		
	}
}
