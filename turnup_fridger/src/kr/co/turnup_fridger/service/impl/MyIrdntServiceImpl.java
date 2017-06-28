package kr.co.turnup_fridger.service.impl;

import java.util.Date;
import java.util.List;

import org.springframework.stereotype.Repository;

import kr.co.turnup_fridger.service.MyIrdntService;
import kr.co.turnup_fridger.vo.MyIrdnt;

@Repository
public class MyIrdntServiceImpl implements MyIrdntService{

	@Override
	public void createMyIrdnt(MyIrdnt myIrdnt) {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void updateMyIrdnt(MyIrdnt myIrdnt) {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void removeMyIrdnt() {
		// TODO Auto-generated method stub
		
	}

	@Override
	public List<MyIrdnt> findAllMyIrdntByFridgerId(int fridgerId) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public List<MyIrdnt> findMyIrdntByIrdntName(String irdntName) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public int getFreshLevel(MyIrdnt myirdnt) {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public MyIrdnt fingMyIrdntBymyIrdntKey(int myIrdntKey) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public List<MyIrdnt> findMyIrdntByStartDate(Date startDate) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public List<MyIrdnt> findMyIrdntByEndDate(Date endDate) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public List<MyIrdnt> findMyIrdntByFreshLevel(int freshLevel) {
		// TODO Auto-generated method stub
		return null;
	}

	
}
