package edu.autocar.detail.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;

import edu.autocar.cmmn.domain.PageInfo;
import edu.autocar.detail.model.DetailVO;
import edu.autocar.detail.service.DetailService;
import edu.autocar.sample.service.SampleService;

@Controller
public class DetailController {
	
	@Autowired
	SampleService service;
	
	@Autowired
	DetailService detailService;
	
	@GetMapping("/detail")
	public String view(@RequestParam(value="page", defaultValue="1") int page, Model model) throws Exception {
		PageInfo<DetailVO> pi = detailService.selectDashboard(page);		
		model.addAttribute("pi", pi);
		return "detail/detail";
	}

}
