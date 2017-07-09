package kr.co.turnup_fridger.controller.common;

import java.io.File;
import java.io.FileOutputStream;
import java.io.InputStream;
import java.util.ArrayList;
import java.util.List;
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
		public ModelAndView boardReviewList()
		{  
			ModelAndView mav = new ModelAndView();
			
			List<BoardReview> list = service.selectBoardReviewList();
	 
			mav.addObject("list", list);
	        mav.setViewName("boardreview/boardreview_list.tiles");
	        return mav; 
		} 
		
		//별점순 조회
		@RequestMapping("boardReviewStarList") 
		@ResponseBody
		public ModelAndView boardReviewStarList()
		{  
			ModelAndView mav = new ModelAndView();
			
			List<BoardReview> list = service.selectBoardReviewByStarList();
	 
			mav.addObject("list", list);
	        mav.setViewName("boardreview/boardreview_list_star.tiles");
	        return mav; 
		} 		
		
		

		//아이디 조회
		@RequestMapping("boardReviewByMemberId")
		@ResponseBody
		public ModelAndView boardReviewByMemberId(@RequestParam String memberId)
		{
			ModelAndView mav = new ModelAndView();	
			
		
			List<BoardReview> list  = service.selectBoardReviewByMemberIdList(memberId);
			
			mav.addObject("list", list);
		    mav.addObject("memberId",  memberId);
		    mav.setViewName("boardreview/boardreview_list_memberid.tiles");

	        return mav; 
		}
		
		//레시피 조회
		@RequestMapping("boardReviewByRecipeName")
		@ResponseBody
		public ModelAndView boardReviewByRecipeName(@RequestParam String recipeName)
		{
			ModelAndView mav = new ModelAndView();	
			
			List<BoardReview> list  = service.selectBoardReviewByRecipeNameList(recipeName);
			
			mav.addObject("list", list);
		    mav.addObject("recipeName", recipeName);
		    mav.setViewName("boardreview/boardreview_list_recipename.tiles"); 

	        return mav; 
		}	
		
		
		
			
		//선택 조회
		@RequestMapping("boardReviewBySelect")
		@ResponseBody
		public ModelAndView boardReviewBySelect(@RequestParam String select, @RequestParam String keyword,@RequestParam(defaultValue="1") int page)
		{
			ModelAndView mav = new ModelAndView();	
			List<BoardReview> list = new ArrayList<>();
			
			String id = "아이디";
			String name = "레시피";
			
			if(select.equals(id))
			{
				list  = service.selectBoardReviewByMemberIdList(keyword);
				mav.addObject("list", list);
			    mav.setViewName("boardreview/boardreview_list_memberid.tiles");
		        
		        return mav;
			}			
			else if(select.equals(name))
			{
				list = service.selectBoardReviewByRecipeNameList(keyword);
				mav.addObject("list", list);
			    mav.setViewName("boardreview/boardreview_list_recipename.tiles"); 
		        return mav; 
			}
			list = service.selectBoardReviewList();
			 
			mav.addObject("list", list);
	        mav.setViewName("boardreview/boardreview_list.tiles");
	        return mav; 
		}		
	
		//등록
		@RequestMapping("boardReviewAdd")
		@ResponseBody
		 public ModelAndView boardReviewAdd(@ModelAttribute BoardReview boardReview,BindingResult errors, HttpServletRequest request) throws Exception
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
			
			List<BoardReview> list = service.selectBoardReviewList();
			 
			mav.addObject("list", list);
	        mav.setViewName("boardreview/boardreview_list.tiles");
	        return mav; 
		}
			
		//삭제
		@RequestMapping("boardReviewRemove")
		@ResponseBody
		public ModelAndView boardReviewRemove(@RequestParam int boardReviewId,
				@RequestParam String writer,@RequestParam String memberId,@RequestParam String adminId)
		{
			
	        ModelAndView mav = new ModelAndView();
	        if((writer.equals(memberId) && adminId.trim().isEmpty()) || !adminId.trim().isEmpty())
	        {
	        	service.removeBoardReview(boardReviewId);//정보삭제 
				List<BoardReview> list = service.selectBoardReviewList();
				mav.addObject("list", list);
		        mav.setViewName("boardreview/boardreview_list.tiles");
		        return mav; 
	        }
			
			List<BoardReview> list = service.selectBoardReviewList();
			mav.addObject("list", list);
	        mav.setViewName("boardreview/boardreview_list.tiles");
	        return mav; 
        

		}	
		
		//수정 폼 이동
		@RequestMapping("boardReviewUploadView")
		@ResponseBody
		public ModelAndView boardReviewUploadView(@RequestParam int boardReviewId, @RequestParam String writer,@RequestParam String memberId)
		{
			ModelAndView mav = new ModelAndView();
			
			if(writer.equals(memberId))
			{
				mav.addObject("boardReview", service.selecetBoardReviewByBoardReviewId(boardReviewId));//해당 수정 정보 불러서 저장
				mav.setViewName("boardreview/boardreview_upload.tiles");
				return mav;
			}	
			
			List<BoardReview> list = service.selectBoardReviewList();
			 
			mav.addObject("list", list);
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
		 public ModelAndView boardReviewUploadForm(@ModelAttribute BoardReview boardReview,@RequestParam int boardReviewId, BindingResult errors,HttpServletRequest request) throws Exception
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
				System.out.println(boardReview);
				List<BoardReview> list = service.selectBoardReviewList();
				 
				mav.addObject("list", list);
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
			
			List<BoardReview> list = service.selectBoardReviewList();
			 
			mav.addObject("list", list);
	        mav.setViewName("boardreview/boardreview_list.tiles");
	        return mav; 

		}
}