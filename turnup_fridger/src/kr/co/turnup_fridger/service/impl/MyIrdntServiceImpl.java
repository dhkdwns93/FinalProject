package kr.co.turnup_fridger.service.impl;

import java.util.Calendar;
import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.co.turnup_fridger.dao.IrdntManageDao;
import kr.co.turnup_fridger.dao.MyIrdntDao;
import kr.co.turnup_fridger.service.MyIrdntService;
import kr.co.turnup_fridger.vo.MyIrdnt;

@Service(value="MyIrdntService")
public class MyIrdntServiceImpl implements MyIrdntService{

	@Autowired
	private MyIrdntDao dao;
	@Autowired
	private IrdntManageDao irdntDao;
	
	@Override
	public void createMyIrdnt(MyIrdnt myIrdnt) throws Exception {
		if(dao.selectMyIrdntByKey(myIrdnt.getMyIrdntKey())!=null){
			throw new Exception("이미 있는 식재료입니다.");
		}
		//받아올 값 = 재료id, 보관시작일, 유통기한, 수량메모, 재료id, 냉장고id, 보관시작상태 
		//수정해서 넣을값 = 식재료key(시퀀스), 신선도(계산), 재료이름(매치해서 넣자)
		//여기서 넣을때 신선도 계산해서 넣어야지 
		String FreshLevel = getFreshLevel(myIrdnt);

		String IrdntName = irdntDao.selectIrdntById(myIrdnt.getIrdntId()).getIrdntName();
		
		
		MyIrdnt newMyIrdnt= new MyIrdnt(myIrdnt.getMyIrdntKey(),myIrdnt.getStartDate(),myIrdnt.getEndDate(),FreshLevel,
				myIrdnt.getIrdntCount(),myIrdnt.getIrdntId(),IrdntName,myIrdnt.getFridgerId(),myIrdnt.getStartFreshLevel(),myIrdnt.getStorgePlace());

		
		dao.insertMyIrdnt(newMyIrdnt);
	}

	@Override
	public void updateMyIrdnt(MyIrdnt myIrdnt) throws Exception {
		if(dao.selectMyIrdntByKey(myIrdnt.getMyIrdntKey())==null){
			throw new Exception("없는 식재료입니다.");
		}
		//재료id를 제외한 다른것들을 수정, 다시 계산해야함
		System.out.println("신선도 전");
		String FreshLevel = getFreshLevel(myIrdnt);
		System.out.println("신선도 후");
		//String IrdntName = irdntDao.selectIrdntById(myIrdnt.getIrdntId()).getIrdntName();
		
		//key값은 jsp쪽에서 고정되도록 처리해야겠다. 
		MyIrdnt newMyIrdnt= new MyIrdnt(myIrdnt.getMyIrdntKey(),myIrdnt.getStartDate(),myIrdnt.getEndDate(),FreshLevel,
				myIrdnt.getIrdntCount(),myIrdnt.getIrdntId(),myIrdnt.getIrdntName(),myIrdnt.getFridgerId(),myIrdnt.getStartFreshLevel(),myIrdnt.getStorgePlace());
		
		System.out.println("dao 가기전");
		dao.updateMyIrdnt(newMyIrdnt);
		System.out.println("dao간후");
		
	}

	@Override
	public void removeMyIrdnt(int irdntKey) throws Exception {
		if (dao.selectMyIrdntByKey(irdntKey) == null) {
			throw new Exception("없는 식재료입니다.");
		}
		dao.deleteMyIrdnt(irdntKey);

	}

	@Override
	public List<MyIrdnt> findAllMyIrdntByFridgerId(int fridgerId) {
		// 냉장고 아이디로 나의식재료들 전부 가져오기...
		// 여기서는 냉장고아이디가 없을수가 없다. 냉장고를 눌러서 선택되서 오는거니까.
		return dao.selectMyIrdntByFridgerId(fridgerId);
	}

	@Override
	public List<MyIrdnt> findMyIrdntByIrdntName(String irdntName, int fridgerId) {
		return dao.selectMyIrdntByName(irdntName, fridgerId);
	}

