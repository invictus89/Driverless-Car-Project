package edu.autocar.contoller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import edu.autocar.domain.Board;
import edu.autocar.domain.PageInfo;
import lombok.extern.slf4j.Slf4j;

@Controller
@RequestMapping("start")
@Slf4j
public class IntroController {
	
	@GetMapping("/intro")
	public void list() throws Exception {
		
	}

}
