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
	
	@Override
	public List<ShareRecipeIrdnt> selectShareRecipeIrdntAll() {
		// TODO Auto-generated method stub
		return session.selectList(sql("selectShareRecipeIrdntAll"));
	}
	
	@Override
	public List<ShareRecipeIrdnt> selectShareRecipeIrdntByIrdntId(int irdntId) {
		// TODO Auto-generated method stub
		return session.selectList(sql("selectShareRecipeIrdntByIrdntId"), irdntId);
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
	
	
}
