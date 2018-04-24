<%@ page import="com.github.pagehelper.PageInfo" %><%--
  Created by IntelliJ IDEA.
  User: atom
  Date: 2018/4/24
  Time: 0:29
  To change this template use File | Settings | File Templates.
--%>

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"  %>
<%
    pageContext.setAttribute("APP_PATH",request.getContextPath());
%>
<html>
<head>
    <link href="${APP_PATH}/statis/bootstrap-3.3.7-dist/css/bootstrap.min.css" rel="stylesheet">
    <script src="${APP_PATH}/statis/js/jquery-3.3.1.min.js"></script>
    <script src="${APP_PATH}/statis/bootstrap-3.3.7-dist/js/bootstrap.min.js"></script>
    <title>Title</title>

    <!-- 员工共添加的模态框 -->
    <div class="modal fade" id="emp_add_modal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                    <h4 class="modal-title" id="myModalLabel">员工添加</h4>
                </div>
                <div class="modal-body">
                    <form class="form-horizontal">
                        <div class="form-group">
                            <label for="empName_add_input" class="col-sm-2 control-label">empName</label>
                            <div class="col-sm-10">
                                <input type="text" class="form-control" id="empName_add_input" name="empName" placeholder="empName">
                                <span id="empName_add_span" class="help-block"></span>
                            </div>
                        </div>
                        <div class="form-group">
                            <label for="email_add_input" class="col-sm-2 control-label">email</label>
                            <div class="col-sm-10">
                                <input type="text" class="form-control" id="email_add_input" name="email" placeholder="email@qq.com">
                                <span id="email_add_span" class="help-block"></span>
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="col-sm-2 control-label">gender</label>
                            <div class="col-sm-10">
                                <label class="radio-inline">
                                    <input type="radio" name="gender" id="gender1_add_input" value="M"> 男
                                </label>
                                <label class="radio-inline">
                                    <input type="radio" name="gender" id="gender2_add_input" value="F"> 女
                                </label>
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="col-sm-2 control-label">depName</label>
                            <div class="col-sm-4">
                                <%--部门提交部门ID--%>
                                <select class="form-control" name="depId" id="dept_add_select">
                                </select>
                            </div>
                        </div>
                    </form>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                    <button type="button" class="btn btn-primary" id="emp_save_btn">保存</button>
                </div>
            </div>
        </div>
    </div>

</head>

<body>
<div class="container">
    <%--标题--%>
    <div class="row">
        <div class="col-md-12">
            <h1>SSM_CRUD</h1>
        </div>
    </div>
    <%--按钮--%>
    <div class="row">
        <div class="col-md-4 col-md-offset-10">
            <button  type="button" class="btn btn-primary" id="emp_add_modal_btn">新增</button>
            <button type="button" class="btn btn-danger">删除</button>
        </div>
    </div>
    <%--表格--%>
    <div class="row">
        <div class="col-md-12">
            <table class="table table-hover" id="emps_tables">
                <thead>
                <tr>
                    <th>#</th>
                    <th>empName</th>
                    <th>email</th>
                    <th>gender</th>
                    <th>deptName</th>
                    <th>操作</th>
                </tr>
                </thead>
                <tbody>
                </tbody>
            </table>
        </div>
    </div>
    <%--分页信息--%>
    <div class="row">
        <%--分页文字信息--%>
        <div class="col-md-6" id="page_info_area">
        </div>
        <%--分页条信息--%>
        <div class="col-md-6" id="page_nav_area">
        </div>
    </div>
</div>

<script type="text/javascript">
    $(function () {
        to_page(1);
    })
    var totalRecond;

  function to_page(pn) {
      $.ajax({
          url:"${APP_PATH}/emps",
          data:"pn="+pn,
          type:"GET",
          success:function (result) {

//              人员信息
              build_emps_table(result);
              //              分页条信息
              build_emps_page_info(result);
//              分页信息
              build_emps_page_nav(result);

          }
      });
  }

    function build_emps_table(result) {

//        每次请求清空表格数据

        $("#emps_tables tbody").empty();
        var emps = result.extend.pageInfo.list;
        $.each(emps,function (index,item) {
            var empIdTd = $("<td></td>").append(item.empId);
            var empNameTd = $("<td></td>").append(item.empName);
            var genderTd = $("<td></td>").append(item.gender=='M'?'男':"女");
            var emailTd = $("<td></td>").append(item.email);
            var depNameTd = $("<td></td>").append(item.department.depName);


            <%--<button class="btn btn-primary  btn-sm">--%>
            <%--<span class="glyphicon glyphicon-pencil" aria-hidden="true"></span>--%>
            <%--编辑--%>
            <%--</button>--%>
            var editBtnn = $("<button></button>").addClass("btn btn-primary  btn-sm").append($("<span></span>").addClass("glyphicon glyphicon-pencil")).append("编辑")
            var delBtnn = $("<button></button>").addClass("btn btn-danger  btn-sm").append($("<span></span>").addClass("glyphicon glyphicon-trash")).append("删除")
            var btnTd = $("<td></td>").append(editBtnn).append(delBtnn);
            $("<tr></tr>").append(empIdTd)
                .append(empNameTd)
                .append(emailTd)
                .append(genderTd)
                .append(depNameTd)
                .append(btnTd)
                .appendTo("#emps_tables tbody");
        })
    }
    function build_emps_page_nav(result) {
//            总数信息清空
            $("#page_info_area").empty();
            $("#page_info_area").append("当前第:"+result.extend.pageInfo.pageNum+"页,总共"+result.extend.pageInfo.pages+"页,当前记录数:"+result.extend.pageInfo.total);
        totalRecond = result.extend.pageInfo.total;
     }

    function build_emps_page_info(result) {
//            分页信息清空
            $("#page_nav_area").empty();
            var num_ul = $("<ul></ul").addClass("pagination")

            var first_page_li = $("<li></li>").append($("<a></a>").append("首页").attr("href","#"));
            var pre_page_li = $("<li></li>").append($("<a></a>").append("&laquo;").attr("href","#"));
            if(result.extend.pageInfo.hasPreviousPage==false){
                first_page_li.addClass("disabled");
                pre_page_li.addClass("disabled")
            }else{
                //            添加点击事件
                first_page_li.click(function () {
                    to_page(1);
                })
                pre_page_li.click(function () {
                    to_page(result.extend.pageInfo.pageNum-1)
                })
            }

            var last_page_li = $("<li></li>").append($("<a></a>").append("末页").attr("href","#"));
            var next_page_li = $("<li></li>").append($("<a></a>").append("&raquo;").attr("href","#"));
            last_page_li.click(function () {
            to_page(result.extend.pageInfo.pages);
        })

        next_page_li.click(function () {
            to_page(result.extend.pageInfo.pageNum+1);
        })
            if(result.extend.pageInfo.hasNextPage==false){
                last_page_li.addClass("disabled");
                next_page_li.addClass("disabled");
             }

              num_ul.append(first_page_li).append(pre_page_li);
            $.each(result.extend.pageInfo.navigatepageNums,function(index,item) {

                var numLi = $("<li></li>").append($("<a></a>").append(item).attr("href","#"));
                if(result.extend.pageInfo.pageNum == item){
                    numLi.addClass("active");
                }
                numLi.click(function () {
                    to_page(item);
                })
                num_ul.append(numLi);
            })
                  num_ul.append(next_page_li).append(last_page_li);
            var nav_Ele = $("<nav></nav>").append(num_ul).addClass();
            nav_Ele.appendTo("#page_nav_area");
  }
  
  function reset_form(ele) {
      $(ele)[0].reset();
      $(ele).find("*").removeClass("has-error has-success");
      $(ele).find(".help-block").text("");


  }

