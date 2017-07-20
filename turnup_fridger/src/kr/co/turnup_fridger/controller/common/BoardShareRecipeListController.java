package kr.co.turnup_fridger.controller.common;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.HashSet;
import java.util.List;
import java.util.Map;
import java.util.Set;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

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

import kr.co.turnup_fridger.exception.BoardException;
import kr.co.turnup_fridger.exception.FindMemberFailException;
import kr.co.turnup_fridger.exception.OverLapException;
import kr.co.turnup_fridger.service.BoardShareRecipeService;
import kr.co.turnup_fridger.service.IrdntManageService;
import kr.co.turnup_fridger.service.MemberService;
import kr.co.turnup_fridger.service.ShareRecipeIrdntService;
import kr.co.turnup_fridger.validation.BoardShareRecipeValidator;
import kr.co.turnup_fridger.vo.BoardShareRecipe;
import kr.co.turnup_fridger.vo.IrdntManage;
import kr.co.turnup_fridger.vo.MemberRecipeRecommand;
import kr.co.turnup_fridger.vo.ShareRecipeIrdnt;

@Controller
@RequestMapping
public class BoardShareRecipeListController{
	
	@Autowired
	BoardShareRecipeService boardShareRecipeService;
	@Autowired
	MemberService service ;
	@Autowired
	IrdntManageService manageService;
	@Autowired
	ShareRecipeIrdntService irdntService;
	
	
	MemberRecipeRecommand memberRecipeRecommand;
	ShareRecipeIrdnt shareRecipeIrdnt;
	IrdntManage irdntManage;
	
	//이미지 경로
	private String eclipseDir ="C:\\Java\\apache-tomcat-8.0.43\\webapps\\turnup_fridger\\img"; 

	//카피
	private void copyToEclipseDir(String newImageName, MultipartFile upImage) throws IOException{
		File eclipseDest = new File(eclipseDir, newImageName);
		FileOutputStream fo = new FileOutputStream(eclipseDest);
		InputStream is = upImage.getInputStream();
		byte [] b = new byte[10000];
		int cnt = is.read(b);
		while(cnt!=-1){
			fo.write(b, 0, cnt);
			cnt = is.read(b);
		}
		fo.close();
		is.close();
	}
	
	
	
	
	
	//게시물 전체 목록
	@RequestMapping("/boardRecipe/boardRecipeList")
	public ModelAndView BoardShareRecipeList(@RequestParam(defaultValue="1") int page, @ModelAttribute BoardShareRecipe boardShareRecipe){
		ModelAndView mav = new ModelAndView();
		Map<String, Object> Map = boardShareRecipeService.selectBoardShareRecipeAll(page);
		
	
		mav.addObject("list", Map.get("list"));
		mav.addObject("pageBean", Map.get("pageBean"));
		mav.setViewName("boardRecipe/boardRecipe_list.tiles");
		
		
		Map<String, Object> map = boardShareRecipeService.selectBoardShareRecipeAll(page);
		
		List<BoardShareRecipe> boardTop = boardShareRecipeService.selectBoardTop4();
		
		mav.addObject("top", boardTop);
		mav.addObject("list", map.get("list"));
		mav.addObject("pageBean", map.get("pageBean"));
		
		mav.setViewName("boardRecipe/boardRecipe_list.tiles");
		return mav;
		
	}
	
