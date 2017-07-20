package kr.co.turnup_fridger.dao.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import kr.co.turnup_fridger.dao.BoardShareRecipeDao;
import kr.co.turnup_fridger.vo.BoardShareRecipe;
import kr.co.turnup_fridger.vo.IrdntManage;
import kr.co.turnup_fridger.vo.MemberRecipeRecommand;

@Repository
public class BoardShareRecipeDaoImpl implements BoardShareRecipeDao{
	
	@Autowired
	private SqlSessionTemplate session;
	//레시피공유게시판
	private String makeSqlId(String id){
		return "kr.co.turnup_fridger.config.mybatis.mapper.BoardShareRecipeMapper."+id;
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
	public List<BoardShareRecipe> selectBoardShareRecipeByTitle(String title,int startIndex, int endIndex) {
		HashMap map = new HashMap();
		map.put("title", title);
		map.put("startIndex", startIndex);
		map.put("endIndex", endIndex);
		
		return session.selectList(makeSqlId("selectBoardShareRecipeByTitle"), map);
	}
	
	@Override
	public int selectBoardCount() {

		return session.selectOne(makeSqlId("selectBoardCount"));
	}
	
	
	@Override
	public int selectBoardByTitileCount(String title) {
	
		return session.selectOne(makeSqlId("selectBoardByTitileCount"), title);
	}




	@Override
	public int selectBoardByMemberIdCount(String memberId) {
	
		return session.selectOne(makeSqlId("selectBoardByMemberIdCount"), memberId);
	}




	@Override
	public int selectBoardByTxtCount(String txt) {
		
		return session.selectOne(makeSqlId("selectBoardByTxtCount"), txt);
	}




	@Override
	public List<BoardShareRecipe> selectBoardShareRecipeByAll(int startIndex, int endIndex) {
		Map<String, Integer> input = new HashMap<String, Integer>();
		input.put("startIndex", startIndex);
		input.put("endIndex", endIndex);
		return session.selectList(makeSqlId("selectBoardShareRecipeByAll"), input);
	}
	
	@Override
	public int updateImageNull(BoardShareRecipe boardShareRecipe) {
		// TODO Auto-generated method stub
		return session.update(makeSqlId("imageUpdateNull"), boardShareRecipe);
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
		recommandMap.put("recipeId", recipeId);
		recommandMap.put("memberId", memberId);
		return session.selectOne(makeSqlId("selectRecommand"), recommandMap);
	}
	
	//레시피 ID로 삭제
	@Override
	public int deleteRecommand(int recipeId) {
	
		return session.delete(makeSqlId("deleteRecommand"), recipeId);
	}
	

	@Override
	public MemberRecipeRecommand selectRecommandOne(int recipeId) {
		
		return session.selectOne(makeSqlId("selectRecommandOne"), recipeId);
	}
	
	@Override
	public List<MemberRecipeRecommand> selectRecommandByRecipeId(int recipeId) {
	
		return session.selectList(makeSqlId("selectRecommandByRecipeId"), recipeId);
	}
	@Override
	public List<BoardShareRecipe> boardSearchByTitle(int startIndex, int endIndex, String title) {
		HashMap<String, Object> map = new HashMap<>();
		map.put("startIndex", startIndex);
		map.put("endIndex", endIndex);
		map.put("title", title);
		return session.selectList(makeSqlId("boardSearchByTitle"), map);
	}
	@Override
	public List<BoardShareRecipe> boardSearchByTxt(int startIndex, int endIndex, String txt) {
		HashMap<String, Object> map = new HashMap<>();
		map.put("startIndex", startIndex);
		map.put("endIndex", endIndex);
		map.put("txt", txt);
		return session.selectList(makeSqlId("boardSearchByTxt"), map);
	}
	@Override
	public List<BoardShareRecipe> boardSearchByMemberId(int startIndex, int endIndex, String memberId) {
		HashMap<String, Object> map = new HashMap<>();
		map.put("startIndex", startIndex);
		map.put("endIndex", endIndex);
		map.put("memberId", memberId);
		return session.selectList(makeSqlId("boardSearchByMemberId"), map);
	}
	@Override
	public List<BoardShareRecipe> selectBoardTop4() {
		
		return session.selectList(makeSqlId("selectBoardTop4"));
	}
	@Override
	public BoardShareRecipe selectBoardShareRecipeByRecipeIdToIrdnt(int recipeId) {
		
		return session.selectOne(makeSqlId("selectBoardShareRecipeByRecipeIdToIrdnt"), recipeId);
	}
	
	@Override
	public List<BoardShareRecipe> selectBoardShareRecipeById(List<Integer> recipeIds,int startIndex, int endIndex) {
		
		HashMap map = new HashMap();
		map.put("recipeIds", recipeIds);
		map.put("startIndex", startIndex);
		map.put("endIndex", endIndex);
		//System.out.println("페이징하러갈때 들고가는 레시피id들"+recipeIds);
		return session.selectList(makeSqlId("selectBoardShareRecipeById"),map);
	}

	@Override
	public int selectBoardShareRecipeByIdCount(List<Integer> recipeIds) {
		//System.out.println("추출된 레시피id들 받아온거"+recipeIds);
		return session.selectOne(makeSqlId("selectBoardShareRecipeByIdCount"),recipeIds);
	}
	@Override
	public int selectBoardShareRecipeByTitleCount(String title) {		
		return session.selectOne(makeSqlId("selectBoardShareRecipeByTitleCount"),title);
	}
	

	
	
	
}
