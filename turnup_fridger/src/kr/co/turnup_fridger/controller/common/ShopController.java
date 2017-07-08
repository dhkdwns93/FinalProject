package kr.co.turnup_fridger.controller.common;

import java.io.File;
import java.io.FileOutputStream;
import java.io.InputStream;
import java.util.List;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.validation.Errors;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import kr.co.turnup_fridger.service.ShopService;
import kr.co.turnup_fridger.validation.ShopValidator;
import kr.co.turnup_fridger.vo.Shop;

@Controller
@RequestMapping("/shop/")
public class ShopController {

	@Autowired
	private ShopService service;
	
	//이미지 경로
	private String eclipseDir = "C:\\Java\\eclipse\\workspace_web\\turnup_fridger1\\WebContent\\up_image"; 
	
	private void copyToEclipseDir(String newImageName, MultipartFile upImage) throws Exception{
		File eclipseDest = new File(eclipseDir, newImageName);
		FileOutputStream fo = new FileOutputStream(eclipseDest);
		InputStream is = upImage.getInputStream();
		byte [] b = new byte[10000];
		int cnt = is.read(b);
		while(cnt != -1){
			fo.write(b, 0, cnt);
			cnt = is.read(b);
		}
		fo.close();
		is.close();
	}
	
	// 등록(관리자) - O
	@RequestMapping(value="addShop", method=RequestMethod.POST )
	public ModelAndView addShop(@ModelAttribute Shop shop ,BindingResult errors, HttpServletRequest req) throws Exception{
		System.out.println("=== shop controller - 진입 ===");
	
		ShopValidator val = new ShopValidator();
		val.validate(shop, errors);
		
		if(errors.hasErrors()){
			return new ModelAndView("common/shop/shop_register_form.tiles");
		}
		
		System.out.println("=== shop controller - 검증 마침 ===");
		
		ModelAndView mav = new ModelAndView();
		String upImageDir = req.getServletContext().getRealPath("/up_image");
		MultipartFile upImage = shop.getUpImage();
		
		String fname = upImage.getOriginalFilename();
		
		if (fname.equals("")) {
			shop.setSaveImg(null);
			service.insertShop(shop);
	     } else if(upImage!=null && !upImage.isEmpty()) {
			shop.setShopImg(upImage.getOriginalFilename());
			String newImageName = UUID.randomUUID().toString();
			shop.setSaveImg(newImageName);
			File dest = new File(upImageDir);
			
			// 이클립스 경로로 카피
			copyToEclipseDir(newImageName,upImage);
			// 파일 이동
			upImage.transferTo(dest);
			// 저장
			service.insertShop(shop);
		}
		System.out.println(" 등록 됐지롱");
		mav.addObject("shop",shop);
		mav.setViewName("common/shop/shopList.tiles");
		mav.addObject("shop", service.selectShopById(shop.getShopId()));
		return mav;	
	}
	
	// 삭제(관리자) - shopId를 이상하게 넘겨줌 
	@RequestMapping(value="removeShop", produces="text/html;charset=UTF-8")
	@ResponseBody
	public String removeShop(String shopId){
		System.out.println(" === shop 삭제 === ");
		int sId = Integer.parseInt(shopId);
		try {
			service.deleteShop(sId);
		} catch (Exception e) {
			return "";
		}
		return "삭제완료";
	}
	
	// 쇼핑몰 전체목록(회원, 관리자) - O
	@RequestMapping("findShopList")
	public ModelAndView findShopList(){
		List<Shop> list = service.selectShopList();
		System.out.println("=== shop List ===");
		return new ModelAndView("common/shop/shopList.tiles", "list", list);
	}
	
	// 쇼핑몰 총 개수(회원, 관리자) - O
	@RequestMapping("findShopCount")
	@ResponseBody
	public int findShopCount(){
		return service.selectShopCount();
	}
	
}
