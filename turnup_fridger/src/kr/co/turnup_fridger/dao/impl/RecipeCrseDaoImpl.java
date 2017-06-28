package kr.co.turnup_fridger.dao.impl;

import java.util.HashMap;
import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import kr.co.turnup_fridger.dao.RecipeCrseDao;
import kr.co.turnup_fridger.vo.RecipeCrse;

@Repository
public class RecipeCrseDaoImpl implements RecipeCrseDao {

	@Autowired
	private SqlSessionTemplate session;
	private String makeSql(String id){
		return "kr.co.turnup_fridger.config.mybatis.mapper.RecipeCrse."+id;
	}
	
	@Override
	public int insertRecipeCrse(RecipeCrse recipeCrse) {
		return session.insert(makeSql("insertRecipeCrse"),recipeCrse);
	}

	@Override
	public int updateRecipeCrse(RecipeCrse recipeCrse) {
		return session.update(makeSql("updateRecipeCrse"),recipeCrse);
	}

	@Override
	public int deleteRecipeCrse(int recipeId, int cookingNo) {
		HashMap map= new HashMap();
		map.put("recipeId",recipeId);
		map.put("cookingNo",cookingNo);
		return session.delete(makeSql("deleteRecipeCrse"),map);
	}

	@Override
	public List<RecipeCrse> selectAllRecipeCrse() {
		return session.selectList(makeSql("selectAllRecipeCrse"));
	}

	@Override
	public List<RecipeCrse> selectRecipeCrseById(int recipeId) {
		return session.selectList(makeSql("selectRecipeCrseById"),recipeId);
	}

	@Override
	public RecipeCrse selectRecipeCrseByIdAndNo(int recipeId, int cookingNo) {
		HashMap map= new HashMap();
		map.put("recipeId",recipeId);
		map.put("cookingNo",cookingNo);
		return session.selectOne(makeSql("selectRecipeCrseByIdAndNo"),map);
	}

	
}
