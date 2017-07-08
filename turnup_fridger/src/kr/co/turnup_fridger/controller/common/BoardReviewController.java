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
	        mav.setViewName("boardreview/boardreview_list");
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
	        mav.setViewName("boardreview/boardreview_list_star");
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
		    mav.setViewName("boardreview/boardreview_list_memberid");

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
		    mav.setViewName("boardreview/boardreview_list_recipename"); 

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
			    mav.setViewName("boardreview/boardreview_list_memberid");
		        
		        return mav;
			}			
			else if(select.equals(name))
			{
				list = service.selectBoardReviewByRecipeNameList(keyword);
				mav.addObject("list", list);
			    mav.setViewName("boardreview/boardreview_list_recipename"); 
		        return mav; 
			}
			list = service.selectBoardReviewList();
			 
			mav.addObject("list", list);
	        mav.setViewName("boardreview/boardreview_list");
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
				//errors에 오류가 1개라도 등록되 있으면 true 리턴
				List<BoardReview> list = service.selectBoardReviewList();
				mav.addObject("list", list);
		        mav.setViewName("boardreview/boardreview_list");
		        return mav;  
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
	        mav.setViewName("boardreview/boardreview_list");
	        return mav; 
		}
			
		//삭제
		@RequestMapping("boardReviewRemove")
		@ResponseBody
		public ModelAndView boardReviewRemove(@RequestParam int boardReviewId,
				@RequestParam String writer,@RequestParam String memberId,@RequestParam String adminId)
		{
			
		System.out.printf("%d,%s,%s,%s",boardReviewId,writer,memberId,adminId);
	        ModelAndView mav = new ModelAndView();
	        if((writer.equals(memberId) && adminId.trim().isEmpty()) || !adminId.trim().isEmpty())
	        {
	        	service.removeBoardReview(boardReviewId);//정보삭제 
				List<BoardReview> list = service.selectBoardReviewList();
				mav.addObject("list", list);
		        mav.setViewName("boardreview/boardreview_list");
		        return mav; 
	        }
			
			List<BoardReview> list = service.selectBoardReviewList();
			mav.addObject("list", list);
	        mav.setViewName("boardreview/boardreview_list");
	        return mav; 
        

		}	
/*			
		//수정 폼 이동
		@RequestMapping("boardFreeUploadView")
		@ResponseBody
		public ModelAndView boardFreeUploadView(@RequestParam int boardFreeId,@RequestParam String writer,@RequestParam String memberId,@RequestParam(defaultValue="1") int page)
		{
			ModelAndView mav = new ModelAndView();
			
			if(writer.equals(memberId))
			{
				mav.addObject("boardFree", service.selectBoardFreeByboardFreeId(boardFreeId));//해당 수정 정보 불러서 저장
				mav.setViewName("common/boardfree/boardfree_upload");
				return mav;
			}	
			
			BoardFree boradFree = service.selectBoardFreeByboardFreeId(boardFreeId);
			mav.addObject("boardFree",boradFree);
			
			Map<String, Object> map = commentFree.selectCommentFreeListbyId(boardFreeId,page);
			mav.addObject("commentFree", map.get("list"));
			mav.addObject("boardFreeId",  map.get("boardFreeId"));
		    mav.addObject("pageBean", map.get("pageBean"));
		    
			
			mav.setViewName("common/boardfree/boardfree_view");
			
			return mav;
		}	
	
		//수정
		@RequestMapping("boardFreeUploadForm")
		@ResponseBody
		 public ModelAndView boardFreeUploadForm(@ModelAttribute BoardFree boardFree,@RequestParam int boardFreeId, BindingResult errors,@RequestParam(defaultValue="1") int page)
		{
			BoardFreeValidator validator = new BoardFreeValidator();
			validator.validate(boardFree, errors);
			if(errors.hasErrors()) 
			{
				//errors에 오류가 1개라도 등록되 있으면 true 리턴
				return new ModelAndView("common/boardfree/boardfree_upload"); 
			}
			ModelAndView mav = new ModelAndView();
			
			service.updateBoardFree(boardFree);//수정
			
			boardFree = service.selectBoardFreeByboardFreeId(boardFreeId);
			mav.addObject("boardFree", boardFree);//게시물 상세 정보
			
			Map<String, Object> map = commentFree.selectCommentFreeListbyId(boardFreeId,page);
			mav.addObject("commentFree",map.get("list"));//해당게시물 댓글 정보
		    mav.addObject("boardFreeId",  map.get("boardFreeId"));
		    mav.addObject("pageBean", map.get("pageBean"));
		    
		    mav.setViewName("common/boardfree/boardfree_view"); 
		    
			return mav;

		}	*/
}