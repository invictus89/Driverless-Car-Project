package edu.autocar.setting.controller;

import java.util.HashMap;
import java.util.Map;
import java.util.Random;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import edu.autocar.setting.model.ViolateVO;
import edu.autocar.setting.service.SettingService;
import lombok.extern.slf4j.Slf4j;

@Controller
@Slf4j
public class SettingController {
	@Autowired
	SettingService service;

	@GetMapping("/setting")
	public String view(Model model) throws Exception {

		return "setting/setting";
	}
	
	static String[] tmp1 = {"가","나","다","라","마","바","사","아","자","차","카","타","파","하"};
	
	@ResponseBody
	@PostMapping("/violate")
	public ResponseEntity<Map<String,Object>> violate() throws Exception {
		Map<String, Object> map = new HashMap<>();
		
		ViolateVO violateVO = new ViolateVO();
		
		String carId1 = String.format("%02d", new Random().nextInt(99) + 1);
		String carId2 = tmp1[new Random().nextInt(14)];
		String carId3 = String.format("%04d", new Random().nextInt(10000) + 1);
		
		String city = "01";
		String district = String.format("%02d", new Random().nextInt(25) + 1);
		
		violateVO.setCarId(carId1+carId2+carId3);
		violateVO.setCity(city);
		violateVO.setDistrict(district);
		
		int rs = service.insertViolate(violateVO);
		if(rs == 1) {
			map.put("rs", "OK");	
		}
		else {
			map.put("rs", "FAIL");
		}
		
		HttpHeaders headers = new HttpHeaders();
		headers.add("Content-Type", "application/json; charset=utf-8");
		return new ResponseEntity<Map<String, Object>>(
		map, headers, HttpStatus.OK);
	}
	

}
