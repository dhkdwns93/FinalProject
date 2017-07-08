package kr.co.turnup_fridger.exception;

public class DuplicateRecipeException extends Exception{
	
	public DuplicateRecipeException(){
		
	}
	public DuplicateRecipeException(String msg){
		super(msg);
	}
}
