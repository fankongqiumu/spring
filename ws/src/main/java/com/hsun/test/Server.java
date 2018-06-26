package com.hsun.test;

import com.fasterxml.jackson.jaxrs.json.JacksonJsonProvider;
import com.hsun.service.StudentServiceImpl;

import org.apache.cxf.jaxrs.JAXRSServerFactoryBean;
import org.apache.cxf.jaxrs.lifecycle.ResourceProvider;
import org.apache.cxf.jaxrs.lifecycle.SingletonResourceProvider;
import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;

import java.util.ArrayList;
import java.util.List;

/**
 * 发布REST服务
 */
public class Server {
    public static void main(String[] args) {
    	ApplicationContext app  = new ClassPathXmlApplicationContext("classpath:spring/spring-core.xml");
    	JAXRSServerFactoryBean factory=(JAXRSServerFactoryBean) app.getBean("jAXRSServerFactoryBean");
    	SingletonResourceProvider singletonResourceProvider=(SingletonResourceProvider) app.getBean("singletonResourceProvider");
    	JacksonJsonProvider jacksonJsonProvider=(JacksonJsonProvider) app.getBean("jacksonJsonProvider");

    	//添加ResourceClass
        List<Class<?>> resourceClassList=new ArrayList<Class<?>>();
        resourceClassList.add(StudentServiceImpl.class);
        //添加ResourceProvider
        List<ResourceProvider> resourceProviderList=new ArrayList<ResourceProvider>();
        resourceProviderList.add(singletonResourceProvider);

        //添加Provider
        List<Object> providerList=new ArrayList<Object>();
        providerList.add(jacksonJsonProvider);
        //发布REST服务
        factory.setResourceClasses(resourceClassList);
        factory.setResourceProviders(resourceProviderList);
        factory.setProviders(providerList);
        factory.create();
        System.out.println("rest ws is published");
    }
}