	//게시글 작성처리(등록)
	@RequestMapping("/common/member/boardRecipe/boardRecipeRegister")
	@ResponseBody
	public ModelAndView boardRecipeRegister(@ModelAttribute BoardShareRecipe boardShareRecipe,
			@RequestParam List<Integer> irdntId, ModelMap map, HttpServletRequest request, BindingResult  errors	) throws Exception{
		ModelAndView mav = new ModelAndView();

		BoardShareRecipeValidator validator = new BoardShareRecipeValidator();
		validator.validate(boardShareRecipe, errors);
		
		if(errors.hasErrors()){//에러가 하나라도 있으면 실행

			return  new ModelAndView("common/member/boardRecipe/boardRecipe_write.tiles");
		}
		
		String upImageDir = request.getServletContext().getRealPath("/img"); 
		MultipartFile upImage = boardShareRecipe.getUpImage();
		String fname = upImage.getOriginalFilename();
		if (fname.equals("")) 
		{
			//만약 사진이 없을경우 폼창으로 이동하면서 알람창을 띄워준다.
			mav.addObject("error","err");
			mav.setViewName("common/member/boardRecipe/boardRecipe_write.tiles");
			return mav;
	
	    }else if(upImage!=null&&!upImage.isEmpty())
	    {
	    	boardShareRecipe.setOriginal(upImage.getOriginalFilename());
	    	String newImageName = UUID.randomUUID().toString();
	    	boardShareRecipe.setSaveName(newImageName);
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
			boardShareRecipeService.insertBoardShareRecipe(boardShareRecipe);
	    }
		

		
		Set<ShareRecipeIrdnt> irdntSet = new HashSet<>();
		List<String> shareRecipeIrdntNameList = new ArrayList<>();
		
		System.out.println("6차: "+ irdntId);
		for(int irdnt : irdntId){
			if(irdnt!=-1){
				irdntSet.add(new ShareRecipeIrdnt(boardShareRecipe.getRecipeId(), irdnt));
//				return new ModelAndView("redirect:/boardRecipe/boardRecipeRegister.do");
				
			}
		}
//		System.out.println("7차 :"+ shareRecipeIrdntNameList);
		List<ShareRecipeIrdnt> irdntList = new ArrayList<>();
		
//		System.out.println("2차 : "+irdntList);
	
		for(ShareRecipeIrdnt toIrdnt : irdntSet){
			irdntList.add(toIrdnt);
			
			irdntService.insertShareRecipeIrdnt(toIrdnt);//재료등록
			shareRecipeIrdntNameList.add(manageService.findIrdntByIrdntId(toIrdnt.getIrdntId()).getIrdntName());
		}
		
		if(shareRecipeIrdntNameList.size()==0){
			shareRecipeIrdntNameList.add("등록된 재료가 없습니다.");
		}
		
		boardShareRecipe.setShareRecipeIrdnt(irdntList);
//		System.out.println("3차 :"+irdntList);
		//응답
		map.addAttribute("recipeId", boardShareRecipe.getRecipeId());
		map.addAttribute("shareRecipeIrdntList", shareRecipeIrdntNameList);
		
//		System.out.println("4차 :"+ shareRecipeIrdntNameList);
		return new ModelAndView("redirect:/common/member/boardRecipe/boardRecipeRegisterSuccess.do");
	}
	
	//등록 성공폼
	@RequestMapping("/common/member/boardRecipe/boardRecipeRegisterSuccess")
	@ResponseBody
	public ModelAndView boardRecipeRegisterSuccess(@RequestParam int recipeId, 
			@RequestParam List<String>shareRecipeIrdntList,
			ModelMap map){
//		boardShareRecipe = boardShareRecipeService.boardRead(recipeId);
		 irdntService.selectShareRecipeIrdntByRecipeId(recipeId);

		map.addAttribute("recipeId", recipeId);
		map.addAttribute("boardShareRecipeList",shareRecipeIrdnt);
		map.addAttribute("shareRecipeIrdntList", shareRecipeIrdntList);

		return new ModelAndView("redirect:/boardRecipe/boardRecipeList.do");
	}
	
	
	//재료명 불러	
	@RequestMapping("/common/member/boardRecipe/findIrdntByNameShare")
	@ResponseBody
	public List<IrdntManage> findIrdntByNameShare(@RequestParam String irdntName){
		List<IrdntManage> list = manageService.findIrdntByName(irdntName);
		return list;
	}
	

	
	

