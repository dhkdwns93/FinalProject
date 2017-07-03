package kr.co.turnup_fridger.security.provider;

import org.springframework.security.authentication.AuthenticationProvider;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.AuthenticationException;
import org.springframework.stereotype.Component;

@Component
/*
 * Spring Security 컨테이너가 사용자 인증 처리(로그인 처리) 할때 호출할 클래스
 * 	=> AuthenticationProvider
 * 구현 : AuthenticationProvider를 implements. 메소드 오버라이딩(authenticate())
 */
public class UserAuthenticationProvider implements AuthenticationProvider

{

	@Override
	public Authentication authenticate(Authentication arg0) throws AuthenticationException {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public boolean supports(Class<?> arg0) {
		// TODO Auto-generated method stub
		return false;
	}
	
	
	
	
	
	
}
