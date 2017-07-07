package kr.co.turnup_fridger.controller.admin;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import kr.co.turnup_fridger.exception.DuplicateIrdntException;
import kr.co.turnup_fridger.exception.NoneIrdntException;
import kr.co.turnup_fridger.service.IrdntManageService;
import kr.co.turnup_fridger.validation.IrdntManageValidator;
import kr.co.turnup_fridger.vo.IrdntManage;

@Controller
@RequestMapping("/common/admin/irdntManage/")
public class IrdntManageController {

	@Autowired
	private IrdntManageService service;
	
	@RequestMapping(value="createIrdnt", produces="html/text;charset=UTF-8;")
	@ResponseBody
	public ModelAndView createIrdnt(@ModelAttribute IrdntManage irdnt,BindingResult errors){
		
		IrdntManageValidator validator= new IrdntManageValidator();
		validator.validate(irdnt, errors);
		System.out.println(irdnt);
	
		if(errors.hasErrors()){
			System.out.println("haserror");
			return new ModelAndView("common/admin/irdntManage/irdnt_form");
		}
		
		try {
		service.createIrdnt(irdnt);
				
		} catch (DuplicateIrdntException e) {
			return new ModelAndView("common/admin/irdntManage/irdnt_form", "errorMsg_irdntName", e.getMessage());
		}		
		return new ModelAndView("common/admin/irdntManage/create_success");

	}
	
	@RequestMapping(value="updateIrdnt",produces="html/text;charset=UTF-8;")
	@ResponseBody
	public ModelAndView updateIrdnt(@ModelAttribute IrdntManage irdnt,BindingResult errors){
		
		IrdntManageValidator validator= new IrdntManageValidator();
		validator.validate(irdnt, errors);
		
		if(errors.hasErrors()){
			return new ModelAndView("common/admin/irdntManage/irdnt_update_form");
		}
		try {
			service.updateIrdnt(irdnt);
		} catch (DuplicateIrdntException e) {
			return new ModelAndView("common/admin/irdntManage/irdnt_update_form","errorMsg_irdntName",e.getMessage());			
		}catch(NoneIrdntException e){
			return new ModelAndView("common/admin/irdntManage/irdnt_update_form","errorMsg_irdntId",e.getMessage());
		}
		return new ModelAndView("common/admin/irdntManage/irdntList");
	}
	
	@RequestMapping(value="removeIrdnt" , produces="html/text;charset=UTF-8;")
	@ResponseBody
	public String removeIrdnt(@RequestParam int irdntId){
		try {
			service.removeIrdnt(irdntId);
		} catch (NoneIrdntException e) {
			return "삭제가 안되썽"+e.getMessage();
		}
		return "삭제완료";
	}
	
	
	@RequestMapping("allIrdntList")
	@ResponseBody
	public List<IrdntManage> allIrdntList(){
		List<IrdntManage> list = service.findAllIrdnt();
		return list;
	}
	
	@RequestMapping("findIrdntByKeyword")
	@ResponseBody
	public List<IrdntManage> findIrdntByKeyword(@RequestParam String irdntName,@RequestParam String irdntCategory){
		List<IrdntManage> list = service.findIrdntsByKeyword(irdntName, irdntCategory);
		return list;

	}
	
	@RequestMapping("findAllICategory")
	
	public ModelAndView findAllCategory(){
		List<String> list = service.findAllIrdntCategory();
		//System.out.println(list);
		return new ModelAndView("common/admin/irdntManage/irdntList","irdntCategory",list);
	}
	
	@RequestMapping("findAllICategory2")
	@ResponseBody
	public ModelAndView findAllCategory2(){
		List<String> list = service.findAllIrdntCategory();
		return new ModelAndView("common/admin/irdntManage/irdnt_form","irdntCategory",list);
	}
	
	
/*	@RequestMapping("findAllICategory")
	@ResponseBody
	public List<String> findAllCategory(){
		List<String> list = service.findAllIrdntCategory();
		return new ModelAndView("common/admin/irdntManage/irdntList","irdntCategory",list);
	}
	*/
	
	
	/*@RequestMapping("findIrdntByName" )
	@ResponseBody
	public List<IrdntManage> findIrdntByName(@RequestParam String irdntName){
		System.out.println("받아는오니? ");
		List<IrdntManage> list = service.findIrdntByName(irdntName);
		return list;
	}*/

	
}
