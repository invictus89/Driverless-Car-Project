package edu.autocar.detail.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import edu.autocar.detail.model.DetailVO;

public interface DetailDao {
	List<DetailVO> getPage(@Param("start") int start, @Param("end") int end) throws Exception;
	
	int count() throws Exception;
}
