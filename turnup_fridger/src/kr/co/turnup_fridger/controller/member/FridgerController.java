package kr.co.turnup_fridger.controller.member;

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.validation.Valid;

import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
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
	//@RequestMapping("register") //맨 끝에 사진이랑 같이 올리는 것 생성 
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
			e.printStackTrace();
			return new ModelAndView("common/member/fridger/register_form", "errorMsg_fridgerName", e.getMessage());
		}

		return new ModelAndView("redirect:register/success.do", "fridgerId", fridger.getFridgerId());
	}
	
	@RequestMapping("register/success")
	public ModelAndView registerSuccess( int fridgerId ) throws Exception{
		System.out.println("로그,다");
		fridger = fridgerService.findFridgerByFridgerId(fridgerId);
		
		return new ModelAndView("/common/member/fridger/register_success.do", "fridger", fridger);
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
	
	
	// 냉장고 삭제 관리 handler
	@RequestMapping("remove")
	public ModelAndView removeFridger(@RequestParam int fridgerId) {
		ModelAndView mv = new ModelAndView();
		try {
			fridgerService.removeFridger(fridgerId);
		} catch (FindFridgerFailException e) {
//			e.printStackTrace();//
			mv.addObject("errorMsg", e.getMessage());
			return mv;
		}
		mv.addObject("fridgerId", fridgerId);
		mv.setViewName("redirect:remove/success.do");
		return mv;
	}
	
	// 냉장고 삭제 관리 handler
	@RequestMapping(value="remove/success", produces="text/html;charset=UTF-8")
	@ResponseBody
	public String removeSuccess(@RequestParam int fridgerId){
		System.out.println(fridgerId);
		return String.format("냉장고[%s]가 삭제되었습니다.", fridgerId);
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

	
	
	
	
	
	
	/********************************냉장고 그룹 가입처리**********************************/
	
	//냉장고 그룹에에 가입 요청 handler
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
	
	
	//냉장고 그룹으로 초대 요청 handler
	@RequestMapping(value="invite",produces="text/html;charset=UTF-8")
	@ResponseBody
	public ModelAndView inviteFridgerGroup(@ModelAttribute("joinProcess") @Valid JoinProcessForm joinProcessForm, BindingResult errors){
		// 요청 파라미터 검증 끝
		if(errors.hasErrors()){
			return new ModelAndView("common/member/fridger/invite_form");
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
			return new ModelAndView("common/member/fridger/invite_form.tiles", "errorMsg", e.getMessage());
		}

		return new ModelAndView("redirect:invite/success.do", "processNo", joinProcess.getProcessNo());
	}
	
	@RequestMapping("invite/success")
	public ModelAndView inviteSuccess(@RequestParam int processNo){
		joinProcess = joinProcessService.findJoinProcessByProcessNo(processNo);

		return new ModelAndView("common/member/fridger/invite_success.tiles", "joinProcess", joinProcess);
	}
	
	
	
	
	
	
	//내가 요청한 처리목록 Handler
	@RequestMapping("joinProcess/show/list/request")
	@ResponseBody
	public List<JoinProcess> getJoinProcessRequestList(){
		// 0) 권한 ID 체크(지금 로그인한 회원)
		Member member = (Member)SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		list = joinProcessService.findJoinProcessByRequestMemberId(member.getMemberId());
		System.out.println(list);
		return list;
	}
	
	
	//내가 요청받은한 처리목록 Handler
	@RequestMapping("joinProcess/show/list/response")
	@ResponseBody
	public List<JoinProcess> getJoinProcessResponseList(){
		// 0) 권한 ID 체크(지금 로그인한 회원)
		Member member = (Member)SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		list = joinProcessService.findJoinProcessByResponseMemberId(member.getMemberId());
		return list;
	}
	

	//냉장고 요청취소 처리 Handler
	@RequestMapping(value="joinProcess/cancel", produces="text/html;charset=UTF-8")
	@ResponseBody
	public String cancelJoinProcess(@RequestParam int[] processNo){
		ArrayList processNoList = new ArrayList<>();
		for(int i : processNo){
			processNoList.add(i);
		}
		System.out.println(list);//log
		int count = joinProcessService.removeJoinProcessByProcessNo(processNoList);
		return count+"개의 요청이 처리되었습니다.";
	}
	
	
	//냉장고 가입/초대 요청 승인 handler
	@RequestMapping(value="joinProcess/accept", produces="text/html;charset=UTF-8")
	@ResponseBody
	public String acceptJoinProcesss(@RequestParam int processNo){
		
		//1.가입처리목록에서 해당 처리 조회
		joinProcess = joinProcessService.findJoinProcessByProcessNo(processNo);
	
		//2.요청상태 변경	
		//3. 냉장고 그룹에 추가 및 상태값 받기
		String result = null;
		if(joinProcess.getProcessState()==10){
			// 요청자로부터 받은 내 냉장고 가입 신청 승인 ( = 요청한 회원이 그룹에 새롭게 저장)
			joinProcess.setProcessState(11);	//10대기,11승인,12거절
			joinProcess.setRespDate(new Date());
			fridgerGroup = new FridgerGroup(0, 0, joinProcess.getReqMemberId(), joinProcess.getProcessFridgerId());
			result="가입요청";
		}else if(joinProcess.getProcessState()==20){
			// 요청자로부터 받은 요청자의 냉장고로 초대 신청 승인 ( = 로그인된 회원, 즉 응답자가 그룹에 새롭게 저장)
			joinProcess.setProcessState(21);	//10대기,11승인,12거절
			joinProcess.setRespDate(new Date());
			fridgerGroup = new FridgerGroup(0, 0, joinProcess.getRespMemberId(), joinProcess.getProcessFridgerId());
			result="초대요청";
		}
		try {
			fridgerGroupService.insertFridgerGroup(fridgerGroup);
		} catch (Exception e) {
			e.printStackTrace();
			return  e.getMessage();
		}
		
		try {
			joinProcessService.updateJoinProcess(joinProcess);
		} catch (Exception e) {
			e.printStackTrace();
			return e.getMessage();
		}
		
		
		return result+"이 승인되었습니다!";
	}
	
	
	//냉장고 가입/초대 요천 거절 handler
	@RequestMapping(value="joinProcess/reject", produces="text/html;charset=UTF-8")
	@ResponseBody
	public String rejectJoinProcesss(@RequestParam int processNo) {
		// 1.가입처리목록에서 해당 처리 조회
		joinProcess = joinProcessService.findJoinProcessByProcessNo(processNo);

		// 2.요청상태 변경
		joinProcess.setProcessState(joinProcess.getProcessState() + 2); // 0대기,1승인,2거절
		joinProcess.setRespDate(new Date());
		try {
			joinProcessService.updateJoinProcess(joinProcess);
		} catch (Exception e) {
//			e.printStackTrace();//
			return e.getMessage();
		}

		// 3. 상태값 받기
		String result = null;
		if (joinProcess.getProcessState() == 12) {
			result = "가입요청";
		} else if (joinProcess.getProcessState() == 22) {
			result = "초대요청";
		}
		try {
			fridgerGroupService.insertFridgerGroup(fridgerGroup);
		} catch (Exception e) {
			e.printStackTrace();
			return e.getMessage();
		}

		return result + "이 거절되었습니다!";
	}
	
	
	
	
	/*************************업로드 테스트**************************/
	
	@RequestMapping(value="register", method={RequestMethod.POST,RequestMethod.GET} )	// input type="file"으로 전송받는 변수는 MultipartFile 타입으로 선언
	public ModelAndView regisgerFridgerWithImgs(@RequestParam String fridgerName,
												@RequestParam String memberId,
									@RequestParam MultipartFile fridgerImgSrc,
								HttpServletRequest request) throws IllegalStateException, IOException{
		fridger = new Fridger(0, fridgerName, memberId);
		String fileName = null;
		System.out.println("=========="+fridgerName);
		long fileSize= 0;		//업로드된 파일은 임시 경로에 있음 -> 최종 저장 디렉터리에 옮기는 작업
		if(fridgerImgSrc != null && !fridgerImgSrc.isEmpty()){
			fileName = fridgerImgSrc.getOriginalFilename();
			fileSize= fridgerImgSrc.getSize();
			System.out.printf("파일명 :%s, 파일크기 :%d%n", fileName, fileSize);
			
			//이동 : request.getServletContext().getRealPath("하위 경로") - Application의 Root경로의 실제 파일경로로 리턴
			System.out.println("request.getServletContext().getRealPath() : "+ request.getServletContext().getRealPath("/images") );
			File dest = new File(request.getServletContext().getRealPath("/images"), fileName);
			
			fridgerImgSrc.transferTo(dest);	// Exception 던짐
			
		}
		// 요청 파라미터 검증 
		
		
			
		
		// 비즈니스 로직 처리
		// 0) 권한 ID 체크(지금 로그인한 회원)
		Member member = (Member)SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		// 1) 빈 냉장고 생성해서  검증된 fridgerForm 넣기
		fridger.setMemberId(member.getMemberId());
		fridger.setFridgerImg(fileName);
		
		
		try {
			// 2) 냉장고 DB에 저장(서비스단에서 냉장고 그룹생성 과정 처리)
			fridgerService.createFridger(fridger);
			System.out.println("냉장고 등록 로그:"+fridger);	//log
		} catch (DuplicatedFridgerException e) {	//냉장고 이름중복되면 예외발생
			return new ModelAndView("common/member/fridger/register_form.tiles", "errorMsg_fridgerName", e.getMessage());
		}
		
		return new ModelAndView("redirect:register/success.do", "fridgerId", fridger.getFridgerId());
	}
	
	
}
