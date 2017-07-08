package kr.co.turnup_fridger.exception;

public class NoneRecipeException extends Exception{

	public NoneRecipeException(){
		
	}
	public NoneRecipeException(String msg){
		super(msg);
	}
}
