package kr.co.turnup_fridger.controller.common;

import java.io.File;
import java.io.FileOutputStream;
import java.io.InputStream;
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
import kr.co.turnup_fridger.validation.BoardNoticeValidator;
import kr.co.turnup_fridger.vo.BoardNotice;

@Controller
@RequestMapping("/boardnotice/")
public class BoardNoticeController extends HttpServlet {
	
	@Autowired
	private BoardNoticeService service;
	@Autowired
	private BoardNoticeDao dao;
	
	private String eclipseDir = "C:\\Java\\eclipse\\workspace_web\\turnup_fridger2\\WebContent\\up_image"; 
	
	
	private void copyToEclipseDir(String newImageName, MultipartFile upImage) throws Exception{
		File eclipseDest = new File(eclipseDir, newImageName);
		FileOutputStream fo = new FileOutputStream(eclipseDest);
		InputStream is = upImage.getInputStream();
		byte [] b = new byte[10000];
		int cnt = is.read(b);
		while(cnt != -1){
			fo.write(b, 0, cnt);
			cnt = is.read(b);
		}
		fo.close();
		is.close();
	}
	
	
	//전체 리스트
	@RequestMapping("boardNoticeList")
	public ModelAndView boardNoticeList(@RequestParam(defaultValue="1") int page) throws Exception
	{  
	    Map<String, Object> map = service.findBoardNoticeList(page);
	
	    
	    
	    ModelAndView mav = new ModelAndView(); 
	    
	    mav.addObject("list", map.get("list"));
	    mav.addObject("pageBean", map.get("pageBean"));
	    mav.setViewName("boardnotice/boardnotice_list"); 
	    
	    return mav;
	} 
	
	//말머리 조회
	@RequestMapping("boardNoticeByItems")
	//@ResponseBody
	public ModelAndView boardNoticeById(@RequestParam String items, @RequestParam(defaultValue="1") int page) throws Exception
	{
		ModelAndView mav = new ModelAndView(); 
		
		Map<String, Object> map = service.findBoardNoticeByItmes(items,page);
		
		String s = "전체보기";
		if(items.equals(s))
		{
			 map = service.findBoardNoticeList(page);
 
			 mav.addObject("list", map.get("list"));
			 mav.addObject("pageBean", map.get("pageBean"));
			 mav.setViewName("boardnotice/boardnotice_list"); 
			    
			return mav;
		}
	    mav.addObject("list", map.get("list"));
	    mav.addObject("items",  map.get("items"));
	    mav.addObject("pageBean", map.get("pageBean"));
	    mav.setViewName("boardnotice/boardnotice_list_items");
		
	    return mav;
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
	@RequestMapping("boardNoticeAdd")
	 public ModelAndView insert(@ModelAttribute BoardNotice boardNotice,BindingResult errors, HttpServletRequest request, ModelMap map) throws Exception
	{
			BoardNoticeValidator validator = new BoardNoticeValidator();
			validator.validate(boardNotice, errors);
			if(errors.hasErrors()) 
			{
				//errors에 오류가 1개라도 등록되 있으면 true 리턴
				return new ModelAndView("boardnotice/boardnotice_form"); 
			}
			
			String upImageDir = request.getServletContext().getRealPath("/up_image");
			MultipartFile upImage = boardNotice.getUpImage();
			
			String fname = upImage.getOriginalFilename();

			if (fname.equals("")) 
			{
				boardNotice.setSaveImg(null);
		    } 
			if(upImage!=null && !upImage.isEmpty())
			{
				boardNotice.setImg(upImage.getOriginalFilename());
				String newImageName = UUID.randomUUID().toString();
				boardNotice.setSaveImg(newImageName);
				File dest = new File(upImageDir);
				//파일 이동
				/************************************
				 * 이클립스 경로로 카피
				 *************************************/
				copyToEclipseDir(newImageName,upImage);
				/************************************
				 * 이클립스 경로로 카피
				 *************************************/
				//파일 이동시키기
				upImage.transferTo(dest);
				//저장
				service.addBoardNotice(boardNotice);
				boardNotice = new BoardNotice(0,boardNotice.getItems(), boardNotice.getTitle(),boardNotice.getTxt(),boardNotice.getImg(),boardNotice.getSaveImg(),boardNotice.getDate() );
				map.addAttribute("boardNotice", boardNotice);
				}
			return new ModelAndView("boardnotice/boardnotice_view");	
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
	 public ModelAndView boardNoticeUploadForm(@ModelAttribute BoardNotice boardNotice,BindingResult errors, HttpServletRequest request, ModelMap map) throws Exception
	{
		BoardNoticeValidator validator = new BoardNoticeValidator();
		validator.validate(boardNotice, errors);
		if(errors.hasErrors()) 
		{
			//errors에 오류가 1개라도 등록되 있으면 true 리턴
			return new ModelAndView("boardnotice/boardnotice_form"); 
		}
		
		String upImageDir = request.getServletContext().getRealPath("/up_image");
		MultipartFile upImage = boardNotice.getUpImage();
		
		String fname = upImage.getOriginalFilename();

		if (fname.equals("")) 
		{
			boardNotice.setSaveImg(null);
	    } 
		else if(upImage!=null && !upImage.isEmpty())
		{
			boardNotice.setImg(upImage.getOriginalFilename());
			String newImageName = UUID.randomUUID().toString();
			boardNotice.setSaveImg(newImageName);
			File dest = new File(upImageDir);
			//파일 이동
			/************************************
			 * 이클립스 경로로 카피
			 *************************************/
			copyToEclipseDir(newImageName,upImage);
			/************************************
			 * 이클립스 경로로 카피
			 *************************************/
			//파일 이동시키기
			upImage.transferTo(dest);
			//저장
			service.addBoardNotice(boardNotice);
		}else
		{
			return new ModelAndView("boardnotice/boardnotice_upload"); 
		}
		return new ModelAndView("boardnotice/boardnotice_view");
	}
	
	
	
	
	//삭제
	@RequestMapping("boardNoticRemove")
	public ModelAndView boardNoticRemove(@RequestParam int id, @RequestParam(defaultValue="1") int page) throws Exception
	{
		service.removeBoardNoticeById(id);
		
	    Map<String, Object> map = service.findBoardNoticeList(page);

	    ModelAndView mav = new ModelAndView(); 
	    
	    mav.addObject("list", map.get("list"));
	    mav.addObject("pageBean", map.get("pageBean"));
	    mav.setViewName("boardnotice/boardnotice_list"); 
	    
	    return mav;

	}	
	
	
}
