package kr.co.turnup_fridger.controller.common;

import java.io.File;
import java.io.FileOutputStream;
import java.io.InputStream;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.validation.Valid;

import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import kr.co.turnup_fridger.dao.BoardNoticeDao;
import kr.co.turnup_fridger.service.BoardNoticeService;
import kr.co.turnup_fridger.service.BoardQnAService;
import kr.co.turnup_fridger.validation.BoardNoticeValidator;
import kr.co.turnup_fridger.validation.BoardQnAValidator;
import kr.co.turnup_fridger.vo.BoardNotice;
import kr.co.turnup_fridger.vo.BoardQnA;

@Controller
@RequestMapping("/common/boardqna/")
public class BoardQnAController extends HttpServlet {
	
		@Autowired
		private BoardQnAService service;
			
		//전체 리스트
		@RequestMapping("boardQnAList")
		@ResponseBody
		public ModelAndView boardNoticeList(@RequestParam(defaultValue="1") int page)
		{  
			Map<String, Object> map = service.findBoardQnAList(page);
		
	        ModelAndView mav = new ModelAndView();
		    mav.addObject("list", map.get("list"));
		    mav.addObject("pageBean", map.get("pageBean"));
	        mav.setViewName("common/boardqna/boardqna_list"); // 뷰를 list.jsp로 설정
	        return mav; 
		} 
	
		
		
		//아이디 조회
		@RequestMapping("boardQnAByMemberId")
		@ResponseBody
		public ModelAndView boardQnAByMemberId(@RequestParam String memberId,@RequestParam(defaultValue="1") int page)
		{
			ModelAndView mav = new ModelAndView();	
			
			Map<String, Object> map  = service.findBoardQnAByMemberId(memberId,page);
			
		    mav.addObject("list", map.get("list"));
		    mav.addObject("memberId",  map.get("memberId"));
		    mav.addObject("pageBean", map.get("pageBean"));
	        mav.setViewName("common/boardqna/boardqna_list_memberid"); // 뷰를 list.jsp로 설정

	        return mav; 
		}
		
		//상세보기
		@RequestMapping("boardQnAView")
		@ResponseBody
		public ModelAndView boardQnAView(@RequestParam int boardQnAId,
				@RequestParam String member,@RequestParam String admin, 
				@RequestParam String memberId,@RequestParam(defaultValue="1") int page)
		{
			ModelAndView mav = new ModelAndView();
			
			System.out.println(boardQnAId);
			System.out.println(member);
			System.out.println(admin);
			System.out.println(memberId);
			
			
			if( (member.equals(memberId) && admin.trim().isEmpty()) || !admin.trim().isEmpty())
			{
				mav.setViewName("common/boardqna/boardqna_view");
				
				mav.addObject("boardQnA", service.findBoardQnAById(boardQnAId));
				return mav;
			}
			
			Map<String, Object> map = service.findBoardQnAList(page);
			
		    mav.addObject("list", map.get("list"));
		    mav.addObject("pageBean", map.get("pageBean"));
	        mav.setViewName("common/boardqna/boardqna_list"); 
	        return mav; 
		}		
		
		//등록
		@RequestMapping("boardQnAAdd")
		@ResponseBody
		 public ModelAndView insert(@ModelAttribute BoardQnA boardQnA,BindingResult errors)
		{
			BoardQnAValidator validator = new BoardQnAValidator();
			
			validator.validate(boardQnA, errors);
			if(errors.hasErrors()) 
			{
				//errors에 오류가 1개라도 등록되 있으면 true 리턴
				return new ModelAndView("common/boardqna/boardqna_form"); 
			}
			ModelAndView mav = new ModelAndView();
			
			service.addBoardQnA(boardQnA);
			
			mav.addObject("boardQnA",boardQnA);
			
			mav.setViewName("common/boardqna/boardqna_view");
			
			mav.addObject("boardQnA", service.findBoardQnAById(boardQnA.getBoardQnAId()));
	        
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
		    mav.addObject("pageBean", map.get("pageBean"));
	        mav.setViewName("common/boardqna/boardqna_list"); // 뷰를 list.jsp로 설정
	        return mav; 

		}	
		
		//수정 폼
		@RequestMapping("boardQnAUploadView")
		@ResponseBody
		public ModelAndView boardQnAUploadView(@RequestParam int boardQnAId)
		{
			ModelAndView mav = new ModelAndView();
			
			mav.setViewName("common/boardqna/boardqna_upload");
			
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
				return new ModelAndView("common/boardqna/boardqna_form"); 
			}
			ModelAndView mav = new ModelAndView();
			
			service.updateBoardQnA(boardQnA);
			BoardQnA bq = new BoardQnA(0,boardQnA.getBoardQnATitle(),boardQnA.getBoardQnATxt(),boardQnA.getBoardQnAdate(),boardQnA.getMemberId());
			mav.addObject("boardQnA",bq);
		    
			mav.setViewName("common/boardqna/boardqna_view");
			
			mav.addObject("boardQnA", service.findBoardQnAById(boardQnAId));
		    
			return mav;

		}		
}