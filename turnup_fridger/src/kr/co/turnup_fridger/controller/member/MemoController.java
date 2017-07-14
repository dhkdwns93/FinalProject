package kr.co.turnup_fridger.controller.member;

import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.View;
import org.springframework.web.servlet.view.InternalResourceView;

import kr.co.turnup_fridger.service.MyMemoService;
import kr.co.turnup_fridger.validation.MemoValidator;
import kr.co.turnup_fridger.vo.MyMemo;

@Controller
@RequestMapping("/memo/")
public class MemoController {

	@Autowired
	private MyMemoService service;
	
	// 지도 팝업 띄우는 핸들러(no-tiles)
	@RequestMapping("map")
	public ModelAndView map(){
		View view = new InternalResourceView("/WEB-INF/view/content/map.jsp");
		return new ModelAndView(view);
	}
	
	// 메모작성팝업 띄우는 핸들러(no-tiles)
	@RequestMapping("memoPopup")
	public ModelAndView memoPopup(){
		View view = new InternalResourceView("/WEB-INF/view/content/common/member/memo/memo_register_form.jsp");
		return new ModelAndView(view);
	}
	
	// 메모상세 팝업 띄우는 핸들러(no-tiles)
	@RequestMapping("memoDetailPopup")
	public ModelAndView memoDetailPopup(String memoId){
		int memId = Integer.parseInt(memoId);
		MyMemo mm = service.selectOneMemo(memId);
		View view = new InternalResourceView("/WEB-INF/view/content/common/member/memo/memoDetail.jsp");
		return new ModelAndView(view, "memo", mm);
	}
	
	// 메모등록 - O
	@RequestMapping(value="addMemo", method=RequestMethod.POST) 
	public ModelAndView addMemo(@ModelAttribute MyMemo mm, BindingResult err) {
		MemoValidator val = new MemoValidator();
		val.validate(mm, err);
		mm.setRegisteredDate(new Date());
		if(err.hasErrors()){
			return new ModelAndView("/common/member/memo/memo_register_form", "error", err);
		}
		
		try {
			service.insertMemo(mm);
		} catch (Exception e) {
			return new ModelAndView("/common/member/memo/memo_register_form", "error", e.getMessage());
		}
		
		return new ModelAndView("redirect:/common/member/memo/memoDetail.do", "memo", mm);
	}
	
	// 메모삭제 O
	@RequestMapping(value="delMemo", produces="html/text;charset=UTF-8;")
	@ResponseBody
	public String removeMemo(@RequestParam String memoId){
		int memId = Integer.parseInt(memoId);
			try {
				service.deleteMemo(memId);
			} catch (Exception e) {
				return e.getMessage();
			}
			return "삭제되었습니다";
	}
	
	// 메모수정 - O
	@RequestMapping(value="modMemo")
	@ResponseBody
	public MyMemo modMemo(String memoId, String memoName, String memoTxt){
		int memId = Integer.parseInt(memoId);
		MyMemo memo = service.selectOneMemo(memId);
		memo.setMemoName(memoName);
		memo.setmemoTxt(memoTxt);
	
		try {
			service.updateMemo(memo);
		} catch (Exception e) {
			
		}
		return memo;
	}
	
	// 내가 쓴 메모목록 - O 					 ajax사용시 produces해줘야 한글 깨지지않음!
/*	@RequestMapping(value="memoList")
	@ResponseBody
	public List<MyMemo> selectMemoByMember(String memberId){
		return service.selectMemoList(memberId);
	}*/
	
	@RequestMapping("memoList")
	public ModelAndView selectMemoByMember(String memberId){
		List<MyMemo>list = service.selectMemoList(memberId);
		return new ModelAndView("common/member/memo/memoList.tiles", "list", list);
		
	}
	
	// 메모하나 상세보기 - O
	@RequestMapping("findOneMemo")
	public ModelAndView selectOneMemo(String memoId){
		int memId = Integer.parseInt(memoId);
		MyMemo mm = service.selectOneMemo(memId);
		return new ModelAndView("common/member/memo/memoDetail.jsp", "memo", mm);
	}
	
	// 내가 쓴 메모개수 - O
	@RequestMapping(value="findMemoCount")
	@ResponseBody
	public int selectMemoCount(String memberId){
		return service.selectMemoCount(memberId);
	}
}
