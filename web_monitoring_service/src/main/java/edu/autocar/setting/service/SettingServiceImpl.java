package edu.autocar.setting.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import edu.autocar.setting.dao.SettingDao;
import edu.autocar.setting.model.ViolateVO;
import lombok.extern.slf4j.Slf4j;

@Repository
@Slf4j
public class SettingServiceImpl implements SettingService {

	@Autowired
	SettingDao dao;

	@Override
	public int insertViolate(ViolateVO violateVO) throws Exception {
		return dao.insertViolate(violateVO);
	}
	
}