package kr.co.turnup_fridger.service;

import java.util.List;

import kr.co.turnup_fridger.vo.Shop;

public interface ShopService {

	/**
	 * 쇼핑몰 등록
	 * @param shop
	 */
	void insertShop(Shop shop) throws Exception;
	
	/**
	 * 쇼핑몰 삭제
	 * @param shopId
	 */
	void deleteShop(int shopId) throws Exception ;
	
	/**
	 * 하나의 쇼핑몰 조회
	 * @param shopId
	 */
	Shop selectShopById(int shopId);
	
	/**
	 * 전체쇼핑몰 리스트 조회
	 * @return
	 */
	List<Shop> selectShopList();
	
	/**
	 * 총 쇼핑몰 개수 조회
	 * @return
	 */
	int selectShopCount();
	
}
