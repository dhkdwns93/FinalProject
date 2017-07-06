package kr.co.turnup_fridger.controller.common;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import kr.co.turnup_fridger.service.BoardShareRecipeService;
import kr.co.turnup_fridger.validation.BoardShareRecipeValidator;
import kr.co.turnup_fridger.vo.BoardShareRecipe;
import kr.co.turnup_fridger.vo.Member;
import kr.co.turnup_fridger.vo.MemberRecipeRecommand;

@Controller
@RequestMapping("/boardRecipe/")
public class BoardShareRecipeListController{
	@Autowired
	BoardShareRecipeService boardShareRecipeService;
	
	//게시물 전체 목록
	@RequestMapping("boardRecipeList")
	public ModelAndView BoardShareRecipeList(@RequestParam(defaultValue="1") int page, @ModelAttribute BoardShareRecipe boardShareRecipe){
		ModelAndView mav = new ModelAndView();
		Map<String, Object> Map = boardShareRecipeService.selectBoardShareRecipeAll(page);
		
		mav.addObject("list", Map.get("list"));
		mav.addObject("pageBean", Map.get("pageBean"));
		mav.setViewName("boardRecipe/boardRecipe_list");
		
		
		Map<String, Object> map = boardShareRecipeService.selectBoardShareRecipeAll(page);
		
		List<BoardShareRecipe> boardTop = boardShareRecipeService.selectBoardTop4();
		
		mav.addObject("top", boardTop);
		mav.addObject("list", map.get("list"));
		mav.addObject("pageBean", map.get("pageBean"));
		
		mav.setViewName("boardRecipe/boardRecipe_list");
		return mav;
		
	}
	
	//게시글 작성처리(등록)
	@RequestMapping("boardRecipeInsert")
	public ModelAndView  insert(@ModelAttribute("boardShareRecipe")BoardShareRecipe boardShareRecipe , BindingResult  errors){
		
		new BoardShareRecipeValidator().validate(boardShareRecipe, errors);
	
		if(errors.hasErrors()){
			
			return new ModelAndView("boardRecipe/boardRecipe_write");
		}
		ModelAndView mav = new ModelAndView();
	
		boardShareRecipeService.insertBoardShareRecipe(boardShareRecipe);
		mav.addObject("boardView",boardShareRecipe);
		mav.addObject("boardView", boardShareRecipeService.boardRead(boardShareRecipe.getRecipeId()));
//        mav.setViewName("boardRecipe/boardRecipe_view");
		mav.setViewName("boardRecipe/boardRecipe_view");
       return mav;
	
     }
	
	//게시글 상세내용 조회, 게시글 조회수 증가처리
	@RequestMapping("boardRecipeView")
	public ModelAndView view(@RequestParam int recipeId, HttpSession session) throws Exception{
		//조회수 증가처리
		boardShareRecipeService.increaseHit(recipeId, session);
		
		ModelAndView mav = new ModelAndView();
		
		mav.addObject("boardView", boardShareRecipeService.boardRead(recipeId));
		mav.setViewName("boardRecipe/boardRecipe_view");
		
		return mav;
	}
	//게시글 수정 성공페이지
	@RequestMapping("boardRecipeUpdateOk")
	public ModelAndView updateSuccess(@ModelAttribute BoardShareRecipe boardShareRecipe ,@RequestParam int recipeId, BindingResult  errors){
		BoardShareRecipeValidator validator = new BoardShareRecipeValidator();
		
		validator.validate(boardShareRecipe, errors);
		
		if(errors.hasErrors()){
			return new ModelAndView("boardRecipe/boardRecipe_update");
		}
		ModelAndView mvc = new ModelAndView();
		boardShareRecipeService.updateBoardShareRecipe(boardShareRecipe);

		mvc.addObject("boardView", boardShareRecipeService.boardRead(recipeId));
		mvc.setViewName("boardRecipe/boardRecipe_view");
				
		return mvc;
	}
	
