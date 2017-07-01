package kr.co.turnup_fridger.test;

import java.util.List;

import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;

import kr.co.turnup_fridger.service.MyDislikeIrdntService;
import kr.co.turnup_fridger.vo.MyDislikeIrdnt;

public class MydislikeIrdntMain {

	public static void main(String[] args) throws Exception {
		ApplicationContext context = new ClassPathXmlApplicationContext(
				"kr/co/turnup_fridger/config/spring/model-context.xml");
		MyDislikeIrdntService service = (MyDislikeIrdntService) context.getBean("MyDislikeIrdntService");

		//service.createMyDislikeIrdnt(new MyDislikeIrdnt(1,2,"id"));
		//실패service.updateMyDislikeIrdnt(new MyDislikeIrdnt(1,3,"id2"));
		//service.removeMyDislikeIrdnt(1);
		
		/*List<MyDislikeIrdnt> list = service.findMyDislikeIrdntByMemberId("id");
		for(MyDislikeIrdnt m:list){
			System.out.println(m);
		}*/
		
		//System.out.println(service.findMyDislikeIrdntBymyDislikeIrdntKey(1));
	
	}
}
