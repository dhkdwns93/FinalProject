package kr.co.turnup_fridger.exception;

public class DuplicatedFridgerException extends Exception{
	public DuplicatedFridgerException(){};
	public DuplicatedFridgerException(String msg){
		super(msg);
	}

}
