package edu.autocar.dashboard.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import edu.autocar.dashboard.dao.DashboardDao;
import edu.autocar.dashboard.model.TodayParkInfoVO;
import lombok.extern.slf4j.Slf4j;

@Repository
@Slf4j
public class DashboardServiceImpl implements DashboardService {

	@Autowired
	DashboardDao dao;
	
	@Override
	public List<TodayParkInfoVO> selectDashboard() throws Exception {
		return dao.selectDashboard();
	}
	
}