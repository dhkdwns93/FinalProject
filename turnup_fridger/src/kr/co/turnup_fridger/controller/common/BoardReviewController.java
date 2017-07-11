package kr.co.turnup_fridger.controller.common;

import java.io.File;
import java.io.FileOutputStream;
import java.io.InputStream;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import kr.co.turnup_fridger.service.BoardReviewService;
import kr.co.turnup_fridger.validation.BoardReviewValidator;
import kr.co.turnup_fridger.vo.BoardReview;
import kr.co.turnup_fridger.vo.RecipeInfo;

@Controller
@RequestMapping("/boardreview/")
public class BoardReviewController extends HttpServlet {
	
		@Autowired
		private BoardReviewService service;
		
		//이미지 경로
		private String eclipseDir = "C:\\Java\\eclipse\\workspace_web\\turnup_fridger2\\WebContent\\up_image";
		
		
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
		@RequestMapping("boardReviewList") 
		@ResponseBody
		public ModelAndView boardReviewList(@RequestParam(defaultValue="1") int page)
		{  
			ModelAndView mav = new ModelAndView();
			
			Map<String, Object> map = service.selectBoardReviewList(page);
	 
			mav.addObject("list", map.get("list"));
			mav.addObject("pageBean", map.get("pageBean"));
	        mav.setViewName("boardreview/boardreview_list.tiles");
	        return mav; 
		} 
		
		//별점순 조회
		@RequestMapping("boardReviewStarList") 
		@ResponseBody
		public ModelAndView boardReviewStarList(@RequestParam(defaultValue="1") int page)
		{  
			ModelAndView mav = new ModelAndView();
			
			Map<String, Object> map = service.selectBoardReviewByStarList(page);
	 
			mav.addObject("list", map.get("list"));
			mav.addObject("pageBean", map.get("pageBean"));
	        mav.setViewName("boardreview/boardreview_list_star.tiles");
	        return mav; 
		} 	
		
		
		//레시피 조회
		@RequestMapping("boardReviewByRecipeName")
		@ResponseBody
		public ModelAndView boardReviewByRecipeName(@RequestParam String recipeName,@RequestParam(defaultValue="1") int page)
		{
			ModelAndView mav = new ModelAndView();	
			
			Map<String, Object> map  = service.selectBoardReviewByRecipeNameList(recipeName,page);
			
			mav.addObject("list", map.get("list"));
		    mav.addObject("recipeName",  map.get("recipeName"));
		    mav.addObject("pageBean", map.get("pageBean"));
		    mav.setViewName("boardreview/boardreview_list_recipename.tiles"); 

	        return mav; 
		}	
		
	
		//아이디 조회
		@RequestMapping("boardReviewByMemberId")
		@ResponseBody
		public ModelAndView boardReviewByMemberId(@RequestParam String memberId,@RequestParam(defaultValue="1") int page)
		{
			ModelAndView mav = new ModelAndView();	
			
		
			Map<String, Object> map  = service.selectBoardReviewByMemberIdList(memberId,page);
			
			mav.addObject("list", map.get("list"));
		    mav.addObject("memberId",  map.get("memberId"));
		    mav.addObject("pageBean", map.get("pageBean"));
		    mav.setViewName("boardreview/boardreview_list_memberid.tiles");

	        return mav; 
		}
			
		//선택 조회
		@RequestMapping("boardReviewBySelect")
		@ResponseBody
		public ModelAndView boardReviewBySelect(@RequestParam String select, @RequestParam String keyword,@RequestParam(defaultValue="1") int page)
		{
			ModelAndView mav = new ModelAndView();	
			Map<String, Object> map = new HashMap<>();
			
			String id = "아이디";
			String name = "레시피";
			
			if(select.equals(id))
			{
				map  = service.selectBoardReviewByMemberIdList(keyword,page);
				
				mav.addObject("list", map.get("list"));
			    mav.addObject("memberId",  keyword);
			    mav.addObject("pageBean", map.get("pageBean"));
			    mav.setViewName("boardreview/boardreview_list_memberid.tiles");

		        return mav;
			}			
			else if(select.equals(name))
			{
				map  = service.selectBoardReviewByRecipeNameList(keyword,page);
				
				mav.addObject("list", map.get("list"));
			    mav.addObject("recipeName",  map.get("recipeName"));
			    mav.addObject("pageBean", map.get("pageBean"));
			    mav.setViewName("boardreview/boardreview_list_recipename.tiles"); 

		        return mav;  
			}
			
			map = service.selectBoardReviewList(page);
			mav.addObject("list", map.get("list"));
			mav.addObject("pageBean", map.get("pageBean"));
	        mav.setViewName("boardreview/boardreview_list.tiles");
	        return mav; 
		}		
	
		//등록
		@RequestMapping("boardReviewAdd")
		@ResponseBody
		 public ModelAndView boardReviewAdd(@ModelAttribute BoardReview boardReview,BindingResult errors, HttpServletRequest request,@RequestParam(defaultValue="1") int page) throws Exception
		{
			ModelAndView mav = new ModelAndView();
			
			BoardReviewValidator validator = new BoardReviewValidator();
			validator.validate(boardReview, errors);
			if(errors.hasErrors()) 
			{
				return new ModelAndView("boardreview/boardreview_form.tiles"); 
			}
			
			String upImageDir = request.getServletContext().getRealPath("/up_image");
			MultipartFile upImage = boardReview.getUpImage();
			
			String fname = upImage.getOriginalFilename();

			if (fname.equals("")) 
			{
				boardReview.setImageSaveName(null);
				service.addBoardReview(boardReview);
		    } 
			else if(upImage!=null && !upImage.isEmpty())
			{
				boardReview.setImageName(upImage.getOriginalFilename());
				String newImageName = UUID.randomUUID().toString();
				boardReview.setImageSaveName(newImageName);
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
				service.addBoardReview(boardReview);
			}
			
			Map<String, Object> map = service.selectBoardReviewList(page);
			 
			mav.addObject("list", map.get("list"));
			mav.addObject("pageBean", map.get("pageBean"));
	        mav.setViewName("boardreview/boardreview_list.tiles");
	        return mav; 
		}
			
