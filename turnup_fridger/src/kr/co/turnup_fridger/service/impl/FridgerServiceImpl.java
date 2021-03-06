package kr.co.turnup_fridger.service.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.co.turnup_fridger.dao.FridgerDao;
import kr.co.turnup_fridger.dao.FridgerGroupDao;
import kr.co.turnup_fridger.dao.JoinProcessDao;
import kr.co.turnup_fridger.exception.DuplicatedFridgerException;
import kr.co.turnup_fridger.exception.FindFridgerFailException;
import kr.co.turnup_fridger.exception.FindMemberFailException;
import kr.co.turnup_fridger.service.FridgerService;
import kr.co.turnup_fridger.util.PagingBean;
import kr.co.turnup_fridger.util.PagingBeanFridger;
import kr.co.turnup_fridger.vo.Fridger;
import kr.co.turnup_fridger.vo.FridgerGroup;

@Service(value="fridgerService")
public class FridgerServiceImpl implements FridgerService{

	@Autowired
	private FridgerDao fDao;

	@Autowired
	private FridgerGroupDao fgDao;
	
	@Autowired
	private JoinProcessDao jpDao;
	
	/*
	 * Exception 따로 만들어주기! 현재는 Exception으로 임의 처리
	 * (non-Javadoc)
	 * @see kr.co.turnup_fridger.service.FridgerService#createFridger(kr.co.turnup_fridger.vo.Fridger)
	 */
	
	@Override
	public void createFridger(Fridger fridger){
		System.out.println("createFridger:"+fridger.getFridgerName());//

		fDao.insertFridger(fridger);
		
		FridgerGroup fg = new FridgerGroup(0, 1, fridger.getMemberId(), fridger.getFridgerId());
		
		System.out.println(fg);
		fgDao.insertFridgerGroup(fg);
		
		System.out.println("------------등록완료");
	}

	@Override
	public void updateFridger(Fridger fridger) throws FindFridgerFailException, FindMemberFailException  {
//		System.out.println(fridger.getFridgerName());
//		System.out.println(fDao.selectFridgerByFridgerFullName(fridger.getFridgerName()));
/*		if(fDao.selectFridgerByFridgerFullName(fridger.getFridgerName()) != null){
			throw new DuplicatedFridgerException("이미 존재하는 냉장고 애칭입니다!");	
		}*/ //중복허용해야할듯요
		// 냉장고 주인 회원 수정 : 양도
		Fridger f = fDao.selectFridgerAndFridgerGroupByFridgerId(fridger.getFridgerId());
//		System.out.println(f);
		boolean validChk = false;
		for(FridgerGroup fg : f.getFridgerGroupList()){
			//바꾸려는 회원이 해당 냉장고를 공유하고 있는 그룹 내 없는 회원인지 판별
			//반복문으로 그룹 회원들을 돌려보면서 아이디가 일치하는지 체크
			System.out.println(fg);
			if(fridger.getMemberId().equals(fg.getGroupMemberId())){
				// 바꾸려는 아이디와 대상 아이디가 같으면 true
				validChk = true;
			}
		}
		if(!validChk){
			// 해당 아이디가 없으면 
			throw new FindMemberFailException("그룹에 존재하지 않은 회원 입니다!");
		}
		fDao.updateFridger(fridger);
		System.out.println("------------수정완료");
		
	}

	@Override
	public void removeFridger(int fridgerId) throws FindFridgerFailException {
		if(fDao.selectFridgerByFridgerId(fridgerId) == null){
			throw new FindFridgerFailException("찾으시는 냉장고가 없습니다!");	
		}
		jpDao.deleteJoinProcessByFridgerId(fridgerId);	//냉장고 처리목록 없에고
		fgDao.deleteFridgerGroupByFridgerId(fridgerId); //냉장고 그룹없애고
		fDao.deleteFridger(fridgerId);	//냉장고 없앤다
		System.out.println("------------삭제완료");
		
	}

	

	@Override
	public List<Fridger> findFridgerAll() {
		return fDao.selectFridgerAll();
	}
	
	@Override
	public Fridger findFridgerByFridgerId(int fridgerId) {
		return fDao.selectFridgerByFridgerId(fridgerId);
	}

	@Override
	public Fridger findFridgerAndIrdntByFridgerId(int fridgerId) {
		System.out.println("여기는 서비스 받아온 냉장고 id = "+fridgerId);
		return fDao.selectFridgerAndIrdntByFridgerId(fridgerId);
	}

	@Override
	public Fridger findFridgerAndFridgerGroupByFridgerId(int fridgerId) {
		return fDao.selectFridgerAndFridgerGroupByFridgerId(fridgerId);
	}

	@Override
	public List<Fridger> findFridgerByFridgerName(String fridgerName) {
		return fDao.selectFridgerByFridgerName(fridgerName);
	}

	@Override
	public List<Fridger> findFridgerAndIrdntByFridgerName(String fridgerName) {
		return fDao.selectFridgerAndIrdntByFridgerName(fridgerName);
	}

	@Override
	public List<Fridger> findFridgerAndFridgerGroupByFridgerName(String fridgerName) {
		return fDao.selectFridgerAndFridgerGroupByFridgerName(fridgerName);
	}

	@Override
	public List<Fridger> findFridgerByOwner(String memberId) {
		return fDao.selectFridgerByOwnerId(memberId);
	}

	@Override
	public List<Fridger> findFridgerAndFridgerGroupByOwnerId(String memberId) {
		return fDao.selectFridgerAndFridgerGroupByOwnerId(memberId);
	}

	@Override
	public List<Fridger> findFridgerAndIrdntByOwnerId(String memberId) {
		return fDao.selectFridgerAndIrdntByOwnerId(memberId);
	}

	
	
	
	/**************************페이지 처리*************************/
	
	
	@Override
	public Map<String, Object> findFridgerByFridgerNamePaging(String fridgerName, int page) {
		Map<String, Object> map = new HashMap<>();
		int totalCount=fDao.selectCountFridgerByFridgerName(fridgerName);
		PagingBeanFridger pagingBean = new PagingBeanFridger(totalCount, page);
		
		List<Fridger> list = fDao.selectFridgerByFridgerNamePaging(fridgerName, pagingBean.getBeginItemInPage(),pagingBean.getEndItemInPage());
		map.put("pagingBean", pagingBean);
		map.put("list", list);
		
		return map;
	}
	
	@Override
	public Map<String, Object> findFridgerByOwnerPaging(String memberId, int page) {
		Map<String, Object> map = new HashMap<>();
		int totalCount=fDao.selectCountFridgerByOwnerId(memberId);
		PagingBeanFridger pagingBean = new PagingBeanFridger(totalCount, page);
		
		List<Fridger> list = fDao.selectFridgerByOwnerIdPaging(memberId, pagingBean.getBeginItemInPage(),pagingBean.getEndItemInPage());
		map.put("pagingBean", pagingBean);
		map.put("list", list);
		
		return map;
	}

	
	
	
	

}
