package edu.autocar.interceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Component;
@Component
public class LoginInterceptor extends BaseInterceptor {

	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
			throws Exception {
		//System.out.println("로그인 prehandler가 실행됩니다.");
		HttpSession session = request.getSession();
		if (session.getAttribute("USER") == null) {
			redirect(request, response, "/login", "로그인이 필요한 서비스입니다.");
			return false;
		}
		return super.preHandle(request, response, handler);
	}
}
