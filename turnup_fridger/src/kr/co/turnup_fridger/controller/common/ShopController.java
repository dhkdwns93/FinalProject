package kr.co.turnup_fridger.controller.common;

import java.io.File;
import java.io.IOException;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.ui.ModelMap;
import org.springframework.validation.Errors;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import kr.co.turnup_fridger.service.ShopService;
import kr.co.turnup_fridger.vo.Shop;

@RequestMapping("/shop/")
public class ShopController {

	@Autowired
	private ShopService service;
	
	// 관리자
	@RequestMapping(value="addShop", method=RequestMethod.POST)
	public ModelAndView addShop(@RequestParam String shopName, @RequestParam String url, @RequestParam MultipartFile shopImg, HttpServletRequest req, ModelMap map) throws IllegalStateException, IOException{
		Shop shop = new Shop();
		shop.setShopName(shopName);
		shop.setShopAddress(url);
		shop.setShopImg(shopImg.getOriginalFilename()); //
		
		if(shopImg != null && !shopImg.isEmpty()){
			String fileName = shopImg.getOriginalFilename();
			File dest = new File(req.getServletContext().getRealPath("/up_images"), fileName); 
			shopImg.transferTo(dest);
			
			shop = new Shop(0, shopName, url, fileName);
			map.addAttribute("shop", shop);
			map.addAttribute("fileName", fileName);
		}
		
		try {
			service.insertShop(shop);
		} catch (Exception e) {
			return new ModelAndView("shop/shop_register_form", "error", "등록실패");
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
	@RequestMapping("findShopList")
	public ModelAndView findShopList(){
		System.out.println("=== shop List ===");
		List<Shop>list = service.selectShopList();
		return new ModelAndView("common/shop/shopList", "list", list);
	}
	
	// 쇼핑몰 총 개수(회원, 관리자)
	@RequestMapping(value="findShopCount", produces="text/html;charset=UTF-8")
	@ResponseBody
	public int findShopCount(){
		return service.selectShopCount();
	}
	
}
