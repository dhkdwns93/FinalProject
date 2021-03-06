package kr.co.turnup_fridger.controller.member;

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.validation.Valid;

import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.validation.BindingResult;
import org.springframework.validation.FieldError;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import kr.co.turnup_fridger.exception.FindFridgerFailException;
import kr.co.turnup_fridger.exception.FindMemberFailException;
import kr.co.turnup_fridger.service.FridgerGroupService;
import kr.co.turnup_fridger.service.FridgerService;
import kr.co.turnup_fridger.service.IrdntManageService;
import kr.co.turnup_fridger.service.JoinProcessService;
import kr.co.turnup_fridger.service.MyIrdntService;
import kr.co.turnup_fridger.validation.form.FridgerForm;
import kr.co.turnup_fridger.validation.form.JoinProcessForm;
import kr.co.turnup_fridger.vo.Fridger;
import kr.co.turnup_fridger.vo.FridgerGroup;
import kr.co.turnup_fridger.vo.JoinProcess;
import kr.co.turnup_fridger.vo.Member;
import kr.co.turnup_fridger.vo.MyIrdnt;

@Controller
@RequestMapping("/common/member/fridger/")
public class FridgerController {

	@Autowired
	private FridgerService fridgerService;
	@Autowired
	private FridgerGroupService fridgerGroupService; 
	@Autowired
	private JoinProcessService joinProcessService;
	@Autowired
	private MyIrdntService myIrdntService;
	@Autowired
	private IrdntManageService irdntManageService;
	
	List list;
	Fridger fridger;
	FridgerGroup fridgerGroup;
	JoinProcess joinProcess;

	
	
	/************************************
	 * 냉장고 및 냉장고 공유 그룹
	 * **********************************/
	@RequestMapping(value="register", produces="text/html;charset=UTF-8") //맨 끝에 사진이랑 같이 올리는 것 생성 <- 다시 사용(7/16~)
	@ResponseBody
	public String registerFridger(@ModelAttribute("fridger") @Valid FridgerForm fridgerForm, BindingResult errors ) {
		if(errors.hasErrors()){
			List<FieldError> list = errors.getFieldErrors();
			StringBuffer sb = new StringBuffer();
			for(FieldError e : list){
				sb.append(e.getDefaultMessage()+"\n");
			}
			return sb.toString();
		}
		
		// 비즈니스 로직 처리
		// 0) 권한 ID 체크(지금 로그인한 회원)
		Member member = (Member)SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		// 1) 빈 냉장고 생성해서  검증된 fridgerForm 넣기
		fridger = new Fridger();
		BeanUtils.copyProperties(fridgerForm, fridger);
		fridger.setMemberId(member.getMemberId());
		System.out.println("냉장고 등록 로그:"+fridger);	//log
		
			// 2) 냉장고 DB에 저장(서비스단에서 냉장고 그룹생성 과정 처리)
		fridgerService.createFridger(fridger);
		return "0";
	}
	

	
	// 냉장고 정보 갱신 handler(주인 바꾸기, 이름바꾸기, 사진바꾸기)
	@RequestMapping(value="update", produces="text/html;charset=UTF-8")
	@ResponseBody
	public String updateFridger(@ModelAttribute("fridger") @Valid FridgerForm fridgerForm, BindingResult errors, HttpServletRequest request) throws IllegalStateException, IOException {
		
		if(errors.hasErrors()){
			List<FieldError> list = errors.getFieldErrors();
			StringBuffer sb = new StringBuffer();
			for(FieldError e : list){
				sb.append(e.getDefaultMessage()+"\n");
			}
			
			return sb.toString();
		}
		
		// 1) 빈 냉장고 생성해서  검증된 fridgerForm 넣기
		fridger = new Fridger();
		BeanUtils.copyProperties(fridgerForm, fridger);
				
		// 2) 냉장고 DB에 저장(서비스단에서 냉장고 그룹생성 과정 처리)
		try {
			fridgerService.updateFridger(fridger);
		} catch (FindFridgerFailException e) {
			//가져갈 에러메시지
			return "냉장고를 찾을 수 없습니다.";	
		} catch (FindMemberFailException e) {
			//가져갈 에러메시지
			return "냉장고 그룹 회원이 아닙니다.";	
		}

		return "0";	
	}
	

	
	
