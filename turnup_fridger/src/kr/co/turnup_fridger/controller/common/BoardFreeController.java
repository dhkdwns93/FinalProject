package kr.co.turnup_fridger.controller.common;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import kr.co.turnup_fridger.service.BoardFreeService;
import kr.co.turnup_fridger.service.CommentFreeService;
import kr.co.turnup_fridger.validation.BoardFreeValidator;
import kr.co.turnup_fridger.vo.BoardFree;
import kr.co.turnup_fridger.vo.CommentFree;

@Controller
@RequestMapping("/common/boardfree/")
public class BoardFreeController extends HttpServlet {
	
		@Autowired
		private BoardFreeService service;
		
		@Autowired
		private CommentFreeService commentFree;
				
		//전체 리스트
		@RequestMapping("boardFreeList") 
		@ResponseBody
		public ModelAndView boardFreeList(@RequestParam(defaultValue="1") int page)
		{  
			ModelAndView mav = new ModelAndView();
			
			Map<String, Object> map = service.selectBoardFreeList(page);
	 
			mav.addObject("list", map.get("list"));
			mav.addObject("totalCount", map.get("totalCount"));
			mav.addObject("pageBean", map.get("pageBean"));
	        mav.setViewName("common/boardfree/boardfree_list.tiles");
	        return mav; 
		} 
	
		//조회수 조회
		@RequestMapping("boardFreeByBoardFreeHits")
		@ResponseBody
		public ModelAndView boardFreeByBoardFreeHits(@RequestParam(defaultValue="1") int page)
		{
			ModelAndView mav = new ModelAndView();	
			
			Map<String, Object> map = service.selectBoardFreeByBoardFreeHits(page);

			mav.addObject("list", map.get("list"));
			mav.addObject("totalCount", map.get("totalCount"));
			mav.addObject("pageBean", map.get("pageBean"));
	        mav.setViewName("common/boardfree/boardfree_list_hit.tiles");
	        return mav; 
		}	
		
		//아이디 조회
		@RequestMapping("boardFreeByMemberId")
		@ResponseBody
		public ModelAndView boardFreeByMemberId(@RequestParam String memberId,@RequestParam(defaultValue="1") int page)
		{
			ModelAndView mav = new ModelAndView();	
			
			
			
			Map<String, Object> map  = service.selectBoardFreeByMemberId(memberId,page);
			
			mav.addObject("list", map.get("list"));
			mav.addObject("totalCount", map.get("totalCount"));
		    mav.addObject("memberId",  map.get("memberId"));
		    mav.addObject("pageBean", map.get("pageBean"));
	        mav.setViewName("common/boardfree/boardfree_list_memberid.tiles"); 

	        return mav; 
		}
		
		//제목 조회
		@RequestMapping("boardFreeByTitle")
		@ResponseBody
		public ModelAndView boardFreeByTitle(@RequestParam String boardFreeTitle,@RequestParam(defaultValue="1") int page)
		{
			ModelAndView mav = new ModelAndView();	
			
			Map<String, Object> map  = service.selectBoardFreeByTitle(boardFreeTitle,page);
			
			mav.addObject("list", map.get("list"));
			mav.addObject("totalCount", map.get("totalCount"));
		    mav.addObject("boardFreeTitle", map.get("boardFreeTitle"));
		    mav.addObject("pageBean", map.get("pageBean"));
	        mav.setViewName("common/boardfree/boardfree_list_title.tiles"); 

	        return mav; 
		}		
		
		
		//선택 조회
		@RequestMapping("boardFreeBySelect")
		@ResponseBody
		public ModelAndView boardFreeBySelect(@RequestParam String select, @RequestParam String keyword,@RequestParam(defaultValue="1") int page)
		{
			ModelAndView mav = new ModelAndView();	
			Map<String, Object> map = new HashMap<>();
			
			String id = "아이디";
			String title = "제목";
			
			if(select.equals(id))
			{
				map  = service.selectBoardFreeByMemberId(keyword,page);
				mav.addObject("list", map.get("list"));
				mav.addObject("totalCount", map.get("totalCount"));
			    mav.addObject("memberId",  map.get("memberId"));
			    mav.addObject("pageBean", map.get("pageBean"));
		        mav.setViewName("common/boardfree/boardfree_list_memberid.tiles"); 
		        
		        return mav;
			}			
			else if(select.equals(title))
			{
				map = service.selectBoardFreeByTitle(keyword, page);
				System.out.println(map);
				mav.addObject("list", map.get("list"));
				mav.addObject("totalCount", map.get("totalCount"));
				mav.addObject("boardFreeTitle",  map.get("boardFreeTitle.tiles"));
			    mav.addObject("pageBean", map.get("pageBean"));
		        mav.setViewName("common/boardfree/boardfree_list_title.tiles");
		        return mav; 
			}
			map = service.selectBoardFreeList(page);
			mav.addObject("list", map.get("list"));
			mav.addObject("totalCount", map.get("totalCount"));
			mav.addObject("pageBean", map.get("pageBean"));
	        mav.setViewName("common/boardfree/boardfree_list.tiles");
	        return mav; 
		}		
	
		
		
