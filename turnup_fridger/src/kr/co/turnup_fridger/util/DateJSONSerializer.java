package kr.co.turnup_fridger.util;

import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Date;

import com.fasterxml.jackson.core.JsonGenerator;
import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.JsonSerializer;
import com.fasterxml.jackson.databind.SerializerProvider;

/**
 * JSONSerializer
 * VO를 JSON으로 변환시 특정 타입의 property를 어떤 형식의 문자열로 변환
 * 
 * java.util.Date - 변화 -> 밀리초
 */

public class DateJSONSerializer extends JsonSerializer<Date>
{

	@Override
	/*
	 * 매개변수 : 1. 변환할 값(원본값)
	 * 		   2. 변환한 내용을 converter에게 출력해주는 메소드 제공(생성)
	 * 		   3. 기존 JsonSerializer
	*/
	public void serialize(Date date, JsonGenerator gen, SerializerProvider pro)
			throws IOException, JsonProcessingException {
		// TODO Auto-generated method stub
		//원하는 값으로 바꾸기
		String dateString = new SimpleDateFormat("yyyy-MM-dd").format(date);
		//바꾼값을 출력
		gen.writeString(dateString);
		
	}
	
}
