package com.hsun.spring.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service//使用@Service注解四横名当前类是一个Spring所管理的Bean
public class UseFuncationService {

	/**
	 * 使用@Autowired将FuncationService注入到当前类中，
	 * 使得UseFuncationService类具有FuncationService类的功能，此处使用JSR-330提供
	 * 的@Inject注解或者是JSR-250提供的@Resource注解是等效的。
	 */
	@Autowired//2
	private FuncationService funcationService;
	
	public String sayHello(String word) {
		
		return funcationService.sayHello(word);
	}
}
