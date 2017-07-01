package kr.co.turnup_fridger.controller.admin;

import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;

import kr.co.turnup_fridger.service.IrdntManageService;
import kr.co.turnup_fridger.vo.IrdntManage;

@Controller
public class IrdntManageController {

	@Autowired
	private IrdntManageService service;
	
	@RequestMapping("register")
	public String resisterIrdnt(@ModelAttribute ("IrdntManage") @Valid IrdntManage irdntManage, BindingResult errors){
		
		
		if(errors.hasErrors()){
			return "/admin/Irdnt_register_form";
		}
		
		try {
			service.createIrdnt(irdntManage);
		} catch (Exception e) {
			//중복으로 던져진 에러메시지 받아야한다. 
			
		}
		return "/admin/Irdnt_register_success";
	}
	
	
}
