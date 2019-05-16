package edu.autocar.contoller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.util.UrlPathHelper;

import lombok.extern.slf4j.Slf4j;

@Controller
@RequestMapping("simulator")
@Slf4j
public class SimulatorController {
	@GetMapping("/main")
	public void list(HttpServletRequest request, HttpSession session) throws Exception {
		UrlPathHelper urlPathHelper = new UrlPathHelper(); 
		String originalURL = urlPathHelper.getOriginatingRequestUri(request);
		session.setAttribute("fromPath", originalURL);
	}
}
