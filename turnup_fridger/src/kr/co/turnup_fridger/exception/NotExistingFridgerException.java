package kr.co.turnup_fridger.exception;

public class NotExistingFridgerException extends Exception{
	public NotExistingFridgerException(){};
	public NotExistingFridgerException(String msg){
		super(msg);
	}

}
