package kr.co.turnup_fridger.controller.common;

import java.io.File;
import java.util.List;

import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;

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

import kr.co.turnup_fridger.service.BoardNoticeService;
import kr.co.turnup_fridger.validation.BoardNoticeValidator;
import kr.co.turnup_fridger.vo.BoardNotice;

@Controller
@RequestMapping("/boardnotice/")
public class BoardNoticeController extends HttpServlet {
	
	@Autowired
	private BoardNoticeService service;
	
	
	//전체 리스트
	@RequestMapping("boardNoticeList")
	public ModelAndView boardNoticeList() throws Exception
	{
		 List<BoardNotice> list = service.findBoardNoticeList();
		 
		 ModelAndView mav = new ModelAndView();
		
		 mav.setViewName("/boardnotice/boardnotice_list");
	     mav.addObject("list", list); 
	     return mav;
	} 
	
	//말머리 조회
	@RequestMapping("boardNoticeByItems")
	@ResponseBody
	public List boardNoticeById(@RequestParam String items)
	{
		 List<BoardNotice> list = service.findBoardNoticeByItmes(items);
		 String s = "전체보기";
		 if(items.equals(s))
		 {
			 list=service.findBoardNoticeList();
			 return list;
		 }
		 System.out.println(list);
	     return list;
	} 
	
	
	//상세보기
	@RequestMapping("boardNoticeView")
	@ResponseBody
	public ModelAndView boardNoticeView(@RequestParam int id)
	{
		ModelAndView mav = new ModelAndView();
		
		mav.setViewName("boardnotice/boardnotice_view");
		
		mav.addObject("boardNotice", service.findBoardNoticeById(id));
	    
		return mav;
	}	
	 
	
	//등록
	//@RequestMapping("boardNoticeAdd")
	 public ModelAndView insert(@ModelAttribute BoardNotice boardNotice, BindingResult errors, @RequestParam MultipartFile img, HttpServletRequest request, ModelMap map) throws Exception
	{
/*		BoardNoticeValidator validator = new BoardNoticeValidator();
		validator.validate(boardNotice, errors);
	
		if(errors.hasErrors())
		{
			return new ModelAndView("boardnotice/boardnotice_form");
		}*/

		String fileName = img.getOriginalFilename();//업로드된 파일명
		
		if(img !=null && !img.isEmpty()) //이미지 이름이 없거나 넘어올때 파일이없을때 체크
		{
			
			long size = img.getSize();//업로드 파일 크기
			
			File dest = new File(request.getServletContext().getRealPath("/up_image"),fileName); //톰켓 경로
			img.transferTo(dest);

			map.addAttribute("fileName",fileName);
		}
		
		BoardNotice bn = new BoardNotice(0,boardNotice.getItems(), boardNotice.getTitle(),boardNotice.getTxt(),fileName,boardNotice.getDate() );
		
		service.addBoardNotice(bn);
		map.addAttribute("boardNotice", bn);
		return new ModelAndView("boardnotice/boardnotice_success");
	}
	
	
	
		//등록
		@RequestMapping("boardNoticeAdd")
		 public ModelAndView insert2(@ModelAttribute BoardNotice boardNotice, BindingResult errors, @RequestParam MultipartFile img, HttpServletRequest request, ModelMap map) throws Exception
		{
	/*		BoardNoticeValidator validator = new BoardNoticeValidator();
			validator.validate(boardNotice, errors);
		
			if(errors.hasErrors())
			{
				return new ModelAndView("boardnotice/boardnotice_form");
			}*/

			String fileName = img.getOriginalFilename();//업로드된 파일명
			
			if(img !=null && !img.isEmpty()) //이미지 이름이 없거나 넘어올때 파일이없을때 체크
			{
				
				long size = img.getSize();//업로드 파일 크기
				
				File dest = new File(request.getServletContext().getRealPath("/up_image"),fileName); //톰켓 경로
				img.transferTo(dest);

				map.addAttribute("fileName",fileName);
			}
			
			BoardNotice bn = new BoardNotice(0,boardNotice.getItems(), boardNotice.getTitle(),boardNotice.getTxt(),fileName,boardNotice.getDate() );
			
			service.addBoardNotice(bn);
			map.addAttribute("boardNotice", bn);
			return new ModelAndView("boardnotice/boardnotice_success");
		}
	
	
	
	//수정 폼
	@RequestMapping("boardNoticeUploadView")
	@ResponseBody
	public ModelAndView boardNoticeUploadView(@RequestParam int id)
	{
		ModelAndView mav = new ModelAndView();
		
		mav.setViewName("boardnotice/boardnotice_upload");
		
		mav.addObject("boardNotice", service.findBoardNoticeById(id));
	    
		return mav;
	}	
	
	//수정
	@RequestMapping("boardNoticeUploadForm")
	 public ModelAndView boardNoticeUploadForm(@ModelAttribute BoardNotice boardNotice, BindingResult errors, @RequestParam MultipartFile img, HttpServletRequest request, ModelMap map) throws Exception
	{
/*		BoardNoticeValidator validator = new BoardNoticeValidator();
		validator.validate(boardNotice, errors);
	
		if(errors.hasErrors())
		{
			return new ModelAndView("boardnotice/boardnotice_form");
		}*/

		String fileName = img.getOriginalFilename();//업로드된 파일명
		
		if(img !=null && !img.isEmpty()) //이미지 이름이 없거나 넘어올때 파일이없을때 체크
		{
			long size = img.getSize();//업로드 파일 크기
			
			File dest = new File(request.getServletContext().getRealPath("/up_image"),fileName); //톰켓 경로
			img.transferTo(dest);

			map.addAttribute("fileName",fileName);
		}
		
		BoardNotice bn = new BoardNotice(boardNotice.getId(),boardNotice.getItems(), boardNotice.getTitle(),boardNotice.getTxt(),fileName,boardNotice.getDate());
		
		service.updateBoardNotice(bn);
		map.addAttribute("boardNotice", bn);
		return new ModelAndView("boardnotice/boardnotice_success");
	}
	
	
	
	
	//삭제
	@RequestMapping("boardNoticRemove")
	public ModelAndView boardNoticRemove(@RequestParam int id)
	{
		service.removeBoardNoticeById(id);
		
		List<BoardNotice> list = service.findBoardNoticeList();
		 
		ModelAndView mav = new ModelAndView();
		
		mav.setViewName("/boardnotice/boardnotice_list");
	    mav.addObject("list", list); 
	    
		return mav;
	}	
	
	
}
