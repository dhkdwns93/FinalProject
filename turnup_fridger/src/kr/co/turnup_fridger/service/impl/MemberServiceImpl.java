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
import org.springframework.transaction.annotation.Transactional;

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
	@Transactional
	public void signUpMember(Member member) throws SignUpMemberFailException{
		//전체 user들 관리테이블인 Authority테이블에 같은 Id있으면 회원가입 불가
		if(authorityDao.selectAuthorityById(member.getMemberId())!=null){
			throw new SignUpMemberFailException("이미 등록된 ID입니다.");
		}
		//전체 member들 관리테이블인 Member테이블에 같은 Email있으면 회원가입 불가
		if(memberDao.selectMemberByEmail(member.getMemberEmail())!=null){
			throw new SignUpMemberFailException("이미 등록된 Email입니다.");
		}else{
			//패스워드 암호화 처리
			member.setMemberPw(passwordEncoder.encode(member.getMemberPw()));
			//System.out.println("serviceImpl signUpMember메소드 : "+member);
			//Authority 테이블 insert -foreignKey제약조건때문에 먼저 넣어줘야해 //일반회원으로 가입하는 경우 자동으로 권한 =member로 설정
			authorityDao.insertAuthority(new Authority(member.getMemberId(),member.getMemberPw(),"ROLE_MEMBER"));
			//Member 테이블 insert
			memberDao.insertMember(member);	
		}
	}

	@Override
	public Member inquiryMemberInfo(String memberId) {
		return memberDao.selectMemberById(memberId);
	}

	@Override
	@Transactional
	public void changeMemberInfo(Member member) throws ChangeMemberInfoFailException {
		//다른 기존회원 중 같은 이메일 사용 회원있으면 update불가.
		Member existMember=memberDao.selectMemberByEmail(member.getMemberEmail());//바꾸려는 member정보중 이메일이
		if(existMember!=null&&!existMember.getMemberId().equals(member.getMemberId())){//같은 회원이 자기와 다른 회원일때=>즉, 다른 회원중 수정하려는 이메일 소유자가 있을 때
			throw new ChangeMemberInfoFailException("이미 타사용자가 사용중인 이메일입니다.");			
		}
		// 패스워드 암호화 처리
		member.setMemberPw(passwordEncoder.encode(member.getMemberPw()));
		// Member 테이블 해당 회원 update
		memberDao.updateMember(member);
		// 비밀번호가 바꼈을 경우 Authority 테이블 해당 회원 update
		Authority existAuthority=authorityDao.selectAuthorityById(member.getMemberId());
		if(!existAuthority.getLoginPw().equals(member.getMemberPw())){//비밀번호가 바꼈을 경우
			//**권한은 바꾸지 않음.
			authorityDao.updateAuthority(new Authority(member.getMemberId(),member.getMemberPw(),existAuthority.getLoginAuthority()));
		}
	}

	@Override
	@Transactional
	public void deleteMember(String memberId) {
		//Member 테이블 해당 회원 삭제
		memberDao.deleteMemberById(memberId);
		//Authority 테이블 해당 회원 삭제
		authorityDao.deleteAuthority(memberId);
	}

	@Override
	public Member findMemberByEmail(String memberEmail){
		return memberDao.selectMemberByEmail(memberEmail);
	}

	@Override
	public List<Member> inquiryMemberList() {
		return memberDao.selectMemberList();
	}

}
