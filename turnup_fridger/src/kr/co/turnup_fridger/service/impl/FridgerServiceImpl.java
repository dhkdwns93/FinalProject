package kr.co.turnup_fridger.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.co.turnup_fridger.dao.FridgerDao;
import kr.co.turnup_fridger.service.FridgerService;
import kr.co.turnup_fridger.vo.Fridger;
import kr.co.turnup_fridger.vo.FridgerGroup;

@Service(value="fridgerService")
public class FridgerServiceImpl implements FridgerService{

	@Autowired
	private FridgerDao dao;

	
	/*
	 * Exception 따로 만들어주기! 현재는 Exception으로 임의 처리
	 * (non-Javadoc)
	 * @see kr.co.turnup_fridger.service.FridgerService#createFridger(kr.co.turnup_fridger.vo.Fridger)
	 */
	
	@Override
	public void createFridger(Fridger fridger) throws Exception {
		System.out.println(fridger.getFridgerName());
		if(!dao.selectFridgerByFridgerName(fridger.getFridgerName()).isEmpty()){
			throw new Exception("이미 존재하는 냉장고 애칭입니다!");	
		}
		dao.insertFridger(fridger);
		System.out.println("------------등록완료");
	}

	@Override
	public void updateFridger(Fridger fridger) throws Exception {
		if(dao.selectFridgerByFridgerId(fridger.getFridgerId()) == null){
			throw new Exception("찾으시는 냉장고가 없습니다!");	
		}
		System.out.println(fridger.getFridgerName());
		if(dao.selectFridgerByFridgerFullName(fridger.getFridgerName()) != null){
			throw new Exception("이미 존재하는 냉장고 애칭입니다!");	
		}
		// 냉장고 주인 회원 수정 : 양도
		Fridger f = dao.selectFridgerAndFridgerGroupByFridgerId(fridger.getFridgerId());
		System.out.println(f);
		for(FridgerGroup fg : f.getFridgerGroupList()){
			//바꾸려는 회원이 해당 냉장고를 공유하고 있는 그룹 내 없는 회원인지 판별
			//반복문으로 그룹 회원들을 돌려보면서 아이디가 일치하는지 체크
			System.out.println(fg);
			if(fridger.getMemberId() != fg.getMemberId()){
				// 바꾸려는 아이디와 대상 아이디가 같지 않다면 다음 회원 아이디 체크
				continue;
			}else{
				// 같은 아이디가 그룹내에서 발견되면 수행하고 반복문을 빠져나온다
				dao.updateFridger(fridger);
				System.out.println("------------수정완료");
				break;
			}
		}
		// 마지막 반복까지 일치하는 아이디가 나타나지 않는 그룹에 속하지 않는 회원이므로 예외를 던진다
		throw new Exception("그룹에 존재하지 않은 회원 입니다!");
	}

	@Override
	public void removeFridger(int fridgerId) throws Exception {
		if(dao.selectFridgerByFridgerId(fridgerId) == null){
			throw new Exception("찾으시는 냉장고가 없습니다!");	
		}
		dao.deleteFridger(fridgerId);
		System.out.println("------------삭제완료");
		
	}

	

	@Override
	public List<Fridger> findFridgerAll() {
		return dao.selectFridgerAll();
	}
	
	@Override
	public Fridger findFridgerByFridgerId(int fridgerId) {
		return dao.selectFridgerByFridgerId(fridgerId);
	}

	@Override
	public Fridger findFridgerAndIrdntByFridgerId(int fridgerId) {
		return dao.selectFridgerAndIrdntByFridgerId(fridgerId);
	}

	@Override
	public Fridger findFridgerAndFridgerGroupByFridgerId(int fridgerId) {
		return dao.selectFridgerAndFridgerGroupByFridgerId(fridgerId);
	}

	@Override
	public List<Fridger> findFridgerByFridgerName(String fridgerName) {
		return dao.selectFridgerByFridgerName(fridgerName);
	}

	@Override
	public List<Fridger> findFridgerAndIrdntByFridgerName(String fridgerName) {
		return dao.selectFridgerAndIrdntByFridgerName(fridgerName);
	}

	@Override
	public List<Fridger> findFridgerAndFridgerGroupByFridgerName(String fridgerName) {
		return dao.selectFridgerAndFridgerGroupByFridgerName(fridgerName);
	}


	
	

}
