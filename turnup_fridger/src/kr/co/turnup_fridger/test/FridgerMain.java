package kr.co.turnup_fridger.test;

import java.util.List;

import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;

import kr.co.turnup_fridger.service.FridgerService;
import kr.co.turnup_fridger.vo.Fridger;

public class FridgerMain {
	

	public static void main(String[] args) throws Exception {
		ApplicationContext context = new ClassPathXmlApplicationContext(
				"kr/co/turnup_fridger/config/spring/model-context.xml");
		FridgerService service = (FridgerService) context.getBean("fridgerService");

		// service.createFridger(new Fridger(10, "2123545", "id-1"));
		// service.updateFridger(new Fridger(1, "냉장고명 수정이욥", "id-3"));
		//service.removeFridger(25);
		
		
		System.out.println("--------------findFridgerAll--------------");
		List<Fridger> list = service.findFridgerAll();
		for (Fridger f : list) {
			System.out.println(f);
		}
		System.out.println("--------------findFridgerByFridgerId(1)--------------");
		System.out.println(service.findFridgerByFridgerId(1));
		System.out.println("--------------findFridgerAndFridgerGroupByFridgerId(1)--------------");
		System.out.println(service.findFridgerAndFridgerGroupByFridgerId(1));
		// 나의 재료와 조인되어있어서 현재(6/28) 테스트 불가능
		//System.out.println("--------------findFridgerAndIrdntByFridgerId(1)--------------");
		//System.out.println(service.findFridgerAndIrdntByFridgerId(1));
		
		System.out.println("--------------findFridgerByFridgerName('냉장고')--------------");
		list = service.findFridgerByFridgerName("냉장고");
		for (Fridger f : list) {
			System.out.println(f);
		}
	}

}
