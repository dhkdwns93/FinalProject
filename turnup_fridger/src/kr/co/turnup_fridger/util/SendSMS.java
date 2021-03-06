package kr.co.turnup_fridger.util;

import java.io.IOException;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller
public class SendSMS {

	@Autowired
    private SMS sms;
	
	// ajax로 메모내용받아서 문자전송처리하는 핸들러
	@RequestMapping(value="/sms/sendSMS", method=RequestMethod.POST)
	@ResponseBody
    public String sendMsg(@RequestParam String memoName, @RequestParam String memoTxt, @RequestParam String memberTel){
        sms.appversion("TEST/1.0");
        sms.charset("UTF-8");
        sms.setuser("janggyu93", "1q2w3e4r");	 // coolsms 계정 

		SmsMessagePdu pdu = new SmsMessagePdu();
		pdu.type = "SMS";
		pdu.destinationAddress = memberTel;
		pdu.scAddress = "01087791763"; 	// 발신자 번호(등록된 번호여야 함)
		pdu.text = "<" + memoName + ">\n" + memoTxt; // 보낼 메세지 내용
		sms.add(pdu);

		try {
			sms.connect();
			sms.send();
			sms.disconnect();
		} catch (IOException e) {
			System.out.println(e.toString());
			return "전송 실패";
		}
		sms.printr();
		sms.emptyall();
        
        return "전송 완료";
    }
}
