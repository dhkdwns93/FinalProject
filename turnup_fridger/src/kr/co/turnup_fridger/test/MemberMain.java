package kr.co.turnup_fridger.test;

import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;

import kr.co.turnup_fridger.service.MemberService;
import kr.co.turnup_fridger.vo.Member;

public class MemberMain {

	public static void main(String[] args) throws Exception {
		ApplicationContext ctx
			=new ClassPathXmlApplicationContext("kr/co/turnup_fridger/config/spring/model-context.xml");
		MemberService service=(MemberService)ctx.getBean("memberService");
		
		Member mem1=new Member("id-1","pw-1","name","address","email-1","tel","sex");
		Member mem2=new Member("id-2","pw-2","name","address","email-2","tel","sex");
		Member mem3=new Member("id-3","pw-3","name","address","email-3","tel","sex");
		Member mem4=new Member("id-4","pw-4","name","address","email-4","tel","sex");
		Member mem5=new Member("id-5","pw-5","name","address","email-5","tel","sex");
		//delete테스트용
		Member mem6=new Member("id-6","pw-6","name","address","email-6","tel","sex");
		
		//같은 Id,Email있으면 회원가입불가
		Member testSignUpMem=new Member("id-1","pw-2","name","address","email-100","tel","sex");
		Member testSignUpMem2=new Member("id-6","pw-5","name-1","address","email-5","tel","sex");
		
		Member testChangeMem=new Member("id-2","pw-2바뀜","name-바뀜-바뀜","address","email-101","tel-바뀜","sex-바뀜");
		//다른 기존회원 중 같은 이메일 사용회원있으면 update불가.
		Member testChangeMem2=new Member("id-3","pw-3바뀜","name-바뀜","address-바뀜","email-5","tel","sex");
	
		//회원가입확인
/*		service.signUpMember(mem1);
		service.signUpMember(mem2);
		service.signUpMember(mem3);
		service.signUpMember(mem4);
		service.signUpMember(mem5);
		service.signUpMember(mem6);*/
		
		
		System.out.println("mem1정보만 봐보기"+service.inquiryMemberInfo(mem1.getMemberId()));
		System.out.println("[전체 member정보]==============");
		System.out.println(service.inquiryMemberList());
		
		//회원수정확인
/*		System.out.println("[바뀐후 member정보]===============");
		service.changeMemberInfo(testChangeMem);
		service.changeMemberInfo(testChangeMem2);
		System.out.println(service.inquiryMemberList());*/
		
		//회원삭제확인
		/*System.out.println("[삭제후 member정보]==============");
		service.deleteMember("id-6");
		System.out.println(service.inquiryMemberList());*/
		
		//이름과 이메일로 회원찾기 확인
		/*System.out.println("[찾을 member정보]==============");
		System.out.println("id-1 : "+service.findMember("name","email-12"));*/
		
		
	
	
	}
}
