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
import org.springframework.web.bind.annotation.ResponseBody;

import com.example.hello.test.service.TestService;

@Controller
@RequestMapping("/hello")
public class TestController2 {

	private static final Logger logger = LoggerFactory.getLogger(TestController2.class);
	
	@Autowired
	public TestService testService;

	@ResponseBody
	@RequestMapping(value = "/getDepth2", method = RequestMethod.POST)
	public Map<String, Object> hello(HttpServletRequest request) throws Exception {

		Map<String, Object> dataMap = new HashMap<String, Object>();
		
		try {

			logger.info("getDepth2=============");

			dataMap = testService.getTest2(request);
			
		} catch (Exception e) {
			logger.info("에러 : ", e);
		}
		
		return dataMap;
	}
}



