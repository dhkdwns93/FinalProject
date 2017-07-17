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
	public void insertShareRecipeIrdnt(ShareRecipeIrdnt shareRecipeIrdnt) throws Exception {
	/*if(dao.selectShareRecipeIrdntByRecipeIdByIrdntId(shareRecipeIrdnt)!=null){
		throw new Exception("이미 등록된 재료입니다.");
	}*/
		dao.insertShareRecipeIrdnt(shareRecipeIrdnt);
	}

	@Override
	public void updateShareRecipeIrdnt(ShareRecipeIrdnt shareRecipeIrdnt) throws Exception {
	/*	if(dao.selectShareRecipeByIrdntKey(shareRecipeIrdnt.getIrdntKey())==null){
			throw new Exception("등록되지 않은 재료입니다.");
		}*/
		dao.updateShareRecipeIrdnt(shareRecipeIrdnt);
	}
	
	@Override
	public void deleteShareRecipeIrdnt(int irdntKey) throws Exception {
		/*if(dao.selectShareRecipeByIrdntKey(irdntKey)==null){
			throw new Exception("등록되지 않은 재료 입니다.");
		}*/
		dao.deleteShareRecipeIrdnt(irdntKey);
	}
	@Override
	public void deleteShareRecipeIrdntByRecipeId(int recipeId) {
		// TODO Auto-generated method stub
		dao.deleteShareRecipeIrdntByRecipeId(recipeId);
	}

	@Override
	public void deleteShareRecipeIrdntByIrdntId(int irdntId) {
		// TODO Auto-generated method stub
		dao.deleteShareRecipeIrdntByIrdntId(irdntId);
	}
	
	


	@Override
	public ShareRecipeIrdnt selectShareRecipeByIrdntName(String irdntName) {
		// TODO Auto-generated method stub
		return dao.selectShareRecipeByIrdntName(irdntName);
	}
	
	
	@Override
	public ShareRecipeIrdnt selectShareRecipeByIrdntKey(int irdntKey) {
		// TODO Auto-generated method stub
		return dao.selectShareRecipeByIrdntKey(irdntKey);
	}
	@Override
	public ShareRecipeIrdnt selectShareRecipeIrdntByRecipeIdByIrdntId(ShareRecipeIrdnt shareRecipeIrdnt) {
		// TODO Auto-generated method stub
		return dao.selectShareRecipeIrdntByRecipeIdByIrdntId(shareRecipeIrdnt);
	}
	
	@Override
	public ShareRecipeIrdnt selectShareRecipeIrdntByRecipeIdNotList(int recipeId) {
		// TODO Auto-generated method stub
		return dao.selectShareRecipeIrdntByRecipeIdNotList(recipeId);
	}

	@Override
	public List<ShareRecipeIrdnt> selectShareRecipeIrdntByRecipeId(int recipeId) {
		// TODO Auto-generated method stub
		return dao.selectShareRecipeIrdntByRecipeId(recipeId);
	}

	
	
	//////////////////////////////////////
	@Override
	public List<ShareRecipeIrdnt> findShareRecipeIrdntByRecipeId(int recipeId) {
		// TODO Auto-generated method stub
		return dao.findShareRecipeIrdntByRecipeId(recipeId);
	}
	
	
	
}
