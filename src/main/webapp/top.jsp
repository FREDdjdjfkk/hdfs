<%--
  Created by IntelliJ IDEA.
  User: 李鹏程
  Date: 2025-03-18
  Time: 10:28
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title>无标题文档</title>
    <link href="css/style.css" rel="stylesheet" type="text/css" />
    <script language="JavaScript" src="js/jquery.js"></script>
    <script type="text/javascript">
        $(function(){
            //顶部导航切换
            $(".nav li a").click(function(){
                $(".nav li a.selected").removeClass("selected")
                $(this).addClass("selected");
            })
        })
    </script>


</head>

<body style="background-color: #4D8BDB ">

<div class="header">
    <div class="topleft">
        <a href="main.jsp" target="_parent">
            <img src="images/logo.jpg" title="系统首页" width="50" height="50"/>
            基于HDFS的网盘系统设计与实现
        </a>
    </div>

    <div class="topright">
        <ul>
            <li><a href="logout" target="_parent">退出</a></li>
        </ul>
        <div class="user">
            <span>${name}</span>
        </div>
    </div>
</div>
</body>
</html>

