package kr.co.turnup_fridger.exception;

public class DuplicateFavoriteException extends Exception{

	public DuplicateFavoriteException(){
		
	}
	public DuplicateFavoriteException(String msg){
		super(msg);
	}
}
