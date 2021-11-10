package com.example.hello.test.service.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.example.hello.test.service.vo.TestVO;
import com.example.hello.test.service.vo.TestVO2;

@Mapper
public interface TestMDAO {

	public List<TestVO> getDepth1();
	
	public List<TestVO2> getSport();
	
	public List<TestVO2> getFood();
	
}
