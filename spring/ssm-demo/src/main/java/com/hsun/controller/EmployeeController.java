package com.hsun.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.validation.FieldError;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.hsun.bean.Employee;
import com.hsun.bean.Msg;
import com.hsun.service.EmployeeService;

/**
 * 处理员工CRUD的请求
 * @author 孙浩
 *
 */

@Controller
public class EmployeeController {
	
	@Autowired
	EmployeeService employeeService;
	
	/**
	 * 单个删除批量删除二合一
	 * 批量删除：1-2-3
	 * 单个删除：1
	 * 
	 * 逻辑：首先判断传入的要删除的员工的id值是否带有 "-"，如果有则是批量删除，否则是单个删除
	 * 		如果是单个删除，首先将传入的字符串做切割(以"-"切割)，使用foreach遍历切割后
	 * 		得到的String类型的数组，将每个遍历到的值通过  Integer.parseInt(String string)
	 * 		方法转化为一个Integer类型的值，并一次将其 添加到一个List集合中，然后调用mapper中处理批量删除的发法即可。
	 * 		(mapper中处理批量删除的方法主要是使用 mybatis 逆向工程生成的条件拼装规则，将service中传入的
	 * 		多个需要删除的 id 值动态拼装到条件中调用"employeeMapper.deleteByExample(example);",最终
	 * 		使之形成这样的一条SQL语句：delete from xxx where emp_id in (1,2,3,4))
	 * 		如果是单个删除，将传入的字符串转换为Integer类型，调用service将之当成参数传入即可(service中包含一个
	 * 		处理删除单个员工的方法，该方法使用mapper接口调用mapper文件中的定义的按照主键删除的方法即可)
	 * 处理删除请求的方法（）
	 * @param empId
	 * @return
	 */
	@RequestMapping(value="/emp/{empIds}",method=RequestMethod.DELETE)
	@ResponseBody
	public Msg deleteEmp(@PathVariable("empIds")String empIds){
		
		if (empIds.contains("-")) {
			List<Integer> del_empIds = new ArrayList<>();
			String[] str_empIds = empIds.split("-");
			for (String string : str_empIds) {
				del_empIds.add(Integer.parseInt(string));
			}
			employeeService.deleteBatch(del_empIds);
		}else{
			Integer empId =Integer.parseInt(empIds);
			employeeService.deleteEmp(empId);
		}
		return Msg.success();
	}
	
	
	/**
	 * 如果直接发送ajax请求方式"type:PUT"形式的请求
	 * 封装数据
	 * Employee
	 * [empId=1012, empName=null, gender=M, email=aaa@qq.com, dId=2, department=null]
	 * 
	 * 问题：
	 * 请求体中有数据
	 * 但是Employee封装不上，导致SQL拼装成：
	 * update tbl_emp where emp_id = 1012
	 * 
	 * 原因：
	 * Tomcat服务器：1.将请求体中的数据封装成一个map
	 * 			   2.request.getParameter("empName")将会从map中取值
	 * 			   3.springMVC 封装pojo对象的时候，会把POJO中的每个属性的值，
	 * 				 request.getParameter("email")；
	 * 
	 * AJAX发送PUT请求不能直接发送：
	 * 			PUT请求，请求体中的数据，request.getParameter("empName")拿不到
	 * 			Tomcat解析到请求的方法是PUT，不会封装请求体中的数据，只有POST形式的请求才会封装请求体中的数据
	 * 	
	 * 解决：
	 * 		我们要能直接发送PUT之类的请求还需要封装请求体中的数据
	 * 		1.在web.xml中配置上 org.springframework.web.filter.HttpPutFormContentFilter过滤器
	 * 		2.它的作用是将请求体中的数据封装成一个map
	 * 		3.request被重新包装,request.getParameter()被重写，就会从自己封装的map中取数据
	 *  	   
	 * 保存更新员工的方法
	 * @param employee
	 * @return
	 */
	@RequestMapping(value="/emp/{empId}",method=RequestMethod.PUT)
	@ResponseBody
	public Msg saveEmp(Employee employee){
		System.out.println("将要更新的员工数据： "+employee);
		employeeService.updateEmp(employee);
		return Msg.success();
	}
	
