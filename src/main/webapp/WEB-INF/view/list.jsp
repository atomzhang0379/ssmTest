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
                <div class="col-md-4 col-md-offset-8">
                    <button  type="button" class="btn btn-primary">新增</button>
                    <button type="button" class="btn btn-danger">删除</button>
                </div>
            </div>
            <%--表格--%>
                <div class="row">
                    <div class="col-md-12">
                        <table class="table table-hover">
                            <tr>
                                <th>#</th>
                                <th>empName</th>
                                <th>email</th>
                                <th>gender</th>
                                <th>deptName</th>
                            </tr>
                            <c:forEach items="${pageInfo.list}" var="emp">
                            <tr>
                                <th>${emp.empId}}</th>
                                <th>${emp.empName}</th>
                                <th>${emp.email}</th>
                                <th>${emp.gender}</th>
                                <th>${emp.department.depName}</th>
                                <th>操作</th>
                                <th>
                                    </c:forEach>
                                    <button class="btn btn-primary  btn-sm">
                                        <span class="glyphicon glyphicon-pencil" aria-hidden="true"></span>
                                        编辑
                                    </button>
                                    <button class="btn btn-danger  btn-sm">
                                        <span class="glyphicon glyphicon-trash" aria-hidden="true"></span>
                                        删除
                                    </button>
                                </th>
                            </tr>
                        </table>
                    </div>
                </div>
            <%--分页信息--%>
                <div class="row">
                    <%--分页文字信息--%>
                    <div class="col-md-6">
                        当前第:${pageInfo.pageNum}页,总共${pageInfo.pages}页,当前记录数：${pageInfo.total}
                    </div>
                    <%--分页条信息--%>
                    <div class="col-md-6">
                        <nav aria-label="Page navigation">

                            <ul class="pagination">
                                <li><a href="${APP_PATH}/emps?pn=1">首页</a></li>
                                <c:if test="${pageInfo.hasPreviousPage}">
                                    <li>
                                        <a href="${APP_PATH}/emps?pn=${pageInfo.pageNum-1}" aria-label="Previous">
                                            <span aria-hidden="true">&laquo;</span>
                                        </a>
                                    </li>
                                </c:if>
                                <c:forEach items="${pageInfo.navigatepageNums}" var="page_Num">
                                    <c:if test="${page_Num == pageInfo.pageNum}">
                                        <li class="active"><a href="${APP_PATH}/emps?pn=${page_Num}">${page_Num}</a></li>
                                    </c:if>
                                    <c:if test="${page_Num != pageInfo.pageNum}">
                                        <li><a href="${APP_PATH}/emps?pn=${page_Num}">${page_Num}</a></li>
                                    </c:if>
                                </c:forEach>
                                <c:if test="${pageInfo.hasNextPage}">
                                <li>
                                    <a href="${APP_PATH}/emps?pn=${pageInfo.pageNum+1}" aria-label="Next">
                                        <span aria-hidden="true">&raquo;</span>
                                    </a>
                                </li>
                                </c:if>
                                <li><a href="${APP_PATH}/emps?pn=${pageInfo.pages}">末页</a></li>
                            </ul>
                        </nav>

                    </div>
                </div>
        </div>
</body>
</html>
