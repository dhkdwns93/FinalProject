package kr.co.turnup_fridger.test;

import java.util.List;

import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;

import kr.co.turnup_fridger.service.IrdntManageService;
import kr.co.turnup_fridger.vo.IrdntManage;

public class IrdntManageMain {

	public static void main(String[] args) throws Exception {
		
		ApplicationContext context = new ClassPathXmlApplicationContext(
				"kr/co/turnup_fridger/config/spring/model-context.xml");
		IrdntManageService service = (IrdntManageService) context.getBean("IrdntManageService");
		
		//service.createIrdnt(new IrdntManage(10,"호박",20,"채소류"));

		//service.updateIrdnt(new IrdntManage(2,"당근2",15,"채소류"));
		
		//service.removeIrdnt(1);
		
		/*
		//전체
		List<IrdntManage> list = service.findAllIrdnt();
		for(IrdntManage m : list){
			System.out.println(m);
		}
		
		//재료명
		List<IrdntManage> list2 = service.findIrdntByIrdntName("당근");
		for(IrdntManage m : list2){
			System.out.println(m);
		}
		
		//id
		System.out.println(service.findIrdntByIrdntId(1));
		
		//카테고리
		List<IrdntManage> list3 = service.fingIrdntByIrdntCategory("채소류");
		for(IrdntManage m : list3){
			System.out.println(m);
		}*/
	}
	
}
