package kr.co.turnup_fridger.service.impl;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.co.turnup_fridger.dao.BoardShareRecipeDao;
import kr.co.turnup_fridger.dao.ShareRecipeIrdntDao;
import kr.co.turnup_fridger.service.BoardShareRecipeService;
import kr.co.turnup_fridger.util.PagingBean;
import kr.co.turnup_fridger.vo.BoardShareRecipe;
import kr.co.turnup_fridger.vo.MemberRecipeRecommand;
@Service
public class BoardShareRecipeServiceImpl implements BoardShareRecipeService{
	
	@Autowired
	private BoardShareRecipeDao dao;
	@Autowired
	private ShareRecipeIrdntDao shareDao;

	@Override
	public void insertBoardShareRecipe(BoardShareRecipe boardShareRecipe) {
		

		dao.insertBoardShareRecipe(boardShareRecipe);
	}
	
	
	
	@Override
	public void increaseHit(int recipeId, HttpSession session) throws Exception{
	//세션에 저장된 조회시간 검색
		long updateTime = 0;
		//최초로 조회할 경우 세션에 저장된 값이 없기때문에 if문은 실행x
		if(session.getAttribute("updateTime"+recipeId)!=null){
			updateTime = (long)session.getAttribute("updateTime"+recipeId);
		}
		//시스템의 현재시간을 currentTime에 저장
		long currentTime= System.currentTimeMillis();
		//시스템 현재시간 - 열람시간 > 일정시간(조회수 증가가 가능하도록 지정한 시간)
		if(currentTime - updateTime > 5*1000){
			dao.increaseHit(recipeId);
			//세션에 시간을 저장 : updateTime+recipeId는 다른변수와 중복되지 않게 정한것.
			session.setAttribute("updateTime"+recipeId, currentTime);
		}
	}



	@Override
	public void deleteBoardShareRecipe(int recipeId) {
		dao.deleteBoardShareRecipe(recipeId);
		
	}

	@Override
	public void updateBoardShareRecipe(BoardShareRecipe boardShareRecipe) {
		dao.updateBoardShareRecipeByRecipeId(boardShareRecipe);
		
	}
	
	
	@Override
	public BoardShareRecipe boardRead(int recipeId) {
		
		return dao.boardRead(recipeId);
	}



	@Override
	public Map<String, Object> selectBoardShareRecipeAll(int page) {
		HashMap<String, Object> map = new HashMap<>();
		int totalCount= dao.selectBoardCount();
		PagingBean pageBean = new PagingBean(totalCount, page);
		map.put("pageBean",	pageBean);
		System.out.println("rrrrr");
		List<BoardShareRecipe> list = dao.selectBoardShareRecipeByAll(pageBean.getBeginItemInPage(), pageBean.getEndItemInPage());
		
		System.out.println(list);
		map.put("list", list);
		
		
		
		return map;
	
	}
	@Override
	public void updateBoardRecommand(int recipeId) {
		
		dao.updateBoardRecommand(recipeId);
	}



	@Override
	public void insertRecommandServie(MemberRecipeRecommand memberRecipeRecommand) {
		// TODO Auto-generated method stub
		dao.insertRecommand(memberRecipeRecommand);
	
	}



	@Override
	public MemberRecipeRecommand selectRecommandService(int recipeId, String memberId) {
		
		
		return dao.selectRecommand(recipeId, memberId);
	}



	@Override
	public void deleteRecommandService(int recipeId) {
		// TODO Auto-generated method stub
		dao.deleteRecommand(recipeId);
	}



	@Override
	public Map<String, Object> boardSearchByTitle(int page, String keyword) {
		System.out.println(keyword);//
		HashMap<String, Object> map = new HashMap<>();
		int totalCount = dao.selectBoardCount();
		PagingBean pageBean = new PagingBean(totalCount, page);
		map.put("pageBean",	pageBean);
		List<BoardShareRecipe> list = dao.boardSearchByTitle(pageBean.getBeginItemInPage(), pageBean.getEndItemInPage(), keyword);
		System.out.println("Service log" + list);
		map.put("list", list);
		return map;
	}



