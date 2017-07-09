package kr.co.turnup_fridger.controller.common;

import javax.servlet.http.HttpServlet;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
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
		private CommentQnAService service;
		
		@Autowired
		private BoardQnAService service2;
	
		//등록
		@RequestMapping("commentQnAAdd")
		@ResponseBody
		 public ModelAndView commentQnAAdd(@ModelAttribute CommentQnA commentQnA, BindingResult errors,@RequestParam int boardQnAId)
		{

			ModelAndView mav = new ModelAndView();
			
			CommentQnAValidator validator = new CommentQnAValidator();
			validator.validate(commentQnA, errors);
			if(errors.hasErrors()) 
			{
				//errors에 오류가 1개라도 등록되 있으면 true 리턴
				mav.setViewName("common/boardqna/boardqna_view");
				mav.addObject("commentQnA",commentQnA);
				mav.addObject("boardQnA", service2.findBoardQnAById(boardQnAId));
				
				return mav; 
			}
			
			service.addCommentQnA(commentQnA);
			
			mav.addObject("commentQnA",commentQnA);
			mav.addObject("boardQnA", service2.findBoardQnAById(boardQnAId));
			mav.setViewName("common/boardqna/boardqna_view");
			return mav;
		}

		//삭제
		@RequestMapping("commentQnARemove")
		@ResponseBody
		public ModelAndView commentQnARemove(@RequestParam int commentQnAId,@RequestParam int boardQnAId)
		{
			service.removeCommentQnA(commentQnAId);
			
			ModelAndView mav = new ModelAndView();
			
			BoardQnA boardQnA = service2.findBoardQnAById(boardQnAId);
			mav.addObject("boardQnA", boardQnA);
			mav.setViewName("common/boardqna/boardqna_view");
	        return mav; 

		}	

		//댓글 수정폼 이동
		@RequestMapping("commentQnAUploadView")
		@ResponseBody
		public ModelAndView commentQnAUploadView(@RequestParam int commentQnAId)
		{
			ModelAndView mav = new ModelAndView();
			
			mav.setViewName("common/boardqna/commentqna_upload");
			
			mav.addObject("commentQnA", service.selectCommentQnAById(commentQnAId));
		    
			return mav;
		}	
		
		//수정
		@RequestMapping("boardQnAUploadForm")
		@ResponseBody
		 public ModelAndView boardQnAUploadForm(@ModelAttribute CommentQnA commentQnA,@RequestParam int commentQnAId,@RequestParam int boardQnAId, BindingResult errors)
		{
				ModelAndView mav = new ModelAndView();
			
				service.updateCommentQnA(commentQnA);
				
				mav.addObject("commentQnA",commentQnA);
				mav.addObject("boardQnA", service2.findBoardQnAById(boardQnAId));
				mav.setViewName("common/boardqna/boardqna_view");
		    
			return mav;

		}		
}