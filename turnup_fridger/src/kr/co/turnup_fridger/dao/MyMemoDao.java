package kr.co.turnup_fridger.dao;

import java.util.List;

import kr.co.turnup_fridger.vo.MyMemo;

public interface MyMemoDao {

	/**
	 * 한개의 장바구니 메모를 등록하는 메소드
	 * @param session
	 * @param memo
	 * @return
	 */
	public int insertMemo(MyMemo memo);
	
	/**
	 * 한개의 장바구니 메모정보를 수정하는 메소드
	 * @param session
	 * @param memo
	 * @return
	 */
	public int updateMemo(MyMemo memo);
	
	/**
	 * 한개의 장바구니 메모정보를 삭제하는 메소드
	 * @param session
	 * @param memoId
	 * @return
	 */
	public int deleteMemo(int memoId);
	
	/**
	 * 회원당 작성한 메모의 리스트를 조회하는 메소드
	 * @param session
	 * @param memberId
	 * @return
	 */
	public List<MyMemo> selectMemoList(String memberId);
	
	/**
	 * 하나의 메모정보를 조회하는 메소드
	 * @param session
	 * @param memoId
	 * @return
	 */
	public MyMemo selectOneMemo(int memoId);
	
	/**
	 * 회원당 자신이 쓴 메모의 개수를 조회하는 메소드
	 * @param session
	 * @param memberId
	 * @return
	 */
	public int selectMemoCount(String memberId);
	
}
