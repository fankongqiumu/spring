package com.hsun.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.hsun.bean.Employee;
import com.hsun.bean.EmployeeExample;
import com.hsun.bean.EmployeeExample.Criteria;
import com.hsun.dao.EmployeeMapper;

@Service("employeeservice")
public class EmployeeService {

	@Autowired
	EmployeeMapper employeeMapper;

	/**
	 * 查询所有的员工
	 * 
	 * @return
	 */
	public List<Employee> getAll() {
		// TODO Auto-generated method stub
		return employeeMapper.selectByExampleWithDept(null);
	}

	public void saveEmp(Employee employee) {
		// TODO Auto-generated method stub
		employeeMapper.insertSelective(employee);
	}

	/**
	 * 检验用户名是否可用
	 * 
	 * @param userName
	 * @return true：代表当前用户名唯一，可用；false：当前用户名已被占用，不可用
	 */
	public boolean checkUser(String userName) {
		// TODO Auto-generated method stub
		EmployeeExample example = new EmployeeExample();
		Criteria criteria = example.createCriteria();// 创建条件拼装对象
		criteria.andEmpNameEqualTo(userName);// 拼装条件：用户名必须和传入的参数一致
		Long count = employeeMapper.countByExample(example);
		return count == 0;
	}

	/**
	 * 按照员工id查询员工信息
	 * 
	 * @param id
	 * @return
	 */
	public Employee getEmp(Integer id) {
		Employee employee = employeeMapper.selectByPrimaryKey(id);
		return employee;
	}

	/**
	 * 员工更新
	 * 
	 * @param employee
	 */
	public void updateEmp(Employee employee) {
		employeeMapper.updateByPrimaryKeySelective(employee);

	}

	/**
	 * 员工删除
	 * @param empId
	 */
	public void deleteEmp(Integer empId) {
		// TODO Auto-generated method stub
		employeeMapper.deleteByPrimaryKey(empId);
	}

	public void deleteBatch(List<Integer> empIds) {
		// TODO Auto-generated method stub
		EmployeeExample example = new EmployeeExample();//创建拼装bean对象
		Criteria criteria = example.createCriteria();//创建拼装对象
		criteria.andEmpIdIn(empIds);//创建拼装条件将sql语句拼装为：delete from xxx where emp_id in (1,2,3,4)
		employeeMapper.deleteByExample(example);
	}

}