		//상세보기
		@RequestMapping("boardFreeView")
		@ResponseBody
		public ModelAndView boardFreeView(@RequestParam int boardFreeId,HttpSession session,@RequestParam(defaultValue="1") int page) throws Exception
		{
			ModelAndView mav = new ModelAndView();
			
			service.increasHit(boardFreeId, session);//추천
			
			BoardFree boradFree = service.selectBoardFreeByboardFreeId(boardFreeId);
			mav.addObject("boardFree",boradFree);
			
			Map<String, Object> map = commentFree.selectCommentFreeListbyId(boardFreeId,page);
			mav.addObject("commentFree", map.get("list"));
			mav.addObject("boardFreeId",  map.get("boardFreeId"));
		    mav.addObject("pageBean", map.get("pageBean"));
		    
			
			mav.setViewName("common/boardfree/boardfree_view.tiles");
			
			return mav;
		}		
		
		//등록
		@RequestMapping("boardFreeAdd")
		@ResponseBody
		 public ModelAndView boardFreeAdd(@ModelAttribute BoardFree boradFree,BindingResult errors)
		{
			BoardFreeValidator validator = new BoardFreeValidator();
			validator.validate(boradFree, errors);
			if(errors.hasErrors())
			{
				return new ModelAndView("common/boardfree/boardfree_form.tiles"); //errors에 오류가 1개라도 등록되 있으면 true 리턴
			}
			ModelAndView mav = new ModelAndView();
			service.addBoardFree(boradFree);//등록
			mav.addObject("boardFree",service.selectBoardFreeByboardFreeId(boradFree.getBoardFreeId()));//상세페이지 필요 정보
			mav.setViewName("common/boardfree/boardfree_view.tiles");
			return mav;
		}
			
		//삭제
		@RequestMapping("boardFreeRemove")
		@ResponseBody
		public ModelAndView boardFreeRemove(@RequestParam int boardFreeId,@RequestParam(defaultValue="1") int page,
				@RequestParam String writer,@RequestParam String memberId,@RequestParam String adminId)
		{
	        ModelAndView mav = new ModelAndView();
	        if((writer.equals(memberId) && adminId.trim().isEmpty()) || !adminId.trim().isEmpty())
	        {
	        	service.removeBoardFree(boardFreeId);//정보삭제
				Map<String, Object> map = service.selectBoardFreeList(page);//리스트 값 불러오기
			    mav.addObject("list", map.get("list"));//리스트 값 저장
			    mav.addObject("totalCount", map.get("totalCount"));
			    mav.addObject("pageBean", map.get("pageBean"));
		        mav.setViewName("common/boardfree/boardfree_list.tiles"); 
		        return mav; 
	        }
			
			BoardFree boradFree = service.selectBoardFreeByboardFreeId(boardFreeId);
			mav.addObject("boardFree",boradFree);
			
			Map<String, Object> map = commentFree.selectCommentFreeListbyId(boardFreeId,page);
			mav.addObject("commentFree", map.get("list"));
			mav.addObject("boardFreeId",  map.get("boardFreeId"));
		    mav.addObject("pageBean", map.get("pageBean"));
		    
			
			mav.setViewName("common/boardfree/boardfree_view.tiles");
			
			return mav;	        

		}	
		
		//수정 폼 이동
		@RequestMapping("boardFreeUploadView")
		@ResponseBody
		public ModelAndView boardFreeUploadView(@RequestParam int boardFreeId,@RequestParam String writer,@RequestParam String memberId,@RequestParam(defaultValue="1") int page)
		{
			ModelAndView mav = new ModelAndView();
			
			if(writer.equals(memberId))
			{
				mav.addObject("boardFree", service.selectBoardFreeByboardFreeId(boardFreeId));//해당 수정 정보 불러서 저장
				mav.setViewName("common/boardfree/boardfree_upload.tiles");
				return mav;
			}	
			
			BoardFree boradFree = service.selectBoardFreeByboardFreeId(boardFreeId);
			mav.addObject("boardFree",boradFree);
			
			Map<String, Object> map = commentFree.selectCommentFreeListbyId(boardFreeId,page);
			mav.addObject("commentFree", map.get("list"));
			mav.addObject("boardFreeId",  map.get("boardFreeId"));
		    mav.addObject("pageBean", map.get("pageBean"));
		    
			
			mav.setViewName("common/boardfree/boardfree_view.tiles");
			
			return mav;
		}	
	
		//수정
		@RequestMapping("boardFreeUploadForm")
		@ResponseBody
		 public ModelAndView boardFreeUploadForm(@ModelAttribute BoardFree boardFree,@RequestParam int boardFreeId, BindingResult errors,@RequestParam(defaultValue="1") int page)
		{
			BoardFreeValidator validator = new BoardFreeValidator();
			validator.validate(boardFree, errors);
			if(errors.hasErrors()) 
			{
				//errors에 오류가 1개라도 등록되 있으면 true 리턴
				return new ModelAndView("common/boardfree/boardfree_upload.tiles"); 
			}
			ModelAndView mav = new ModelAndView();
			
			service.updateBoardFree(boardFree);//수정
			
			boardFree = service.selectBoardFreeByboardFreeId(boardFreeId);
			mav.addObject("boardFree", boardFree);//게시물 상세 정보
			
			Map<String, Object> map = commentFree.selectCommentFreeListbyId(boardFreeId,page);
			mav.addObject("commentFree",map.get("list"));//해당게시물 댓글 정보
		    mav.addObject("boardFreeId",  map.get("boardFreeId"));
		    mav.addObject("pageBean", map.get("pageBean"));
		    
		    mav.setViewName("common/boardfree/boardfree_view.tiles"); 
		    
			return mav;

		}	
}