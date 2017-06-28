package kr.co.turnup_fridger.dao;

import java.util.List;

import kr.co.turnup_fridger.vo.Shop;

public interface ShopDao {

	/**
	 *  한개의 쇼핑몰정보를 등록하는 메소드
	 * @param session
	 * @param shop
	 * @return
	 */
	public int insertShop(Shop shop);
	
	/**
	 * 한개의 쇼핑몰정보를 삭제하는 메소드
	 * @param session
	 * @param shopId
	 * @return
	 */
	public int deleteShop(int shopId);
	
	/**
	 * 전체 쇼핑몰리스트를 조회하는 메소드
	 * @param session
	 * @return
	 */
	public List<Shop> selectShopList();
	
	/**
	 * 총 쇼핑몰의 개수를 조회하는 메소드
	 * @param session
	 * @return
	 */
	public int selectShopCount();
}
