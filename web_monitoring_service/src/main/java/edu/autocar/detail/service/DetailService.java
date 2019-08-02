package edu.autocar.detail.service;

import edu.autocar.cmmn.domain.PageInfo;
import edu.autocar.detail.model.DetailVO;

public interface DetailService {
	
	PageInfo<DetailVO> selectDashboard(int page) throws Exception; 
	
}