	//게시글 상세내용 조회, 게시글 조회수 증가처리
	@RequestMapping("/boardRecipe/boardRecipeView")
	public ModelAndView boardRecipeView(@RequestParam int recipeId, 
			HttpSession session) throws Exception{
		
		ModelAndView mav = new ModelAndView();
		//조회수 증가처리
		boardShareRecipeService.increaseHit(recipeId, session);
		
		//recipeId로 3개 조인한 값 상세조회
		BoardShareRecipe boardRecipe = boardShareRecipeService.selectBoardByShareIrdnt(recipeId);
		
		List<ShareRecipeIrdnt> list = irdntService.findShareRecipeIrdntByRecipeId(recipeId);
		
		List<ShareRecipeIrdnt> share = irdntService.selectShareRecipeIrdntByRecipeId(recipeId);
		mav.addObject("share", share);
		for(int i=0; i<share.size();i++){
			mav.addObject("irdntList",  share.get(i).getIrdntManage().getIrdntName());
		}
		
		mav.addObject("boardShareRecipe",boardRecipe);
		mav.addObject("list", list);
		mav.setViewName("boardRecipe/boardRecipe_view.tiles");
		return mav;
	}
		
	
	
	
	
	//상세페이지랑 수정페이지폼이랑 메서드를 똑같이 사용.
	//게시글 수정페이지
	@RequestMapping("/common/boardReipce/boardRecipeUpdate")
	@ResponseBody
	public ModelAndView update(@RequestParam int recipeId) {
		ModelAndView mav = new ModelAndView();
		/*	BoardShareRecipe boardShareRecipe = boardShareRecipeService.selectBoardByShareIrdnt(recipeId);
		
		List<ShareRecipeIrdnt> shareRecipeList = irdntService.findShareRecipeIrdntByRecipeId(boardShareRecipe.getRecipeId());
		List<String> shareRecipeIrdntNameList = new ArrayList<>();
		if(shareRecipeList.size()==0){
			shareRecipeIrdntNameList.add("등록된 재료가 없습니다.");
		}else{
			for(ShareRecipeIrdnt irdnt :  shareRecipeList){
				shareRecipeIrdntNameList.add(manageService.findIrdntByIrdntId(irdnt.getIrdntId()).getIrdntName());
			}
		}*/
		/*mav.addObject("boardShareRecipe",boardShareRecipe);
		//mav.addObject("list", list);
		mav.setViewName("common/boardRecipe/boardRecipe_update.tiles");
		//경로 이동
		return mav;*/
		BoardShareRecipe boardRecipe = boardShareRecipeService.selectBoardByShareIrdnt(recipeId);
		
		//List<ShareRecipeIrdnt> list = irdntService.findShareRecipeIrdntByRecipeId(recipeId);
		System.out.println(boardRecipe);
		mav.addObject("boardShareRecipe",boardRecipe);
		//mav.addObject("list", list);
		mav.setViewName("common/boardRecipe/boardRecipe_update.tiles");
		//경로 이동
		return mav;
	}
	
	
	//게시글 수정 폼 페이지
	@RequestMapping("/common/boardRecipe/boardRecipeUpdateOk")
	@ResponseBody
	public ModelAndView updateSuccess(@ModelAttribute BoardShareRecipe boardShareRecipe,  BindingResult  errors,  HttpServletRequest request,  @RequestParam(value="irdntId")  List<Integer> irdntId, ModelMap map) throws Exception{
		System.out.println("수정의 시작");
		BoardShareRecipeValidator validator = new BoardShareRecipeValidator();
		validator.validate(boardShareRecipe, errors);
		
		if(errors.hasErrors()){//에러가 하나라도 있으면 실행
			System.out.println("ddddd");
			return  new ModelAndView("common/boardRecipe/boardRecipe_update.tiles");
		}
		System.out.println("발리데이터 넘어왔어");
		
			ModelAndView mav = new ModelAndView();
			//사진 
			
			String upImageDir = request.getServletContext().getRealPath("/up_Image");
			MultipartFile upImage = boardShareRecipe.getUpImage();
			
			String fileName = upImage.getOriginalFilename();
			
			if(upImage!=null&&!upImage.isEmpty()){
				boardShareRecipe.setOriginal(upImage.getOriginalFilename());
				String newImageName = UUID.randomUUID().toString();
				boardShareRecipe.setSaveName(newImageName);
				
				File dest = new File(upImageDir);
				
				//파일이동
				copyToEclipseDir(newImageName, upImage);
				//파일 이동시키기
				upImage.transferTo(dest);
				//저장
				boardShareRecipeService.updateBoardShareRecipe(boardShareRecipe);
			}
			map.addAttribute("boardShareRecipe", boardShareRecipe);
			
			Set<ShareRecipeIrdnt> irdntSet = new HashSet<>();
			List<String> shareRecipeIrdntNameList = new ArrayList<>();
			//게시물 재료 삭제
			irdntService.deleteShareRecipeIrdntByRecipeId(boardShareRecipe.getRecipeId());
			System.out.println(boardShareRecipe);
			for(int ir : irdntId){
				if(ir!=-1){
					irdntSet.add(new ShareRecipeIrdnt(boardShareRecipe.getRecipeId(), ir));
				}
			}
			List<ShareRecipeIrdnt> shareRecipeList	= new ArrayList<>();
			for(ShareRecipeIrdnt recipeShare : irdntSet){
				shareRecipeList.add(recipeShare);
				irdntService.insertShareRecipeIrdnt(recipeShare);
				shareRecipeIrdntNameList.add(manageService.findIrdntByIrdntId(recipeShare.getIrdntId()).getIrdntName());
			}

			if(shareRecipeIrdntNameList.size()==0){//등록된 기피재료가 하나도 없으면 //id default값 하나 등록되있음.
			shareRecipeIrdntNameList.add("등록된 기피재료가 없습니다");
		}
			//boardShareRecipe객체에 넣기
			boardShareRecipe.setShareRecipeIrdnt(shareRecipeList);
			

			//게시물 수정
			boardShareRecipeService.updateBoardShareRecipe(boardShareRecipe);
			
			
			//응답
			mav.addObject("boardShareRecipe",boardShareRecipe);
			mav.addObject("shareRecipeIrdntList", shareRecipeIrdntNameList);
			mav.setViewName("common/member/boardRecipe/boardRecipe_success.tiles");
			return mav;
	}

