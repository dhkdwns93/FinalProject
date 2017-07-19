package kr.co.turnup_fridger.controller.common;

import java.io.IOException;
import java.util.HashMap;
import java.util.List;
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

import kr.co.turnup_fridger.service.BoardQnAService;
import kr.co.turnup_fridger.service.CommentQnAService;
import kr.co.turnup_fridger.validation.BoardQnAValidator;
import kr.co.turnup_fridger.vo.BoardQnA;
import kr.co.turnup_fridger.vo.CommentQnA;

@Controller
@RequestMapping("/common/boardqna/")
public class BoardQnAController extends HttpServlet {
	
		@Autowired
		private BoardQnAService service;
		@Autowired
		private CommentQnAService comment;	
		
		//전체 리스트
		@RequestMapping("boardQnAList")
		@ResponseBody
		public ModelAndView boardNoticeList(@RequestParam(defaultValue="1") int page)
		{  
			Map<String, Object> map = service.findBoardQnAList(page);
		
	        ModelAndView mav = new ModelAndView();
		    mav.addObject("list", map.get("list"));
		    mav.addObject("totalCount", map.get("totalCount"));
		    mav.addObject("pageBean", map.get("pageBean"));
	        mav.setViewName("common/boardqna/boardqna_list.tiles");
	        return mav; 
		} 
	
		
		
		//아이디 조회
		@RequestMapping("boardQnAByMemberId")
		@ResponseBody
		public ModelAndView boardQnAByMemberId(@RequestParam String memberId,@RequestParam(defaultValue="1") int page)
		{
			ModelAndView mav = new ModelAndView();	
			Map<String, Object> map = new HashMap<>();
			if(!memberId.trim().isEmpty())
			{
				map  = service.findBoardQnAByMemberId(memberId,page);
				
			    mav.addObject("list", map.get("list"));
			    mav.addObject("totalCount", map.get("totalCount"));
			    mav.addObject("memberId",  map.get("memberId"));
			    mav.addObject("pageBean", map.get("pageBean"));
		        mav.setViewName("common/boardqna/boardqna_list_memberid.tiles");

		        return mav; 
			}
			
			map = service.findBoardQnAList(page);
		
		    mav.addObject("list", map.get("list"));
		    mav.addObject("totalCount", map.get("totalCount"));
		    mav.addObject("pageBean", map.get("pageBean"));
	        mav.setViewName("common/boardqna/boardqna_list.tiles"); 
	        return mav; 
		}
		
		//상세보기
		@RequestMapping("boardQnAView")
		@ResponseBody
		public ModelAndView boardQnAView(@RequestParam int boardQnAId,
				@RequestParam String member,@RequestParam String admin, 
				@RequestParam String memberId,@RequestParam(defaultValue="1") int page,
				HttpServletRequest request, HttpServletResponse response) throws IOException
		{
			ModelAndView mav = new ModelAndView();
			
			if( (member.equals(memberId) && admin.trim().isEmpty()) || !admin.trim().isEmpty())
			{
				
				List<CommentQnA> list = comment.selectCommentQnAByboardQnAId(boardQnAId);
				mav.addObject("list", list);
				BoardQnA boardQnA = service.findBoardQnAById(boardQnAId);
				mav.addObject("boardQnA", boardQnA);
				mav.setViewName("common/boardqna/boardqna_view.tiles");
				return mav;
			}
			
			Map<String, Object> map = service.findBoardQnAList(page);
			
		    mav.addObject("list", map.get("list"));
		    mav.addObject("pageBean", map.get("pageBean"));
	        mav.addObject("error", "err");
		    mav.setViewName("common/boardqna/boardqna_list.tiles"); 
	        
	        
	        return mav; 
		}		
		
