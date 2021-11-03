package com.example.hello.test.api;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller
@RequestMapping("/test")
public class TestController {

	private static final Logger logger = LoggerFactory.getLogger(TestController.class);

	@RequestMapping(value = "/test.do", method = RequestMethod.GET)
	public String hello(Model model) throws Exception {

		logger.info("model: {}", model);

		try {
			
			model.addAttribute("msg", "방가워!" );
			
		} catch (Exception e) {
			logger.info("에러 : ", e);
		}
		return "hello";
	}
}
