package kr.co.turnup_fridger.util;

public class InsertMain {
	public static void main(String[] args) {
		InsertMethod insertMethod=new InsertMethod();
		String fileRoot = System.getProperty("user.dir")+"\\WebContent\\WEB-INF\\etc\\";
		
		//레시피기본정보
		insertMethod.insertAPI(fileRoot, "recipe_info");
		
		
		//레시피재료정보
		//insertMethod.insertAPI(fileRoot,"recipe_irdnt");//(파일루트, txt파일명)

	
		//레시피 과정정보
		//insertMethod.insertAPI(fileRoot,"recipe_crse");//(파일루트, txt파일명)

		
		//재료 관리
		//insertMethod.insertAPI(fileRoot,"irdnt_manage");//(파일루트, txt파일명)

	
	}
	
}