	/**
	 * 检查用户名是否可用
	 * @param userName
	 * @return
	 */
	@ResponseBody
	@RequestMapping("/checkuser")
	public Msg checkUser(@RequestParam("empName")String userName){
		//先判断用户名是否是合法的表达式
		String regx = "(^[a-zA-Z0-9_-]{6,16}$)|(^[\u2E80-\u9FFF]{2,5})";
		if (!userName.matches(regx)) {
			return Msg.fail().add("va_msg", "用户名可以是2-5位中文或者6-16位英文和数字的组合");
		}
		//用户名重复校验
		boolean b = employeeService.checkUser(userName);
		if(b){
			return Msg.success();
		}else{
			return Msg.fail().add("va_msg", "用户名重复，不可用");
		}
	}
	
	
	/**
	 * 导入Jackson包，负责将PageInfo对象转成Json
	 * @param pn
	 * @return
	 */
	@RequestMapping("/emps")	
	@ResponseBody
	public Msg getEmpsWithJson(@RequestParam(value="pn",defaultValue="1") Integer pn){
		//原生的不是分页查询
				//引入pageHelper插件
				//在查询之前只需要调用
				PageHelper.startPage(pn, 10);//第一个参数是页码，第二个参数是每页的大小
				//startPage后跟的查询就是一个简单的查询
				List<Employee> emps= employeeService.getAll();
				//使用pageInfo包装后的查询结果，只需要将pageInfo交给页面即可
				//pageInfo封装了详细的分页信息，包括有我们查询出来的数据
				PageInfo page = new PageInfo(emps,5);//第一个参数是查询出来的数据，第二个参数是要连续显示的页数
				return Msg.success().add("pageInfo",page);
	}
	
	/**
	 * 查询员工数据（分页查询）
	 * @param pageNumber
	 * @param model
	 * @return
	 */
	//@RequestMapping("/emps")	
	public String  getEmps(@RequestParam(value="pn",defaultValue="1") Integer pn,Model model) {
		//原生的不是分页查询
		//引入pageHelper插件
		//在查询之前只需要调用
		PageHelper.startPage(pn, 10);//第一个参数是页码，第二个参数是每页的大小
		//startPage后跟的查询就是一个简单的查询
		List<Employee> emps= employeeService.getAll();
		//使用pageInfo包装后的查询结果，只需要将pageInfo交给页面即可
		//pageInfo封装了详细的分页信息，包括有我们查询出来的数据
		PageInfo page = new PageInfo(emps,5);//第一个参数是查询出来的数据，第二个参数是要连续显示的页数
		model.addAttribute("pageInfo",page);
		return "list";
	}
	
	/**
	 * 保存员工
	 * @return
	 * REST风格的URI定义
	 * URI：
	 *emp/{id} GET查询员工
	 *emp  POST 保存员工
	 *emp/{id} PUT 修改员工
	 *emp/{id} DELETE 删除员工
	 */
	@RequestMapping(value="emp",method=RequestMethod.POST)
	@ResponseBody
	public Msg saveEmp(@Valid Employee employee,BindingResult result){//@Valid注解代表封装的对象要进行注解，BindingResult对象用于封装的结果
		if(result.hasErrors()){
			//校验失败应该在模态框中返回校验失败的错误信息
			Map<String, Object> map = new HashMap<>();
			List<FieldError> errrs = result.getFieldErrors();//获取校验失败的所有信息
			for (FieldError fieldError : errrs) {
				System.out.println("错误的字段名："+fieldError.getField());
				System.out.println("错误信息："+fieldError.getDefaultMessage());
				map.put(fieldError.getField(), fieldError.getDefaultMessage());
			}
			return Msg.fail().add("errorFields", map);
		}else{
			employeeService.saveEmp(employee);
			return Msg.success();	
		}
	}
	
	@RequestMapping(value="/emp/{id}",method=RequestMethod.GET)
	@ResponseBody
	private Msg getEmp(@PathVariable("id")Integer id) {//@PathVariable("id")此注解表示该方法需要传入的参数来自于地址中的参数
		Employee employee = employeeService.getEmp(id);
		return Msg.success().add("emp", employee);
	}
}
