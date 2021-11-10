package com.example.hello.test.service.impl;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.example.hello.cmn.service.CmnService;
import com.example.hello.test.service.TestService;
import com.example.hello.test.service.dao.TestMDAO;
import com.example.hello.test.service.vo.TestVO;
import com.example.hello.test.service.vo.TestVO2;
import com.example.hello.test.service.vo.TestVO3;
import com.fasterxml.jackson.databind.ObjectMapper;

@Service
public class TestServiceImpl implements TestService {
	
	private static final Logger logger = LoggerFactory.getLogger(TestServiceImpl.class);

	@Autowired
	public CmnService cmnService;
	
	@Autowired
	public TestMDAO testMDAO;
	
	@Override
	public Map<String, Object> getTest1() {
		
		Map<String, Object> dataMap = new HashMap<String, Object>();
		
		try {
			
			List<TestVO> testList = testMDAO.getDepth1();
			
			if(!testList.isEmpty()) {
				dataMap.put("result", "0000");
				dataMap.put("testList", testList);
			} else {
				dataMap.put("result", "1000");
				dataMap.put("testList", null);
			}
		} catch (Exception e) {
			logger.info("에러 : ", e);
		}
		return dataMap;
	}
	
	@Override
	public Map<String, Object> getTest2(HttpServletRequest request) {

		Map<String, Object> dataMap = new HashMap<String, Object>();
		
		try {

			String jsonStr = cmnService.readJSONStringFromRequestBody(request);
			
			List<TestVO2> nextList = new ArrayList<TestVO2>();

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
			
			if( !nextList.isEmpty() ) {
				dataMap.put("result", "0000");
				dataMap.put("nextList", nextList);
			} else {
				dataMap.put("result", "1000");
				dataMap.put("nextList", null);
			}
			
		} catch (Exception e) {
			logger.info("에러 : ", e);
		}

		return dataMap;
	}

	@Override
	public Map<String, Object> getTest3(HttpServletRequest request) {

		Map<String, Object> dataMap = new HashMap<String, Object>();

		try {
			// 받은 데이터를 화면에서 받아도 되는데 여기선 몰해야할까
			List<TestVO3> list = new ArrayList<TestVO3>();
			
			TestVO3 vo = new TestVO3();
			vo.setCode(request.getParameter("depth1C"));
			vo.setName(request.getParameter("depth1N"));
			
			list.add(vo);
			
			vo = new TestVO3();
			vo.setCode(request.getParameter("depth2C"));
			vo.setName(request.getParameter("depth2N"));
			
			list.add(vo);
			
			dataMap.put("result", "0000");
			dataMap.put("testList", list);
			
		} catch (Exception e) {
			logger.info("에러 : ", e);
		}
		return dataMap;
	}
}
