/**
 (ServiceImpl)AdminServiceImpl
작성자 :  김경혜
최초 작성일 170703
변경이력
*/
package kr.co.turnup_fridger.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

import kr.co.turnup_fridger.dao.AdminDao;
import kr.co.turnup_fridger.dao.AuthorityDao;
import kr.co.turnup_fridger.exception.RegisterAdminFailException;
import kr.co.turnup_fridger.service.AdminService;
import kr.co.turnup_fridger.vo.Admin;
import kr.co.turnup_fridger.vo.Authority;

@Service("adminService")
public class AdminServiceImpl implements AdminService {

	@Autowired
	private AdminDao adminDao;
	@Autowired
	private AuthorityDao authorityDao;
	//@Autowired
	private PasswordEncoder passwordEncoder;
	
	@Override
	public Admin inquiryAdminInfo(String adminId) {
		return adminDao.selectAdminById(adminId);
	}

	@Override
	public void changeAdminInfo(Admin admin) {
		//패스워드 암호화 처리 
		admin.setAdminPw(passwordEncoder.encode(admin.getAdminPw()));
		//Admin 테이블 해당 관리자 update
		adminDao.updateAdmin(admin);
		//비밀번호가 바꼈을 경우 Authority 테이블 해당 관리자 update
		Authority existAuthority=authorityDao.selectAuthorityById(admin.getAdminId());
		if(!existAuthority.getLoginPw().equals(admin.getAdminPw())){
			//**권한은 바꾸지 않음.
			authorityDao.updateAuthority(new Authority(admin.getAdminId(),admin.getAdminPw(),existAuthority.getLoginAuthority()));
		}
	}

	@Override
	public List<Admin> inquiryAdminList() {
		return adminDao.selectAdminList();
	}

	@Override
	public void registerAdmin(Admin admin) throws RegisterAdminFailException {
		//전체 user들 관리테이블인 Authority테이블에 같은 Id있으면 관리자 등록 불가.
		if(authorityDao.selectAuthorityById(admin.getAdminId())!=null){
			throw new RegisterAdminFailException("이미 등록된 ID입니다.");
		}
		//패스워드 암호화 처리
		admin.setAdminPw(passwordEncoder.encode(admin.getAdminPw()));
		//Authority 테이블 insert //처음 등록할때는 자동으로 권한 = (일반관리자)"admin"(VO에서 처리)
		authorityDao.insertAuthority(new Authority(admin.getAdminId(),admin.getAdminPw(),admin.getAdminAuthority()));
		//Admin 테이블 insert
		adminDao.insertAdmin(admin);
	}

	@Override
	public void changeAdminAuthority(String adminId, String adminAuthority) {
		Admin existAdmin=adminDao.selectAdminById(adminId);
		existAdmin.setAdminAuthority(adminAuthority);
		//Admin 테이블 해당 관리자 update
		adminDao.updateAuthority(existAdmin);
		//Authority 테이블 해당 관리자 update
		authorityDao.updateAuthority(new Authority(existAdmin.getAdminId(),existAdmin.getAdminPw(),existAdmin.getAdminAuthority()));
	}

	@Override
	public void deleteAdmin(String adminId) {
		//Admin 테이블 해당 관리자 삭제 //-head마스터 삭제못하게 후에 수정해야함
		adminDao.deleteAdminById(adminId);
		//Authority 테이블 해당 관리자 삭제
		authorityDao.deleteAuthority(adminId);
	}

}