	//재료 삭제
	@RequestMapping("boardRecipe/boardRecipeIrdntDelete")
	@ResponseBody
	public ModelAndView boardRecipeIrdntDelete(@RequestParam int recipeId)
	{
		ModelAndView mav = new ModelAndView();
		
		irdntService.deleteShareRecipeIrdntByRecipeId(recipeId);
		
		BoardShareRecipe boardRecipe = boardShareRecipeService.selectBoardByShareIrdnt(recipeId);
		
		List<ShareRecipeIrdnt> list = irdntService.findShareRecipeIrdntByRecipeId(recipeId);
		System.out.println(list);
		mav.addObject("boardShareRecipe",boardRecipe);
		mav.addObject("list", list);
		mav.setViewName("common/boardRecipe/boardRecipe_update.tiles");
		//경로 이동
		return mav;
	}
	
	
	
	//이미지 삭제
	@RequestMapping("boardRecipe/boardRecipeImageDelete")
	@ResponseBody
	public ModelAndView boardRecipeImageDelete(@ModelAttribute BoardShareRecipe boardShareRecipe,
			BindingResult  errors	,@RequestParam int recipeId)
	{
		ModelAndView mav = new ModelAndView();
		
		boardShareRecipeService.updateImageNull(boardShareRecipe);
		
		BoardShareRecipe boardRecipe = boardShareRecipeService.selectBoardByShareIrdnt(recipeId);
		
		List<ShareRecipeIrdnt> list = irdntService.findShareRecipeIrdntByRecipeId(recipeId);
		System.out.println(list);
		mav.addObject("boardShareRecipe",boardRecipe);
		mav.addObject("list", list);
		mav.setViewName("common/boardRecipe/boardRecipe_update.tiles");
		//경로 이동
		return mav;
	}
	
	
	
	
	
