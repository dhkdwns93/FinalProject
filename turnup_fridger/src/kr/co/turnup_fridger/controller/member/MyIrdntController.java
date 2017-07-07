package kr.co.turnup_fridger.controller.member;

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

import kr.co.turnup_fridger.exception.DuplicateMyIrdntException;
import kr.co.turnup_fridger.exception.NoneMyIrdntException;
import kr.co.turnup_fridger.service.FridgerService;
import kr.co.turnup_fridger.service.IrdntManageService;
import kr.co.turnup_fridger.service.MyIrdntService;
import kr.co.turnup_fridger.validation.MyIrdntForm;
import kr.co.turnup_fridger.vo.FridgerGroup;
import kr.co.turnup_fridger.vo.IrdntManage;
import kr.co.turnup_fridger.vo.Member;
import kr.co.turnup_fridger.vo.MyIrdnt;

@Controller
@RequestMapping("/common/member/myIrdnt/")
public class MyIrdntController {

	@Autowired
	private MyIrdntService service;
	@Autowired
	private IrdntManageService irdntService;
	@Autowired
	private FridgerService fridgerService;
	
	@RequestMapping(value = "createMyIrdnt", produces="html/text;charset=UTF-8;")
	@ResponseBody
	public ModelAndView createMyIrdnt(@ModelAttribute ("myIrdnt") @Valid MyIrdntForm myIrdntForm,BindingResult errors){
		
		if(errors.hasErrors()){
			return new ModelAndView("common/member/myIrdnt/myIrdnt_form");
		}
		
		Member member = (Member)SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		List<FridgerGroup> group = fridgerService.findFridgerAndFridgerGroupByFridgerId(myIrdntForm.getFridgerId()).getFridgerGroupList();
	/*	boolean validChk = false;
		for(int i=0; i<group.size();i++){
			if(member.getMemberId().equals(group.get(i).getGroupMemberId())){
				//현재회원의 id가 이 냉장고그룹에 속해있는지 하나하나 확인-> 같다.있다.
				validChk = true;
				break;
			}
		}
		if(!validChk){
			throw new Exception("적합한 사용자가 아닙니다."); 
		}*/
		
		MyIrdnt myIrdnt = new MyIrdnt();
		BeanUtils.copyProperties(myIrdntForm, myIrdnt);

		try {
			service.createMyIrdnt(myIrdnt);
		} catch (DuplicateMyIrdntException e) {
			return new ModelAndView("common/member/myIrdnt/myIrdnt_form","errorMsg_keyDuplicate",e.getMessage());
		}
		return new ModelAndView("common/member/myIrdnt/myIrdntList");
	}
	
	@RequestMapping(value="updateMyIrdnt", produces="html/text;charset=UTF-8;")
	@ResponseBody
	public ModelAndView updateMyIrdnt(@ModelAttribute ("myIrdnt") @Valid MyIrdntForm myIrdntForm,BindingResult errors){
		
		if(errors.hasErrors()){
			return new ModelAndView("/common/member/myIrdnt/myIrdnt_update_form");
		}
		
		MyIrdnt myIrdnt = new MyIrdnt();
		BeanUtils.copyProperties(myIrdntForm, myIrdnt);
		try {
			service.updateMyIrdnt(myIrdnt);
		} catch (NoneMyIrdntException e) {
			return new ModelAndView("common/member/myIrdnt/myIrdnt_detail","errorMsg_keyNull",e.getMessage());
		}
		return new ModelAndView("common/member/myIrdnt/myIrdntList");
		
	}
	
	@RequestMapping(value="removeMyIrdnt", produces="html/text;charset=UTF-8;")
	@ResponseBody
	public String removeMyIrdnt(@RequestParam List<Integer> irdntKey,@RequestParam int fridgerId){
		try {
			for(int i=0;i<irdntKey.size();i++){
				service.removeMyIrdnt(irdntKey.get(i));
			}
		} catch (NoneMyIrdntException e) {
			return "삭제안돼앵~"+e.getMessage();
		}
		return "삭제완료!";
	}
	
	@RequestMapping("allMyIrdntList")
	@ResponseBody
	public List<MyIrdnt> allMyIrdntList(@RequestParam int fridgerId){
		List<MyIrdnt> list = service.findAllMyIrdntByFridgerId(fridgerId);
		return list;
	}
	
	@RequestMapping("findMyIrdntByFreshLevelAndIrdntName")
	@ResponseBody
	public List<MyIrdnt> findMyIrdntByFreshLevelAndIrdntName(@RequestParam String freshLevel, @RequestParam String irdntName, @RequestParam int fridgerId){
		System.out.println(freshLevel +","+irdntName+","+fridgerId);
		
		List<MyIrdnt> list = service.findMyIrdntByFreshLevelAndIrdntName(freshLevel, irdntName, fridgerId);
		return list;
	}
	
	//날짜순 정렬을 만들어야하나?	
	
	@RequestMapping("findIrdntByName" )
	@ResponseBody
	public List<IrdntManage> findIrdntByName(@RequestParam String irdntName){
		List<IrdntManage> list = irdntService.findIrdntByName(irdntName);
		return list;
	}
	
	@RequestMapping("findIrdntByKey")
	@ResponseBody
	public ModelAndView findIrdntByKey(@RequestParam int myIrdntKey){
		MyIrdnt myIrdnt = service.fingMyIrdntBymyIrdntKey(myIrdntKey);
		return new ModelAndView("common/member/myIrdnt/myIrdnt_update_form","myIrdnt",myIrdnt);
	}
	
	
/*	@RequestMapping("findMyIrdntByKeyword")
	public List findMyIrdntByKeyword(@RequestParam String keyword, @RequestParam Object searchWord, @RequestParam int fridgerId) throws ParseException{
		
		if(keyword.equals("재료명")){
			String irdntName = searchWord.toString();
			List<MyIrdnt> list = service.findMyIrdntByIrdntName(irdntName, fridgerId);
			return list;
		}
		else if(keyword.equals("보관시작일")){
			SimpleDateFormat transDate = new SimpleDateFormat("yyyy-MM-dd");
			Date startDate = transDate.parse(searchWord.toString());
			List<MyIrdnt> list = service.findMyIrdntByStartDate(startDate, fridgerId);
			return list;
		}
		else if(keyword.equals("신선도")){
			int freshLevel = (int) searchWord;
			List<MyIrdnt> list = service.findMyIrdntByFreshLevel(freshLevel, fridgerId);
			return list;
		}
		else if(keyword.equals("유통기한")){
			SimpleDateFormat transDate = new SimpleDateFormat("yyyy-MM-dd");
			Date endDate = transDate.parse(searchWord.toString());
			List<MyIrdnt> list = service.findMyIrdntByEndDate(endDate, fridgerId);
			return list;
		}else{
			List<MyIrdnt> list = service.findAllMyIrdntByFridgerId(fridgerId);
			return list;
		}
	}*/
	
	
}
