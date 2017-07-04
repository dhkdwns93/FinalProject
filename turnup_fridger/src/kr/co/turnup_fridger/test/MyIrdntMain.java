package kr.co.turnup_fridger.test;

import java.util.Date;
import java.util.List;

import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;

import kr.co.turnup_fridger.service.MyIrdntService;
import kr.co.turnup_fridger.vo.MyIrdnt;

public class MyIrdntMain {

	public static void main(String[] args) throws Exception {
		ApplicationContext context = new ClassPathXmlApplicationContext(
				"kr/co/turnup_fridger/config/spring/model-context.xml");
		MyIrdntService service = (MyIrdntService) context.getBean("MyIrdntService");
		
		//service.createMyIrdnt(new MyIrdnt(10,new Date(116,5,1),new Date(116,6,1),0,"5",2,"공백",1,"보통"));
		//완료service.updateMyIrdnt(new MyIrdnt(0,new Date(117,4,1),new Date(117,5,1),0,"10",2,"0",0,"좋음"));
		//완료 service.removeMyIrdnt(0);
		
		/*완료//냉장고id로
		List<MyIrdnt> list = service.findAllMyIrdntByFridgerId(0);
		for(MyIrdnt m : list){
			System.out.println(m);
		}
		
		
		//재료이름, 냉장고id
		List<MyIrdnt> list2 = service.findMyIrdntByIrdntName("당근2", 0);
		for(MyIrdnt m : list2){
			System.out.println(m);
		}
		
		//완료 식재료key
		//System.out.println(service.fingMyIrdntBymyIrdntKey(0));
	
		//시작일, 냉장고id
		List<MyIrdnt> list3 = service.findMyIrdntByStartDate(new Date(117,04,01) , 0);
		for(MyIrdnt m : list3){
			System.out.println(m);
		}
		
		//유통기한, 냉장고id
		List<MyIrdnt> list4 = service.findMyIrdntByEndDate(new Date(117,05,01), 0);
		for(MyIrdnt m : list4){
			System.out.println(m);
		}
		
		//신선도, 냉장고id
		List<MyIrdnt> list5 = service.findMyIrdntByFreshLevel(0,0);
		for(MyIrdnt m : list5){
			System.out.println(m);
		}*/
	}
}
