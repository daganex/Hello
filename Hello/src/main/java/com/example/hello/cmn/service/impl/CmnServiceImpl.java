package com.example.hello.cmn.service.impl;

import java.io.BufferedReader;

import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Service;

import com.example.hello.cmn.service.CmnService;

@Service
public class CmnServiceImpl implements CmnService{

	@Override
	public String readJSONStringFromRequestBody(HttpServletRequest request){
		
		String result = "";
	    StringBuffer json = new StringBuffer();
	    String line = null;
	 
	    try {
	        BufferedReader reader = request.getReader();
	        while((line = reader.readLine()) != null) {
	            json.append(line);
	        }
	        result = json.toString();
	    }catch(Exception e) {
	        System.out.println("Error reading JSON string: " + e.toString());
	    }
	    return result;
	}
}
