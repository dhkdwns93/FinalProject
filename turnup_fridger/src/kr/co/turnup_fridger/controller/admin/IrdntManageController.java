package kr.co.turnup_fridger.controller.admin;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
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
	public ModelAndView createIrdnt(@ModelAttribute IrdntManage irdnt,BindingResult errors){
		
		IrdntManageValidator validator= new IrdntManageValidator();
		validator.validate(irdnt, errors);
	
		if(errors.hasErrors()){
			System.out.println("발리데이션");
			
			//여기서 새페이지 열리네... 그냥 그 팝업창에서 처리하고싶다. 
			return new ModelAndView("common/admin/irdntManage/irdnt_form");
		}
		
		try {
		service.createIrdnt(irdnt);
				
		} catch (DuplicateIrdntException e) {
			return new ModelAndView("common/admin/irdntManage/irdnt_form", "errorMsg_irdntName", e.getMessage());
		}		
		return new ModelAndView("redirect:successCreateIrdnt.do");
	}
	
	@RequestMapping("successCreateIrdnt")
	public ModelAndView successCreateIrdnt(String msg){
		return new ModelAndView("common/admin/irdntManage/irdntList.tiles","success_msg","등록성공!");
	}
	
	
	@RequestMapping(value="updateIrdnt",produces="html/text;charset=UTF-8;")
	public ModelAndView updateIrdnt(@ModelAttribute IrdntManage irdnt,BindingResult errors){
		
		System.out.println("받아온거 : " + irdnt);
		IrdntManageValidator validator= new IrdntManageValidator();
		validator.validate(irdnt, errors);
		
		if(errors.hasErrors()){
			System.out.println("발리데이터에서 잡힘");
			return new ModelAndView("common/admin/irdntManage/irdnt_update_form");
		}
		try {
			service.updateIrdnt(irdnt);	
		}catch(NoneIrdntException e){
			return new ModelAndView("common/admin/irdntManage/irdnt_update_form","errorMsg_irdntId",e.getMessage());
		}
		return new ModelAndView("common/admin/irdntManage/irdntList.tiles");
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
		return new ModelAndView("common/admin/irdntManage/irdntList.tiles","irdntCategory",list);
	}
	
	@RequestMapping("findAllICategory2")
	public ModelAndView findAllCategory2(){
		List<String> list = service.findAllIrdntCategory();
		return new ModelAndView("common/admin/irdntManage/irdnt_form","irdntCategory",list);
	}
	
	@RequestMapping("findIrdntById")
	public ModelAndView findIrdntByKey(@RequestParam int irdntId){
		IrdntManage irdnt = service.findIrdntByIrdntId(irdntId);
		ModelMap map = new ModelMap();
		List<String> list = service.findAllIrdntCategory();
		map.addAttribute("list", list);
		map.addAttribute("irdnt", irdnt);
		return new ModelAndView("common/admin/irdntManage/irdnt_update_form",map);
	}
	
	//레시피 등록/수정시 필요!
	@RequestMapping("findIrdntByName")
	@ResponseBody
	public List<IrdntManage> findIrdntByName(@RequestParam String irdntName){
		System.out.println("findIrdntByName 핸들러: irdntName:"+irdntName);//받아옴
		List<IrdntManage> list = service.findIrdntByName(irdntName);
		System.out.println(list);
		return list;
	}
	
	
	
/*	@RequestMapping("findAllICategory")
	@ResponseBody
	public List<String> findAllCategory(){
		List<String> list = service.findAllIrdntCategory();
		return new ModelAndView("common/admin/irdntManage/irdntList","irdntCategory",list);
	}
	*/
	
	
	

	
}
