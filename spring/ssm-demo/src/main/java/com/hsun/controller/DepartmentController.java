package com.hsun.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.hsun.bean.Department;
import com.hsun.bean.Msg;
import com.hsun.service.DepartmentService;

/**
 * 处理和部门有关的请求
 * @author 孙浩
 *
 */
@Controller
public class DepartmentController {
	@Autowired
	private DepartmentService departentService;
	
	/**
	 * 返回所有部门信息
	 */
	@RequestMapping("/depts")
	@ResponseBody
	public Msg getDepts(){
		//查出所有的部门信息
		List<Department> list = departentService.getDepts();
		return Msg.success().add("depts", list);
	}
}
