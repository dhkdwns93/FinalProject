package kr.co.turnup_fridger.service.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.co.turnup_fridger.dao.IrdntManageDao;
import kr.co.turnup_fridger.exception.DuplicateIrdntException;
import kr.co.turnup_fridger.exception.NoneIrdntException;
import kr.co.turnup_fridger.service.IrdntManageService;
import kr.co.turnup_fridger.util.PagingBean;
import kr.co.turnup_fridger.vo.IrdntManage;

@Service(value="IrdntManageService")
public class IrdntManageServiceImpl implements IrdntManageService{

	@Autowired
	private IrdntManageDao dao;
	
	@Override
	public void createIrdnt(IrdntManage irdnt) throws DuplicateIrdntException{

		if (!dao.selectIrdntByFullName(irdnt.getIrdntName()).isEmpty()) {
			throw new DuplicateIrdntException("다른 재료명을 입력해주세요.");
		}
		irdnt.setIrdntId(0);
	
		dao.insertIrdnt(irdnt);
		

	}

	@Override
	public void updateIrdnt(IrdntManage irdnt) throws NoneIrdntException{
		
		//재료id로 검색해서 id가 없으면못한다고 하고, 재료명 이미 있는거 안됨.
		if(dao.selectIrdntById(irdnt.getIrdntId())==null){			
			throw new NoneIrdntException("없는 식재료입니다.");
		}

		dao.updateIrdnt(irdnt);
		
		
	}

	@Override
	public void removeIrdnt(int irdntId) throws NoneIrdntException {
		//없는id는 삭제못하겠지 
		if(dao.selectIrdntById(irdntId)==null){
			throw new NoneIrdntException("없는 식재료입니다.");
		}
		dao.deleteIrdnt(irdntId);
	
	}
	
	@Override
	public Map<String,Object> findAllIrdnt(int page) {
		HashMap<String,Object> map = new HashMap<>();
		int totalCount = dao.selectAllIrdntCount();
		PagingBean pageBean = new PagingBean(totalCount,page);
		
		List<IrdntManage> list = dao.selectAllIrdnt(pageBean.getBeginItemInPage(), pageBean.getEndItemInPage());
		map.put("pageBean", pageBean);
		map.put("list", list);
		
		return map;
	}

	@Override
	public List<IrdntManage> fingAllIrdntNotPaging() {
		return dao.selectAllIrdntNotPaging();
	}

	@Override
	public IrdntManage findIrdntByIrdntId(int irdntId) {
		return dao.selectIrdntById(irdntId);
	}

	@Override
	public Map<String,Object> findIrdntsByKeyword(String irdntName, String irdntCategory,int page) {
		HashMap<String,Object> map = new HashMap<>();
		int totalCount= dao.selectIrdntsBykeywordCount(irdntName, irdntCategory);
		PagingBean pageBean = new PagingBean(totalCount,page);
		
		List<IrdntManage> list = dao.selectIrdntsBykeyword(irdntName, irdntCategory, pageBean.getBeginItemInPage(), pageBean.getEndItemInPage());
		map.put("pageBean", pageBean);
		map.put("list", list);
		return map;
	}

	@Override
	public List<String> findAllIrdntCategory() {
		return dao.selectAllIrdntCategory();
	}

	@Override
	public List<IrdntManage> findIrdntByName(String irdntName) {
		return dao.selectIrdntByName(irdntName);
	}
	
	
	
	
}
