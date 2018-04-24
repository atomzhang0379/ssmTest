package com.atom.crud.service;

import com.atom.crud.bean.Employee;
import com.atom.crud.bean.EmployeeExample;
import com.atom.crud.dao.EmployeeMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class EmployeeService {

    @Autowired
    EmployeeMapper employeeMapper;

    public List<Employee> getAll(){

        return employeeMapper.selectByExampleWithDept(null);
    }

    public int saveEmp(Employee employee){

       return employeeMapper.insertSelective(employee);
    }

    public boolean checkUser(String userName) {
        EmployeeExample employeeExample = new EmployeeExample();
        EmployeeExample.Criteria criteria = employeeExample.createCriteria();
        criteria.andEmpNameEqualTo(userName);
        long count = employeeMapper.countByExample(employeeExample);
//        employeeMapper.countByExample()
        return count==0;
    }
}