		//삭제
		@RequestMapping("boardReviewRemove")
		@ResponseBody
		public ModelAndView boardReviewRemove(@RequestParam int boardReviewId,
				@RequestParam String writer,@RequestParam String memberId,@RequestParam String adminId,@RequestParam(defaultValue="1") int page)
		{
			
	        ModelAndView mav = new ModelAndView();
	        if((writer.equals(memberId) && adminId.trim().isEmpty()) || !adminId.trim().isEmpty())
	        {
	        	service.removeBoardReview(boardReviewId);//정보삭제 
				Map<String, Object> map = service.selectBoardReviewList(page);
				 
				mav.addObject("list", map.get("list"));
				mav.addObject("pageBean", map.get("pageBean"));
		        mav.setViewName("boardreview/boardreview_list.tiles");
		        return mav; 
	        }
			
			Map<String, Object> map = service.selectBoardReviewList(page);
			 
			mav.addObject("list", map.get("list"));
			mav.addObject("pageBean", map.get("pageBean"));
	        mav.setViewName("boardreview/boardreview_list.tiles");
	        return mav; 
        

		}	
		
		//수정 폼 이동
		@RequestMapping("boardReviewUploadView")
		@ResponseBody
		public ModelAndView boardReviewUploadView(@RequestParam int boardReviewId, @RequestParam String writer,@RequestParam String memberId,@RequestParam(defaultValue="1") int page)
		{
			ModelAndView mav = new ModelAndView();
			
			if(writer.equals(memberId))
			{
				mav.addObject("boardReview", service.selecetBoardReviewByBoardReviewId(boardReviewId));//해당 수정 정보 불러서 저장
				mav.setViewName("boardreview/boardreview_upload.tiles");
				return mav;
			}	
			
			Map<String, Object> map = service.selectBoardReviewList(page);
			 
			mav.addObject("list", map.get("list"));
			mav.addObject("pageBean", map.get("pageBean"));
	        mav.setViewName("boardreview/boardreview_list.tiles");
	        return mav; 
		}
		
		//이지지 삭제
		@RequestMapping("boardReviewImageDelete")
		@ResponseBody
		public ModelAndView boardReviewImageDelete(@ModelAttribute BoardReview boardReview,BindingResult errors,@RequestParam int boardReviewId)
		{
			ModelAndView mav = new ModelAndView();
			
			service.updateImageNull(boardReview);
			
			mav.addObject("boardReview", service.selecetBoardReviewByBoardReviewId(boardReview.getBoardReviewId()));//해당 수정 정보 불러서 저장
			mav.setViewName("boardreview/boardreview_upload.tiles");
			return mav;
		}		
			
		//수정
		@RequestMapping("boardReviewUploadForm")
		@ResponseBody
		 public ModelAndView boardReviewUploadForm(@ModelAttribute BoardReview boardReview,@RequestParam int boardReviewId, BindingResult errors,HttpServletRequest request,@RequestParam(defaultValue="1") int page) throws Exception
		{
			ModelAndView mav = new ModelAndView();
			
			BoardReviewValidator validator = new BoardReviewValidator();
			validator.validate(boardReview, errors);
			if(errors.hasErrors()) 
			{
				return new ModelAndView("boardreview/boardreview_upload.tiles"); 
			}
			
			if(boardReview.getImageName() != null)
			{
				service.updateBoardReview(boardReview);
				Map<String, Object> map = service.selectBoardReviewList(page);
				 
				mav.addObject("list", map.get("list"));
				mav.addObject("pageBean", map.get("pageBean"));
		        mav.setViewName("boardreview/boardreview_list.tiles");
		        return mav;  
				
			}
			String upImageDir = request.getServletContext().getRealPath("/up_image");
			MultipartFile upImage = boardReview.getUpImage();
			
			String fname = upImage.getOriginalFilename();

			if (fname.equals("")) 
			{
				boardReview.setImageSaveName(null);
				service.updateBoardReview(boardReview);
		    } 
			else if(upImage!=null && !upImage.isEmpty())
			{
				boardReview.setImageName(upImage.getOriginalFilename());
				String newImageName = UUID.randomUUID().toString();
				boardReview.setImageSaveName(newImageName);
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
				service.addBoardReview(boardReview);
			}
			
			Map<String, Object> map = service.selectBoardReviewList(page);
			 
			mav.addObject("list", map.get("list"));
			mav.addObject("pageBean", map.get("pageBean"));
	        mav.setViewName("boardreview/boardreview_list.tiles");
	        return mav; 

		}
		
		//레시피 이름 리스트
		@RequestMapping("reviewRecipeName") 
		@ResponseBody
		public List reviewRecipeName(@RequestParam String recipeName)
		{  
			List<RecipeInfo> list = service.selectRecipeName(recipeName);
			System.out.println(list);
	        return list; 
		} 
		
}