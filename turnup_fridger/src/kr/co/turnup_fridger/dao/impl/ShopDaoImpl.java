package kr.co.turnup_fridger.dao.impl;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import kr.co.turnup_fridger.dao.ShopDao;
import kr.co.turnup_fridger.vo.Shop;

@Repository
public class ShopDaoImpl implements ShopDao{
	
	@Autowired
	private SqlSessionTemplate session;

	private String sql = "kr.co.turnUp_fridger.config.mybatis.mapper.shopMapper.";
	
	@Override
	public int insertShop(Shop shop) {
		return session.insert(sql+"insertShop", shop);
	}

	@Override
	public int deleteShop(int shopId) {
		return session.delete(sql+"deleteShop", shopId);
	}

	@Override
	public List<Shop> selectShopList() {
		return session.selectList(sql+"selectShopList");
	}

	@Override
	public int selectShopCount() {
		return session.selectOne(sql+"selectShopCount");
	}

	
}
