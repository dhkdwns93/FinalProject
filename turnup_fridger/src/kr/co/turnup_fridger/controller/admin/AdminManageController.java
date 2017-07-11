/**
 (Controller)AdminManageController
작성자 :  김경혜
최초 작성일 170705
변경이력
*/
package kr.co.turnup_fridger.controller.admin;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContext;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import kr.co.turnup_fridger.exception.RegisterAdminFailException;
import kr.co.turnup_fridger.service.AdminService;
import kr.co.turnup_fridger.service.MemberService;
import kr.co.turnup_fridger.service.MyDislikeIrdntService;
import kr.co.turnup_fridger.vo.Admin;
import kr.co.turnup_fridger.vo.Member;

/**
 *	/common/admin/경로로 요청하는 작업 처리
 */
@Controller
@RequestMapping("/common/admin")
public class AdminManageController {
	
	@Autowired
	private MemberService memberService;
	
	@Autowired
	private AdminService adminService;
	
	@Autowired
	private MyDislikeIrdntService myDislikeIrdntService;
	
	@Autowired
	private PasswordEncoder passwordEncoder;
	
	/**
	 * 전체개인회원정보 조회
	 * @return
	 */
	@RequestMapping("/member_list")
	public ModelAndView inquiryMemberList(){
		List<Member> memberList=memberService.inquiryMemberList();
		return new ModelAndView("common/admin/user/member_list","memberList",memberList);
	}
	
	/**
	 * 관리자 등록
	 * 처리 후 join_admin_success.do를 이용해 응답처리 -redirect방식 이동
	 * 보내줄 요청 파라미터 : adminId
	 * @param admin
	 * @return
	 * @throws RegisterAdminFailException
	 */
	@RequestMapping("/master/join_admin")
	public ModelAndView registerAdmin(@ModelAttribute Admin admin) throws RegisterAdminFailException{
		adminService.registerAdmin(admin);
		return new ModelAndView("redirect:/common/admin/master/join_admin_success.do","adminId",admin.getAdminId());
	}
	
	@RequestMapping("/master/join_admin_success")
	public ModelAndView registerSuccesAdmin(@RequestParam String adminId){
		Admin admin=adminService.inquiryAdminInfo(adminId);
		return new ModelAndView("common/admin/master/user/join_admin_success","admin",admin);
	}
	
	/**
	 * 전체관리자등록정보 조회
	 * @return
	 */
	@RequestMapping("/admin_list")
	public ModelAndView inquiryAdminList(){
		List<Admin> adminList=adminService.inquiryAdminList();
		//System.out.println("AdminManageController- adminList : "+adminList);
		return new ModelAndView("common/admin/user/admin_list","adminList",adminList);
	}
	
	/**
	 * 관리자 개인정보 수정
	 * 수정할 정보와 기존 패스워드를 받음
	 * 수정 후 admin_mypage로 이동
	 * @param admin
	 * @param newAdminPw
	 * @return
	 */
	@RequestMapping("/admin_change")
	public String changeAdminInfo(@ModelAttribute Admin admin, @RequestParam String oldAdminPw){
		//1. 요청한 사용자 정보 조회
		SecurityContext ctx=SecurityContextHolder.getContext();
		Authentication authentication=ctx.getAuthentication();
		
		//PW체크
		String originalAdminPw=((Admin)authentication.getPrincipal()).getAdminPw();
		//바꾸려는 비밀번호
		String adminPw=admin.getAdminPw();
		if(!passwordEncoder.matches(oldAdminPw,originalAdminPw)){
//		if(!adminPw.equals(admin.getAdminPw())){
			System.out.println("originalPW="+originalAdminPw);
			System.out.println("입력한 PW="+ oldAdminPw);
			System.out.println("AdminManageController + PW가 다릅니다.");
			throw new RuntimeException("PW가 다릅니다.");
		}
		
		//2.BusinessLogic호출
		if((adminService.inquiryAdminInfo(admin.getAdminId()).getAdminAuthority()).equals("ROLE_HEADMASTERADMIN")){
			System.out.println("Head Master는 수정이 불가합니다.");
			throw new RuntimeException("Head Master는 수정이 불가합니다.");
		}
		adminService.changeAdminInfo(admin);
		
		//3.응답
		ctx.setAuthentication(new UsernamePasswordAuthenticationToken(admin, null, authentication.getAuthorities()));
		return "common/admin/user/admin_mypage";
	}
	
