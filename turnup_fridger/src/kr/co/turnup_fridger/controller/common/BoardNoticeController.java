package kr.co.turnup_fridger.controller.common;

import java.io.File;
import java.io.FileOutputStream;
import java.io.InputStream;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import kr.co.turnup_fridger.dao.BoardNoticeDao;
import kr.co.turnup_fridger.service.BoardNoticeService;
import kr.co.turnup_fridger.validation.BoardNoticeValidator;
import kr.co.turnup_fridger.vo.BoardNotice;
import kr.co.turnup_fridger.vo.BoardReview;

@Controller
@RequestMapping
public class BoardNoticeController extends HttpServlet {
	
	@Autowired
	private BoardNoticeService service;
	@Autowired
	private BoardNoticeDao dao;
	
	//이미지 경로
	private String eclipseDir = "C:\\Java\\apache-tomcat-8.0.43\\webapps\\turnup_fridger\\img"; 
	
	
	//카피
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
	@RequestMapping("/boardnotice/boardNoticeList")
	@ResponseBody
	public ModelAndView boardNoticeList(@RequestParam(defaultValue="1") int page)
	{  
	    Map<String, Object> map = service.findBoardNoticeList(page);

	    ModelAndView mav = new ModelAndView(); 
	    mav.addObject("totalCount",map.get("totalCount"));
	    mav.addObject("list", map.get("list"));
	    mav.addObject("pageBean", map.get("pageBean"));
	    mav.setViewName("boardnotice/boardnotice_list.tiles"); 
	    
	    return mav;
	} 
	
	//말머리 조회
	@RequestMapping("/boardnotice/boardNoticeByItems")
	@ResponseBody
	public ModelAndView boardNoticeById(@RequestParam String items, @RequestParam(defaultValue="1") int page)
	{
		/*int p =  Integer.parseInt(page);
	
		System.out.printf("%s,%d",items,p);*/
		ModelAndView mav = new ModelAndView(); 
		
		Map<String, Object> map = service.findBoardNoticeByItmes(items,page);
		
		String s = "전체보기";
		if(items.equals(s))
		{
			 map = service.findBoardNoticeList(page);
 
			 mav.addObject("list", map.get("list"));
			 mav.addObject("totalCount",map.get("totalCount"));
			 mav.addObject("pageBean", map.get("pageBean"));
			 mav.setViewName("boardnotice/boardnotice_list.tiles"); 
			    
			return mav;
		}
	    mav.addObject("list", map.get("list"));
	    mav.addObject("items",  map.get("items"));
	    mav.addObject("totalCount",map.get("totalCount"));
	    mav.addObject("pageBean", map.get("pageBean"));
	    mav.setViewName("boardnotice/boardnotice_list_items.tiles");
		
	    return mav;
	} 
	
	
	
	//상세보기
	@RequestMapping("/boardnotice/boardNoticeView")
	@ResponseBody
	public ModelAndView boardNoticeView(@RequestParam int id)
	{
		
		System.out.println(id);
		ModelAndView mav = new ModelAndView();
		
		mav.setViewName("boardnotice/boardnotice_view.tiles");
				
		mav.addObject("boardNotice", service.findBoardNoticeById(id));
	    
		return mav;
	}	
	 
	
	//등록
	@RequestMapping("/common/admin/boardnotice/boardNoticeAdd")
	@ResponseBody
	 public ModelAndView boardNoticeAdd(@ModelAttribute BoardNotice boardNotice,BindingResult errors, HttpServletRequest request) throws Exception
	{
			BoardNoticeValidator validator = new BoardNoticeValidator();
			validator.validate(boardNotice, errors);
			if(errors.hasErrors()) 
			{
				//errors에 오류가 1개라도 등록되 있으면 true 리턴
				return new ModelAndView("common/admin/boardnotice/boardnotice_form.tiles"); 
			}
			
			ModelAndView mav = new ModelAndView();
			
			String upImageDir = request.getServletContext().getRealPath("/img");
			MultipartFile upImage = boardNotice.getUpImage();
			
			String fname = upImage.getOriginalFilename();

			if (fname.equals("")) 
			{
				boardNotice.setSaveImg(null);
				service.addBoardNotice(boardNotice);
		    } 
			else if(upImage!=null && !upImage.isEmpty())
			{
				boardNotice.setImg(upImage.getOriginalFilename());
				String newImageName = UUID.randomUUID().toString();
				boardNotice.setSaveImg(newImageName);
				File dest = new File(upImageDir,newImageName);
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
			}
			mav.addObject("boardNotice",boardNotice);
			mav.setViewName("boardnotice/boardnotice_view.tiles");
			mav.addObject("boardNotice", service.findBoardNoticeById(boardNotice.getId()));
			return mav;	
	}
	
	
	
