/**
 (Controller)MebmerManageController
작성자 :  김경혜
최초 작성일 170704
변경이력
*/
package kr.co.turnup_fridger.controller.member;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContext;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import kr.co.turnup_fridger.exception.ChangeMemberInfoFailException;
import kr.co.turnup_fridger.service.IrdntManageService;
import kr.co.turnup_fridger.service.MemberService;
import kr.co.turnup_fridger.service.MyDislikeIrdntService;
import kr.co.turnup_fridger.vo.Member;
import kr.co.turnup_fridger.vo.MyDislikeIrdnt;

/**
 *	/common/member/경로로 요청하는 작업 처리
 */

@Controller
@RequestMapping("/common/member")
public class MemberManageController {
	@Autowired
	private MemberService memberService;
	
	@Autowired
	private MyDislikeIrdntService myDislikeIrdntService;
	
	@Autowired
	private IrdntManageService irdntManageService;
	
	@Autowired
	private PasswordEncoder passwordEncoder;
	
	@RequestMapping("/member_mypage_event")
	public ModelAndView memberMyPage(){
		//1. 요청한 사용자 정보 조회
		SecurityContext ctx=SecurityContextHolder.getContext();
		Authentication authentication=ctx.getAuthentication();
		//로그인한 Member정보 불러옴
		Member member=(Member)authentication.getPrincipal();
		
		//2.BusinessLogic
		List<MyDislikeIrdnt> memberDislikeIrdntList=myDislikeIrdntService.findMyDislikeIrdntByMemberId(member.getMemberId());
		List<String> myDislikeIrdntNameList=new ArrayList<>();
		if(memberDislikeIrdntList.size()==0){//등록된 기피재료가 하나도 없으면
			myDislikeIrdntNameList.add("등록된 기피재료가 없습니다");
		}else{
			for(MyDislikeIrdnt irdnt : memberDislikeIrdntList){
				myDislikeIrdntNameList.add(irdntManageService.findIrdntByIrdntId(irdnt.getIrdntId()).getIrdntName());
			}
		}
		//3.응답
		ctx.setAuthentication(new UsernamePasswordAuthenticationToken(member, null, authentication.getAuthorities()));
		return new ModelAndView("common/member/user/member_mypage","myDislikeIrdntNameList",myDislikeIrdntNameList);

	}
	
	/**
	 * 회원 정보 수정
	 * 수정할 정보와 기존 패스워드를 받음, 기피재료도 받음
	 * 수정 후 member_mypage로 이동
	 * @param member
	 * @param oldMemberPassword
	 * @return
	 * @throws Exception 
	 */
	@RequestMapping("/member_change")
	public String changeMemberInfo(@ModelAttribute Member member, @RequestParam String newMemberPw, @RequestParam List<Integer> myDislikeIrdntId, ModelMap map) throws Exception{
		//1. 요청한 사용자 정보 조회
		SecurityContext ctx=SecurityContextHolder.getContext();
		Authentication authentication=ctx.getAuthentication();
		//System.out.println(authentication);
		//System.out.println(member);
		//System.out.println("기존의 비밀번호" + member.getMemberPw());
		//ID 체크
		String memberId=((Member)authentication.getPrincipal()).getMemberId();
		//PW 체크
		String memberPw=((Member)authentication.getPrincipal()).getMemberPw();
		//if(!passwordEncoder.matches(memberPw,member.getMemberPw())){
		if(!memberPw.equals(member.getMemberPw())){
			System.out.println("MemberManageController + PW가 다릅니다");
			throw new RuntimeException("PW가 다릅니다.");
		}
//		System.out.println("MemberManage"+myDislikeIrdntId);
		
		
		//2. Business Logic 호출
		//System.out.println("MemberManage"+newMemberPw);
		member.setMemberPw(newMemberPw);
		myDislikeIrdntService.removeMyDislikeIrdntByMemberId(member.getMemberId());
		List<MyDislikeIrdnt> myDislikeIrdntList=new ArrayList<>();
		List<String> myDislikeIrdntNameList=new ArrayList<>();
		for(int irdntId:myDislikeIrdntId){
			if(irdntId!=-1){
				myDislikeIrdntList.add(new MyDislikeIrdnt(member.getMemberId(),irdntId));
				myDislikeIrdntService.createMyDislikeIrdnt(new MyDislikeIrdnt(member.getMemberId(),irdntId));
				myDislikeIrdntNameList.add(irdntManageService.findIrdntByIrdntId(irdntId).getIrdntName());
			}
		}
		if(myDislikeIrdntNameList.size()==0){//등록된 기피재료가 하나도 없으면 //id default값 하나 등록되있음.
			myDislikeIrdntNameList.add("등록된 기피재료가 없습니다");
		}
		member.setMyDislikeIrdntList(myDislikeIrdntList);//member객체에 set
		memberService.changeMemberInfo(member);
//		System.out.println("MemberManage"+myDislikeIrdntNameList);List<String> myDislikeIrdntNameList=new ArrayList<>();
		
		//membervo에서 찾아서 올거야?
/*		List<MyDislikeIrdnt> memberDislikeIrdntList=myDislikeIrdntService.findMyDislikeIrdntByMemberId(memberId);
		List<String> myDislikeIrdntNameList=new ArrayList<>();
		if(myDislikeIrdntId.size()==1){//등록된 기피재료가 하나도 없으면 //id default값 하나 등록되있음.
			myDislikeIrdntNameList.add("등록된 기피재료가 없습니다");
		}else{
			for(MyDislikeIrdnt irdnt : memberDislikeIrdntList){
				myDislikeIrdntNameList.add(irdntManageService.findIrdntByIrdntId(irdnt.getIrdntId()).getIrdntName());
			}
		}	*/	
		ctx.setAuthentication(new UsernamePasswordAuthenticationToken(member, null, authentication.getAuthorities()));
		//3. 응답
		map.addAttribute("myDislikeIrdntNameList", myDislikeIrdntNameList);
		return "redirect:/common/member/member_change_success.do";
	}
	@RequestMapping("/member_change_success")
	public ModelAndView successChangeMember(@RequestParam List<String> myDislikeIrdntNameList){
		return new ModelAndView("common/member/user/member_mypage","myDislikeIrdntNameList",myDislikeIrdntNameList);
	}
	
	
	/**
	 * 회원탈퇴
	 * 기존 패스워드를 받음
	 * 탈퇴 후 기본페이지로 이동 -redirect방식 이동
	 * @param member
	 * @param oldMemberPassword
	 * @return
	 * @throws ChangeMemberInfoFailException 
	 */
	@RequestMapping("/member_delete")
	public String leaveMember(@RequestParam String memberId, @RequestParam String inputPw){
		//1. 요청한 사용자 정보 조회
		SecurityContext ctx=SecurityContextHolder.getContext();
		Authentication authentication=ctx.getAuthentication();
		//PW 체크
		String memberPw=((Member)authentication.getPrincipal()).getMemberPw();
		//if(!passwordEncoder.matches(oldMemberPassword,((Member)authentication.getPrincipal()).getMemberPw())){
		if(!memberPw.equals(inputPw)){
			System.out.println("MemberManageController(deleteMember메소드) + PW가 다릅니다");
			throw new RuntimeException("PW가 다릅니다.");
		}
		
		//2.Business Logic 호출
		//System.out.println("회원탈퇴메소드 확인"+memberId);
		memberService.deleteMember(memberId);
		
		//3.응답
		ctx.setAuthentication(null);//로그아웃처리

		return "redirect:../../index_kh.do";
	}

}
