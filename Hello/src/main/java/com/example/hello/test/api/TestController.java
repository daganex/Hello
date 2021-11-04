package com.example.hello.test.api;

import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
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
	
	@RequestMapping(value = "/test.do", method = RequestMethod.GET)
	public String hello(Model model) throws Exception {

		try {
			logger.info("start=============");
			
			List<TestVO> testList = testMDAO.getAll();
			
			model.addAttribute("test", testList);
			
			for(TestVO vo : testList) {
				logger.info("vo: {}", vo);
			}
			
		} catch (Exception e) {
			logger.info("에러 : ", e);
		}
		return "hello";
	}
}
