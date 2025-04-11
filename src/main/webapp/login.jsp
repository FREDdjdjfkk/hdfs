<%--
  Created by IntelliJ IDEA.
  User: 李鹏程
  Date: 2025-03-17
  Time: 11:22
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
    <title>用户登录</title>
    <link href="css/style.css" rel="stylesheet" type="text/css" />
    <script language="JavaScript" src="js/jquery.js"></script>
    <script src="js/cloud.js" type="text/javascript"></script>

    <script language="javascript">
        $(function(){
            $('.loginbox').css({'position':'absolute','left':($(window).width()-692)/2});
            $(window).resize(function(){
                $('.loginbox').css({'position':'absolute','left':($(window).width()-692)/2});
            })
        });
    </script>

</head>

<body style="background-color:#1c77ac; background-image:url(images/light.png); background-repeat:no-repeat; background-position:center top; overflow:hidden;">



<div id="mainBody">
    <div id="cloud1" class="cloud"></div>
    <div id="cloud2" class="cloud"></div>
</div>




<div class="loginbody">

    <span class="system">基于HDFS的网盘系统</span>
    <div class="loginbox">
        <img src="images/logo.jpg" class="left-img" alt="左侧图片"/>
        <form action="login" method="post">

            <ul>
                <li><input name="account" type="text" class="loginuser" placeholder="请输入账号"/></li>
                <li><input name="pwd" type="password" class="loginpwd" placeholder="请输入密码"/></li>
                <li><input name="" type="submit" class="loginbtn" value="登 录"   /><label><input name="" type="checkbox" value="" checked="checked" />记住密码</label><label><a href="reg.jsp">我要注册</a></label></li>
            </ul>

        </form>
    </div>

</div>




</body>
</html>
