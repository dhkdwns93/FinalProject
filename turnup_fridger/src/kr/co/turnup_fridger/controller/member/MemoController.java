package kr.co.turnup_fridger.controller.member;

import java.util.List;

import javax.validation.Valid;

import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.validation.Errors;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.co.turnup_fridger.service.MyMemoService;
import kr.co.turnup_fridger.validation.form.MyMemoForm;
import kr.co.turnup_fridger.vo.MyMemo;

@Controller
@RequestMapping("/memo/")
public class MemoController {

	@Autowired
	private MyMemoService service;
	
	@RequestMapping(value="addMemo", produces="text/html;charset=UTF-8") // ajax사용시 produces해줘야 한글 깨지지않음!
	public String addMemo(@ModelAttribute("MyMemo") @Valid MyMemoForm memoForm, Errors err){
		
		if(err.hasErrors()){
			return "등록실패";
		}
		
		MyMemo m = new MyMemo();
		BeanUtils.copyProperties(memoForm, m);
		try {
			service.insertMemo(m);
		} catch (Exception e) {
			return e.getMessage();
		}
		return "등록완료";
	}
	
	@RequestMapping(value="delMemo", produces="text/html;charset=UTF-8")
	@ResponseBody
	public String removeMemo(int memoId, Errors err){
		if(err.hasErrors()){
			return "삭제실패";
		}
			try {
				service.deleteMemo(memoId);
			} catch (Exception e) {
				return "error!";
			}
			return "삭제 완료";
	}
	
	@RequestMapping(value="modMemo", produces="text/html;charset=UTF-8")
	public String modMemo(MyMemo memo){
		try {
			service.updateMemo(memo);
		} catch (Exception e) {
			return "error!";
		}
		return "수정 완료";
	}
	
	// 내가 쓴 메모목록
	@RequestMapping(value="memoList", produces="text/html;charset=UTF-8")
	@ResponseBody
	public List<MyMemo> selectMemoByMember(String memberId){
/*		List<MyMemo> list = service.selectMemoList("shh");
		for(MyMemo m : list){
			System.out.println(m);
		}*/
		return service.selectMemoList(memberId);
	}
	
	// 메모하나 상세보기
	@RequestMapping(value="/findOneMemo", produces="text/html;charset=UTF-8")
	@ResponseBody
	public MyMemo selectOneMemo(int memoId){
		
		return service.selectOneMemo(memoId);
	}
	
	// 내가 쓴 메모개수
	@RequestMapping(value="/findMemoCount", produces="text/html;charset=UTF-8")
	@ResponseBody
	public int selectMemoCount(String memberId){
		
		return service.selectMemoCount(memberId);
	}
	

}
