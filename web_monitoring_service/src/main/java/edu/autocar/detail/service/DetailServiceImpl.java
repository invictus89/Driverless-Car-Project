package edu.autocar.detail.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import edu.autocar.cmmn.domain.PageInfo;
import edu.autocar.detail.dao.DetailDao;
import edu.autocar.detail.model.DetailVO;
import lombok.extern.slf4j.Slf4j;


@Repository
@Slf4j
public class DetailServiceImpl implements DetailService{
	
	@Autowired
	DetailDao dao;
	
	
	final static private int PER_PAGE_COUNT = 10;
	
	
	@Override
	public PageInfo<DetailVO> selectDashboard(int page) throws Exception {
		int start = PER_PAGE_COUNT*(page-1)+1;
		int end = PER_PAGE_COUNT * page;

		
		int totalCount = dao.count();
		//System.out.println("레코드 갯수 > " + totalCount);
		List<DetailVO> list = dao.getPage(start, end);
		
		return new PageInfo<>(totalCount, (int)Math.ceil(totalCount / (double)PER_PAGE_COUNT),
				page, PER_PAGE_COUNT, list);
	}



	
	

}
