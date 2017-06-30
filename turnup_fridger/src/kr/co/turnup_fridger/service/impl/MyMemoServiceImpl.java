package kr.co.turnup_fridger.service.impl;

import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;
import org.springframework.stereotype.Service;

import kr.co.turnup_fridger.dao.MyMemoDao;
import kr.co.turnup_fridger.service.MyMemoService;
import kr.co.turnup_fridger.vo.MyMemo;

@Service("myMemoServiceImpl")
public class MyMemoServiceImpl implements MyMemoService{

	@Autowired(required=false)
	private MyMemoDao dao;
	
	@Override // 장바구니 메모 등록
	public void insertMemo(MyMemo memo) throws Exception{
		if(dao.selectOneMemo(memo.getMemoId()) != null){
			throw new Exception("메모가 이미 존재합니다");
		}
		dao.insertMemo(memo);
		System.out.println("메모등록완료♡");
	}

	@Override // 장바구니 메모 수정
	public void updateMemo(MyMemo memo) throws Exception {
		if(dao.selectOneMemo(memo.getMemoId()) == null){
			throw new Exception("해당 메모가 존재하지 않습니다");
		}
		dao.updateMemo(memo);
		System.out.println("메모수정완료♡");
	}

	@Override // 장바구니 메모 삭제
	public void deleteMemo(int memoId) throws Exception {
		if(dao.selectOneMemo(memoId) == null){
			throw new Exception("해당 메모가 존재하지 않습니다");
		}
		dao.deleteMemo(memoId);
		System.out.println("메모삭제완료♡");
	}

	@Override //  한 회원의 메모리스트 조회
	public List<MyMemo> selectMemoList(String memberId) {

		return dao.selectMemoList(memberId);
	}

	@Override // 하나의 메모 조회
	public MyMemo selectOneMemo(int memoId) {
		
		return dao.selectOneMemo(memoId);
	}

	@Override // 회원당 작성한 메모의 개수 조회
	public int selectMemoCount(String memberId) {
	
		return dao.selectMemoCount(memberId);
	}

	public static void main(String[] args) throws Exception {
		
		ApplicationContext container = new ClassPathXmlApplicationContext("kr/co/turnup_fridger/config/spring/model-context.xml");
		MyMemoService s = (MyMemoService)container.getBean("myMemoServiceImpl");
		
		MyMemo memo = new MyMemo(0, "간식거리", "과자, 과일, 음료수", "shh", new Date());
		
		s.insertMemo(memo);
		s.updateMemo(memo);
		s.deleteMemo(9);
		s.selectMemoCount("shh");
		s.selectMemoList("shh");
		s.selectOneMemo(7);
	}
}
