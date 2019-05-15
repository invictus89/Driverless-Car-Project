package edu.autocar.service;

import org.springframework.web.multipart.MultipartFile;

import edu.autocar.domain.Member;
import edu.autocar.domain.PageInfo;

public interface MemberService {
	Member getMember(String userId) throws Exception;
	
	// 비밀번호 체크 
	Member checkPassword(String userId, String password) throws Exception;
}
