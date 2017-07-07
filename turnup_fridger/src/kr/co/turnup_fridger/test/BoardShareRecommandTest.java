package kr.co.turnup_fridger.test;

import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;

import kr.co.turnup_fridger.vo.MemberRecipeRecommand;

public class BoardShareRecommandTest {
	public static void main(String[] args) {
	
		ApplicationContext container = 
				new ClassPathXmlApplicationContext("kr/co/turnup_fridger/config/spring/model-context.xml");
		
		
//		MemeberRecipeRecommandService service = (MemeberRecipeRecommandService)container.getBean("memeberRecipeRecommandServiceImpl");
	

//	service.insertMemberRecipeRecommand(new MemberRecipeRecommand(1,1,"id-2"));
//	System.out.println("등록");
		
	/*	int recipeId = 1;
		service.updateMemberRcipeRecommand(recipeId);
		System.out.println("완료");
		*/
		
	/*	int recipeId = 1;
		service.deleteRcipeRecommand(recipeId);
		System.out.println("recipeId로 삭제완료");*/
		
	/*	String memberId="id-2";
		service.deleteMemberRecommand(memberId);
		System.out.println("memberId로 삭제완료");*/
		
//		MemberRecipeRecommand list =  service.selectRecommand(10, "id-1");
//		System.out.println(list);
	}
}
