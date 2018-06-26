package com.hsun.test;

import java.util.List;

import org.junit.Before;
import org.junit.Test;
import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;

import com.hsun.dao.StudentMapper;
import com.hsun.pojo.Student;
import com.hsun.pojo.StudentExample;

public class MybatisTest {
	
	private ApplicationContext app; 
	
	@Before
	public void init() {
		app = new ClassPathXmlApplicationContext("classpath:spring/spring-core.xml");
	}

	@Test
	public void test() {
		StudentMapper studentMapper = app.getBean(StudentMapper.class);
		StudentExample example = new StudentExample();
		List<Student> students = studentMapper.selectByExample(example);
		for (Student student : students) {
			System.out.println(student);
		}
	}

}
