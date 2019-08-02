package edu.autocar.dashboard.dao;

import java.util.List;

import edu.autocar.dashboard.model.TodayParkInfoVO;

public interface DashboardDao {
	List<TodayParkInfoVO> selectDashboard() throws Exception; 
}
