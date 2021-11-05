package com.example.hello.test.api;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.example.hello.test.service.dao.TestMDAO;
import com.example.hello.test.service.vo.TestVO;

@Controller
@RequestMapping("/test")
public class TestController {

	private static final Logger logger = LoggerFactory.getLogger(TestController.class);
	
	@Autowired
	public TestMDAO testMDAO;
	
	@RequestMapping(value = "/p1", method = RequestMethod.GET)
	public String hello(HttpServletRequest request) throws Exception {

		Map<String, Object> dataMap = new HashMap<String, Object>();
		
		try {
			
			logger.info("start=============");
			
			List<TestVO> testList = testMDAO.getDepth1();
			
			dataMap.put("testList", testList);
			
			request.setAttribute("dataMap", dataMap);
			
		} catch (Exception e) {
			logger.info("에러 : ", e);
		}
		return "hello";
	}
}