	//수정 폼 이동
	@RequestMapping("/common/admin/boardnotice/boardNoticeUploadView")
	@ResponseBody
	public ModelAndView boardNoticeUploadView(@RequestParam int id)
	{
		ModelAndView mav = new ModelAndView();
		
		mav.setViewName("common/admin/boardnotice/boardnotice_upload.tiles");
		
		mav.addObject("boardNotice", service.findBoardNoticeById(id));
	    
		return mav;
	}	

	//사진삭제
	@RequestMapping("/common/admin/boardnotice/boardNoticeImageDelete")
	@ResponseBody
	 public ModelAndView boardNoticeImageDelete(@ModelAttribute BoardNotice boardNotice,BindingResult errors)
	{
		ModelAndView mav = new ModelAndView();
		
		service.updateImageNull(boardNotice);
		
		mav.addObject("boardNotice", service.findBoardNoticeById(boardNotice.getId()));
		mav.setViewName("common/admin/boardnotice/boardnotice_upload.tiles");
		return mav;
	}

	
	//수정
	@RequestMapping("/common/admin/boardnotice/boardNoticeUploadForm")
	@ResponseBody
	 public ModelAndView boardNoticeUploadForm(@ModelAttribute BoardNotice boardNotice,BindingResult errors, HttpServletRequest request,@RequestParam int id) throws Exception
	{
		ModelAndView mav = new ModelAndView();
		
		BoardNoticeValidator validator = new BoardNoticeValidator();
		validator.validate(boardNotice, errors);
		if(errors.hasErrors()) 
		{
			//errors에 오류가 1개라도 등록되 있으면 true 리턴
			return new ModelAndView("common/admin/boardnotice/boardnotice_upload.tiles"); 
		}
		
		if(boardNotice.getImg() != null)
		{
			service.updateBoardNotice(boardNotice);
			mav.addObject("boardNotice",boardNotice);
			mav.addObject("boardNotice", service.findBoardNoticeById(id));
			mav.setViewName("boardnotice/boardnotice_view.tiles");
			return mav;	
		}

		String upImageDir = request.getServletContext().getRealPath("/up_image");
		MultipartFile upImage = boardNotice.getUpImage();
		
		String fname = upImage.getOriginalFilename();

		if (fname.equals("")) 
		{
			boardNotice.setSaveImg(null);
			service.updateBoardNotice(boardNotice);
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
			service.updateBoardNotice(boardNotice);
		}
		mav.addObject("boardNotice",boardNotice);
		mav.addObject("boardNotice", service.findBoardNoticeById(id));
		mav.setViewName("boardnotice/boardnotice_view.tiles");
		return mav;	
	}
	
	
	
	
	//삭제
	@RequestMapping("/common/admin/boardnotice/boardNoticRemove")
	@ResponseBody
	public ModelAndView boardNoticRemove(@RequestParam int id, @RequestParam(defaultValue="1") int page) throws Exception
	{
		service.removeBoardNoticeById(id);
		
	    Map<String, Object> map = service.findBoardNoticeList(page);

	    ModelAndView mav = new ModelAndView(); 
	    
	    mav.addObject("list", map.get("list"));
	    mav.addObject("totalCount",map.get("totalCount"));
	    mav.addObject("pageBean", map.get("pageBean"));
	    mav.setViewName("boardnotice/boardnotice_list.tiles"); 
	    
	    return mav;

	}	
	
	
}
