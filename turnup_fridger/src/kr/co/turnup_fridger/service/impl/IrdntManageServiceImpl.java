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
		
		if(dao.selectIrdntByFullName(irdnt.getIrdntName())!=null){
			throw new Exception("다른 재료명을 입력해주세요.");
		}
		irdnt.setIrdntId(0);
		dao.insertIrdnt(irdnt);
		
		return "등록성공!";
	}

	@Override
	public void updateIrdnt(IrdntManage irdnt) throws Exception{
		
		//재료id로 검색해서 id가 없으면못한다고 하고, 재료명 이미 있는거 안됨.
		if(dao.selectIrdntById(irdnt.getIrdntId())==null){
			throw new Exception("없는 식재료입니다.");
		}
		
		/*if(dao.selectIrdntByFullName(irdnt.getIrdntName())!=null){
			throw new Exception("다른 재료명을 입력해주세요.");
		}*/
		
		dao.updateIrdnt(irdnt);
		
	}

	@Override
	public void removeIrdnt(int irdntId) throws Exception {
		//없는id는 삭제못하겠지 
		if(dao.selectIrdntById(irdntId)==null){
			throw new Exception("없는 식재료입니다.");
		}
		dao.deleteIrdnt(irdntId);
		System.out.println("삭제완료");
		
	}

	@Override
	public List<IrdntManage> findAllIrdnt() {
		return dao.selectAllIrdnt();
	}

	@Override
	public List<IrdntManage> findIrdntByIrdntName(String irdntName) {
		//공백들어오면? 그냥 전부나오겠네 부분검색이니까 
		return dao.selectIrdntByName(irdntName);
	}

	@Override
	public IrdntManage findIrdntByIrdntId(int irdntId) {
		//공백이거나 틀린타입이면? validation?
		return dao.selectIrdntById(irdntId);
	}

	@Override
	public List<IrdntManage> fingIrdntByIrdntCategory(String irdntCategory) {
		//이거는 드롭박스로 해서 선택하게 할거야
		return dao.selectIrdntByCategory(irdntCategory);
	}

	
}
