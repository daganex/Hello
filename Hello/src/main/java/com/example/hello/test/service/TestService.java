package com.example.hello.test.service;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;

public interface TestService {
	
	public Map<String, Object> getTest1();
	
	public Map<String, Object> getTest2(HttpServletRequest request);

	public Map<String, Object> getTest3(HttpServletRequest request);
}
