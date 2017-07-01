package kr.co.turnup_fridger.test;

import java.util.ArrayList;
import java.util.Date;

import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;

import kr.co.turnup_fridger.service.FridgerService;
import kr.co.turnup_fridger.service.JoinProcessService;
import kr.co.turnup_fridger.vo.Fridger;
import kr.co.turnup_fridger.vo.JoinProcess;

public class JoinProcessMain {

	public static void main(String[] args) throws Exception {
		ApplicationContext context = new ClassPathXmlApplicationContext(
				"kr/co/turnup_fridger/config/spring/model-context.xml");
		JoinProcessService js = (JoinProcessService) context.getBean("joinProcessService");
		FridgerService fs = (FridgerService) context.getBean("fridgerService");
		
		JoinProcess joinProcess;
		
		Fridger fridger;
		

		System.out.println("----------처리전 전체 조회--------------");
		for(JoinProcess j : js.findJoinProcessAll()){
			System.out.println(j);
		}
		System.out.println("---------------------------------------");
		
		/*
		System.out.println("----------가입처리등록--------------");
		System.out.println("id-5님이 " + fs.findFridgerByFridgerId(21).getFridgerName() +"에 가입을 원합니다");	
		joinProcess = new JoinProcess(0, 21, 10, new Date(), "id-5", fs.findFridgerByFridgerId(21).getMemberId());
		js.requestJoinFridgerGroup(joinProcess);	//완
		*/
		/*
		System.out.println("id-4님을 " + fs.findFridgerByFridgerId(2).getFridgerName() +"로 초대합니다");
		joinProcess = new JoinProcess(0, 2, 20, new Date(), fs.findFridgerByFridgerId(2).getMemberId(), "id-4");
		js.inviteJoinFridgerGroup(joinProcess);	//완
		 */
		/*
		System.out.println("----------가입처리업뎃--------------");
		js.updateJoinProcess(new JoinProcess(4, 11, new Date()));	//완
		*/
		
		/*
		System.out.println("----------번호로 가입처리삭제--------------");
		ArrayList list = new ArrayList();
		list.add(4);
		js.removeJoinProcessByProcessNo(list);	//완
		*/
		
		
		/*
		System.out.println("----------가입처리삭제: 승인대기상태로 14일 지난 것--------------");
		js.removeJoinProcessNotProcessedIn14Days();	//완
		 */		
		
		/*
		System.out.println("----------가입처리삭제: 처리되고 6개월 지난 것--------------");
		js.removeJoinProcessCompleted6MonthsBefore();	//완
		 */		
		/*
		System.out.println("----------처리후 전체조회--------------");
		for(JoinProcess j : js.findJoinProcessAll()){
			System.out.println(j);
		}
		*/
		
		
		System.out.println("----------냉장고 id로 가입처리 목록 조회--------------");
		for(JoinProcess j : js.findJoinProcessByFridgerId(21)){
			System.out.println(j);
		}
		
		System.out.println("----------처리상태(11)로 가입처리 목록 조회--------------");
		for(JoinProcess j : js.findJoinProcessByProcessState(11)){
			System.out.println(j);
		}
		
		System.out.println("----------처리 날짜로 가입처리 목록 조회--------------");
		for(JoinProcess j : js.findJoinProcessByRequestDate(java.sql.Date.valueOf("2017-06-30"))){
			System.out.println(j);
		}
		
		
		
		
	}
}