	//게시글 삭제
	@RequestMapping("/common/boardRecipe/boardRecipeDelete")
	@ResponseBody
	public ModelAndView delete(@RequestParam int recipeId, @RequestParam String memberId,
			@RequestParam String writer, @RequestParam String adminId,
			@RequestParam(defaultValue="1") int page){
		ModelAndView mav = new ModelAndView();
		irdntService.deleteShareRecipeIrdntByRecipeId(recipeId);
		boardShareRecipeService.deleteRecommandService(recipeId);
		boardShareRecipeService.deleteBoardShareRecipe(recipeId);
		
		
		List<BoardShareRecipe> top = boardShareRecipeService.selectBoardTop4();
		Map<String, Object> map = boardShareRecipeService.selectBoardShareRecipeAll(page);
		
		mav.addObject("top", top);
		mav.addObject("list", map.get("list"));
		mav.addObject("recipeId", map.get("recipeId"));
		mav.setViewName("boardRecipe/boardRecipe_list.tiles");
		
		return mav;
	}
	
	//TOP4
	@RequestMapping("boardRecip/boardRecipeTop4")
	public ModelAndView selectBoardTop4(@RequestParam(defaultValue="1") int page){
		ModelAndView mav = new ModelAndView();
		
		Map<String, Object> map = boardShareRecipeService.selectBoardShareRecipeAll(page);
		
		List<BoardShareRecipe> boardTop = boardShareRecipeService.selectBoardTop4();
		
		mav.addObject("top", boardTop);
		mav.addObject("list", map.get("list"));
		mav.addObject("pageBean", map.get("pageBean"));
		
		mav.setViewName("boardRecipe/boardRecipe_list.tiles");
		return mav;
	}
	
	//추천수 +1 추가 
	@RequestMapping("/common/boardRecipe/increaseRecommand")
	@ResponseBody
	public ModelAndView recommandByTwoId(@RequestParam int recipeId, @RequestParam String memberId ) throws Exception{
		ModelAndView mav = new ModelAndView();
	
				boardShareRecipeService.updateBoardRecommand(recipeId);
				boardShareRecipeService.insertRecommandServie(new MemberRecipeRecommand(0, recipeId, memberId));
			
		
		
		mav.setViewName("boardRecipe/boardRecipe_list.tiles");
		return mav;
	}
	
/*	@RequestMapping("/common/boareRecipe/recommand")
	@ResponseBody
	public ModelAndView recommand( @RequestParam(value="recipeId") int recipeId, @RequestParam String memberId) throws OverLapException, FindMemberFailException{
		ModelAndView mav = new ModelAndView();
		System.out.println("3차");
		 BoardShareRecipe boardShareRecipe = (BoardShareRecipe) boardShareRecipeService.boardRead(recipeId);
		 boardShareRecipe = boardShareRecipeService.selectBoardByShareIrdnt(recipeId);
//		MemberRecipeRecommand recommand = boardShareRecipeService.selectRecommandService(recipeId, memberId);
		
		 System.out.println("4차");
//		mav.addObject(recommand);//sessionScope.recommand
		mav.addObject("top", boardShareRecipe);//중복검사?
		mav.addObject("list", boardShareRecipe);
		mav.setViewName("boardRecipe/boardRecipe_list.tiles");
		return mav;
	}*/
	
	//제목 조회
	@RequestMapping("/boardRecipe/boardSearchByTitle")
	@ResponseBody
	public ModelAndView boardSearchByTitle(@RequestParam(defaultValue="1") int page, @RequestParam String title){
		ModelAndView mav = new ModelAndView();
		
		Map<String, Object> map = boardShareRecipeService.boardSearchByTitle(page, title);
		
		mav.addObject("list", map.get("list"));
		mav.addObject("totalCount", map.get("totalCount"));
		mav.addObject("title",map.get( title));
		mav.addObject("pageBean", map.get("pageBean"));
		mav.setViewName("boardRecipe/boardRecipe_list_byTitle.tiles");
		return mav;
	}
	
