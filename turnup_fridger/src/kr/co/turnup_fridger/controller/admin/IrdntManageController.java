package kr.co.turnup_fridger.controller.admin;

import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import kr.co.turnup_fridger.service.IrdntManageService;
import kr.co.turnup_fridger.vo.IrdntManage;

@Controller
@RequestMapping("/irdntManage/")
public class IrdntManageController {

	@Autowired
	private IrdntManageService service;
	
	@RequestMapping("createIrdnt")
	public ModelAndView createIrdnt(@ModelAttribute ("IrdntManage") @Valid IrdntManage irdntManage, BindingResult errors){
	
		if(errors.hasErrors()){
			return new ModelAndView("irdntManage/Irdnt_create_form");
		}
		
		try {
			service.createIrdnt(irdntManage);
		} catch (Exception e) {
			//중복으로 던져진 에러메시지 받아야한다. 
			
		}
		return new ModelAndView("irdntManage/Irdnt_create_success");
	}
	
	@RequestMapping("updateIrdnt")
	public ModelAndView updateIrdnt(@ModelAttribute IrdntManage irdnt, BindingResult errors) throws Exception{
		
		service.updateIrdnt(irdnt);
		
		return new ModelAndView("irdntManage/Irdnt_update_success");
	}
	
	@RequestMapping("removeIrdnt")
	public ModelAndView removeIrdnt(@RequestParam int irdntId) throws Exception{
		service.removeIrdnt(irdntId);
		
		
		return new ModelAndView("irdntManage/Irdnt_list");
	}
	

	
}
