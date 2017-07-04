package kr.co.turnup_fridger.test;

import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;

import kr.co.turnup_fridger.service.AdminService;
import kr.co.turnup_fridger.vo.Admin;

public class AdminMain {
	public static void main(String[] args) throws Exception{
		ApplicationContext ctx=new ClassPathXmlApplicationContext("kr/co/turnup_fridger/config/spring/model-context.xml");
		AdminService service=(AdminService)ctx.getBean("adminService");
		
		Admin admin1=new Admin("admin-1","pw-1","name","tel","email");
		Admin admin2=new Admin("admin-2","pw-2","name","tel","email");
		Admin admin3=new Admin("admin-3","pw-3","name","tel","email");
		Admin admin4=new Admin("admin-4","pw-4","name","tel","email");
		//delete 테스트용
		Admin admin5=new Admin("admin-5","pw-5","name","tel","email");
		
		//같은 Id있으면 회원가입 불가
		Admin testRegisterAdmin=new Admin("admin-1","pw-바뀜","name-바뀜","tel","email");
		
		Admin testChangeAdmin=new Admin("admin-2","pw-2바뀜","name-바뀜","tel-바뀜","email-바뀜","권한-바뀌면안되는것");
		
		
		//관리자 등록확인
/*		service.registerAdmin(admin1);
		service.registerAdmin(admin2);
		service.registerAdmin(admin3);
		service.registerAdmin(admin4);
		service.registerAdmin(admin5);*/
		
		System.out.println("admin1정보만 봐보기"+service.inquiryAdminInfo("admin-1"));
		System.out.println("[전체 admin정보]============");
		System.out.println(service.inquiryAdminList());
		
		//아이디 같은 관리자 등록확인
//		service.registerAdmin(testRegisterAdmin);
		
		//관리자수정확인
/*		System.out.println("[수정후 admin정보]============");
		service.changeAdminInfo(testChangeAdmin);
		System.out.println(service.inquiryAdminList());*/
		
		//관리자 권한수정확인
/*		System.out.println("[권한후 admin정보]============");
		service.changeAdminAuthority("admin-1", "masterAdmin");
		System.out.println(service.inquiryAdminList());*/
		
		//관리자 삭제 확인
		/*System.out.println("[삭제후 admin정보]============");
		service.deleteAdmin("admin-5");
		System.out.println(service.inquiryAdminList());*/
		
		
	}
}
