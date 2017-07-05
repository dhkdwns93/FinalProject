package kr.co.turnup_fridger.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.co.turnup_fridger.dao.IrdntManageDao;
import kr.co.turnup_fridger.service.IrdntManageService;
import kr.co.turnup_fridger.vo.IrdntManage;

@Service(value="IrdntManageService")
public class IrdntManageServiceImpl implements IrdntManageService{

	@Autowired
	private IrdntManageDao dao;
	
	@Override
	public String createIrdnt(IrdntManage irdnt) throws Exception{
		
		if(!dao.selectIrdntByFullName(irdnt.getIrdntName()).isEmpty()){
			System.out.println("뭐가잡혔어? "+ irdnt);
			throw new Exception("다른 재료명을 입력해주세요.");
		}
		irdnt.setIrdntId(0);
		System.out.println(irdnt);
		dao.insertIrdnt(irdnt);
		System.out.println("serviceImpl : "+ irdnt);
		
		return "등록성공!";
	}

	@Override
	public String updateIrdnt(IrdntManage irdnt) throws Exception{
		
		//재료id로 검색해서 id가 없으면못한다고 하고, 재료명 이미 있는거 안됨.
		if(dao.selectIrdntById(irdnt.getIrdntId())==null){
			throw new Exception("없는 식재료입니다.");
		}
		if(dao.selectIrdntByFullName(irdnt.getIrdntName())!=null){
			throw new Exception("다른 재료명을 입력해주세요.");
		}
		dao.updateIrdnt(irdnt);
		return "수정성공!";
	}

	@Override
	public void removeIrdnt(int irdntId) throws Exception {
		//없는id는 삭제못하겠지 
		if(dao.selectIrdntById(irdntId)==null){
			throw new Exception("없는 식재료입니다.");
		}
		dao.deleteIrdnt(irdntId);
	
	}
	
	@Override
	public List<IrdntManage> findAllIrdnt() {
		return dao.selectAllIrdnt();
	}

	@Override
	public IrdntManage findIrdntByIrdntId(int irdntId) {
		return dao.selectIrdntById(irdntId);
	}

	@Override
	public List<IrdntManage> findIrdntsByKeyword(String irdntName, String irdntCategory) {
		return dao.selectIrdntsBykeyword(irdntName, irdntCategory);
	}

	@Override
	public List<String> findAllIrdntCategory() {
		return dao.selectAllIrdntCategory();
	}
	


	
}
