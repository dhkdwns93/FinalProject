package kr.co.turnup_fridger.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.co.turnup_fridger.dao.ShareRecipeIrdntDao;
import kr.co.turnup_fridger.service.ShareRecipeIrdntService;
import kr.co.turnup_fridger.vo.ShareRecipeIrdnt;

@Service
public class ShareRecipeIrdntServiceImpl implements ShareRecipeIrdntService{
	
	@Autowired
	private ShareRecipeIrdntDao dao;
	
	@Override
	public void insertShareRecipeIrdnt(ShareRecipeIrdnt shareRecipeIrdnt) {
		// TODO Auto-generated method stub
		dao.insertShareRecipeIrdnt(shareRecipeIrdnt);
	}

	@Override
	public void updateShareRecipeIrdnt(ShareRecipeIrdnt shareRecipeIrdnt) {
		// TODO Auto-generated method stub
		dao.updateShareRecipeIrdnt(shareRecipeIrdnt);
	}
	
	@Override
	public void deleteShareRecipeIrdnt(int irdntKey) {
		// TODO Auto-generated method stub
		dao.deleteShareRecipeIrdnt(irdntKey);
	}
	
	@Override
	public List<ShareRecipeIrdnt> selectShareRecipeIrdntAll() {
		// TODO Auto-generated method stub
		return dao.selectShareRecipeIrdntAll();
	}
	
	@Override
	public ShareRecipeIrdnt selectShareRecipeIrdntByIrdntId(int irdntId) {
		// TODO Auto-generated method stub
		return dao.selectShareRecipeIrdntByIrdntId(irdntId);
	}
	
	@Override
	public ShareRecipeIrdnt selectShareRecipeIrdntByRecipeId(int recipeId) {
		// TODO Auto-generated method stub
		return dao.selectShareRecipeIrdntJoinByRecipeId(recipeId);
	}
	
}
