package edu.autocar.dashboard.service;

import java.util.List;

import edu.autocar.dashboard.model.TodayParkInfoVO;
import edu.autocar.sample.model.SampleVO;

public interface DashboardService {
	
	List<TodayParkInfoVO> selectDashboard() throws Exception; 
	
}
