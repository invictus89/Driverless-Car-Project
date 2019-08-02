package edu.autocar.setting.model;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class ViolateVO {
	
	private int id;
	private float lat;
	private float lng;
	private String city;
	private String district;
	private String carId;
	private String parkDate;
	
}
