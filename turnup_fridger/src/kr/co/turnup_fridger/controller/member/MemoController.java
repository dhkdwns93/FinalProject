package kr.co.turnup_fridger.controller.member;

import java.util.List;

import javax.validation.Valid;

import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.validation.Errors;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import kr.co.turnup_fridger.service.MyMemoService;
import kr.co.turnup_fridger.validation.form.MyMemoForm;
import kr.co.turnup_fridger.vo.MyMemo;

@Controller
@RequestMapping("/memo/")
public class MemoController {

	@Autowired
	private MyMemoService service;
	
	// 메모등록
	@RequestMapping(value="addMemo", method=RequestMethod.POST) // ajax사용시 produces해줘야 한글 깨지지않음!
	public ModelAndView addMemo(@ModelAttribute("myMemo") @Valid MyMemoForm memoForm, Errors err){
		System.out.println("== memo add ===");
		if(err.hasErrors()){
			return new ModelAndView("common/member/memo/memo_register_form");
		}
		
		MyMemo m = new MyMemo();
		BeanUtils.copyProperties(memoForm, m);
		try {
			service.insertMemo(m);
		} catch (Exception e) {
			return new ModelAndView("common/member/memo/memo_register_form", "error", e.getMessage());
		}
		System.out.println("=== memo add!! ===");
		return new ModelAndView("common/member/memo/memoList");
	}
	// 메모삭제
	@RequestMapping(value="delMemo")
	public ModelAndView removeMemo(@RequestParam int memoId){
			try {
				service.deleteMemo(memoId);
			} catch (Exception e) {
				return new ModelAndView("common/member/memo/memoDetail", "error", e.getMessage());
			}
			return new ModelAndView("common/member/memo/memoList");
	}
	// 메모수정
	@RequestMapping(value="modMemo")
	public ModelAndView modMemo(String memoName, String memoTxt){
		System.out.println("======= 메모수정 =======");
		MyMemo memo = new MyMemo();
		memo.setMemoName(memoName);
		memo.setmemoTxt(memoTxt);
		try {
			service.updateMemo(memo);
		} catch (Exception e) {
			return  new ModelAndView("common/member/memo/memo_update_form", "error", e.getMessage());
		}
		return new ModelAndView("common/member/memo/memoList");
	}
	
	// 내가 쓴 메모목록
	@RequestMapping(value="memoList", produces="application/json;charset=UTF-8")
	@ResponseBody
	public List<MyMemo> selectMemoByMember(String memberId){
		System.out.println("======= MemoList =======");
		System.out.println(service.selectMemoList(memberId));
		return service.selectMemoList(memberId);
	}
	
	// 메모하나 상세보기
	@RequestMapping("findOneMemo")
	public ModelAndView selectOneMemo(String memId){
		int memoId = Integer.parseInt(memId);
		MyMemo mm = service.selectOneMemo(memoId);
		return new ModelAndView("common/member/memo/memoDetail", "memo", mm);
	}
	
	// 내가 쓴 메모개수
	@RequestMapping(value="/findMemoCount")
	@ResponseBody
	public int selectMemoCount(String memberId){
		
		return service.selectMemoCount(memberId);
	}
	

}
