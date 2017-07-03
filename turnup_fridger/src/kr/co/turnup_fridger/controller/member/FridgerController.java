package kr.co.turnup_fridger.controller.member;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.co.turnup_fridger.service.FridgerService;
import kr.co.turnup_fridger.vo.Fridger;
import kr.co.turnup_fridger.vo.FridgerGroup;

@Controller
@RequestMapping("/fridger/")
public class FridgerController {

	@Autowired
	private FridgerService service;
	
	
	List list;
	Fridger fridger;
	FridgerGroup fridgerGroup;
	
	// 모든 리스트 뿌려주는 handler
	@RequestMapping("show/list")
	@ResponseBody
	public List<Fridger> getFridgerListAll(){
		list = service.findFridgerAll();
		return list;
	}
	
	// 냉장고Id로 찾아서 뿌려주는 handler
	@RequestMapping("show/fridgerById")
	@ResponseBody
	public Fridger getFridgerById(int fridgerId){
		fridger = service.findFridgerByFridgerId(fridgerId);
		return fridger;
	}
	
	// 이름으로 찾아 뿌려주는 handler
	@RequestMapping("show/fridgerByName")
	@ResponseBody
	public List<Fridger> getFridgerByName(String fridgerName){
		list = service.findFridgerByFridgerName(fridgerName);
		return list;
	}
	
	
	//냉장고 주인 회원으로 찾기
	@RequestMapping("show/fridgerByOwner")
	@ResponseBody
	public List<Fridger> getFridgerByOwner(String memberId){
		list = service.findFridgerByOwner(memberId);
		return list;
	}
	
	@RequestMapping("show/detail")
	@ResponseBody
	public List<FridgerGroup> getFriderInDetail(int fridgerId){
		list = service.findFridgerAndFridgerGroupByFridgerId(fridgerId).getFridgerGroupList();
		
		/*로그*/
		for(Object f : list){
			System.out.println(f);
		}
		return list;
	}
	
	
	
}
