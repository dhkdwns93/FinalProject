package kr.co.turnup_fridger.controller.admin;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import kr.co.turnup_fridger.service.IrdntManageService;
import kr.co.turnup_fridger.validation.IrdntManageValidator;
import kr.co.turnup_fridger.vo.IrdntManage;

@Controller
@RequestMapping("/common/admin/irdntManage/")
public class IrdntManageController {

	@Autowired
	private IrdntManageService service;
	
	@RequestMapping("createIrdnt")
	@ResponseBody
	public ModelAndView createIrdnt(@ModelAttribute IrdntManage irdnt,BindingResult errors) throws Exception{
		
		IrdntManageValidator validator= new IrdntManageValidator();
		validator.validate(irdnt, errors);
		
		if(errors.hasErrors()){
			return new ModelAndView("/common/admin/irdntManage/irdnt_form");
		}
		
		service.createIrdnt(irdnt);		
		
		List<IrdntManage> list = service.findAllIrdnt();
		ModelAndView mav = new ModelAndView();
		mav.setViewName("/irdntManage/irdntList");
	    mav.addObject("list", list); 
		return mav;
	}
	
	@RequestMapping("updateIrdnt")
	@ResponseBody
	public ModelAndView updateIrdnt(@ModelAttribute IrdntManage irdnt,BindingResult errors) throws Exception{
		
		IrdntManageValidator validator= new IrdntManageValidator();
		validator.validate(irdnt, errors);
		
		if(errors.hasErrors()){
			return new ModelAndView("/irdntManage/irdnt_form");
		}
		
		service.updateIrdnt(irdnt);
		
		List<IrdntManage> list = service.findAllIrdnt();
		ModelAndView mav = new ModelAndView();
		mav.setViewName("/irdntManage/irdntList");
	    mav.addObject("list", list); 
		return mav;
	}
	
	@RequestMapping("removeIrdnt")
	@ResponseBody
	public ModelAndView removeIrdnt(@RequestParam int irdntId) throws Exception{
		
		service.removeIrdnt(irdntId);
		
		List<IrdntManage> list = service.findAllIrdnt();
		ModelAndView mav = new ModelAndView();
		mav.setViewName("/irdntManage/irdntList");
	    mav.addObject("list", list); 
		return mav;
	}
	
	@RequestMapping("allIrdntList")
	@ResponseBody
	public List<IrdntManage> allIrdntList(){
		List<IrdntManage> list = service.findAllIrdnt();
		return list;
	}
	
	@RequestMapping("findIrdntByKeyword")
	@ResponseBody
	public List findIrdntByKeyword(@RequestParam String keyword, @RequestParam String searchWord){
		
		if(keyword.equals("재료명")){
			List<IrdntManage> list = service.findIrdntByIrdntName(searchWord);
			return list;
		}
		if(keyword.equals("재료id")){
			int searchWord2 = Integer.parseInt(searchWord);
			IrdntManage irdnt = service.findIrdntByIrdntId(searchWord2);
			List<IrdntManage> list = new ArrayList<>();
			list.add(irdnt);
			return list;
		}
		else{
			List<IrdntManage> list = service.findAllIrdnt();
			return list;
		}
	}
	


	
}