	@Override
	public Map<String, Object> boardSearchByTxt(int page, String keyword) {
		HashMap<String, Object> map = new HashMap<>();
		int totalCount = dao.selectBoardCount();
		PagingBean pageBean = new PagingBean(totalCount, page);
		map.put("pageBean",	pageBean);
		
		List<BoardShareRecipe> list = dao.boardSearchByTxt(pageBean.getBeginItemInPage(), pageBean.getEndItemInPage(), keyword);
		map.put("list", list);
		return map;
	}



	@Override
	public Map<String, Object> boardSearchByMemberId(int page, String keyword) {
		HashMap<String, Object> map = new HashMap<>();
		int totalCount = dao.selectBoardCount();
		PagingBean pageBean = new PagingBean(totalCount, page);
		map.put("pageBean",	pageBean);
		
		List<BoardShareRecipe> list = dao.boardSearchByMemberId(pageBean.getBeginItemInPage(), pageBean.getEndItemInPage(), keyword);
		map.put("list", list);
		return map;
	
	}



	@Override
	public List<BoardShareRecipe> selectBoardTop4() {
		List<BoardShareRecipe> boardTop = dao.selectBoardTop4();
		return boardTop;
	}



	@Override
	public List<BoardShareRecipe> selectBoardShareRecipeByRecipeIdToIrdnt(int recipeId) {
		
		return dao.selectBoardShareRecipeByRecipeIdToIrdnt(recipeId);
	}
	@Override
	public List<String> selectBoardShareRecipeByRecipeIdToImg(int recipeId) {
		
		return dao.selectBoardShareRecipeByRecipeIdToImg(recipeId);
	}

	@Override
	public void insertBoardShareRecipeImg(int recipeId, String boardShareRecipeImgUrl) {
		HashMap map = new HashMap();
		map.put("recipeId",recipeId);
		map.put("image", boardShareRecipeImgUrl);
		dao.insertBoardShareRecipeImg(map);
	}
	
	@Override
	public void deleteBoardShareRecipeImgByKey(int boardShareRecipeImgKey) {
	
		dao.deleteBoardShareRecipeImgByKey(boardShareRecipeImgKey);
	}

	@Override
	public void deleteBoardShareRecipeImgAll(int recipeId) {
		
		dao.deleteBoardShareRecipeImgAll(recipeId);
	}
	
	@Override
	public List<String> selectBoardShareRecipeImg(int recipeId) {
	
		return dao.selectBoardShareRecipeImg(recipeId);
	}


	//연수
	@Override
	public Map findUserRecipeByIds(List<Integer> irdntIds, List<Integer> hateIrdntsIds, int page) {
		
		//재료id들을 줘서 recipeid들과 count수의 map을 받은 list.
		List recipeMap = shareDao.getRecipeBoardIdByIrdntIds(irdntIds, hateIrdntsIds);
		List recipeIds = new ArrayList();
		List countList = new ArrayList();
		HashMap userMap = new HashMap();
		
		for(int i =0;i<recipeMap.size();i++){
			HashMap map = (HashMap) recipeMap.get(i);
			//System.out.println("게시판  map"+ map);
			recipeIds.add(map.get("recipeId"));
			countList.add(map);
		}
		
		int totalCount = dao.selectBoardShareRecipeByIdCount(recipeIds);
		PagingBean pageBean = new PagingBean(totalCount,page);
		
		List<BoardShareRecipe> userList = dao.selectBoardShareRecipeById(recipeIds,pageBean.getBeginItemInPage(),pageBean.getEndItemInPage());
		
		userMap.put("userList", userList);
		userMap.put("countList", countList);
		userMap.put("pageBean", pageBean);
		
		return userMap;
	}
	
	//연수
	@Override
	public Map selectBoardShareRecipeByTitle(String title, int page) {
		HashMap map = new HashMap();
		
		int totalCount = dao.selectBoardShareRecipeByTitleCount(title);
		PagingBean pageBean = new PagingBean(totalCount,page);
		
		List<BoardShareRecipe> list = dao.selectBoardShareRecipeByTitle(title, pageBean.getBeginItemInPage(), pageBean.getEndItemInPage());
		map.put("list", list);
		map.put("pageBean", pageBean);
		return map;
	}
	
	
}
