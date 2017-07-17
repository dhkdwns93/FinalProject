package kr.co.turnup_fridger.util;

public class InsertMain {
	public static void main(String[] args) {
		InsertMethod insertMethod=new InsertMethod();
		
		
		//레시피재료정보
		//insertMethod.insertAPI("C:\\Java\\api\\recipe\\","recipe_irdnt");//(파일루트, txt파일명)

		
		//레시피기본정보
		//insertMethod.insertAPI("C:\\Java\\api\\recipe\\","recipe_info");
		
		//재료관리 
		//insertMethod.insertAPI("C:\\Java\\api\\recipe\\","irdnt_manage");//(파일루트, txt파일명)

		
		
		
		
		///////은영이가 //////////////////
		//레시피재료정보
		//insertMethod.insertAPI("D:\\Eunyoung\\java\\api\\","recipe_irdnt");//(파일루트, txt파일명)
		insertMethod.insertAPI("D:\\Eunyoung\\java\\api\\","irdnt_manage");//(파일루트, txt파일명)
		
		//레시피기본정보
		//insertMethod.insertAPI("D:\\Eunyoung\\java\\api\\","recipe_info");
		
		//재료관리 
		//insertMethod.insertAPI("D:\\Eunyoung\\java\\api\\","recipe_crse");//(파일루트, txt파일명)
	}//end of main
}