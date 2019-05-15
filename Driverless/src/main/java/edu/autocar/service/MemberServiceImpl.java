package edu.autocar.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;
import edu.autocar.dao.MemberDao;
import edu.autocar.domain.Member;
import edu.autocar.domain.PageInfo;
import edu.autocar.domain.UserLevel;
import edu.autocar.util.SHA256Util;
import lombok.extern.slf4j.Slf4j;


@Slf4j
@Repository
public class MemberServiceImpl implements MemberService {

	@Autowired
	MemberDao dao;


	@Override
	public Member getMember(String userId) throws Exception {
		return dao.findById(userId);
	}

	@Override
	public Member checkPassword(String userId, String password) throws Exception {
		Member user = dao.findById(userId);
		if(user != null) {	// 사용자 ID가 존재하는 경우 
			//password = SHA256Util.getEncrypt(password, user.getSalt());
			if(password.equals(user.getUserPwd())) 
				return user;
		}
		// ID가 없거나 비밀번호가 다른 경우
		
		return null;
	}
}
