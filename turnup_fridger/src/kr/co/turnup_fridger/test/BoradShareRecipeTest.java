package kr.co.turnup_fridger.test;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;

import kr.co.turnup_fridger.service.BoardShareRecipeService;
import kr.co.turnup_fridger.vo.BoardShareRecipe;
import kr.co.turnup_fridger.vo.ShareRecipeIrdnt;

public class BoradShareRecipeTest {
	public static void main(String[] args) {
		ApplicationContext container = 
				new ClassPathXmlApplicationContext("kr/co/turnup_fridger/config/spring/model-context.xml");
	
		BoardShareRecipeService service = (BoardShareRecipeService)container.getBean("boardShareRecipeServiceImpl");
	
		
		//insert
//		service.insertBoardShareRecipe(new BoardShareRecipe(3,"밥", "얹히기", new Date(2007-1900,11,07), 1, 1, "콩", "id-1" ));
		service.insertBoardShareRecipe(new BoardShareRecipe(4 ,"김치찌개", "대한민국정통음식", new Date(2011-1900,02,24), 10, 150, "참치", "id-1" ));
		System.out.println("레시피공유 게시판 글 등록");
		
		
		//delete
//		service.deleteBoardShareRecipe(3);
//		System.out.println("레시피공유 게시판 글 삭제");
		
		//update
//		service.updateBoardShareRecipe(new BoardShareRecipe(3, "미역국", "생일상음식", new Date(2007-1900,12,20), 2,2,"소고기", "id-1"));
//		System.out.println("레시피 공유 게시판 글 수정");
		
		//select : 제목으로 조회
		/*String title = "부";
		System.out.println("----------------title 조회------------------");
		List<BoardShareRecipe> list = service.selectBoardShareRecipeByTitle(title);
		if(list.size()==0){
			System.out.printf("%s 제목의 게시물이 없습니다.", title);
		}else{
			for(BoardShareRecipe bsr : list){
				System.out.println(bsr);
			}
		}*/
		
		/*int hits = 1;
		System.out.println("****************hits 조회*****************");
		List<BoardShareRecipe> list2 = service.selectBoardShareRecipeByHits(hits);
		if(list2.size()==0){
			System.out.printf("%d 조회된 게시물이 없습니다.", hits);
		}else{
			for(BoardShareRecipe hBsr : list2){
				System.out.println(hBsr);
			}
		}*/
		
		/*int recommand = 1;
		System.out.println("#############recommand 조회##############");
		List<BoardShareRecipe> list3 = service.selectBoardShareRecipeByRecommand(recommand);
		for(BoardShareRecipe rBsr : list3){
			System.out.println(rBsr);
		}*/
		
		/*System.out.println("++++++++++++++전체조회+++++++++++++++++++++");
		List<BoardShareRecipe> list4 = service.selectBoardShareRecipeAll();
		for(BoardShareRecipe aBsr : list4){
			System.out.println(aBsr);
		}*/
		
		/*String memberId = "id-1";
		System.out.println("$$$$$$$$$$$$$$$$회원ID조인 조회$$$$$$$$$$$$$$$$$$");
	
		List<BoardShareRecipe> list5 = service.selectBoardShareRecipeByMemberIdToInfo(memberId);
		
		if(list5==null){
			System.out.printf("%s 회원이 조회한 게시물이 없습니다.");
		}else{
			for(int i =0 ; i<list5.size() ; i++){
				String listId = list5.get(i).toString();
				System.out.println(listId);
			}
			
		}*/
		/*
		int recipeId = 3;
		System.out.println("%%%%%%%%%%%%%%추천조인 조회%%%%%%%%%%%55");
		
		List<BoardShareRecipe> list6 = service.selectBoardShareRecipeByRecipeIdToRecommend(recipeId);
		if(list6==null){
			System.out.println("%d 추천수가 없습니다.");
		}else{
			for(BoardShareRecipe rBsr : list6){
				System.out.println(rBsr);
			}
		}*/
		
	/*	int SrecipeId = 2;
		System.out.println("&&&&&&&&&&&&&&&&&&재료명 조인 조회&&&&&&&&&&&&&&&&&&");
		List<ShareRecipeIrdnt> list7 = service.selectBoardShareRecipeByRecipeIdToIrdnt(SrecipeId);
		System.out.println(list7);
		*/
		
		//사진 조회
		/*int iRecipeId= 3;
		List<String> list8 = service.selectBoardShareRecipeByRecipeIdToImg(iRecipeId);
		System.out.println(list8);*/
		
		/*//레시피공유게시판 조회시 사진과 재료명 함께 조회
		int recipeId= 5;
		
		List<BoardShareRecipe> list8 = service.selectBoardShareRecipeByRecipeIdToIrdnt(recipeId);
		System.out.println(list8);*/
		
		
		
	}
}
