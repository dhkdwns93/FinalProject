package kr.co.turnup_fridger.controller.member;

import java.util.Date;
import java.util.List;

import javax.validation.Valid;

import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.context.SecurityContext;
import org.springframework.security.core.context.SecurityContextHolder;
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
import kr.co.turnup_fridger.vo.Authority;
import kr.co.turnup_fridger.vo.Fridger;
import kr.co.turnup_fridger.vo.FridgerGroup;
import kr.co.turnup_fridger.vo.JoinProcess;

@Controller
@RequestMapping("/common/member/fridger/")
public class FridgerController {

	@Autowired
	private FridgerService fridgerService;
	@Autowired
	private FridgerGroupService fridgerGroupService; 
	@Autowired
	private JoinProcessService joinProcessService;
	
	List list;
	Fridger fridger;
	FridgerGroup fridgerGroup;
	JoinProcess joinProcess;
	// 0) 권한 ID 체크(지금 로그인한 회원)
	
	
	
	
	
	//냉장고 생성 handler (우선 시큐리티 제외, 맵퍼에 주석처리하고 해야함)
	@RequestMapping("register")
	public ModelAndView registerFridger(@ModelAttribute("fridger") @Valid FridgerForm fridgerForm, BindingResult errors ) {
		// 요청 파라미터 검증 끝
		if(errors.hasErrors()){
			return new ModelAndView("common/member/fridger/register_form");
		}
		
		// 비즈니스 로직 처리
		Authority authority = (Authority)SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		// 1) 냉장고 생성
		fridger = new Fridger();
		BeanUtils.copyProperties(fridgerForm, fridger);
		fridger.setMemberId(authority.getLoginId());
		System.out.println("냉장고 등록 로그:"+fridger);	//log
		
		try {
			// 2) 냉장고 DB에 저장(서비스단에서 냉장고 그룹생성 과정 처리)
			fridgerService.createFridger(fridger);

		} catch (DuplicatedFridgerException e) {	//냉장고 이름중복되면 예외발생
			return new ModelAndView("common/member/fridger/register_form", "errorMsg", e.getMessage());
		}
		
		return new ModelAndView("redirect:register/success.do", "fridgerId", fridger.getFridgerId());
	}
	
	@RequestMapping("register/success")
	public ModelAndView registerSuccess(@RequestParam int fridgerId ) throws Exception{
		fridger = fridgerService.findFridgerByFridgerId(fridgerId);

		return new ModelAndView("common/member/fridger/register_success", "fridger", fridger);

	}
	
	
	@RequestMapping(value="request",produces="text/html;charset=UTF-8")
	@ResponseBody
	public String requestFridgerGroup(@RequestParam int fridgerId){
		
		Authority authority = (Authority)SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		fridger = fridgerService.findFridgerByFridgerId(fridgerId);
		System.out.println(fridger);	//log
		
		joinProcess = new JoinProcess(0, fridger.getFridgerId(), 10, new Date(), authority.getLoginId(), fridger.getMemberId());
		
		try {
			joinProcessService.requestJoinFridgerGroup(joinProcess);
		} catch (Exception e) {
			return e.getMessage();
		}

		return "가입신청을 완료했습니다.";
	}
	
	
	@RequestMapping(value="invite",produces="text/html;charset=UTF-8")
	@ResponseBody
	public String inviteFridgerGroup(@RequestParam int fridgerId, @RequestParam String respMemberId){
		
		fridger = fridgerService.findFridgerByFridgerId(fridgerId);
		System.out.println("초대로그:"+fridger);	//log
		
		joinProcess = new JoinProcess(0, fridger.getFridgerId(), 20, new Date(), fridger.getMemberId(), respMemberId);
		
		try {
			joinProcessService.inviteJoinFridgerGroup(joinProcess);
		} catch (Exception e) {
			return e.getMessage();
		}

		return "초대요청을 완료했습니다.";
	}
	
	@RequestMapping("joinProcess/show/list/requst")
	@ResponseBody
	public List<JoinProcess> getJoinProcessRequestList(String reqMemberId){
		list = joinProcessService.findJoinProcessByRequestMemberId(reqMemberId);
		return list;
	}
	
	@RequestMapping("joinProcess/show/list/invite")
	@ResponseBody
	public List<JoinProcess> getJoinProcessList(String respMemberId){
		list = joinProcessService.findJoinProcessByResponseMemberId(respMemberId);
		return list;
	}
	
	// 모든 리스트 뿌려주는 handler
	@RequestMapping("show/list")
	@ResponseBody
	public List<Fridger> getFridgerList(){
		list = fridgerService.findFridgerAll();
		return list;
	}
	
	// 냉장고Id로 찾아서 뿌려주는 handler
	@RequestMapping("show/byId")
	@ResponseBody
	public Fridger getFridgerById(int fridgerId){
		fridger = fridgerService.findFridgerByFridgerId(fridgerId);
		return fridger;
	}
	
	// 이름으로 찾아 뿌려주는 handler
	@RequestMapping("show/byName")
	@ResponseBody
	public List<Fridger> getFridgerByName(String fridgerName){
		list = fridgerService.findFridgerByFridgerName(fridgerName);
		return list;
	}
	
	
	//냉장고 주인 회원ID으로 찾는 handler
	@RequestMapping("show/byOwner")
	@ResponseBody
	public List<Fridger> getFridgerByOwner(String memberId){
		System.out.println(memberId);
		list = fridgerService.findFridgerByOwner(memberId);
		return list;
	}
	
	//로그인 된 회원의 냉장고 찾는 handler
		@RequestMapping("show/mine" )
		@ResponseBody
		public List<Fridger> getFridgerMine(){
			Authority authority = (Authority)SecurityContextHolder.getContext().getAuthentication().getPrincipal();
			list = fridgerService.findFridgerByOwner(authority.getLoginId());
			System.out.println(list);
			return list;
		}
	
	
	//선택한 냉장고 현황 보여주는 handler
	@RequestMapping("show/detail")
	@ResponseBody
	public List<FridgerGroup> getFriderInDetail(int fridgerId){
		list = fridgerService.findFridgerAndFridgerGroupByFridgerId(fridgerId).getFridgerGroupList();
		
		/*로그*/
		for(Object f : list){
			System.out.println(f);
		}
		return list;
	}

	
	
	
}
