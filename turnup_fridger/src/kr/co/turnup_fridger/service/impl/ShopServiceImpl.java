package kr.co.turnup_fridger.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;
import org.springframework.stereotype.Service;

import kr.co.turnup_fridger.dao.ShopDao;
import kr.co.turnup_fridger.service.ShopService;
import kr.co.turnup_fridger.vo.Shop;


@Service
public class ShopServiceImpl implements ShopService{
	
	public static void main(String[] args)  throws Exception{
		
		ApplicationContext c = new ClassPathXmlApplicationContext("kr/co/turnup_fridger/config/spring/model-context.xml");
		
		ShopService s = (ShopService)c.getBean("shopServiceImpl");
		
		
		// 쇼핑몰 추가
		s.insertShop( new Shop(7, "이름", "주소", "사진"));
		//System.out.println(shop.getShopName()+"이 등록되었습니다." );
		System.out.println("--------------------");
		// 쇼핑몰 삭제
		s.deleteShop(1);
		System.out.println("--------------------");
		// 총 쇼핑몰개수
		System.out.println("총 개수 : "+s.selectShopCount());
		System.out.println("--------------------");
		// 하나의 쇼핑몰 조회
		System.out.println(s.selectShopById(1));
		System.out.println("--------------------");
		// 전체 쇼핑몰 조회 
		List<Shop> list = s.selectShopList();
		for(Shop sh : list){
			System.out.println(sh);
		}
		
	}
	
	@Autowired
	private ShopDao dao;

	@Override // 쇼핑몰 등록
	public void insertShop(Shop shop)  throws Exception{
		if(dao.selectShopById(shop.getShopId())!= null){
			throw new Exception("이미 존재하는 쇼핑몰입니다");
		}
		dao.insertShop(shop);
	}

	@Override // 쇼핑몰 삭제
	public void deleteShop(int shopId)  throws Exception {
		if(dao.selectShopById(shopId) == null){
			throw new Exception("해당 쇼핑몰이 존재하지 않습니다");
		}
		dao.deleteShop(shopId);
	}

	@Override // 하나의 쇼핑몰 조회
	public Shop selectShopById(int shopId) {
		return dao.selectShopById(shopId);
	}

	@Override // 전체쇼핑몰 리스트 조회
	public List<Shop> selectShopList() {
		return dao.selectShopList();
	}

	@Override // 총 쇼핑몰 개수 조회
	public int selectShopCount() {
		return dao.selectShopCount();
	}

	
}
