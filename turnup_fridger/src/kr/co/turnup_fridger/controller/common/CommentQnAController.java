package kr.co.turnup_fridger.controller.common;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServlet;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import kr.co.turnup_fridger.service.BoardQnAService;
import kr.co.turnup_fridger.service.CommentQnAService;
import kr.co.turnup_fridger.validation.CommentQnAValidator;
import kr.co.turnup_fridger.vo.BoardQnA;
import kr.co.turnup_fridger.vo.CommentQnA;

@Controller
@RequestMapping("/common/commentqna/")
public class CommentQnAController extends HttpServlet {
	
		@Autowired
		private CommentQnAService commentQnAService;
		
		@Autowired
		private BoardQnAService boardQnAservice;
	

		
		//댓글 등록
		@RequestMapping("commentQnAAdd")
		@ResponseBody
		 public ModelAndView commentQnAAdd(@ModelAttribute CommentQnA commentQnA, BindingResult errors,
				 @RequestParam int boardQnAId,ModelMap map)
		{

			ModelAndView mav = new ModelAndView();
			
			CommentQnAValidator validator = new CommentQnAValidator();
			validator.validate(commentQnA, errors);
			if(errors.hasErrors()) 
			{
				//errors에 오류가 1개라도 등록되 있으면 true 리턴
				List<CommentQnA> list = commentQnAService.selectCommentQnAByboardQnAId(boardQnAId);
				mav.addObject("list", list);
				BoardQnA boardQnA = boardQnAservice.findBoardQnAById(boardQnAId);
				mav.addObject("boardQnA", boardQnA);
				mav.setViewName("common/boardqna/boardqna_view.tiles");
				return mav; 
			}
				
			commentQnAService.addCommentQnA(commentQnA);
			//댓글 등록 시 댓글수 증가
			commentQnAService.commentCount(boardQnAId);
			
			BoardQnA boardQnA = boardQnAservice.findBoardQnAById(boardQnAId);
			map.addAttribute("commentQnA", commentQnA);
			map.addAttribute("boardQnAId", boardQnA.getBoardQnAId());

			return new ModelAndView("redirect:/common/commentqna/success.do");
		}
		
		@RequestMapping("success")
		public ModelAndView registerSuccess(@RequestParam int boardQnAId,ModelMap map)
		{
			ModelAndView mav = new ModelAndView();
			
			BoardQnA boardQnA = boardQnAservice.findBoardQnAById(boardQnAId);
			List<CommentQnA> list = commentQnAService.selectCommentQnAByboardQnAId(boardQnA.getBoardQnAId());
			mav.addObject("list", list);
			mav.addObject("boardQnA", boardQnA);
			mav.setViewName("common/boardqna/boardqna_view.tiles");
	        return mav; 
		}
		

		//댓글 삭제
		@RequestMapping("commentQnARemove")
		@ResponseBody
		public ModelAndView commentQnARemove(@RequestParam int commentQnAId,@RequestParam int boardQnAId)
		{
			commentQnAService.removeCommentQnA(commentQnAId);
			
			//댓글 삭제 시 댓글수 감소
			commentQnAService.commentDeleteCount(boardQnAId);
			
			ModelAndView mav = new ModelAndView();
			
			BoardQnA boardQnA = boardQnAservice.findBoardQnAById(boardQnAId);
			List<CommentQnA> list = commentQnAService.selectCommentQnAByboardQnAId(boardQnAId);
			mav.addObject("list", list);
			mav.addObject("boardQnA", boardQnA);
			mav.setViewName("common/boardqna/boardqna_view.tiles");
	        return mav; 

		}	

		//댓글 수정폼 이동
		@RequestMapping("commentQnAUploadView")
		@ResponseBody
		public ModelAndView commentQnAUploadView(@RequestParam int commentQnAId)
		{
			ModelAndView mav = new ModelAndView();
			
			mav.setViewName("common/boardqna/commentqna_upload.tiles");
			
			mav.addObject("commentQnA", commentQnAService.selectCommentQnAById(commentQnAId));
		    
			return mav;
		}	
		
		//수정
		@RequestMapping("commentQnAUploadForm")
		@ResponseBody
		 public ModelAndView commentQnAUploadForm(@ModelAttribute CommentQnA commentQnA,@RequestParam int commentQnAId,@RequestParam int boardQnAId, BindingResult errors)
		{
				ModelAndView mav = new ModelAndView();
			
				CommentQnAValidator validator = new CommentQnAValidator();
				validator.validate(commentQnA, errors);
				if(errors.hasErrors()) 
				{
					mav.setViewName("common/boardqna/commentqna_upload.tiles");
					
					mav.addObject("commentQnA", commentQnAService.selectCommentQnAById(commentQnAId));
				    
					return mav;
				}
				
				commentQnAService.updateCommentQnA(commentQnA);
				mav.addObject("commentQnA",commentQnA);
				
				List<CommentQnA> list = commentQnAService.selectCommentQnAByboardQnAId(boardQnAId);
				mav.addObject("list", list);
				mav.addObject("boardQnA", boardQnAservice.findBoardQnAById(boardQnAId));
				mav.setViewName("common/boardqna/boardqna_view.tiles");
		    
			return mav;

		}		
}