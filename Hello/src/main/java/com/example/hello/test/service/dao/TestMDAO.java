package com.example.hello.test.service.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.example.hello.test.service.vo.TestVO;

@Mapper
public interface TestMDAO {

	public List<TestVO> getDepth1();
	
	public List<TestVO> getSport();
	
	public List<TestVO> getFood();
	
}
