package kr.co.turnup_fridger.dao.impl;

import java.util.HashMap;
import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import kr.co.turnup_fridger.dao.ShareRecipeIrdntDao;
import kr.co.turnup_fridger.vo.ShareRecipeIrdnt;
@Repository
public class ShareRecipeIrdntDaoImpl implements ShareRecipeIrdntDao{
	
	
	@Autowired
	private SqlSessionTemplate session;
	
	private String sql(String id){
		return "kr.co.turnup_fridger.config.mybatis.mapper.ShareRecipeIrdntMapper."+id;
	}
	
	@Override
	public int insertShareRecipeIrdnt(ShareRecipeIrdnt shareRecipeIrdnt) {
		// TODO Auto-generated method stub
		return session.insert(sql("insertShareRecipeIrdnt"), shareRecipeIrdnt);
	}

	@Override
	public int updateShareRecipeIrdnt(ShareRecipeIrdnt shareRecipeIrdnt) {
		// TODO Auto-generated method stub
		return session.update(sql("updateShareRecipeIrdnt"), shareRecipeIrdnt);
	}
	
	@Override
	public int deleteShareRecipeIrdnt(int irdntKey) {
		// TODO Auto-generated method stub
		return session.delete(sql("deleteShareRecipeIrdnt"), irdntKey);
	}
	
/*	@Override
	public List<ShareRecipeIrdnt> selectShareRecipeIrdntAll() {
		// TODO Auto-generated method stub
		return session.selectList(sql("selectShareRecipeIrdntAll"));
	}*/
	@Override
	public ShareRecipeIrdnt selectShareRecipeByIrdntName(String irdntName) {
		// TODO Auto-generated method stub
		return session.selectOne(sql("selectShareRecipeByIrdntName"), irdntName);
	}

	@Override
	public ShareRecipeIrdnt selectShareRecipeIrdntByRecipeIdByIrdntId(ShareRecipeIrdnt shareRecipeIrdnt) {
		// TODO Auto-generated method stub
		return session.selectOne(sql("selectShareRecipeIrdntByRecipeIdByIrdntId"), shareRecipeIrdnt);
	}

	@Override
	public int deleteShareRecipeIrdntByRecipeId(int recipeId) {
		// TODO Auto-generated method stub
		return session.delete(sql("deleteShareRecipeIrdntByRecipeId"), recipeId);
	}

	@Override
	public int deleteShareRecipeIrdntByIrdntId(int irdntId) {
		// TODO Auto-generated method stub
		return session.delete(sql("deleteShareRecipeIrdntByIrdntId"), irdntId);
	}
	
	

	@Override
	public ShareRecipeIrdnt selectShareRecipeIrdntByRecipeIdNotList(int recipeId) {
		// TODO Auto-generated method stub
		return session.selectOne(sql("selectShareRecipeIrdntByRecipeIdNotList"), recipeId);
	}

	@Override
	public ShareRecipeIrdnt selectShareRecipeByIrdntKey(int irdntKey) {
		// TODO Auto-generated method stub
		return session.selectOne(sql("selectShareRecipeByIrdntKey"), irdntKey);
	}

	@Override
	public ShareRecipeIrdnt selectShareRecipeIrdntByIrdntId(int irdntId) {
		// TODO Auto-generated method stub
		return session.selectOne(sql("selectShareRecipeIrdntByIrdntId"), irdntId);
	}
	
	@Override
	public List<ShareRecipeIrdnt> selectShareRecipeIrdntByRecipeId(int recipeId) {
		return session.selectList(sql("selectShareRecipeIrdntByRecipeId"), recipeId);
	}

	@Override
	public List<Integer> getRecipeBoardIdByIrdntIds(List<Integer> irdntIds, List<Integer> hateIrdntIds) {
		HashMap map = new HashMap();
		map.put("irdntIds",irdntIds);
		map.put("hateIrdntIds",hateIrdntIds);
		System.out.println("매퍼가기전 선호/비선호 재료들 "+irdntIds+"/"+hateIrdntIds);
		
		return session.selectList(sql("getRecipeBoardIdByIrdntIds"),map);
	}
	
	
	//////////////////////////

	@Override
	public List<ShareRecipeIrdnt> findShareRecipeIrdntByRecipeId(int recipeId) {
		// TODO Auto-generated method stub
		return 	session.selectList(sql("selectRecipeId"),recipeId);
	}
	

	
	
}
