package com.atom.crud.controller;

import com.atom.crud.bean.Department;
import com.atom.crud.bean.Massages;
import com.atom.crud.service.DepartmentService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.List;

@Controller
public class DepartmentController {

    @Autowired
    private DepartmentService departmentService;

    @RequestMapping("/depts")
    @ResponseBody
    public Massages getDept(){

        List<Department> list = departmentService.getDepts();
        return Massages.Success().add("depts",list);

    }



}
