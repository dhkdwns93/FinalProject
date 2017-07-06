package kr.co.turnup_fridger.controller.member;

import java.util.Date;
import java.util.List;

import javax.validation.Valid;

import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import kr.co.turnup_fridger.exception.DuplicatedFridgerException;
import kr.co.turnup_fridger.exception.FindFridgerFailException;
import kr.co.turnup_fridger.exception.FindMemberFailException;
import kr.co.turnup_fridger.service.FridgerGroupService;
import kr.co.turnup_fridger.service.FridgerService;
import kr.co.turnup_fridger.service.JoinProcessService;
import kr.co.turnup_fridger.validation.form.FridgerForm;
import kr.co.turnup_fridger.validation.form.JoinProcessForm;
import kr.co.turnup_fridger.vo.Fridger;
import kr.co.turnup_fridger.vo.FridgerGroup;
import kr.co.turnup_fridger.vo.JoinProcess;
import kr.co.turnup_fridger.vo.Member;

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

	
	
	
	
	
	//냉장고 생성 handler 
	@RequestMapping("register")
	public ModelAndView registerFridger(@ModelAttribute("fridger") @Valid FridgerForm fridgerForm, BindingResult errors ) {
		System.out.println(fridgerForm);//log
		// 요청 파라미터 검증 끝
		if(errors.hasErrors()){
			return new ModelAndView("common/member/fridger/register_form");
		}
		
		// 비즈니스 로직 처리
		// 0) 권한 ID 체크(지금 로그인한 회원)
		Member member = (Member)SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		// 1) 빈 냉장고 생성해서  검증된 fridgerForm 넣기
		fridger = new Fridger();
		BeanUtils.copyProperties(fridgerForm, fridger);
		fridger.setMemberId(member.getMemberId());
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
	

	// 냉장고 정보 갱신 페이지 연결 handler(요청하는 사람과 실제 냉장고 주인 첵)
	@RequestMapping(value="update_chk", produces="text/html;charset=UTF-8")
	public ModelAndView moveToUpdateForm(@RequestParam int fridgerId) throws Exception{
		// 0) 권한 ID 체크(지금 로그인한 회원)
		Member member = (Member)SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		fridger = fridgerService.findFridgerByFridgerId(fridgerId);
		// 수정 요청한 ID 실제 냉장고 주인ID가 다르면 예외
		if(!member.getMemberId().equals(fridger.getMemberId())){
			return new ModelAndView();
		}
		System.out.println("체크하고 jsp로");
		return new ModelAndView("common/member/fridger/update_form", "fridger", fridger );
	}
	
	// 냉장고 정보 갱신 handler(주인 바꾸기, 이름바꾸기)
	@RequestMapping("update")
	public ModelAndView updateFridger(@ModelAttribute("fridger") @Valid FridgerForm fridgerForm, BindingResult errors ) {
		// 요청 파라미터 검증 끝
		System.out.println("넘어오나 우선 보자");
		fridger = new Fridger();
		if(errors.hasErrors()){
			fridger.setResultCode("FAIL");
			return new ModelAndView("common/member/fridger/update_form");
		}
		
		BeanUtils.copyProperties(fridgerForm, fridger);
		fridger.setResultCode("SUCCESS");
		System.out.println("냉장고 수정 로그:"+fridger);	//log
		
	
			try {
				fridgerService.updateFridger(fridger);
			} catch (FindFridgerFailException e) {
				e.printStackTrace();
				fridger.setResultCode("FAIL");
				return new ModelAndView("common/member/fridger/update_form", "errorMsg_fridgerId", e.getMessage());
			} catch (DuplicatedFridgerException e) {
				e.printStackTrace();
				fridger.setResultCode("FAIL");
				return new ModelAndView("common/member/fridger/update_form", "errorMsg_fridgerName",e.getMessage());
			} catch (FindMemberFailException e) {
				e.printStackTrace();//log
				fridger.setResultCode("FAIL");
				return new ModelAndView("common/member/fridger/update_form", "errorMsg_memberId", e.getMessage());
			}
		
	return new ModelAndView("redirect:update/success.do", "fridgerId", fridger.getFridgerId());
	}
	
	@RequestMapping("update/success")
	public ModelAndView updateSuccess(@RequestParam int fridgerId ) throws Exception{
		fridger = fridgerService.findFridgerByFridgerId(fridgerId);
		return new ModelAndView("common/member/fridger/update_success", "fridger", fridger);
	}
	
	
	
	@RequestMapping(value="request",produces="text/html;charset=UTF-8")
	@ResponseBody
	public String requestFridgerGroup(@ModelAttribute("joinProcess") @Valid JoinProcessForm joinProcessForm, BindingResult errors){
		// 요청 파라미터 검증 끝
				if(errors.hasErrors()){
					return errors.getObjectName()+"에서 오류 발생";
				}
		// 0) 권한 ID 체크(지금 로그인한 회원)
		Member member = (Member)SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		// 1) 빈 냉장고 생성 해서 검증된 joinProess 넣기
		joinProcess = new JoinProcess();
		BeanUtils.copyProperties(joinProcessForm, joinProcess);
		joinProcess.setReqMemberId(member.getMemberId());
		joinProcess.setReqDate(new Date());
		System.out.println("냉장고 그룹 가입로그:"+joinProcess);	//log
		
		try {
			joinProcessService.requestJoinFridgerGroup(joinProcess);
		} catch (Exception e) {
			return e.getMessage();
		}

		return "가입신청을 완료했습니다.";
	}
	
	
	@RequestMapping(value="invite",produces="text/html;charset=UTF-8")
	@ResponseBody
	public ModelAndView inviteFridgerGroup(@ModelAttribute("joinProcess") @Valid JoinProcessForm joinProcessForm, BindingResult errors){
		// 요청 파라미터 검증 끝
		if(errors.hasErrors()){
			return new ModelAndView("common/member/fridger/update_form");
		}
	
		// 0) 권한 ID 체크(지금 로그인한 회원)
		Member member = (Member)SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		// 1) 빈 냉장고 생성 해서 검증된 joinProess 넣기
		joinProcess = new JoinProcess();
		BeanUtils.copyProperties(joinProcessForm, joinProcess);
		joinProcess.setReqMemberId(member.getMemberId());
		joinProcess.setReqDate(new Date());
		System.out.println("냉장고그룹 초대 로그:"+joinProcess);	//log
		
		try {
			joinProcessService.inviteJoinFridgerGroup(joinProcess);
		} catch (Exception e) {
			return new ModelAndView("common/member/fridger/invite_form", "errorMsg", e.getMessage());
		}

		return new ModelAndView("redirect:invite/success.do", "processNo", joinProcess.getProcessNo());
	}
	
	@RequestMapping("invite/success")
	public ModelAndView inviteSuccess(@RequestParam int processNo){
		joinProcess = joinProcessService.findJoinProcessByProcessNo(processNo);

		return new ModelAndView("common/member/fridger/invite_success", "joinProcess", joinProcess);
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
			Member member = (Member)SecurityContextHolder.getContext().getAuthentication().getPrincipal();
			list = fridgerService.findFridgerByOwner(member.getMemberId());
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
