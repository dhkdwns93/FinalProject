package kr.co.turnup_fridger.service;

import java.util.List;

import kr.co.turnup_fridger.vo.MyMemo;

public interface MyMemoService {

	/**
	 * 장바구니 메모 등록
	 * @param memo
	 */
	void insertMemo(MyMemo memo) throws Exception;
	
	/**
	 * 장바구니 메모 수정
	 * @param memo
	 */
	void updateMemo(MyMemo memo) throws Exception;
	
	/**
	 * 장바구니 메모 삭제
	 * @param memoId
	 */
	void deleteMemo(int memoId) throws Exception;
	
	/**
	 * 한 회원의 메모리스트 조회
	 * @param memberId
	 * @return
	 */
	List<MyMemo> selectMemoList(String memberId);
	
	/**
	 * 하나의 메모 조회
	 * @param memoId
	 * @return
	 */
	MyMemo selectOneMemo(int memoId);
	
	/**
	 * 회원당 작성한 메모의 개수 조회
	 * @param memberId
	 * @return
	 */
	int selectMemoCount(String memberId);
	
}
