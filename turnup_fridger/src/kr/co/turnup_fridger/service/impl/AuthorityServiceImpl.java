/**
 (ServiceImpl)AuthorityServiceImpl
작성자 :  김경혜
최초 작성일 170706
변경이력
*/
package kr.co.turnup_fridger.service.impl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.co.turnup_fridger.dao.AuthorityDao;
import kr.co.turnup_fridger.service.AuthorityService;
import kr.co.turnup_fridger.vo.Authority;

@Service("authorityService")
public class AuthorityServiceImpl implements AuthorityService {
	@Autowired
	private AuthorityDao authorityDao;
	
	@Override
	public Authority findAuthority(String loginId) {
		return authorityDao.selectAuthorityById(loginId);
	}

}
