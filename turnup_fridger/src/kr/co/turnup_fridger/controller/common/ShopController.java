package kr.co.turnup_fridger.controller.common;

import java.util.List;

import javax.validation.Valid;

import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.validation.Errors;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import kr.co.turnup_fridger.service.ShopService;
import kr.co.turnup_fridger.validation.form.ShopForm;
import kr.co.turnup_fridger.vo.Shop;

@RequestMapping("/shop/")
public class ShopController {

	@Autowired
	private ShopService service;
	
	// 관리자
	@RequestMapping(value="addShop", produces="text/html;charset=UTF-8")
	public ModelAndView addShop(@ModelAttribute("shop") @Valid ShopForm shopForm, Errors errors){
		
		if(errors.hasErrors()){
			return new ModelAndView("shop/shop_register_form");
		}
		
		Shop shop = new Shop();
		BeanUtils.copyProperties(shopForm, shop);
		try {
			service.insertShop(shop);
		} catch (Exception e) {
			return new ModelAndView("shop/shop_register_form", "error", errors);
		}
		return new ModelAndView("shop/addShop");
	}
	
	// 관리자
	@RequestMapping(value="removeShop", produces="text/html;charset=UTF-8")
	@ResponseBody
	public ModelAndView removeShop(int shopId, Errors errors){
		if(errors.hasErrors()){
			return new ModelAndView("shop/shopList");
		}
		try {
			service.deleteShop(shopId);
		} catch (Exception e) {
			return new ModelAndView("shop/shopList", "error", errors);
		}
		return new ModelAndView("shop/shopList");
	}
	
	// 하나의 쇼핑몰 조회 (뷰X)
	@RequestMapping(value="findShopById", produces="text/html;charset=UTF-8")
	@ResponseBody
	public Shop findShop(int shopId){
		return service.selectShopById(shopId);
	}
	
	// 쇼핑몰 전체목록(회원, 관리자)
	@RequestMapping(value="findShopList", produces="text/html;charset=UTF-8")
	@ResponseBody
	public List<Shop> findShopList(){
		return service.selectShopList();
	}
	
	// 쇼핑몰 총 개수(회원, 관리자)
	@RequestMapping(value="findShopCount", produces="text/html;charset=UTF-8")
	@ResponseBody
	public int findShopCount(){
		return service.selectShopCount();
	}
	
}
