package kr.co.turnup_fridger.dao.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import kr.co.turnup_fridger.dao.BoardShareRecipeDao;
import kr.co.turnup_fridger.vo.BoardShareRecipe;
import kr.co.turnup_fridger.vo.MemberRecipeRecommand;

@Repository
public class BoardShareRecipeDaoImpl implements BoardShareRecipeDao{
	
	@Autowired
	private SqlSessionTemplate session;
	//레시피공유게시판
	private String makeSqlId(String id){
		return "kr.co.turnup_fridger.config.mybatis.mapper.BoardShareRecipeMapper."+id;
	}
	//레시피공유사진
	private String sql(String id){
		return "kr.co.turnup_fridger.config.mybatis.mapper.BoardShareRecipeImgMapper."+id;
	}
	
	@Override
	public int insertBoardShareRecipe(BoardShareRecipe boardShareRecipe) {
		
		return session.insert(makeSqlId("insertBoardShareRecipe"), boardShareRecipe);
	}
	
	
	@Override
	public int increaseHit(int recipeId) {
		
		return session.update(makeSqlId("increaseHit"), recipeId);
	}
	@Override
	public int deleteBoardShareRecipe(int recipeId) {
		
		return session.delete(makeSqlId("deleteBoardShareRecipe"), recipeId);
	}
	

	@Override
	public int updateBoardShareRecipeByRecipeId(BoardShareRecipe boardShareRecipe) {
		
		return session.update(makeSqlId("updateBoardShareRecipeByRecipeId"), boardShareRecipe);
	}
	
	@Override
	public BoardShareRecipe boardRead(int recipeId) {
		
		return session.selectOne(makeSqlId("boardRead"), recipeId);
	}
	@Override
	public List<BoardShareRecipe> selectBoardShareRecipeByTitle(String title) {
	
		return session.selectList(makeSqlId("selectBoardShareRecipeByTitle"), title);
	}
	
	@Override
	public int selectBoardCount() {

		return session.selectOne(makeSqlId("selectBoardCount"));
	}
	@Override
	public List<BoardShareRecipe> selectBoardShareRecipeByAll(int startIndex, int endIndex) {
		Map<String, Integer> input = new HashMap<String, Integer>();
		input.put("startIndex", startIndex);
		input.put("endIndex", endIndex);
		return session.selectList(makeSqlId("selectBoardShareRecipeByAll"), input);
	}
	
	
	@Override
	public int updateBoardRecommand(int recipeId) {
		// TODO Auto-generated method stub
		return session.update(makeSqlId("updateBoardRecommand"), recipeId);
	}
	@Override
	public int insertRecommand(MemberRecipeRecommand memberRecipeRecommand) {
		// TODO Auto-generated method stub
		return session.insert(makeSqlId("insertRecommand"), memberRecipeRecommand);
	}
	@Override
	public MemberRecipeRecommand selectRecommand(int recipeId, String memberId) {
		HashMap<String, Object> recommandMap = new HashMap<>();
		recommandMap.put("recip;eId", recipeId);
		recommandMap.put("memberId", memberId);
		return session.selectOne(makeSqlId("selectRecommand"), recommandMap);
	}
	@Override
	public int deleteRecommand(int recipeId) {
		// TODO Auto-generated method stub
		return session.delete(makeSqlId("deleteRecommand"), recipeId);
	}
	@Override
	public List<BoardShareRecipe> boardSearchByTitle(int startIndex, int endIndex, String keyword) {
		HashMap<String, Object> map = new HashMap<>();
		map.put("startIndex", startIndex);
		map.put("endIndex", endIndex);
		map.put("keyword", keyword);
		return session.selectList(makeSqlId("boardSearchByTitle"), map);
	}
	@Override
	public List<BoardShareRecipe> boardSearchByTxt(int startIndex, int endIndex, String keyword) {
		HashMap<String, Object> map = new HashMap<>();
		map.put("startIndex", startIndex);
		map.put("endIndex", endIndex);
		map.put("keyword", keyword);
		return session.selectList(makeSqlId("boardSearchByTxt"), map);
	}
	@Override
	public List<BoardShareRecipe> boardSearchByMemberId(int startIndex, int endIndex, String keyword) {
		HashMap<String, Object> map = new HashMap<>();
		map.put("startIndex", startIndex);
		map.put("endIndex", endIndex);
		map.put("keyword", keyword);
		return session.selectList(makeSqlId("boardSearchByMemberId"), map);
	}
	@Override
	public List<BoardShareRecipe> selectBoardTop4() {
		
		return session.selectList(makeSqlId("selectBoardTop4"));
	}
	@Override
	public List<BoardShareRecipe> selectBoardShareRecipeByRecipeIdToIrdnt(int recipeId) {
		
		return session.selectList(makeSqlId("selectBoardShareRecipeByRecipeIdToIrdnt"), recipeId);
	}
	@Override
	public List<String> selectBoardShareRecipeByRecipeIdToImg(int recipeId) {
		
		return session.selectList(makeSqlId("selectBoardShareRecipeByRecipeIdToImg"), recipeId);
	}
	
	@Override
	public int insertBoardShareRecipeImg(HashMap map) {
		return session.insert(sql("insertBoardShareRecipeImg"), map);
	}
	
	
	@Override
	public int deleteBoardShareRecipeImgByKey(int boardShareRecipeImgKey) {
		// TODO Auto-generated method stub
		return session.delete(sql("deleteBoardShareRecipeImgByKey"), boardShareRecipeImgKey);
	}
	@Override
	public int deleteBoardShareRecipeImgAll(int recipeId) {
		// TODO Auto-generated method stub
		return session.delete(sql("deleteBoardShareRecipeImgAll"), recipeId);
	}
	
	@Override
	public List<String> selectBoardShareRecipeImg(int recipeId) {
		// TODO Auto-generated method stub
		return session.selectList(sql("selectBoardShareRecipeImg"), recipeId);
	}
	
	@Override
	public List<BoardShareRecipe> selectBoardShareRecipeById(List<Integer> recipeIds) {
		System.out.println("보드쉐어dao 찾을 id들" + recipeIds);
		HashMap map = new HashMap();
		map.put("recipeIds", recipeIds);
		
		return session.selectList(makeSqlId("selectBoardShareRecipeById"),map);
	}
	
	
	
	
}