	// 냉장고 삭제 관리 handler
	@RequestMapping("remove")
	public ModelAndView removeFridger(@RequestParam int fridgerId) {
		ModelAndView mv = new ModelAndView();
		try {
			fridgerService.removeFridger(fridgerId);
		} catch (FindFridgerFailException e) {
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
		return String.format("냉장고가 삭제되었습니다.", fridgerId);
	}
	
	
	// 냉장고 그룹 탈퇴 handler
		@RequestMapping(value="fridgerGroup/out",  produces="text/html;charset=UTF-8")
		@ResponseBody
		public String outFridgerGroup(@RequestParam int fridgerId, @RequestParam String groupMemberId) {
			
			try {
				fridgerGroupService.deleteFridgerGroupByFridgerIdAndMemberId(fridgerId, groupMemberId);
			} catch (Exception e) {
				return e.getMessage();
			}
			
			return "0";
		}
	

	
	// 모든 리스트 뿌려주는 handler
	@RequestMapping(value="show/list", produces="text/html;charset=UTF-8")
	@ResponseBody
	public List<Fridger> getFridgerList(){
		list = fridgerService.findFridgerAll();
		return list;
	}
	
	// 냉장고Id로 찾아서 뿌려주는 handler
	@RequestMapping(value="show/byId", produces="text/html;charset=UTF-8")
	@ResponseBody
	public Fridger getFridgerById(int fridgerId){
		fridger = fridgerService.findFridgerByFridgerId(fridgerId);
		return fridger;
	}
	
	// 이름으로 찾아 뿌려주는 handler
	@RequestMapping(value="show/byName")
	@ResponseBody
	public Map<String, Object> getFridgerByName(String fridgerName, int page){
		Map<String, Object> map = fridgerService.findFridgerByFridgerNamePaging(fridgerName, page);
		return map;
	}
	
	
	//냉장고 주인 회원ID으로 찾는 handler
	@RequestMapping("show/byOwner")
	@ResponseBody
	public Map<String, Object> getFridgerByOwner(String memberId ,int page){
		Map<String, Object> map = fridgerService.findFridgerByOwnerPaging(memberId, page);
		return map;
	}
	
	//로그인 된 회원의 소유한 냉장고 찾는 handler
		@RequestMapping("show/mine" )
		@ResponseBody
		public List<Fridger> getFridgerMine(){	
			Member member = (Member)SecurityContextHolder.getContext().getAuthentication().getPrincipal();
			list = fridgerService.findFridgerByOwner(member.getMemberId());
			return list;
		}
	
		

	//로그인 된 회원이 공유하고 있는 냉장고 찾는 handler
		@RequestMapping("show/mine/shared")
		@ResponseBody
		public List<Fridger> getFridgerMineShared(){	
			Member member = (Member)SecurityContextHolder.getContext().getAuthentication().getPrincipal();
			List<Fridger> list = new ArrayList<Fridger>();
			for(FridgerGroup fg:fridgerGroupService.selectFridgerGroupByGroupMemberId(member.getMemberId())){
				list.add(fridgerService.findFridgerByFridgerId(fg.getFridgerId()));
			};
			//내가 공유하는 냉장고 
			return list;
		}
	
	
	//선택한 냉장고 현황 보여주는 handler
	@RequestMapping("show/detail")
	@ResponseBody
	public List<FridgerGroup> getFriderInDetail(int fridgerId){
		list = fridgerService.findFridgerAndFridgerGroupByFridgerId(fridgerId).getFridgerGroupList();
		return list;
	}

	
	//선택한 냉장고 현황 보여주는 handler
	@RequestMapping("main")
	public ModelAndView getFridgerMain(){
		Member member = (Member)SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		list = fridgerGroupService.selectFridgerGroupByGroupMemberId(member.getMemberId());
		return new ModelAndView("common/member/fridger/myFridger.tiles", "fridgerList", list);
	}
	
	
	//공유관리를 위한 회원의 공유 냉장고 현황 보여주는 handler
	@RequestMapping("group/manage")
	public ModelAndView getFridgerManage(){
		Member member = (Member)SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		list = fridgerGroupService.selectFridgerGroupByGroupMemberId(member.getMemberId());
		return new ModelAndView("common/member/fridger/group_select_form.tiles", "fridgerList", list);
	}
		

	@RequestMapping("select")
	@ResponseBody
	public Map getFridgerSelect(@RequestParam int fridgerId){
		Map map = new HashMap<>();
		// Fridger : 냉장고 명/ 사진 (조인 - FridgerGroup : 공유회원 수 / 이름 )
		fridger = fridgerService.findFridgerAndFridgerGroupByFridgerId(fridgerId);
		map.put("fridger", fridger);
		// JoinProcess : 나가 한 냉장고 가입/초대 요청, 내가 받은 가입/초대 요청
		
		// MyIrdnt : 신선도(Avg) 냉장고속 재료 갯수(총수), 보관장소별 갯수 count, 재료별 갯수
		map.put("myIrdntCount", myIrdntService.findAllMyIrdntCount(fridgerId));
		map.put("myIrdntGoodCount", myIrdntService.CountMyIrdntByFreshLevel(fridgerId, "안전"));
		map.put("myIrdntNormalCount", myIrdntService.CountMyIrdntByFreshLevel(fridgerId, "보통"));
		map.put("myIrdntBadCount", myIrdntService.CountMyIrdntByFreshLevel(fridgerId, "위험"));
		map.put("myIrdntBadList", myIrdntService.findMyIrdntByFreshLevel("위험", fridgerId));
		
		
		int myIrdntRoomTempCount = 0;
		int myIrdntColdTempCount = 0;
		int myIrdntFreezeTempCount = 0;
		if(fridgerService.findFridgerAndIrdntByFridgerId(fridgerId).getMyIrdntList() != null && fridgerService.findFridgerAndIrdntByFridgerId(fridgerId).getMyIrdntList().size() >0 && !fridgerService.findFridgerAndIrdntByFridgerId(fridgerId).getMyIrdntList().isEmpty()){
			for(MyIrdnt myIrdnt :  fridgerService.findFridgerAndIrdntByFridgerId(fridgerId).getMyIrdntList()){
				if(myIrdnt.getStorgePlace().equals("실온")){
					myIrdntRoomTempCount++;
				}else if(myIrdnt.getStorgePlace().equals("냉장")){
					myIrdntColdTempCount++;
				}else if(myIrdnt.getStorgePlace().equals("냉동")){
					myIrdntFreezeTempCount++;
				}
			}
		}
		map.put("myIrdntRoomTempCount", myIrdntRoomTempCount);
		map.put("myIrdntColdTempCount", myIrdntColdTempCount);		
		map.put("myIrdntFreezeTempCount", myIrdntFreezeTempCount);
		
		
		list = new ArrayList<>();
		List<String> tempList = irdntManageService.findAllIrdntCategory();
		for(String categoryName : tempList){
			int count = myIrdntService.findMyIrdntByCategory(fridgerId, categoryName);
			if(count !=0){
				Map category = new HashMap<>();
				category.put("categoryName", categoryName);
				category.put("count", count);
				list.add(category);

			}
		}
		map.put("irdntCategoryList", list);
		
		return map;
	}
	
	
	
	
	
	/************************************
	 * 냉장고 공유 그룹 가입처리
	 * **********************************/
	
	//냉장고 그룹에에 가입 요청 handler
	@RequestMapping(value="request",produces="text/html;charset=UTF-8")
	@ResponseBody
	public String requestFridgerGroup(@ModelAttribute("joinProcess") @Valid JoinProcessForm joinProcessForm, BindingResult errors){
				if(errors.hasErrors()){
			List<FieldError> list = errors.getFieldErrors();
			StringBuffer sb = new StringBuffer();
			for(FieldError e : list){
				sb.append(e.getDefaultMessage()+"\n");
			}
			return sb.toString();
		}
		// 0) 권한 ID 체크(지금 로그인한 회원)
		Member member = (Member)SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		// 1) 빈 냉장고 생성 해서 검증된 joinProess 넣기
		joinProcess = new JoinProcess();
		BeanUtils.copyProperties(joinProcessForm, joinProcess);
		joinProcess.setReqMemberId(member.getMemberId());
		joinProcess.setReqDate(new Date());
		
		try {
			joinProcessService.requestJoinFridgerGroup(joinProcess);
		} catch (Exception e) {
			return e.getMessage();
		}

		return "0";
	}
	
	
	//냉장고 그룹으로 초대 요청 handler
	@RequestMapping(value="invite",produces="text/html;charset=UTF-8")
	@ResponseBody
	public String inviteFridgerGroup(@ModelAttribute("joinProcess") @Valid JoinProcessForm joinProcessForm, BindingResult errors, ModelMap map){
		
		if(errors.hasErrors()){
			List<FieldError> list = errors.getFieldErrors();
			StringBuffer sb = new StringBuffer();
			for(FieldError e : list){
				sb.append(e.getDefaultMessage()+"\n");
			}
			return sb.toString();
		}
	
		// 0) 권한 ID 체크(지금 로그인한 회원)
		Member member = (Member)SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		// 1) 빈 냉장고 생성 해서 검증된 joinProess 넣기
		joinProcess = new JoinProcess();
		BeanUtils.copyProperties(joinProcessForm, joinProcess);
		joinProcess.setReqMemberId(member.getMemberId());
		joinProcess.setReqDate(new Date());
		
		try {
			joinProcessService.inviteJoinFridgerGroup(joinProcess);
		} catch (Exception e) {
			return e.getMessage();
		}
		
		return "0";
	}
		
	
	//내가 요청한 처리목록 Handler
	@RequestMapping("joinProcess/show/list/request" )
	@ResponseBody
	public List<JoinProcess> getJoinProcessRequestList(){
		// 0) 권한 ID 체크(지금 로그인한 회원)
		Member member = (Member)SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		list = joinProcessService.findJoinProcessByRequestMemberId(member.getMemberId());
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
			return  e.getMessage();
		}
		
		try {
			joinProcessService.updateJoinProcess(joinProcess);
		} catch (Exception e) {
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
			return e.getMessage();
		}

		return result + "이 거절되었습니다!";
	}
	
	
	@RequestMapping(value="group/out", produces="text/html;charset=UTF-8")
	@ResponseBody
	public String removeFromFridgerGroup(@RequestParam int fridgerId, @RequestParam String groupMemberId) {
		
		try {
			fridgerGroupService.deleteFridgerGroupByFridgerIdAndMemberId(fridgerId, groupMemberId);
		} catch (Exception e) {
			return e.getMessage();
		}
		
		return "0";
	}
	
	
	@RequestMapping(value="joinProcess/intro")
	@ResponseBody
	public Map<String, Integer> getIntro() {
		Map<String, Integer> map = new HashMap<>();
		int allFridgerCount = 0;
		int allFridgerGroupCount = 0;
		for(Fridger f : fridgerService.findFridgerAll()){
			allFridgerCount++;
			allFridgerGroupCount += fridgerGroupService.selectFridgerGroupCount(f.getFridgerId());
			
		}
		map.put("allFridgerCount", allFridgerCount);
		map.put("allFridgerGroupCount", allFridgerGroupCount);
	
		return map;
	}
	
	

}
