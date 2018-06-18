package com.hsun.spring.config;

import org.springframework.context.annotation.ComponentScan;
import org.springframework.context.annotation.Configuration;

@Configuration//1 @Configration声明当前类是一个配置类
@ComponentScan("com.hsun.spring.service")//2 
/**
 * 使用@ComponentScan，自动扫描包下所有			
 * @Service、@Repository、@Controller、@Component
 * 的类，并注册为Bean
 */
public class DiConfig {

}
