/**
 (Controller)UserManageController
작성자 :  김경혜
최초 작성일 170703
변경이력
170708 기피재료추가 처리 
*/
package kr.co.turnup_fridger.controller.common;

import java.util.ArrayList;
import java.util.HashSet;
import java.util.List;
import java.util.Set;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.co.turnup_fridger.service.AuthorityService;
import kr.co.turnup_fridger.service.IrdntManageService;
import kr.co.turnup_fridger.service.MemberService;
import kr.co.turnup_fridger.service.MyDislikeIrdntService;
import kr.co.turnup_fridger.validation.MemberJoinValidator;
import kr.co.turnup_fridger.vo.Member;
import kr.co.turnup_fridger.vo.MyDislikeIrdnt;

/**
 * 인증이 필요없는 작업처리 -사용자 관리
 */
@Controller
public class UserManageController {
	
	@Autowired
	private MemberService memberService;
	
	@Autowired
	private MyDislikeIrdntService myDislikeIrdntService;
	
	@Autowired
	private IrdntManageService irdntManageService;
	
	@Autowired
	private AuthorityService authorityService;
	
	/**
	 * 회원 등록
	 * 처리후 join_member_success.do를 이용해 응답처리 -redirect방식 이동
	 * 요청파라미터 : memberId
	 * @param member
	 * @return
	 * @throws Exception 
	 */
	@RequestMapping("/join_member")
	public String signUpMember(@ModelAttribute Member member, @RequestParam List<Integer> myDislikeIrdntId, ModelMap map, BindingResult errors) throws Exception{
		//1.요청파라미터 조회+검증
		MemberJoinValidator validator=new MemberJoinValidator();
		validator.validate(member, errors);
		if(errors.hasErrors()){//errors에 오류가 1개라도 등록되있으면 다시 form으로 돌아가
			//return new ModelAndView("user/join_member_form","member",member);
			//System.out.println(errors);
			return "user/join_member_form";
		}
		
		//2.BusinessLogic
		memberService.signUpMember(member);
		Set<MyDislikeIrdnt> myDislikeIrdntSet=new HashSet<>();//중복으로 등록신청할경우 하나만 넘어옴.
		List<String> myDislikeIrdntNameList=new ArrayList<>();
		for(int irdntId:myDislikeIrdntId){
			if(irdntId!=-1){
				myDislikeIrdntSet.add(new MyDislikeIrdnt(member.getMemberId(),irdntId));
				//myDislikeIrdntService.createMyDislikeIrdnt(new MyDislikeIrdnt(member.getMemberId(),irdntId));
				//myDislikeIrdntNameList.add(irdntManageService.findIrdntByIrdntId(irdntId).getIrdntName());		
			}
		}
//		System.out.println(myDislikeIrdntSet);
		List<MyDislikeIrdnt> myDislikeIrdntList=new ArrayList<>();
		for(MyDislikeIrdnt nonDuplicateIrdnt:myDislikeIrdntSet){
			myDislikeIrdntList.add(nonDuplicateIrdnt);
			myDislikeIrdntService.createMyDislikeIrdnt(nonDuplicateIrdnt);
			myDislikeIrdntNameList.add(irdntManageService.findIrdntByIrdntId(nonDuplicateIrdnt.getIrdntId()).getIrdntName());
		}
		
		if(myDislikeIrdntNameList.size()==0){//등록된 기피재료가 하나도 없으면 //id default값 하나 등록되있음.
			myDislikeIrdntNameList.add("등록된 기피재료가 없습니다");
		}
		member.setMyDislikeIrdntList(myDislikeIrdntList);//member객체에 set
		
		//3.응답
		map.addAttribute("memberId",member.getMemberId());
		map.addAttribute("myDislikeIrdntNameList", myDislikeIrdntNameList);
		//return new ModelAndView("redirect:/join_member_success.do","memberId",member.getMemberId());
		return "redirect:/join_member_success.do";
	}
	
	@RequestMapping("/send_find_IdPw_email")
	public String sendEmail(@RequestParam String inputName, @RequestParam String inputEmail){
		
		
		return "redirect:/popup_find_IdPw_form.do";
	}
	
	@RequestMapping("/join_member_success")
	public String signUpSuccessMember(@RequestParam String memberId,@RequestParam List<String> myDislikeIrdntNameList,ModelMap map){
		Member member=memberService.inquiryMemberInfo(memberId);
		map.addAttribute("member",member);
		map.addAttribute("myDislikeIrdntNameList", myDislikeIrdntNameList);
		//return new ModelAndView("user/join_member_success","member",member);
		return "user/join_member_success";
	}
	
	/**
	 * 회원등록시 아이디 중복조회-Ajax처리
	 * @param inputId
	 * @return
	 */
	@RequestMapping(value="/popup_duplicate_id", produces="text/html;charset=UTF-8")
	@ResponseBody
	public String duplicateId(String inputId){
		//1.요청파라미터 조회+검증
		//System.out.println(memberId);
		//2.BusinessLogic
		if(authorityService.findAuthority(inputId)!=null){
			//System.out.println("ID있음");
			return "duplicateIdError";
		}
		if(inputId.trim().length()<2||inputId.trim().length()>15){
			return "idLengthError";
		}
		return inputId.trim();
	}
	
	/**
	 * 회원등록시 이메일 중복조회-Ajax처리
	 * @param inputId
	 * @return
	 */
	@RequestMapping(value="/popup_duplicate_email", produces="text/html;charset=UTF-8")
	@ResponseBody
	public String duplicateEmail(String inputEmail){
		//1.요청파라미터 조회+검증
		//2.BusinessLogic
		if(memberService.findMemberByEmail(inputEmail)!=null){
			//System.out.println("Email있음");
			return "duplicateEmailError";
		}
		return inputEmail;
	}

	/**
	 * ID/PW찾기 -Ajax처리
	 * @param inputName
	 * @param inputEmail
	 * @return
	 */
	@RequestMapping(value="/popup_find_IdPw", produces="text/html;charset=UTF-8")
	@ResponseBody
	public String findIdPw(String inputName,String inputEmail){
		//1.요청파라미터 조회+검증
		//2.BusinessLogic
		if(memberService.findMember(inputName, inputEmail)==null){
			//System.out.println("Email있음");
			return "nonExistMember";
		}
		return inputEmail;
	}
	

}
