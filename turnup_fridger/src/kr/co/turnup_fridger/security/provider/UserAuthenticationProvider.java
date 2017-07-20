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
public class UserAuthenticationProvider implements AuthenticationProvider{

	@Autowired
	private AuthorityDao authorityDao;
	@Autowired
	private MemberDao memberDao;
	@Autowired
	private AdminDao adminDao;
	@Autowired
	private PasswordEncoder encoder;

	@Override
	public Authentication authenticate(Authentication authentication) throws AuthenticationException {
		
		String loginId=authentication.getName();//사용자가 입력한 ID
		String loginPw=(String)authentication.getCredentials();//사용자가 입력한 PW
		
		//권한 조회
		Authority user=authorityDao.selectAuthorityById(loginId);
		if(user==null){
			throw new UsernameNotFoundException("등록되지 않은 계정입니다.");
		}
		String userAuthority = user.getLoginAuthority();
		if (!userAuthority.equals("ROLE_MEMBER")&&!userAuthority.equals("ROLE_ADMIN")&&
				!userAuthority.equals("ROLE_MASTERADMIN")&&!userAuthority.equals("ROLE_HEADMASTERADMIN")) {

			throw new UsernameNotFoundException("권한 입력에 오류가 있는 사용자 입니다.");
		}
		if(userAuthority.equals("ROLE_MEMBER")){
			//ID체크
			Member member=memberDao.selectMemberById(loginId);			
			if(member==null){//해당ID의 회원이 없으면 로그인 실패
				throw new UsernameNotFoundException("등록되지 않은 ID입니다.");
			}
			//PW체크
			if(!encoder.matches(loginPw,member.getMemberPw())){//Pw가 일치하지 않으면 로그인 실패
				throw new BadCredentialsException("입력하신 ID와 패스워드가 일치하지 않습니다.");
			}
			//===========(인증성공)==============
			List<SimpleGrantedAuthority> list=new ArrayList<>();
			list.add(new SimpleGrantedAuthority(userAuthority));

			return new UsernamePasswordAuthenticationToken(member, null, list);
		}
		
		//권한이 admin(+masterAdmin)이면 vo.admin객체를 담아 리턴.
		if(userAuthority.equals("ROLE_ADMIN")||userAuthority.equals("ROLE_MASTERADMIN")){
			//ID체크	
			Admin admin=adminDao.selectAdminById(loginId);
			if(admin==null){//해당ID의 회원이 없으면 로그인 실패
				throw new UsernameNotFoundException("등록되지 않은 ID입니다.");
			}
			//PW체크
			if(!encoder.matches(loginPw,admin.getAdminPw())){//Pw가 일치하지 않으면 로그인 실패
				throw new BadCredentialsException("입력하신 ID와 패스워드가 일치하지 않습니다.");
			}
			//===========(인증성공)==============
			List<SimpleGrantedAuthority> list=new ArrayList<>();
			list.add(new SimpleGrantedAuthority(userAuthority));
			return new UsernamePasswordAuthenticationToken(admin,null,list);
		}
		//권한 headmaster -DB상으로 관리할 수 있어야 하므로 비밀번호 passwordencoding 처리 안함.
		if(userAuthority.equals("ROLE_HEADMASTERADMIN")){
			//ID체크	
			Admin admin=adminDao.selectAdminById(loginId);
			if(admin==null){//해당ID의 회원이 없으면 로그인 실패
				throw new UsernameNotFoundException("등록되지 않은 ID입니다.");
			}
			//PW체크
			if(!loginPw.equals(admin.getAdminPw())){
				throw new BadCredentialsException("입력하신 ID와 패스워드가 일치하지 않습니다.");
			}
			//===========(인증성공)==============
			List<SimpleGrantedAuthority> list=new ArrayList<>();
			list.add(new SimpleGrantedAuthority(userAuthority));
			System.out.println("User..Provider"+list);//확인용
			return new UsernamePasswordAuthenticationToken(admin,null,list);
		}
		return null;//- 인증 실패
	}

	@Override
	public boolean supports(Class<?> authentication) {
		return authentication.isAssignableFrom(UsernamePasswordAuthenticationToken.class);
	}
}
