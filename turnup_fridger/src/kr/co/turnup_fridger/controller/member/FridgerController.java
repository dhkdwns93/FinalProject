package kr.co.turnup_fridger.controller.member;

import java.util.Date;
import java.util.List;

import javax.validation.Valid;

import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import kr.co.turnup_fridger.exception.DuplicatedFridgerException;
import kr.co.turnup_fridger.service.FridgerGroupService;
import kr.co.turnup_fridger.service.FridgerService;
import kr.co.turnup_fridger.service.JoinProcessService;
import kr.co.turnup_fridger.validation.form.FridgerForm;
import kr.co.turnup_fridger.vo.Fridger;
import kr.co.turnup_fridger.vo.FridgerGroup;
import kr.co.turnup_fridger.vo.JoinProcess;

@Controller
//@RequestMapping("/common/member/fridger/")
@RequestMapping("/fridger/")
public class FridgerController {

	@Autowired
	private FridgerService fService;
	@Autowired
	private FridgerGroupService fgService; 
	@Autowired
	private JoinProcessService jpService;
	
	List list;
	Fridger fridger;
	FridgerGroup fridgerGroup;
	JoinProcess joinProcess;
	
	
	//냉장고 생성 handler (우선 시큐리티 제외, 맵퍼에 주석처리하고 해야함)
	@RequestMapping("register")
	public ModelAndView registerFridger(@ModelAttribute("fridger") @Valid FridgerForm fridgerForm, BindingResult errors ) {
		// 요청 파라미터 검증 끝
		
		if(errors.hasErrors()){
			return new ModelAndView("fridger/register_form");
		}
		
		// 비즈니스 로직 처리
		// 1) 냉장고 생성
		fridger = new Fridger();
		System.out.println(fridger);
		BeanUtils.copyProperties(fridgerForm, fridger);
		
		try {
			fService.createFridger(fridger);
		} catch (DuplicatedFridgerException e) {
//			return new ModelAndView("common/member/fridger/register_form", "errorMsg", e.getMessage());
			return new ModelAndView("fridger/register_form", "errorMsg", e.getMessage());
		}
		
//		return new ModelAndView("redirect:common/member/fridger/register/success.do", "fridgerId", fridger.getFridgerId());
		return new ModelAndView("redirect:register/success.do", "fridgerId", fridger.getFridgerId());
	}
	
	@RequestMapping("register/success")
	public ModelAndView registerSuccess(@RequestParam int fridgerId ) throws Exception{
		fridger = fService.findFridgerByFridgerId(fridgerId);
//		return new ModelAndView("common/member/fridger/register_success", "fridger", fridger);
		return new ModelAndView("fridger/register_success", "fridger", fridger);
	}
	
	
	@RequestMapping(value="join",produces="text/html;charset=UTF-8")
	@ResponseBody
	public String requestJoinFridger(@RequestParam int fridgerId, @RequestParam String reqMemberId){
		
		
		fridger = fService.findFridgerByFridgerId(fridgerId);
//		System.out.println(fridger);	//log
		joinProcess = new JoinProcess(0, fridger.getFridgerId(), 10, new Date(), reqMemberId, fridger.getMemberId());
	
			try {
				jpService.requestJoinFridgerGroup(joinProcess);
			} catch (Exception e) {
				return e.getMessage();
			}

		return "가입신청을 완료했습니다.";
	}
	
	
	
	
	// 모든 리스트 뿌려주는 handler
	@RequestMapping("show/list")
	@ResponseBody
	public List<Fridger> getFridgerListAll(){
		list = fService.findFridgerAll();
		return list;
	}
	
	// 냉장고Id로 찾아서 뿌려주는 handler
	@RequestMapping("show/byId")
	@ResponseBody
	public Fridger getFridgerById(int fridgerId){
		fridger = fService.findFridgerByFridgerId(fridgerId);
		return fridger;
	}
	
	// 이름으로 찾아 뿌려주는 handler
	@RequestMapping("show/byName")
	@ResponseBody
	public List<Fridger> getFridgerByName(String fridgerName){
		list = fService.findFridgerByFridgerName(fridgerName);
		return list;
	}
	
	
	//냉장고 주인 회원으로 찾는 handler
	@RequestMapping("show/byOwner")
	@ResponseBody
	public List<Fridger> getFridgerByOwner(String memberId){
		list = fService.findFridgerByOwner(memberId);
		return list;
	}
	
	
	//선택한 냉장고 현황 보여주는 handler
	@RequestMapping("show/detail")
	@ResponseBody
	public List<FridgerGroup> getFriderInDetail(int fridgerId){
		list = fService.findFridgerAndFridgerGroupByFridgerId(fridgerId).getFridgerGroupList();
		
		/*로그*/
		for(Object f : list){
			System.out.println(f);
		}
		return list;
	}

	
	
	
}
