package kr.co.turnup_fridger.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.security.core.context.SecurityContextHolder;

import kr.co.turnup_fridger.service.MyMemoService;
import kr.co.turnup_fridger.vo.Member;
import kr.co.turnup_fridger.vo.MyMemo;

public class LogProcessor {

/*	@Autowired
	private MyMemoService service;*/
	
	@Scheduled(cron="0 14 14 * * *")
	public void SchedulingController(){
		// 로그인한 회원정보
	/*	Member mm = (Member)SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		// 메모목록
		List<MyMemo> list = service.selectMemoList(mm.getMemberId());
		// 
		// 만약에 지금 로그이
		
		for(MyMemo m : list){
			
			service.deleteMemo(m.getMemoId());
		}*/
		System.out.println("삭제완료");
	}
}
