package kr.co.turnup_fridger.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import kr.co.turnup_fridger.dao.FridgerDao;
import kr.co.turnup_fridger.service.FridgerService;
import kr.co.turnup_fridger.vo.Fridger;
import kr.co.turnup_fridger.vo.FridgerGroup;

@Repository
public class FridgerServiceImpl implements FridgerService{

	@Autowired
	private FridgerDao dao;

	@Override
	public void createFridger(Fridger fridger) throws Exception {
		if(dao.selectFridgerByFridgerName(fridger.getFridgerName()) != null){
			throw new Exception("이미 존재하는 냉장고 애칭입니다!");	
		}
		dao.insertFridger(fridger);
	}

	@Override
	public void updateFridger(Fridger fridger) throws Exception {
		if(dao.selectFridgerByFridgerId(fridger.getFridgerId()) == null){
			throw new Exception("찾으시는 냉장고가 없습니다!");	
		}
		if(dao.selectFridgerByFridgerName(fridger.getFridgerName()) != null){
			throw new Exception("이미 존재하는 냉장고 애칭입니다!");	
		}
		for(FridgerGroup fg : dao.selectFridgerAndFridgerGroupByFridgerId(fridger.getFridgerId()).getFridgerGroupList()){
			if(fridger.getMemberId() == fg.getMemberId()){
				dao.updateFridger(fridger);
				break;
			}else{
				// 수정해야할 곳 
			}
			throw new Exception("그룹에 존재하지 않은 회원 입니다!");
		}
		
		
	}

	@Override
	public void removeFridger(Fridger fridger) {
		// TODO Auto-generated method stub
		
	}

	@Override
	public Fridger findFridgerByFridgerId(int fridgerId) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public Fridger findFridgerAndIrdntByFridgerId(int fridgerId) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public Fridger findFridgerAndFridgerGroupByFridgerId(int fridgerId) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public List<Fridger> findFridgerByFridgerName(String fridgerName) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public List<Fridger> findFridgerAndIrdntByFridgerName(String fridgerName) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public List<Fridger> findFridgerAndFridgerGroupByFridgerName(String fridgerName) {
		// TODO Auto-generated method stub
		return null;
	}
	
	

}
