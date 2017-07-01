/**
 (ServiceImpl)memberServiceImpl
작성자 :  김경혜
최초 작성일 170629
변경이력
170701 authority 테이블 생성 후 다시 authority와 관련된 기능 수정
*/
package kr.co.turnup_fridger.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

import kr.co.turnup_fridger.dao.AuthorityDao;
import kr.co.turnup_fridger.dao.MemberDao;
import kr.co.turnup_fridger.exception.ChangeMemberInfoFailException;
import kr.co.turnup_fridger.exception.FindMemberFailException;
import kr.co.turnup_fridger.exception.SignUpMemberFailException;
import kr.co.turnup_fridger.service.MemberService;
import kr.co.turnup_fridger.vo.Authority;
import kr.co.turnup_fridger.vo.Member;

@Service("memberService")
public class MemberServiceImpl implements MemberService {

	@Autowired
	private MemberDao memberDao;
	@Autowired
	private AuthorityDao authorityDao;
	@Autowired
	private PasswordEncoder passwordEncoder;
	
	
	@Override
	public void signUpMember(Member member) throws SignUpMemberFailException{
		//전체 user들 관리테이블인 Authority테이블에 같은 Id있으면 회원가입 불가
		if(authorityDao.selectAuthorityById(member.getLoginId())!=null){
			throw new SignUpMemberFailException("이미 등록된 ID입니다.");
		}else{
			//전체 member들 관리테이블인 Member테이블에 같은 Email있으면 회원가입 불가
			if(memberDao.selectMemberByEmail(member.getMemberEmail())!=null){
				throw new SignUpMemberFailException("이미 등록된 Email입니다.");
			}else{
				//패스워드 암호화 처리
				member.setLoginPw(passwordEncoder.encode(member.getLoginPw()));
				//Member 테이블 insert
				memberDao.insertMember(member);
				//Authority 테이블 insert //일반회원으로 가입하는 경우 자동으로 권한 =member로 설정
				authorityDao.insertAuthority(new Authority(member.getLoginId(),member.getLoginPw(),"member"));
			}
		}
	}

	@Override
	public Member inquiryMemberInfo(String loginId) {
		return memberDao.selectMemberById(loginId);
	}

	@Override
	public void changeMemberInfo(Member member) throws ChangeMemberInfoFailException {
		//다른 기존회원 중 같은 이메일 사용 회원있으면 update불가.
		Member existMember=memberDao.selectMemberByEmail(member.getMemberEmail());//바꾸려는 member정보중 이메일이
		if(!existMember.getLoginId().equals(member.getLoginId())){//같은 회원이 자기와 다른 회원일때=>즉, 다른 회원중 수정하려는 이메일 소유자가 있을 때
			throw new ChangeMemberInfoFailException("이미 타사용자가 사용중인 이메일입니다.");			
		}
		// 패스워드 암호화 처리
		member.setLoginPw(passwordEncoder.encode(member.getLoginPw()));
		// Member 테이블 해당 회원 update
		memberDao.updateMember(member);
		// 비밀번호가 바꼈을 경우 Authority 테이블 해당 회원 update
		Member existMember2=memberDao.selectMemberById(member.getLoginId());
		if(!existMember2.equals(member.getLoginPw())){//비밀번호가 바꼈을 경우
			//**권한은 바꾸지 않음.
			authorityDao.updateAuthority(new Authority(member.getLoginId(),member.getLoginPw(),existMember.getMemberAuthority()));
		}
	}

	@Override
	public void deleteMember(String loginId) {
		//Member 테이블 해당 회원 삭제
		memberDao.deleteMemberById(loginId);
		//Authority 테이블 해당 회원 삭제
		authorityDao.deleteAuthority(loginId);
	}

	@Override
	public Member findMember(String name, String memberEmail) throws FindMemberFailException {
		Member existMember=memberDao.selectMemberByEmail(memberEmail);
		//이메일, 이름 모두 일치하지 않으면 이용불가.
		if(!existMember.getMemberName().equals(name)){
			throw new FindMemberFailException("이름과 이메일이 일치하지 않습니다.");
		}
		return existMember;
	}

	@Override
	public List<Member> inquiryMemberList() {
		return memberDao.selectMemberList();
	}

}
