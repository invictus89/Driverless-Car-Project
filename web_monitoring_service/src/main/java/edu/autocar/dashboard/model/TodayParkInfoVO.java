package edu.autocar.dashboard.model;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class TodayParkInfoVO {
	
	private String cityId;
	private int sigId;
	private String sigKorNm;
	private String sigEngNm;
	private String color;
	private int parkCnt;
}
