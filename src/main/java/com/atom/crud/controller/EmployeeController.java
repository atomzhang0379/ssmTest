package com.atom.crud.controller;


import com.atom.crud.bean.Employee;
import com.atom.crud.bean.Massages;
import com.atom.crud.service.EmployeeService;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.validation.FieldError;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.validation.Valid;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
public class EmployeeController {

    @Autowired
    EmployeeService employeeService;

    public Massages massages;

    @RequestMapping("/emps")
    @ResponseBody
    public Massages getEmpsWithJson(@RequestParam(value="pn",defaultValue = "1")Integer pn, Model model){
        PageHelper.startPage(pn,5);
//        紧跟的查询就是一个分页查询
        List<Employee> emps = employeeService.getAll();
//        将pageinfo交给页面，里面封装了详细的分页信息，包括查询出来的数据,连续显示的页数
        PageInfo pageInfo = new PageInfo(emps,5);

            return Massages.Success().add("pageInfo",pageInfo);
    }


    public String getEmps(@RequestParam(value="pn",defaultValue = "1")Integer pn, Model model){
//        引入分页,传入页码，以及每页的大小
        PageHelper.startPage(pn,5);
//        紧跟的查询就是一个分页查询
        List<Employee> emps = employeeService.getAll();
//        将pageinfo交给页面，里面封装了详细的分页信息，包括查询出来的数据,连续显示的页数
        PageInfo pageInfo = new PageInfo(emps,5);
        model.addAttribute("pageInfo",pageInfo);

        return "list";


    }


//    添加员工

    @RequestMapping(value = "/saveEmp",method = RequestMethod.POST)
    @ResponseBody
    public Massages saveEmp(@Valid  Employee employee, BindingResult bindingResult){

        if (bindingResult.hasErrors()){
            Map<String,Object> map = new HashMap<String, Object>();

            List<FieldError> fieldErrors =  bindingResult.getFieldErrors();
            for (FieldError fieldError: fieldErrors) {
                System.out.println("错误的字段名"+fieldError.getField());
                System.out.println("错误的信息"+fieldError.getDefaultMessage());
                map.put(fieldError.getField(),fieldError.getDefaultMessage());
            }
                return Massages.fail().add("errorFields",map);
        }else {
            int result = employeeService.saveEmp(employee);
            return Massages.Success().add("num",result);
        }

    }


//    检查员工姓名
    @RequestMapping(value = "/checkUser")
    @ResponseBody
    public Massages checkUser(@RequestParam("userName") String userName){
//        判断用户名的是否合法
        String regist = "(^[a-zA-Z0-9_-]{6,16}$)|(^[\\u2E80-\\u9FFF]{2,5})";
        if (!userName.matches(regist)){
            return Massages.fail().add("va_msg","用户名必须是6-16位的字母数字   组合或者3-6位中文");

        }
        boolean boo = employeeService.checkUser(userName);
        if (boo){
           return Massages.Success();
        }else{
           return Massages.fail().add("va_msg","用户名不可用");
        }

    }


}
