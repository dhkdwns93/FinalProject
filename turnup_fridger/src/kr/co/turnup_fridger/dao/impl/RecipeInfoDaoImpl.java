package kr.co.turnup_fridger.dao.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import kr.co.turnup_fridger.dao.RecipeInfoDao;
import kr.co.turnup_fridger.vo.RecipeInfo;

@Repository
public class RecipeInfoDaoImpl implements RecipeInfoDao{

	@Autowired
	private SqlSessionTemplate session;
	private String makeSql(String id){
		return "kr.co.turnup_fridger.config.mybatis.mapper.RecipeInfoMapper."+id;
	}	
	
	@Override
	public int insertRecipeInfo(RecipeInfo recipeInfo) {
		return session.insert(makeSql("insertRecipeInfo"),recipeInfo);
	}

	@Override
	public int updateRecipeInfo(RecipeInfo recipeInfo) {
		return session.update(makeSql("updateRecipeInfo"),recipeInfo);
	}

	@Override
	public int deleteRecipeInfo(int recipeId) {
		return session.delete(makeSql("deleteRecipeInfo"),recipeId);
	}

	@Override
	public List<RecipeInfo> selectAllRecipeInfo() {
		return session.selectList(makeSql("selectAllRecipeInfo"));
	}

	@Override
	public RecipeInfo selectRecipeInfoById(int recipeId) {
		return session.selectOne(makeSql("selectRecipeInfoById"),recipeId);
	}

	//조인
	@Override
	public RecipeInfo selectThreeOfRecipesById(int recipeId) {
		return session.selectOne(makeSql("selectThreeOfRecipesById"),recipeId);
	}
	
	@Override
	public RecipeInfo selectRecipeInfoByFullName(String recipeName){
		return session.selectOne(makeSql("selectRecipeInfoByFullName"), recipeName);
		
	}
	
	//페이징
	@Override
	public List<RecipeInfo> selectRecipeInfoByName(String recipeName, String keyword) {
		System.out.println("dao"+recipeName+keyword);
		Map<String,String> input= new HashMap<String,String>();
		input.put("recipeName", recipeName);
		input.put("keyword",keyword);	
		System.out.println(input);
		return session.selectList(makeSql("selectRecipeInfoByName"),input);
	}
	@Override
	public int selectRecipeInfoByNameCount(String recipeName, String keyword) {
		HashMap map = new HashMap();
		map.put("recipeName", recipeName);
		map.put("keyword",keyword);		
		return session.selectOne(makeSql("selectRecipeInfoByNameCount"),map);
	}

	//페이징
	@Override
	public List<RecipeInfo> selectRecipeInfoByCategoryAndType(String categoryName, String typeName,String keyword) {
		HashMap map = new HashMap();
		map.put("categoryName", categoryName);
		map.put("typeName", typeName);
		map.put("keyword",keyword);		
		return session.selectList(makeSql("selectRecipeInfoByCategoryAndType"),map);
	}
	@Override
	public int selectRecipeInfoByCategoryAndTypeCount(String categoryName, String typeName, String keyword) {
		HashMap map = new HashMap();
		map.put("categoryName", categoryName);
		map.put("typeName", typeName);
		map.put("keyword",keyword);		
		return session.selectOne(makeSql("selectRecipeInfoByCategoryAndTypeCount"),map);
	}
	
	
	//페이징
	@Override
	public List<RecipeInfo> selectRecipesInfoByIds(List<Integer> recipeIds,String keyword) {
		HashMap map = new HashMap();
		map.put("recipeIds", recipeIds);
		map.put("keyword",keyword);	
		//System.out.println("레시피인포dao : "+recipeIds +"/"+keyword);
		return session.selectList(makeSql("selectRecipesInfoByIds"),map);
	}

	@Override
	public int selectRecipesInfoByIdsCount(List<Integer> recipeIds, String keyword) {
		HashMap map = new HashMap();
		map.put("recipeIds", recipeIds);
		map.put("keyword",keyword);		
		return session.selectOne(makeSql("selectRecipesInfoByIdsCount"),map);
	}

	@Override
	public List<String> selectTypeNameByCategoryName(String categoryName) { 
		return session.selectList(makeSql("selectTypeNameByCategoryName"),categoryName);
	}

	
	
}