	//게시글 수정 폼 페이지
	@RequestMapping("boardRecipeUpdate")
	public ModelAndView update(@ModelAttribute("boardShareRecipe") BoardShareRecipe boardShareRecipe, @RequestParam int recipeId){
		
		ModelAndView mav = new ModelAndView();
		boardShareRecipe = boardShareRecipeService.boardRead(recipeId);
		mav.addObject("boardUpdate",  boardShareRecipe);
		mav.setViewName("boardRecipe/boardRecipe_update");
		
		return mav;
	}
	
	
	
	
	//게시글 삭제
	@RequestMapping("boardRecipeDelete")
	public ModelAndView delete(@RequestParam int recipeId, @RequestParam(defaultValue="1") int page){
		ModelAndView mav = new ModelAndView();
		boardShareRecipeService.deleteBoardShareRecipe(recipeId);
		Map<String, Object> map = boardShareRecipeService.selectBoardShareRecipeAll(page);
		
		mav.addObject("list", map.get("list"));
		mav.addObject("pageBean", map.get("pageBean"));
		mav.setViewName("boardRecipe/boardRecipe_list");
		
		return mav;
	}
	//TOP4
	@RequestMapping("boardRecipeTop4")
	public ModelAndView selectBoardTop4(@RequestParam(defaultValue="1") int page){
		ModelAndView mav = new ModelAndView();
		
		Map<String, Object> map = boardShareRecipeService.selectBoardShareRecipeAll(page);
		
		List<BoardShareRecipe> boardTop = boardShareRecipeService.selectBoardTop4();
		
		mav.addObject("top", boardTop);
		mav.addObject("list", map.get("list"));
		mav.addObject("pageBean", map.get("pageBean"));
		
		mav.setViewName("boardRecipe/boardRecipe_list");
		return mav;
	}
	//추천수 +1 추가
	@RequestMapping("increaseRecommand")
	public ModelAndView recommandByTwoId(@RequestParam int recipeId, @RequestParam String memberId){
		ModelAndView mav = new ModelAndView();
		
		boardShareRecipeService.updateBoardRecommand(recipeId);
		boardShareRecipeService.insertRecommandServie(new MemberRecipeRecommand(recipeId, memberId));
		
		
		
		mav.addObject("recipeId", recipeId);
		mav.addObject("memberId", memberId);
		mav.setViewName("redirect:/boardRecipe/recommand.do");
		return mav;
	}
	
	@RequestMapping("recommand")
	public ModelAndView recommand(@RequestParam int recipeId, @RequestParam String memberId){
		ModelAndView mav = new ModelAndView();
		/*BoardShareRecipe overLap = new BoardShareRecipe();
		Member member = new Member();*/
		BoardShareRecipe boardShareRecipe = boardShareRecipeService.boardRead(recipeId);
		/*//중복 추천 했을 경우 
		if(overLap.getMemberId().equals(member.getMemberId())){
			String message = "이미 추천하신 게시물입니다.";
			mav.addObject("message", message);
			mav.setViewName("redirect:/board/list.do");
		//비회원이 추천버튼을 눌렀을 경우
		}else if(overLap.getMemberId()==null||overLap.getMemberId().trim().isEmpty()){
			String errorMassage = "회원에게만 추천 기능이 부여됩니다.";
			mav.addObject("errorMassage", errorMassage);
			mav.setViewName("redirect:/board/list.do");
		}*/
		MemberRecipeRecommand recommand = boardShareRecipeService.selectRecommandService(recipeId, memberId);
		mav.addObject("recommand", recommand);//sessionScope.recommand
		mav.addObject("recommandBoard", boardShareRecipe);//중복검사?
		mav.setViewName("redirect:/boardRecipe/boardRecipeList.do");
		return mav;
	}
	
	
	//선택 검색 
	@RequestMapping("selectSearch")
	public ModelAndView selectSearch(@RequestParam(defaultValue="1") int page, @RequestParam String keyword, @RequestParam String searchOption){
		ModelAndView mav = new ModelAndView();
		
		//제목 검색
		if(searchOption.equals("title")){

			Map<String, Object> map = boardShareRecipeService.boardSearchByTitle(page, keyword);
			
			mav.addObject("list", map.get("list"));
			mav.addObject("pageBean", map.get("pageBean"));
			
			mav.setViewName("boardRecipe/boardRecipe_list");
			return mav;
			
			//내용 검색
			}else if(searchOption.equals("txt")){
			
			Map<String, Object> map = boardShareRecipeService.boardSearchByTxt(page, keyword);
			
			mav.addObject("list", map.get("list"));
			mav.addObject("pageBean", map.get("pageBean"));
			mav.setViewName("boardRecipe/boardRecipe_list");
			return mav;
			
			//memberId로 검색
			}else {
				
				Map<String, Object> map = boardShareRecipeService.boardSearchByMemberId(page, keyword);
				mav.addObject("list", map.get("list"));
				mav.addObject("pageBean", map.get("pageBean"));
				mav.setViewName("boardRecipe/boardRecipe_list");
				return mav;
			}
	}
	
	
}
	
	
	
	
	
	

