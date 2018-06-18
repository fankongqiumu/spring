package com.hsun.spring.service;

import org.springframework.stereotype.Service;

@Service//1
public class FuncationService {
	
	public String sayHello(String word) {
		
		return "Hello " + word + "!"; 
	}

}
