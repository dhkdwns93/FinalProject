package kr.co.turnup_fridger.test;

import java.util.List;

import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;

import kr.co.turnup_fridger.service.BoardShareRecipeService;
import kr.co.turnup_fridger.vo.BoardShareRecipe;

public class BoardShareRecipeImgTest {

		public static void main(String[] args) {
			ApplicationContext container = 
					new ClassPathXmlApplicationContext("kr/co/turnup_fridger/config/spring/model-context.xml");
			
			
			BoardShareRecipeService service = (BoardShareRecipeService)container.getBean("boardShareRecipeServiceImpl");
			
			
			service.insertBoardShareRecipeImg(1, "ii.jsp");
			service.insertBoardShareRecipeImg(2, "iii.jsp");
			service.insertBoardShareRecipeImg(3, "iiii.jsp");
			System.out.println("이미지 추가");
			
			
		/*	int BoardShareRecipeImgKey = 8;
			service.deleteBoardShareRecipeImgByKey(BoardShareRecipeImgKey);
			System.out.println("이미지 선택 삭제");*/
			
		/*	int recipeId = 3;
			service.deleteBoardShareRecipeImgAll(recipeId);
			System.out.println("이미지 전체 삭제");*/
			
		/*	int recipeId =  3;
			
			List<String> list = service.selectBoardShareRecipeImg(recipeId);
			System.out.println(list);
			*/
			
		}
	}