	@Override
	public String getFreshLevel(MyIrdnt myirdnt) {
	      // 해당냉장고에서의 재료마다의 신선도 계산하는 메서드.

		System.out.println("신선도시작~"+myirdnt);
	      int irdntId = myirdnt.getIrdntId();
	      Long leftDay; // 남은 일수 밀리초변환.
	      
	      if (myirdnt.getEndDate() == null) {// 유통기한 없으면
	         // Calendar myPeriod = Calendar.getInstance();
	    	 int period;
	        
	    	 if(myirdnt.getStorgePlace().equals("실온")){
	    		 period = irdntDao.selectIrdntById(myirdnt.getIrdntId()).getRoomTemPeriod();
	    	 }
	    	 else if(myirdnt.getStorgePlace().equals("냉장")){
	    		 period=irdntDao.selectIrdntById(myirdnt.getIrdntId()).getColdTemPeriod();
	    	 }
	    	 else{
	    		 period=irdntDao.selectIrdntById(myirdnt.getIrdntId()).getFreezeTemPeriod();
	    	 }
	    	 
	    	/* if (dao.selectMyIrdntByKey(myirdnt.getMyIrdntKey()).getStorgePlace().equals("실온")) {
		 			period = irdntDao.selectIrdntById(irdntId).getRoomTemPeriod();
		 		} else if (dao.selectMyIrdntByKey(myirdnt.getMyIrdntKey()).getStorgePlace().equals("냉장")) {
		 			period = irdntDao.selectIrdntById(irdntId).getColdTemPeriod();
		 		}else{
		 			//냉동
		 			period = irdntDao.selectIrdntById(irdntId).getFreezeTemPeriod();	
		 		}*/
	 			
	         switch (myirdnt.getStartFreshLevel()) {
	         case "좋음":
	            period = period * 1;
	            break;
	         case "보통":
	            period = (int) (period * 0.7);
	            break;
	         case "나쁨":
	            period = (int) (period * 0.5);
	            break;
	         }
	         
	         Date startDay = myirdnt.getStartDate();// 재료의 보관시작일
	         
	         // myperiod = 보관시작일+보관기간 의 밀리초.
	         long myPeriod = startDay.getTime() + (period * 86400000);

	         // 예상 유통기한에서 현재시간을 뺀 밀리초.
	         leftDay = myPeriod - new Date().getTime();
	      }
	      else {// 유통기한이 입력됨
	         // 밀리초단위 : 유통기한 - 현재시간
	         leftDay = myirdnt.getEndDate().getTime() - new Date().getTime();
	      }
	      
	      //남은날짜에 따라 1-4로 리턴
	      if(leftDay < 3*86400000) return "위험";
	      if(leftDay < 7*86400000) return "보통";
	      else return "안전";
	   
	}

	@Override
	public MyIrdnt fingMyIrdntBymyIrdntKey(int myIrdntKey) {
		return dao.selectMyIrdntByKey(myIrdntKey);
	}

	@Override
	public List<MyIrdnt> findMyIrdntByStartDate(Date startDate,int fridgerId) {
		return dao.selectMyIrdntByStartDate(startDate, fridgerId);
	}

	@Override
	public List<MyIrdnt> findMyIrdntByEndDate(Date endDate,int fridgerId) {
		return dao.selectSoonExpireMyIrdnt(endDate, fridgerId);
	}

	@Override
	public List<MyIrdnt> findMyIrdntByFreshLevel(String freshLevel,int fridgerId) {
		//신선도입력해서 해당하는 식재료들 뽑아오는거. 
		//나중에 이걸로 식재료 신선도 보여주자 
		return dao.selectMyStaleIrdnt(freshLevel, fridgerId);
	}

	@Override
	public List<MyIrdnt> findMyIrdntByFreshLevelAndIrdntName(String freshLevel, String irdntName, int fridgerId) {
		return dao.selectMyIrdntByFreshLevelAndIrdntName(freshLevel, irdntName, fridgerId);
	}

	
	
	
}