		//등록
		@RequestMapping("boardQnAAdd")
		@ResponseBody
		 public ModelAndView insert(@ModelAttribute BoardQnA boardQnA,BindingResult errors,
				 ModelMap model)
		{
			BoardQnAValidator validator = new BoardQnAValidator();
			
			validator.validate(boardQnA, errors);
			if(errors.hasErrors()) 
			{
				//errors에 오류가 1개라도 등록되 있으면 true 리턴
				return new ModelAndView("common/boardqna/boardqna_form.tiles"); 
			}
			ModelAndView mav = new ModelAndView();
			
			service.addBoardQnA(boardQnA);
			
/*			mav.addObject("boardQnA",boardQnA);
			
			List<CommentQnA> list = comment.selectCommentQnAByboardQnAId(boardQnA.getBoardQnAId());
			mav.addObject("list", list);
			mav.addObject("boardQnA", service.findBoardQnAById(boardQnA.getBoardQnAId()));
			mav.setViewName("common/boardqna/boardqna_view.tiles");	
			return mav;			*/
			boardQnA = service.findBoardQnAById(boardQnA.getBoardQnAId());
			List<CommentQnA> list = comment.selectCommentQnAByboardQnAId(boardQnA.getBoardQnAId());

			model.addAttribute("list",list);
			model.addAttribute("boardQnA",boardQnA);			
			model.addAttribute("boardQnAId", boardQnA.getBoardQnAId());
			
			return new ModelAndView("redirect:/common/boardqna/success.do");
		}
		
		@RequestMapping("success")
		public ModelAndView registerSuccess(@RequestParam int boardQnAId,ModelMap map)
		{
			ModelAndView mav = new ModelAndView();
		
			List<CommentQnA> list = comment.selectCommentQnAByboardQnAId(boardQnAId);
			mav.addObject("list", list);
			mav.addObject("boardQnA", service.findBoardQnAById(boardQnAId));
			mav.setViewName("common/boardqna/boardqna_view.tiles");	
			return mav;
		}
		
		
		//삭제
		@RequestMapping("boardQnARemove")
		@ResponseBody
		public ModelAndView boardQnARemove(@RequestParam int boardQnAId,@RequestParam(defaultValue="1") int page)
		{
			service.removeBoardQnA(boardQnAId);
			
			Map<String, Object> map = service.findBoardQnAList(page);
			
	        ModelAndView mav = new ModelAndView();
		    mav.addObject("list", map.get("list"));
		    mav.addObject("totalCount", map.get("totalCount"));
		    mav.addObject("pageBean", map.get("pageBean"));
	        mav.setViewName("common/boardqna/boardqna_list.tiles");
	        return mav; 

		}	
		
		//수정 폼
		@RequestMapping("boardQnAUploadView")
		@ResponseBody
		public ModelAndView boardQnAUploadView(@RequestParam int boardQnAId)
		{
			ModelAndView mav = new ModelAndView();
			
			mav.setViewName("common/boardqna/boardqna_upload.tiles");
			
			mav.addObject("boardQnA", service.findBoardQnAById(boardQnAId));
		    
			return mav;
		}	
		
		//수정
		@RequestMapping("boardQnAUploadForm")
		@ResponseBody
		 public ModelAndView boardQnAUploadForm(@ModelAttribute BoardQnA boardQnA,@RequestParam int boardQnAId, BindingResult errors)
		{
			BoardQnAValidator validator = new BoardQnAValidator();
			
			validator.validate(boardQnA, errors);
			if(errors.hasErrors()) 
			{
				//errors에 오류가 1개라도 등록되 있으면 true 리턴
				return new ModelAndView("common/boardqna/boardqna_form.tiles"); 
			}
			ModelAndView mav = new ModelAndView();
			
			service.updateBoardQnA(boardQnA);
			mav.addObject("boardQnA",boardQnA);
			List<CommentQnA> list = comment.selectCommentQnAByboardQnAId(boardQnA.getBoardQnAId());
			mav.addObject("list", list);
			mav.setViewName("common/boardqna/boardqna_view.tiles");
			mav.addObject("boardQnA", service.findBoardQnAById(boardQnAId));
		    
			return mav;

		}		
}