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
		private CommentFreeService commentFreeService;
		
		@Autowired
		private BoardFreeService boardFreeService;
	
		//등록
		@RequestMapping("commentFreeAdd")
		@ResponseBody
		 public ModelAndView commentFreeAdd(@ModelAttribute CommentFree commentFree, BindingResult errors,@RequestParam int boardFreeId, @RequestParam(defaultValue="1") int page,ModelMap map)
		{

			ModelAndView mav = new ModelAndView();
			
			CommentFreeValidator validator = new CommentFreeValidator();
			validator.validate(commentFree, errors);
			
			//에러가 있을 경우
			if(errors.hasErrors()) 
			{
				//자유게시판 상세 정보
				BoardFree boardFree = boardFreeService.selectBoardFreeByboardFreeId(boardFreeId);
				mav.addObject("boardFree", boardFree);
				
				//해당 게시물 정보 
				Map<String, Object> list = commentFreeService.selectCommentFreeListbyId(boardFreeId,page);
				mav.addObject("commentFree", list.get("list"));
				mav.addObject("boardFreeId",  list.get("boardFreeId"));
			    mav.addObject("pageBean", list.get("pageBean"));
				mav.setViewName("common/boardfree/boardfree_view.tiles");
				return mav; 
			}
			
			//에러가 없을 경우
			commentFreeService.addCommentFree(commentFree);
			//댓글 수 증가
			commentFreeService.commentCount(boardFreeId);
			//해당 글 정보
			BoardFree boardFree = boardFreeService.selectBoardFreeByboardFreeId(boardFreeId);
			
			//해당 댓글 목록
			Map<String, Object> list = commentFreeService.selectCommentFreeListbyId(commentFree.getBoardFreeId(),page);
			map.addAttribute("commentFreeId",commentFree.getBoardFreeId());
		    map.addAttribute("commentFree",list.get("list"));
		    map.addAttribute("boardFree",boardFree);
		    map.addAttribute("boardFreeId",boardFree.getBoardFreeId());
		    map.addAttribute("pageBean", list.get("pageBean"));
		    
			return new ModelAndView("redirect:/common/commentfree/success.do");
		}
		
		@RequestMapping("success")
		@ResponseBody
		public ModelAndView registerSuccess(@RequestParam int boardFreeId, @RequestParam int commentFreeId,@RequestParam(defaultValue="1") int page)
		{
			ModelAndView mav = new ModelAndView();
			
			BoardFree boardFree = boardFreeService.selectBoardFreeByboardFreeId(boardFreeId);
			Map<String, Object> map = commentFreeService.selectCommentFreeListbyId(boardFreeId,page);
			
			mav.addObject("boardFree", boardFree);
			mav.addObject("commentFree",map.get("list"));
		    mav.addObject("boardFreeId", boardFree.getBoardFreeId());
		    mav.addObject("pageBean", map.get("pageBean"));
			
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
			
			//로그인 아이디와 작성자가 일치 할 경우 또는 관리자일 경우
			if((writer.equals(memberId) && adminId.trim().isEmpty()) || !adminId.trim().isEmpty())
			{
				commentFreeService.removeCommentFree(commentFreeId);
				//댓글 수 감소
				commentFreeService.commentDeleteCount(boardFreeId);
				//해당 글 정보
				BoardFree boradFree = boardFreeService.selectBoardFreeByboardFreeId(boardFreeId);
				mav.addObject("boardFree",boradFree);
				//해당 글 댓글 목록 
				Map<String, Object> map = commentFreeService.selectCommentFreeListbyId(boardFreeId,page);
				mav.addObject("commentFree", map.get("list"));
				mav.addObject("boardFreeId",  map.get("boardFreeId"));
			    mav.addObject("pageBean", map.get("pageBean"));
			    mav.setViewName("common/boardfree/boardfree_view.tiles");
			    
			    return mav;
				
			}
			//일치하지 않을 경우
			
			//해당 게시물로 이동
			BoardFree boradFree = boardFreeService.selectBoardFreeByboardFreeId(boardFreeId);
			mav.addObject("boardFree",boradFree);
			Map<String, Object> map = commentFreeService.selectCommentFreeListbyId(boardFreeId,page);
			mav.addObject("commentFree", map.get("list"));
			mav.addObject("boardFreeId",  map.get("boardFreeId"));
		    mav.addObject("pageBean", map.get("pageBean"));
		    //alert창 
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
			
			//로그인 한 아이디와 작성자가 일치 할 경우 수정폼으로 이동
			if(writer.equals(memberId))
			{
				mav.setViewName("common/boardfree/commentfree_upload.tiles");
				
				mav.addObject("commentFree", commentFreeService.selectCommentFreeById(commentFreeId));
			    
				return mav;
			}
			
			//일치하지 않을 경우
			BoardFree boradFree = boardFreeService.selectBoardFreeByboardFreeId(boardFreeId);
            mav.addObject("boardFree",boradFree);
			Map<String, Object> map = commentFreeService.selectCommentFreeListbyId(boardFreeId,page);
			mav.addObject("commentFree", map.get("list"));
			mav.addObject("boardFreeId",  map.get("boardFreeId"));
		    mav.addObject("pageBean", map.get("pageBean"));
		    //alert창 
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
				//에러가 있을 경우
				if(errors.hasErrors()) 
				{
					mav.setViewName("common/boardfree/commentfree_upload.tiles");
					
					mav.addObject("commentFree", commentFreeService.selectCommentFreeById(commentFreeId));
				    
					return mav;
				}

				commentFreeService.updateCommentFree(commentFree);
				
				//자유게시판 상세 정보
				BoardFree boardFree = boardFreeService.selectBoardFreeByboardFreeId(boardFreeId);
				mav.addObject("boardFree", boardFree);
				
				//해당 댓글 LIST
				Map<String, Object> map = commentFreeService.selectCommentFreeListbyId(boardFreeId,page);
				mav.addObject("commentFree", map.get("list"));
				mav.addObject("boardFreeId",  map.get("boardFreeId"));
			    mav.addObject("pageBean", map.get("pageBean"));
				mav.setViewName("common/boardfree/boardfree_view.tiles");
		        return mav;

		}
}