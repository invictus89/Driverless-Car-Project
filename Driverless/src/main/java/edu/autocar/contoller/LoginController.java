package edu.autocar.contoller;

import javax.servlet.http.HttpSession;
import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import edu.autocar.domain.LoginInfo;
import edu.autocar.domain.Member;
import edu.autocar.service.MemberService;
import lombok.extern.slf4j.Slf4j;

@Controller
@Slf4j
@RequestMapping("/start")
public class LoginController {
	@Autowired
	MemberService service;
	
	@GetMapping("/logout")
	public String logout(HttpSession session) {
		session.invalidate();
		return "redirect:/start/intro";
	}
	
	@PostMapping("/login")
	public String postLogin(@Valid LoginInfo loginInfo, BindingResult result,
			HttpSession session) throws Exception {
		if(result.hasErrors()) return "start/intro";
		
		Member member = service.checkPassword(
				loginInfo.getUserId(), loginInfo.getUserPwd());
		
		if(member != null) {
			session.setAttribute("USER", member);
			String target = loginInfo.getTarget();
			if(target !=null && ! target.isEmpty()) 
						return "redirect:"+ target;

			if(member.isAdmin()) {	// 관리자 인경우
				System.out.println("관리자 로그인");
				return "redirect:/start/intro";
			} else {	//
				System.out.println("userlevel : "+member.getUserLevel());
				return "redirect:/";	
			}
		} else {
			result.reject("fail", "사용자 ID 또는 비밀번호가 일치하지 않습니다.");
			return "start/intro";
		}	
		
	}
}