//  模态框新增事件

    $("#emp_add_modal_btn").click(function () {

//        每次点击后表单重置
        reset_form("#emp_add_modal form");
        //发送ajax请求显示下拉列表
        getDepts();
        $("#emp_add_modal").modal({
           backdrop:"static"
        });
    })
//    获取部门信息并添加option
    function getDepts() {
        $.ajax({
            url:"${APP_PATH}/depts",
            type:"GET",
            success:function (result) {
//                {"code":100,"msg":"处理成功","extend":{"depts":[{"depId":1,"depName":"研发部"},{"depId":2,"depName":"产品部"}]}}
                $.each(result.extend.depts,function () {
                    var optionEle = $("<option></option>").append(this.depName).attr("value",this.depId);
                    optionEle.appendTo("#dept_add_select");
                })
            }
        });
    }

//    校验表单
    function validate_add_form() {
        var empName = $("#empName_add_input").val();

//        字母大小写和中文
        var registName = /(^[a-zA-Z0-9_-]{6,16}$)|(^[\u2E80-\u9FFF]{2,5})/;
        if(!registName.test(empName)){
            show_validate_msg("#empName_add_input","error","用户名是2-5中文或6-16位英文和数字组合！")
            return false;
        }else{
            show_validate_msg("#empName_add_input","success","")
        }
        var empEmail = $("#email_add_input").val();
        var registEmail = /^[a-z\d]+(\.[a-z\d]+)*@([\da-z](-[\da-z])?)+(\.{1,2}[a-z]+)+$/;
        if(!registEmail.test(empEmail)){
            show_validate_msg("#email_add_input","error","邮箱格式不正确")
            return false;
        }else {
            show_validate_msg("#email_add_input","success","")
        }

            return true;


    }


//    抽取校验提示信息方法
        function show_validate_msg(ele,status,msg) {

            $(ele).parent().removeClass("has-success has-error");
            $(ele).next("span").text("")
            if(status == "success"){
                $(ele).parent().addClass("has-success");
                $(ele).next("span").text(msg)
            }else if(status == "error"){
                $(ele).parent().addClass("has-error");
                $(ele).next("span").text(msg)
            }

        }

//    点击保存员工信息
       $("#emp_save_btn").click(function () {

           if(!validate_add_form()){
               return false;
           }
            $.ajax({
               url:"${APP_PATH}/saveEmp",
               type:"POST",
               data:$("#emp_add_modal form").serialize(),
                success:function (result) {
//                    alert($("#emp_add_modal form").serialize());
//                    添加之后关闭模态框
//                    如果后台也校验成功则跳转
                    if (result.code== 100){
                        $("#emp_add_modal").modal('hide');
//                    来到最后一页
                        to_page(totalRecond);
                    }else {
                        if(undefined != result.extend.errorFields.email){
//                           显示邮箱错误信息
                            show_validate_msg("#email_add_input","error",result.extend.errorFields.email);
                        }else if(undefined != result.extend.errorFields.empName){
//                           显示name的错误信息
                            show_validate_msg("#empName_add_input","error",result.extend.errorFields.empName);
                        }

                    }


                }

           })

       })

//    绑定员工姓名输入框事件并进行校验
    $("#empName_add_input").change(function () {
        var userName = this.value;

        $.ajax({
            url:"${APP_PATH}/checkUser",
            type:"POST",
            data:"userName="+userName,
            success:function (result) {
                if(result.code==100){
                    show_validate_msg("#empName_add_input","success","用户名可用");
                }else{
                    show_validate_msg("#empName_add_input","error",result.extend.va_msg);
                }
            }

        })
    });

</script>
</body>
</html>