	/**
	 * 관리자 권한 수정처리 
	 * 권한을 수정하려는 관리자의 Id와 바꿀 권한정보를 받음
	 *  **headMaster와 로그인한 Master관리자는 권한정보를 수정할수 없음
	 * 권한 수정 후 전체관리자등록정보 페이지로 이동 -redirect방식 이동
	 * @param adminId
	 * @param adminAuthority
	 * @return
	 */
	@RequestMapping("/master/admin_change_authority")
	public String changeAdminAuthority(@RequestParam String adminId, @RequestParam String adminAuthority){
		//1.요청한 사용자 정보 조회
		SecurityContext ctx=SecurityContextHolder.getContext();
		Authentication authentication=ctx.getAuthentication();

		//2.Business Logic
		if((adminService.inquiryAdminInfo(adminId).getAdminAuthority()).equals("ROLE_HEADMASTERADMIN")){
			System.out.println("Head Master는 권한수정이 불가합니다.");
			throw new RuntimeException("Head Master는 권한수정이 불가합니다.");
		}
		//수정필요
		if(adminId.equals(((Admin)authentication.getPrincipal()).getAdminId())){
			System.out.println("로그인한 관리자는 권한수정이 불가합니다.");
			throw new RuntimeException("로그인한 관리자는 권한수정이 불가합니다.");
		}
		
//		System.out.println("AdminManage changeAdminAuthority : "+ adminId);
//		System.out.println("AdminManage changeAdminAuthority : "+ adminAuthority);
		
		adminService.changeAdminAuthority(adminId, adminAuthority);
		
		//3.응답
		return "redirect:/common/admin/admin_list.do";
	}
	
	/**
	 * 관리자 탈퇴처리
	 * 탈퇴처리하려는 관리자의 Id를 받음
	 *  **headMaster는 탈퇴할 수 없음
	 *  **Master관리자는 headMaster만 탈퇴처리 할 수 있음.
	 * 탈퇴 후 전체관리자등록정보 페이지로 이동 -redirect방식 이동
	 * @param adminId
	 * @return
	 */
	@RequestMapping("/master/admin_delete")
	public String deleteAdmin(@RequestParam String adminId){
		//1.요청한 사용자 정보 조회
		SecurityContext ctx=SecurityContextHolder.getContext();
		Authentication authentication=ctx.getAuthentication();
//		String adminAuthority=service.inquiryAdminInfo(adminId).getAdminAuthority();
//		System.out.println("AdminManage deleteAdmin : "+ adminAuthority);
		
//		String loginAuthority=((Admin)authentication.getPrincipal()).getAdminAuthority();
//		System.out.println(loginAuthority);
		//2.Business Logic
		if((adminService.inquiryAdminInfo(adminId).getAdminAuthority()).equals("ROLE_HEADMASTERADMIN")){
			System.out.println("Head Master는 탈퇴가 불가합니다.");
			throw new RuntimeException("Head Master는 탈퇴가 불가합니다.");
		}
		
		if(((adminService.inquiryAdminInfo(adminId)).getAdminAuthority()).equals("ROLE_MASTERADMIN")){//**Master관리자 탈퇴시키려 할경우
			if(!(((Admin)authentication.getPrincipal()).getAdminAuthority()).equals("ROLE_HEADMASTERADMIN")){
				System.out.println("Master관리자는 headMaster만 탈퇴처리 할 수 있습니다.");
				throw new RuntimeException("Master관리자는 headMaster만 탈퇴처리 할 수 있습니다.");
			}
			//System.out.println("master관리자 탈퇴");
			adminService.deleteAdmin(adminId);
		}else{
			//System.out.println("일반관리자 탈퇴");
			adminService.deleteAdmin(adminId);
		}
		
		//System.out.println("AdminManage deleteAdmin : "+ adminId);
		//service.deleteAdmin(adminId);
		//3.응답
		return "redirect:/common/admin/admin_list.do";
	}
	
	/**
	 * 개인회원 강제탈퇴 처리
	 * @param memberId
	 * @return
	 */
	@RequestMapping("/member_delete")
	public String deleteMember(@RequestParam String memberId){
		//1.요청한 사용자 정보 조회

		//2.Business Logic
		//System.out.println(memberId + "탈퇴");	
		myDislikeIrdntService.removeMyDislikeIrdntByMemberId(memberId);
		memberService.deleteMember(memberId);
		//3.응답
		return "redirect:/common/admin/member_list.do";
	}

}
