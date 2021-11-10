package com.example.hello.test.api;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.example.hello.test.service.TestService;

@Controller
@RequestMapping("/test")
public class TestController3 {

	private static final Logger logger = LoggerFactory.getLogger(TestController3.class);
	
	@Autowired
	public TestService testService;
	
	@RequestMapping(value = "/p2", method = RequestMethod.POST)
	public String hello(HttpServletRequest request) throws Exception {

		Map<String, Object> dataMap = new HashMap<String, Object>();
		
		try {
			logger.info("start=============");
			
			dataMap = testService.getTest3(request);
			request.setAttribute("dataMap", dataMap);
			
		} catch (Exception e) {
			logger.info("에러 : ", e);
		}
		return "hello2";
	}
}
