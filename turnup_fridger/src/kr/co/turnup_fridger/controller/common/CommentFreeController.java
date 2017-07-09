package kr.co.turnup_fridger.controller.common;

import java.util.Map;

import javax.servlet.http.HttpServlet;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.validation.Errors;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import kr.co.turnup_fridger.service.BoardFreeService;
import kr.co.turnup_fridger.service.CommentFreeService;
import kr.co.turnup_fridger.validation.CommentFreeValidator;
import kr.co.turnup_fridger.vo.BoardFree;
import kr.co.turnup_fridger.vo.CommentFree;

@Controller
@RequestMapping("/common/commentfree/")
public class CommentFreeController extends HttpServlet {
	
		@Autowired
		private CommentFreeService service;
		
		@Autowired
		private BoardFreeService board;
	
		//등록
		@RequestMapping("commentFreeAdd")
		@ResponseBody
		 public ModelAndView commentFreeAdd(@ModelAttribute CommentFree commentFree, BindingResult errors,@RequestParam int boardFreeId, @RequestParam(defaultValue="1") int page)
		{

			ModelAndView mav = new ModelAndView();
			
			CommentFreeValidator validator = new CommentFreeValidator();
			validator.validate(commentFree, errors);
			if(errors.hasErrors()) 
			{
				//자유게시판 상세 정보
				BoardFree boardFree = board.selectBoardFreeByboardFreeId(boardFreeId);
				mav.addObject("boardFree", boardFree);
				
				//해당 댓글 LIST
				Map<String, Object> map = service.selectCommentFreeListbyId(boardFreeId,page);
				mav.addObject("commentFree", map.get("list"));
				mav.addObject("boardFreeId",  map.get("boardFreeId"));
			    mav.addObject("pageBean", map.get("pageBean"));
				mav.setViewName("common/boardfree/boardfree_view.tiles");
				return mav; 
			}
			
			
			
			service.addCommentFree(commentFree);
			
			BoardFree boardFree = board.selectBoardFreeByboardFreeId(boardFreeId);
			mav.addObject("boardFree", boardFree);//게시물 상세 정보
			
			Map<String, Object> map = service.selectCommentFreeListbyId(commentFree.getBoardFreeId(),page);
			mav.addObject("commentFree",map.get("list"));//해당게시물 댓글 정보
		    mav.addObject("boardFreeId",  map.get("boardFreeId"));
		    mav.addObject("pageBean", map.get("pageBean"));
		    
		    
			mav.setViewName("common/boardfree/boardfree_view.tiles");
			
			return mav;
		}
	

		//삭제
		@RequestMapping("commentFreeRemove")
		@ResponseBody
		public ModelAndView commentQnARemove(@RequestParam int commentFreeId,@RequestParam int boardFreeId,@RequestParam String adminId,@RequestParam String memberId,
				@RequestParam String writer,@RequestParam(defaultValue="1") int page)
		{
			
			ModelAndView mav = new ModelAndView();
			
			if((writer.equals(memberId) && adminId.trim().isEmpty()) || !adminId.trim().isEmpty())
			{
				service.removeCommentFree(commentFreeId);
			}
			//자유게시판 상세 정보
			BoardFree boardFree = board.selectBoardFreeByboardFreeId(boardFreeId);
			mav.addObject("boardFree", boardFree);
			
			//해당 댓글 LIST
			Map<String, Object> map = service.selectCommentFreeListbyId(boardFreeId,page);
			mav.addObject("commentFree", map.get("list"));
			mav.addObject("boardFreeId",  map.get("boardFreeId"));
		    mav.addObject("pageBean", map.get("pageBean"));
			mav.setViewName("common/boardfree/boardfree_view.tiles");
	        return mav;
		}	
		

		//댓글 수정폼 이동
		@RequestMapping("commentFreeUploadView")
		public ModelAndView commentFreeUploadView(@RequestParam int commentFreeId)
		{
			ModelAndView mav = new ModelAndView();
			
			mav.setViewName("common/boardfree/commentfree_upload.tiles");
			
			mav.addObject("commentfree", service.selectCommentFreeById(commentFreeId));
		    
			return mav;
		}	
		
		//수정
		@RequestMapping("commentFreeUploadForm")
		 public ModelAndView commentFreeUploadForm(@ModelAttribute CommentFree commentFree,@RequestParam int commentFreeId,@RequestParam int boardFreeId, BindingResult errors,@RequestParam(defaultValue="1") int page)
		{
				ModelAndView mav = new ModelAndView();
			
				service.updateCommentFree(commentFree);
				
				//자유게시판 상세 정보
				BoardFree boardFree = board.selectBoardFreeByboardFreeId(boardFreeId);
				mav.addObject("boardFree", boardFree);
				
				//해당 댓글 LIST
				Map<String, Object> map = service.selectCommentFreeListbyId(boardFreeId,page);
				mav.addObject("commentFree", map.get("list"));
				mav.addObject("boardFreeId",  map.get("boardFreeId"));
			    mav.addObject("pageBean", map.get("pageBean"));
				mav.setViewName("common/boardfree/boardfree_view.tiles");
		        return mav;

		}
}