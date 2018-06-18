package com.hsun.spring;

import org.springframework.context.annotation.AnnotationConfigApplicationContext;

import com.hsun.spring.config.DiConfig;
import com.hsun.spring.service.UseFuncationService;

public class App {
	
	public static void main(String[] args) {
		AnnotationConfigApplicationContext app = 
				new AnnotationConfigApplicationContext(DiConfig.class);//1
		//使用AnnotationConfigApplicationContext作为Spring的容器，接收一个配置类作为参数
		
		UseFuncationService useFuncationService = 
				app.getBean(UseFuncationService.class);//2
		//获得生命配置的UseFuncationService的Bean
		
		System.out.println(useFuncationService.sayHello("world"));
		
		app.close();
		
		
	}

}
