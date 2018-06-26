package com.hsun.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.hsun.dao.StudentMapper;
import com.hsun.pojo.Student;

@Service(value="studentService")
public class StudentServiceImpl implements StudentService{
	
	@Autowired
	private StudentMapper studentMapper;

	@Override
	public Student retireveStudentById(long id) {
		return studentMapper.selectByPrimaryKey(id);
	}

}
