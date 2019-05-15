package edu.autocar.domain;

import java.util.Date;

import javax.validation.constraints.Email;
import javax.validation.constraints.NotEmpty;

import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import lombok.AllArgsConstructor;
import lombok.Data;

@Data
@AllArgsConstructor
public class Member {
	@NotEmpty(message = "사용자 ID는 필수 항목입니다.")
	private String userId;
	@NotEmpty(message = "비밀번호는 필수 항목입니다.")
	private String userPwd;
	//private String salt;
	private String userName;
	private UserLevel userLevel;
	private String userImg;

	public Member() {
		userLevel = UserLevel.NORMAL;
	}

	public boolean isAdmin() {
		return userLevel == UserLevel.ADMIN;
	}
}
