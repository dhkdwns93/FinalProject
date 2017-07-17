package kr.co.turnup_fridger.test;

import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;

import kr.co.turnup_fridger.exception.DuplicateFavoriteException;
import kr.co.turnup_fridger.service.FavoriteRecipeService;
import kr.co.turnup_fridger.vo.FavoriteRecipe;

public class FavoriteTest {
public static void main(String[] args) throws DuplicateFavoriteException {

	ApplicationContext context = new ClassPathXmlApplicationContext(
			"kr/co/turnup_fridger/config/spring/model-context.xml");
	FavoriteRecipeService service = (FavoriteRecipeService) context.getBean("FavoriteRecipeService");
	
	//service.createFavoriteRecipe(new FavoriteRecipe(0,"user1",478));
}
}
