/**
 (AuthenticationProvider)UserAuthenticationProvider
작성자 : 
최초 작성일 
변경이력
-
170705 headmaster권한 추가
*/
package kr.co.turnup_fridger.security.provider;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.authentication.AuthenticationProvider;
import org.springframework.security.authentication.BadCredentialsException;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.AuthenticationException;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Component;

import kr.co.turnup_fridger.dao.AdminDao;
import kr.co.turnup_fridger.dao.AuthorityDao;
import kr.co.turnup_fridger.dao.MemberDao;
import kr.co.turnup_fridger.vo.Admin;
import kr.co.turnup_fridger.vo.Authority;
import kr.co.turnup_fridger.vo.Member;

@Component
/*
 * Spring Security 컨테이너가 사용자 인증 처리(로그인 처리) 할때 호출할 클래스
 * 	=> AuthenticationProvider
 * 구현 : AuthenticationProvider를 implements. 메소드 오버라이딩(authenticate())
 */
public class UserAuthenticationProvider implements AuthenticationProvider{

	@Autowired
	private AuthorityDao authorityDao;
	@Autowired
	private MemberDao memberDao;
	@Autowired
	private AdminDao adminDao;
	@Autowired
	private PasswordEncoder encoder;
	//문자열을 암호화 - encode()
	//문자열과 암호화된 문자열을 비고 - matches(비교대상문자열, 암호화된문자열) : boolean
	
	/*Authentication : 인증/권한 정보를 가지는 객체 
			- 매개변수는 로그인 처리시 사용할 ID와 패스워드를 제공
			- 리턴 타입은 로그인처리 끝나고 로그인한 사용자의 정보를 담아 리턴할때 사용
		- 인증 실패 : Exception을 던지거나 return null 인 경우 스프링 시큐리티 컨테이너는 인증실패로처리
	  GrantedAuthority - 권한정보 하나를 저장하는 객체.
	*/
	@Override
	public Authentication authenticate(Authentication authentication) throws AuthenticationException {
		
		String loginId=authentication.getName();//사용자가 입력한 ID
		String loginPw=(String)authentication.getCredentials();//사용자가 입력한 PW
		
		//권한 조회
		Authority user=authorityDao.selectAuthorityById(loginId);
		String userAuthority = user.getLoginAuthority();
		if (userAuthority == null || userAuthority.trim().isEmpty()) {
			throw new UsernameNotFoundException("권한 입력에 오류가 있는 사용자 입니다.");
		}
		if(userAuthority.equals("ROLE_MEMBER")){
			//ID체크
			Member member=memberDao.selectMemberById(loginId);			
			if(member==null){//해당ID의 회원이 없으면 로그인 실패
				throw new UsernameNotFoundException("등록되지 않은 ID입니다.");
			}
			//PW체크
			if(!loginPw.equals(member.getMemberPw())){
			//if(!encoder.matches(loginPw,user.getLoginPw())){//Pw가 일치하지 않으면 로그인 실패
				throw new BadCredentialsException("입력하신 ID와 패스워드가 일치하지 않습니다.");
			}
			//System.out.println(member);
			//===========(인증성공)==============
			List<SimpleGrantedAuthority> list=new ArrayList<>();
			list.add(new SimpleGrantedAuthority(userAuthority));
			
			//System.out.println(list);//확인용
			//System.out.println(new UsernamePasswordAuthenticationToken(member, null, list));
			
			return new UsernamePasswordAuthenticationToken(member, null, list);
		}
		
		//권한이 admin(+masterAdmin)이면 vo.admin객체를 담아 리턴.
		if(userAuthority.equals("ROLE_ADMIN")||userAuthority.equals("ROLE_MASTERADMIN")||userAuthority.equals("ROLE_HEADMASTERADMIN")){
			//ID체크	
			Admin admin=adminDao.selectAdminById(loginId);
			if(admin==null){//해당ID의 회원이 없으면 로그인 실패
				throw new UsernameNotFoundException("등록되지 않은 ID입니다.");
			}
			//PW체크
			if(!loginPw.equals(admin.getAdminPw())){
			//if(!encoder.matches(loginPw,user.getLoginPw())){//Pw가 일치하지 않으면 로그인 실패
				throw new BadCredentialsException("입력하신 ID와 패스워드가 일치하지 않습니다.");
			}
			//System.out.println("User..Provider"+admin);
			//===========(인증성공)==============
			List<SimpleGrantedAuthority> list=new ArrayList<>();
			list.add(new SimpleGrantedAuthority(userAuthority));
			System.out.println("User..Provider"+list);//확인용
			return new UsernamePasswordAuthenticationToken(admin,null,list);
		}
		return null;//- 인증 실패 : Exception을 던지거나 return null 인 경우 스프링 시큐리티 컨테이너는 인증실패로처리
	}

	@Override
	public boolean supports(Class<?> authentication) {
		return authentication.isAssignableFrom(UsernamePasswordAuthenticationToken.class);
	}
	
	
	
	
	
	
}
