package kr.co.turnup_fridger.controller.member;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import kr.co.turnup_fridger.service.MyIrdntService;
import kr.co.turnup_fridger.validation.MyIrdntForm;
import kr.co.turnup_fridger.vo.MyIrdnt;

@Controller
@RequestMapping("/myIrdnt/")
public class MyIrdntController {

	@Autowired
	private MyIrdntService service;
	
	@RequestMapping("createMyIrdnt")
	public ModelAndView createMyIrdnt(@ModelAttribute ("myIrdnt") MyIrdntForm myIrdntForm, @RequestParam int fridgerId, BindingResult errors) throws Exception{
		
		/*MyIrdntValidator validator = new MyIrdntValidator();
		validator.validate(irdnt, errors);*/
		
		if(errors.hasErrors()){
			return new ModelAndView("/myIrdnt/myIrdnt_form");
		}
		
		MyIrdnt myIrdnt = new MyIrdnt();
		BeanUtils.copyProperties(myIrdntForm, myIrdnt);
		service.createMyIrdnt(myIrdnt);
		
		List<MyIrdnt> list = service.findAllMyIrdntByFridgerId(fridgerId);
		ModelAndView mav = new ModelAndView();
		mav.setViewName("/myIrdnt/myIrdntList");
	    mav.addObject("list", list); 
	    return mav;
		
	}
	
	@RequestMapping("updateMyIrdnt")
	public ModelAndView updateMyIrdnt(@ModelAttribute ("myIrdnt") MyIrdntForm myIrdntForm,BindingResult errors,@RequestParam int fridgerId) throws Exception{
		
		/*MyIrdntValidator validator = new MyIrdntValidator();
		validator.validate(irdnt, errors);*/
		
		if(errors.hasErrors()){
			return new ModelAndView("/myIrdnt/myIrdnt_form");
		}
		MyIrdnt myIrdnt = new MyIrdnt();
		BeanUtils.copyProperties(myIrdntForm, myIrdnt);
		service.updateMyIrdnt(myIrdnt);
		
		List<MyIrdnt> list = service.findAllMyIrdntByFridgerId(fridgerId);
		ModelAndView mav = new ModelAndView();
		mav.setViewName("/myIrdnt/myIrdntList");
	    mav.addObject("list", list); 
	    return mav;
	}
	
	@RequestMapping("removeMyIrdnt")
	public ModelAndView removeMyIrdnt(@RequestParam int irdntKey,@RequestParam int fridgerId) throws Exception{
		service.removeMyIrdnt(irdntKey);
		
		List<MyIrdnt> list = service.findAllMyIrdntByFridgerId(fridgerId);
		ModelAndView mav = new ModelAndView();
		mav.setViewName("/myIrdnt/myIrdntList");
	    mav.addObject("list", list); 
	    return mav;
		
	
	}
	
	@RequestMapping("allMyIrdntList")
	public ModelAndView allMyIrdntList(@RequestParam int fridgerId){
		List<MyIrdnt> list = service.findAllMyIrdntByFridgerId(fridgerId);
		ModelAndView mav = new ModelAndView();
		mav.setViewName("/myIrdnt/myIrdntList");
	    mav.addObject("list", list); 
	    return mav;
	}
	
	@RequestMapping("findMyIrdntByKeyword")
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
	}
}
