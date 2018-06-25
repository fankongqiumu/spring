package com.hsun.spring.aop.aspect;

import java.lang.reflect.Method;

import org.aspectj.lang.JoinPoint;
import org.aspectj.lang.annotation.After;
import org.aspectj.lang.annotation.Aspect;
import org.aspectj.lang.annotation.Before;
import org.aspectj.lang.annotation.Pointcut;
import org.aspectj.lang.reflect.MethodSignature;
import org.springframework.stereotype.Component;

import com.hsun.spring.aop.annotation.Action;

@Aspect
@Component
public class LogAspect {

	@Pointcut("@annotation(com.hsun.spring.aop.annotation.Action)")
	public void annottationPointcut() {}
	
	@Before("execution(* com.hsun.spring.aop.service.DemoMethodService.*(..))")
	public void before(JoinPoint joinPoint) {
		MethodSignature methodSignature = (MethodSignature)
				joinPoint.getSignature();
		Method method= methodSignature.getMethod();
		System.out.println("方法规则式拦截，"+method.getName());
	} 
	
	@After("execution(* com.hsun.spring.aop.service.DemoMethodService.*(..))")
	public void after(JoinPoint joinPoint) {
		MethodSignature methodSignature = (MethodSignature)
				joinPoint.getSignature();
		Method method= methodSignature.getMethod();
		Action action = method.getAnnotation(Action.class);
		System.out.println("注解式拦截，"+action.name());
	}

}
