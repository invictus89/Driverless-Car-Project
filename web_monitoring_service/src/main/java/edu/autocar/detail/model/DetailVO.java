package edu.autocar.detail.model;


import java.util.Date;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;


@Data
@NoArgsConstructor
@AllArgsConstructor

public class DetailVO {
	private int id;
	private String district;
	private String carId;
	private Date parkDate;
	private byte[] img;
}
