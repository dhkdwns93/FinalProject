package kr.co.turnup_fridger.exception;

public class ExistingFridgerNameException extends Exception{
	public ExistingFridgerNameException(){};
	public ExistingFridgerNameException(String msg){
		super(msg);
	}

}
