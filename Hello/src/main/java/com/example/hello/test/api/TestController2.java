package com.example.hello.test.api;

import java.util.ArrayList;
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
import org.springframework.web.bind.annotation.ResponseBody;

import com.example.hello.cmn.service.CmnService;
import com.example.hello.test.service.dao.TestMDAO;
import com.example.hello.test.service.vo.TestVO;
import com.example.hello.test.service.vo.TestVO2;
import com.fasterxml.jackson.databind.ObjectMapper;

@Controller
@RequestMapping("/test")
public class TestController2 {

	private static final Logger logger = LoggerFactory.getLogger(TestController2.class);

	@Autowired
	public CmnService cmnService;

	@Autowired
	public TestMDAO testMDAO;
	
	@ResponseBody
	@RequestMapping(value = "/p1/getDepth2", method = RequestMethod.POST)
	public Map<String, Object> hello(HttpServletRequest request) throws Exception {

		Map<String, Object> dataMap = new HashMap<String, Object>();

		try {

			logger.info("getDepth2=============");

			List<TestVO> nextList = new ArrayList<TestVO>();

			String jsonStr = cmnService.readJSONStringFromRequestBody(request);

			if(!"".equals(jsonStr)) {
				ObjectMapper mapper = new ObjectMapper();

				TestVO2 testVO2 = mapper.readValue(jsonStr, TestVO2.class);
				logger.info("AJAX가 요청한 값 : " + testVO2);

				if( testVO2 != null && !"".equals(testVO2.getCode()) ) {
					String reqCode = testVO2.getCode();
					logger.info("AJAX가 요청한 코드 값 : " + reqCode);

					switch(reqCode) {
					case "1" :
						nextList = testMDAO.getSport();
						break;
					case "2" :
						nextList = testMDAO.getFood();
						break;	

					}
				}
			}

			dataMap.put("result", "0000");
			dataMap.put("nextList", nextList);
			
			logger.info("AJAX에 응답 값 : " + nextList);
		} catch (Exception e) {
			logger.info("에러 : ", e);
			dataMap.put("result", "9999");
		}
		return dataMap;
	}
}