	//아이디조회
	@RequestMapping("/boardRecipe/boardSearchByMemberId")
	@ResponseBody
	public ModelAndView boardSearchByMemberId(@ModelAttribute BoardShareRecipe boardShareRecipe ,@RequestParam(defaultValue="1") int page, @RequestParam String memberId){
		ModelAndView mav = new ModelAndView();
		
		Map<String, Object> map = boardShareRecipeService.boardSearchByMemberId(page, memberId);
		
		map = boardShareRecipeService.selectBoardShareRecipeAll(page);
		
		List<BoardShareRecipe> boardTop = boardShareRecipeService.selectBoardTop4();
		
		mav.addObject("top", boardTop);
//		mav.addObject("list", map.get("list"));
//		mav.addObject("pageBean", map.get("pageBean"));
//		
//		mav.setViewName("boardRecipe/boardRecipe_list.tiles");
		
		
		
		mav.addObject("list", map.get("list"));
		mav.addObject("totalCount", map.get("totalCount"));
		mav.addObject("memberId", map.get(memberId));
		mav.addObject("pageBean", map.get("pageBean"));
		mav.setViewName("boardRecipe/boardRecipe_list_byMemberId.tiles");
		return mav;
	}
	
	//내용조회
		@RequestMapping("/boardRecipe/boardSearchByTxt")
		@ResponseBody
		public ModelAndView boardSearchByTxt(@RequestParam(defaultValue="1") int page, @RequestParam String txt){
			ModelAndView mav = new ModelAndView();
			
			Map<String, Object> map = boardShareRecipeService.boardSearchByTxt(page, txt);
			
			mav.addObject("list", map.get("list"));
			mav.addObject("totalCount", map.get("totalCount"));
			mav.addObject("txt", map.get(txt));
			mav.addObject("pageBean", map.get("pageBean"));
			mav.setViewName("boardRecipe/boardRecipe_list_byTxt.tiles");
			return mav;
		}
	
	//선택 검색 
	@RequestMapping("/boardRecipe/selectSearch")
	@ResponseBody
	public ModelAndView selectSearch(@RequestParam(defaultValue="1") int page, @RequestParam String keyword, @RequestParam String searchOption){
		ModelAndView mav = new ModelAndView();
		Map<String, Object> map = new HashMap<>();
		System.out.println(keyword);
		String id = "아이디";
		String title = "제목";
		String txt = "내용";
		
		//제목 검색
		if(searchOption.equals(title)){
			System.out.println(searchOption+title+"123");
			 map = boardShareRecipeService.boardSearchByTitle(page, keyword);
			System.out.println(title);
			mav.addObject("list", map.get("list"));
			mav.addObject("totalCount", map.get("totalCount"));
			mav.addObject("pageBean", map.get("pageBean"));
			mav.setViewName("boardRecipe/boardRecipe_list.do");
			return mav;
			
			//내용 검색
			}else if(searchOption.equals(txt)){
			
			 map = boardShareRecipeService.boardSearchByTxt(page, keyword);
		
			mav.addObject("list", map.get("list"));
			mav.addObject("totalCount", map.get("totalCount"));
			mav.addObject("pageBean", map.get("pageBean"));
			mav.setViewName("boardRecipe/boardRecipe_list.tiles");
			return mav;
			
			//memberId로 검색
			}else if(searchOption.equals(id)){
				map = boardShareRecipeService.boardSearchByMemberId(page, keyword);
				mav.addObject("list", map.get("list"));
				mav.addObject("totalCount", map.get("totalCount"));
				mav.addObject("pageBean", map.get("pageBean"));
				mav.setViewName("boardRecipe/boardRecipe_list.tiles");
				return mav;
			}
		map = boardShareRecipeService.selectBoardShareRecipeAll(page);
		mav.addObject("list", map.get("list"));
		mav.addObject("totalCount", map.get("totalCount"));
		mav.addObject("pageBean", map.get("pageBean"));
		mav.setViewName("boardRecipe/boardRecipe_list.tiles");
		return mav;
	}
/*	@RequestMapping("")
	@Response
	public ModelAndView 
	*/
}
	
	
	
	
	
	

