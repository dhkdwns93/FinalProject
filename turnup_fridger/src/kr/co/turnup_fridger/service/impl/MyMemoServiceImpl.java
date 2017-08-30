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
	}

	@Override // 장바구니 메모 수정
	public void updateMemo(MyMemo memo) throws Exception {
		if(dao.selectOneMemo(memo.getMemoId()) == null){
			throw new Exception("해당 메모가 존재하지 않습니다");
		}
		dao.updateMemo(memo);
	}

	@Override // 장바구니 메모 삭제
	public void deleteMemo(int memoId) throws Exception {
		if(dao.selectOneMemo(memoId) == null){
			throw new Exception("해당 메모가 존재하지 않습니다");
		}
		dao.deleteMemo(memoId);
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

	
	/* ------------------- 기능 테스트 ---------------------------------------------------------------------------------------------*/
	
	public static void main(String[] args) throws Exception {
		
		ApplicationContext c = new ClassPathXmlApplicationContext("kr/co/turnup_fridger/config/spring/model-context.xml");
		MyMemoService s = (MyMemoService)c.getBean("myMemoServiceImpl");
		
		// 추가
		s.insertMemo(new MyMemo(0, "야식", "떡볶이, 피자, 치킨", "shh", new Date()));
		
		// 수정
/*		s.updateMemo(new MyMemo(0, "간식거리", "과자, 과일, 음료수", "shh", new Date()));
		
		// 삭제
		s.deleteMemo(9);*/
		
		// 총 개수
		System.out.println("--------------회원당 작성한 메모 개수-------------");
		System.out.println(s.selectMemoCount("shh"));
		
		// memberid로 메모리스트 조회 
		System.out.println("-------------한회원의 메모리스트--------------");
		List<MyMemo> list = s.selectMemoList("shh");
		for(MyMemo m : list){
			System.out.println(m);
		}
		
		// 메모id로 하나의 메모조회
		System.out.println("--------------하나의 메모조회-------------");
		System.out.println(s.selectOneMemo(27));
	}
}
