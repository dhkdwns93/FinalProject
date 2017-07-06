package kr.co.turnup_fridger.test;

import java.util.List;

import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;

import kr.co.turnup_fridger.service.ShareRecipeIrdntService;
import kr.co.turnup_fridger.vo.ShareRecipeIrdnt;

public class ShareRecipeIrdntTest {
	public static void main(String[] args) {
		ApplicationContext container = 
				new ClassPathXmlApplicationContext("kr/co/turnup_fridger/config/spring/model-context.xml");
		
		
		ShareRecipeIrdntService service = (ShareRecipeIrdntService)container.getBean("shareRecipeIrdntServiceImpl");
	
		//insert
//		service.insertShareRecipeIrdnt(new ShareRecipeIrdnt(1,1,1, null, null));
//		System.out.println("재료 등록");
		
		//update
//		service.updateShareRecipeIrdnt(new ShareRecipeIrdnt(1,2,1, null, null ));
//		System.out.println("재료 수정");
	
		//delete
//		service.deleteShareRecipeIrdnt(1);
//		System.out.println("재료 삭제");
		
		//전체조회
//		List<ShareRecipeIrdnt> list = service.selectShareRecipeIrdntAll();
//		for(ShareRecipeIrdnt sri : list){
//			System.out.println(sri);
//		}
		
		//irdnt로 조회
		/* int irdntId = 1;
		 ShareRecipeIrdnt share = service.selectShareRecipeIrdntByIrdntId(irdntId);
		
		 System.out.println(share);*/
		
		//recipeId로 조회
		int recipeId = 2;
		 ShareRecipeIrdnt share = service.selectShareRecipeIrdntByRecipeId(recipeId);
		 
		 System.out.println(share);
	}
}
