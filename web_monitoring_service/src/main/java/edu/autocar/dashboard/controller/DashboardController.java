package edu.autocar.dashboard.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import edu.autocar.dashboard.model.TodayParkInfoVO;
import edu.autocar.dashboard.service.DashboardService;
import lombok.extern.slf4j.Slf4j;

@Controller
@Slf4j
public class DashboardController {
	@Autowired
	DashboardService service;
	
	@GetMapping("/dashboard")
	public String view(Model model) throws Exception {
		
		return "dashboard/dashboard";
	}
	
	
	@ResponseBody
	@PostMapping("/dashboard")
	public ResponseEntity<Map<String,Object>> get() throws Exception {
		Map<String, Object> map = new HashMap<>();
		
		List<TodayParkInfoVO> rs = service.selectDashboard();
		
		map.put("rs", rs);
		HttpHeaders headers = new HttpHeaders();
		headers.add("Content-Type", "application/json; charset=utf-8");
		return new ResponseEntity<Map<String, Object>>(
		map, headers, HttpStatus.OK);
	}
	
}
