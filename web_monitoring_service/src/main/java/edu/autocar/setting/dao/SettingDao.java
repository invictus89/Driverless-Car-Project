package edu.autocar.setting.dao;

import java.util.List;

import edu.autocar.dashboard.model.TodayParkInfoVO;
import edu.autocar.setting.model.ViolateVO;

public interface SettingDao {
	int insertViolate(ViolateVO violateVO) throws Exception; 
}
