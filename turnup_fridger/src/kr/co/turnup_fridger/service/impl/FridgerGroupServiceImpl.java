package kr.co.turnup_fridger.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;
import org.springframework.stereotype.Service;

import kr.co.turnup_fridger.dao.FridgerGroupDao;
import kr.co.turnup_fridger.service.FridgerGroupService;
import kr.co.turnup_fridger.vo.FridgerGroup;

@Service
public class FridgerGroupServiceImpl implements FridgerGroupService{

	@Autowired
	private FridgerGroupDao dao;
	
	public static void main(String[] args) throws Exception {
		ApplicationContext c = new ClassPathXmlApplicationContext("kr/co/turnup_fridger/config/spring/model-context.xml");
		FridgerGroupService f = (FridgerGroupService)c.getBean("fridgerGroupServiceImpl");
		
		// 추가
		//f.insertFridgerGroup(new FridgerGroup(26,6,"kgw",3));
		
		// 삭제
		//f.deleteFridgerGroup("kgw");
		
		// 하나의 공유멤버 조회
		System.out.println("--------하나의 공유멤버-------");
		System.out.println(f.selectFridgerGroupByGroupMemberId("moon"));
		
		// 한 냉장고의 공유멤버리스트
		System.out.println("--------한 냉장고의 공유멤버리스트-------");
		List<FridgerGroup> list = f.selectFridgerGroupByFridgerId(3);
		for(FridgerGroup ff : list){
			System.out.println(ff);
		}
		
		// 한 냉장고의 공유멤버 수 
		System.out.println("--------한 냉장고의 공유멤버 수-------");
		System.out.println(f.selectFridgerGroupCount(3));
		
	}
	
	@Override
	public void insertFridgerGroup(FridgerGroup fg) throws Exception {
		List<FridgerGroup> list = dao.selectFridgerGroupByFridgerId(fg.getFridgerId());
		for(FridgerGroup f : list){
			if(f.getGroupMemberId() == fg.getGroupMemberId()){
				throw new Exception("이미 해당그룹의 멤버입니다");
			}
		}
		dao.insertFridgerGroup(fg);
	}

	@Override
	public void deleteFridgerGroup(String groupMemberId) throws Exception {
		if(dao.selectFridgerGroupByGroupMemberId(groupMemberId) == null){
			throw new Exception("삭제할 그룹멤버가 없습니다");
		}
		dao.deleteFridgerGroup(groupMemberId);
	}

	@Override
	public FridgerGroup selectFridgerGroupByGroupMemberId(String groupMemberId) {
		return dao.selectFridgerGroupByGroupMemberId(groupMemberId);
	}

	@Override
	public List<FridgerGroup> selectFridgerGroupByFridgerId(int fridgerId) {
		return dao.selectFridgerGroupByFridgerId(fridgerId);
	}

	@Override
	public int selectFridgerGroupCount(int fridgerId) {
		return dao.selectFridgerGroupCount(fridgerId);
	}
	

	
}
