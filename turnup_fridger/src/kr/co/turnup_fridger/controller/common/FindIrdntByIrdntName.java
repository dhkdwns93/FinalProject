package kr.co.turnup_fridger.controller.common;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.co.turnup_fridger.service.IrdntManageService;
import kr.co.turnup_fridger.vo.IrdntManage;

@Controller
public class FindIrdntByIrdntName {
	
	@Autowired
	private IrdntManageService service;
	
	
	@RequestMapping("findIrdntByName")
	@ResponseBody
	public List<IrdntManage> findIrdntByName(@RequestParam String irdntName){
		List<IrdntManage> list = service.findIrdntByName(irdntName);
		return list;
	}
}
