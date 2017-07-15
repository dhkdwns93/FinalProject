package kr.co.turnup_fridger.controller.common;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.Map;

import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.validation.BindingResult;
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
		 public ModelAndView commentFreeAdd(@ModelAttribute CommentFree commentFree, BindingResult errors,@RequestParam int boardFreeId, @RequestParam(defaultValue="1") int page,ModelMap map)
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
				Map<String, Object> list = service.selectCommentFreeListbyId(boardFreeId,page);
				mav.addObject("commentFree", list.get("list"));
				mav.addObject("boardFreeId",  list.get("boardFreeId"));
			    mav.addObject("pageBean", list.get("pageBean"));
				mav.setViewName("common/boardfree/boardfree_view.tiles");
				return mav; 
			}
			
			service.addCommentFree(commentFree);
			service.commentCount(boardFreeId);
			BoardFree boardFree = board.selectBoardFreeByboardFreeId(boardFreeId);
			Map<String, Object> list = service.selectCommentFreeListbyId(commentFree.getBoardFreeId(),page);
			/*mav.addObject("boardFree", boardFree);//게시물 상세 정보*/			
			/*mav.addObject("commentFree",map.get("list"));//해당게시물 댓글 정보
		    mav.addObject("boardFreeId",  map.get("boardFreeId"));
		    mav.addObject("pageBean", map.get("pageBean"));*/
			
			map.addAttribute("commentFreeId",commentFree.getBoardFreeId());//댓글 아이디
		    map.addAttribute("commentFree",list.get("list"));//댓글 리스트
		    map.addAttribute("boardFree",boardFree);//댓글 리스트
		    map.addAttribute("boardFreeId",boardFree.getBoardFreeId());//게시판 아이디
		    map.addAttribute("pageBean", list.get("pageBean"));//페이징
		    
			return new ModelAndView("redirect:/common/commentfree/success.do");
		}
		
		@RequestMapping("success")
		@ResponseBody
		public ModelAndView registerSuccess(@RequestParam int boardFreeId, @RequestParam int commentFreeId,@RequestParam(defaultValue="1") int page)
		{
			ModelAndView mav = new ModelAndView();
			
			BoardFree boardFree = board.selectBoardFreeByboardFreeId(boardFreeId);
			Map<String, Object> map = service.selectCommentFreeListbyId(boardFreeId,page);
			
			mav.addObject("boardFree", boardFree);//게시판 정보
			mav.addObject("commentFree",map.get("list"));//댓글 정보
		    mav.addObject("boardFreeId", boardFree.getBoardFreeId());//게시판 아이디
		    mav.addObject("pageBean", map.get("pageBean"));//페이징
			
			mav.setViewName("common/boardfree/boardfree_view.tiles");
	        return mav; 
		}
		
		

		//삭제
		@RequestMapping("commentFreeRemove")
		@ResponseBody
		public ModelAndView commentQnARemove(@RequestParam int commentFreeId,@RequestParam int boardFreeId,@RequestParam String adminId,@RequestParam String memberId,
				@RequestParam String writer,@RequestParam(defaultValue="1") int page,HttpServletRequest request, HttpServletResponse response) throws IOException
		{
			
			ModelAndView mav = new ModelAndView();
			
			if((writer.equals(memberId) && adminId.trim().isEmpty()) || !adminId.trim().isEmpty())
			{
				service.removeCommentFree(commentFreeId);
				service.commentDeleteCount(boardFreeId);
				BoardFree boradFree = board.selectBoardFreeByboardFreeId(boardFreeId);
				mav.addObject("boardFree",boradFree);
				Map<String, Object> map = service.selectCommentFreeListbyId(boardFreeId,page);
				mav.addObject("commentFree", map.get("list"));
				mav.addObject("boardFreeId",  map.get("boardFreeId"));
			    mav.addObject("pageBean", map.get("pageBean"));
			    mav.setViewName("common/boardfree/boardfree_view.tiles");
			    return mav;
				
			}
			
			BoardFree boradFree = board.selectBoardFreeByboardFreeId(boardFreeId);
			mav.addObject("boardFree",boradFree);
			Map<String, Object> map = service.selectCommentFreeListbyId(boardFreeId,page);
			mav.addObject("commentFree", map.get("list"));
			mav.addObject("boardFreeId",  map.get("boardFreeId"));
		    mav.addObject("pageBean", map.get("pageBean"));
		    mav.addObject("error", "err");
		    mav.setViewName("common/boardfree/boardfree_view.tiles");

			return mav;
		}	
		

		//댓글 수정폼 이동
		@RequestMapping("commentFreeUploadView")
		@ResponseBody
		public ModelAndView commentFreeUploadView(@RequestParam int commentFreeId,@RequestParam String writer,
				@RequestParam String memberId,@RequestParam int boardFreeId,@RequestParam(defaultValue="1") int page,
				HttpServletRequest request, HttpServletResponse response) throws Exception
		{
			ModelAndView mav = new ModelAndView();
			
			if(writer.equals(memberId))
			{
				mav.setViewName("common/boardfree/commentfree_upload.tiles");
				
				mav.addObject("commentFree", service.selectCommentFreeById(commentFreeId));
			    
				return mav;
			}

			BoardFree boradFree = board.selectBoardFreeByboardFreeId(boardFreeId);
            mav.addObject("boardFree",boradFree);
			Map<String, Object> map = service.selectCommentFreeListbyId(boardFreeId,page);
			mav.addObject("commentFree", map.get("list"));
			mav.addObject("boardFreeId",  map.get("boardFreeId"));
		    mav.addObject("pageBean", map.get("pageBean"));
		    mav.addObject("error", "err");
			mav.setViewName("common/boardfree/boardfree_view.tiles");

            return mav;
		}	
			
		//수정
		@RequestMapping("commentFreeUploadForm")
		@ResponseBody
		 public ModelAndView commentFreeUploadForm(@ModelAttribute CommentFree commentFree,@RequestParam int commentFreeId,@RequestParam int boardFreeId, BindingResult errors,@RequestParam(defaultValue="1") int page)
		{
				ModelAndView mav = new ModelAndView();
			
				CommentFreeValidator validator = new CommentFreeValidator();
				validator.validate(commentFree, errors);
				if(errors.hasErrors()) 
				{
					mav.setViewName("common/boardfree/commentfree_upload.tiles");
					
					mav.addObject("commentFree", service.selectCommentFreeById(commentFreeId));
				    
					return mav;
				}

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