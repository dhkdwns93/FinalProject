package kr.co.turnup_fridger.dao;

import java.util.List;

import kr.co.turnup_fridger.vo.IrdntManage;

public interface IrdntManageDao {

	/**
	 * 재료입력
	 * @return
	 */
	int insertIrdnt(IrdntManage irdnt);
	
	/**
	 * 재료수정
	 * @return
	 */
	int updateIrdnt(IrdntManage irdnt);
	
	/**
	 * 재료삭제
	 * @return
	 */
	int deleteIrdnt(int irdntId);
	
	/**
	 * 재료 전부 조회
	 * @return
	 */
	List<IrdntManage> selectAllIrdnt();
	
	/**
	 * 재료명으로 재료들 조회 (부분일치)
	 * @return
	 */
	List<IrdntManage> selectIrdntByName(String irdntName);
	
	/**
	 * 재료 id로 재료조회
	 * @return
	 */
	IrdntManage selectIrdntById(int irdntId);
	
	/**
	 * 재료분류로 재료들 조회
	 * @return
	 */
	List<IrdntManage> selectIrdntByCategory(String irdntCategory);
	
}
