<%--
  Created by IntelliJ IDEA.
  User: 李鹏程
  Date: 2025-03-17
  Time: 14:59
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title>用户注册</title>
    <link href="css/style.css" rel="stylesheet" type="text/css" />
    <script type="text/javascript" src="js/jquery.js"></script>
    <script type="text/javascript" src="js/validate.js"></script>
</head>

<body>


<div class="formbody">

    <div class="formtitle"><span>用户注册</span></div>

    <form id="frm" action="reg" method="post" validate="true" onsubmit="return check('frm')">
        <ul class="forminfo">
            <li><label>用 户 名:</label><input name="account" id="account" type="text" class="dfinput" onblur="checkAccount()" dataType="Require" msg="请输入用户名"  placeholder="请输入4位以上的账号"/><i id="msg" style="color: #ea2020"></i></li>
            <li><label>用户密码:</label><input name="pwd" id="pwd" type="password" class="dfinput" dataType="Require" msg="请输入密码" placeholder="请输入密码"/></li>
            <li><label>确认密码:</label><input name="repwd" type="password" class="dfinput" dataType="Require" msg="请输入确认密码" placeholder="请输入确认密码"/></li>
            <li><label>真实姓名:</label><input name="name" type="text" class="dfinput" dataType="Require" msg="请输入用户姓名" placeholder="请输入真实姓名"/></li>
            <li><label>&nbsp;</label><input name="" type="submit" class="btn" value="提交信息"/></li>
        </ul>
    </form>

</div>
</body>
</html>

<script type="text/javascript">
    function checkAccount(){
        var account=$("#account").val();   //获取账号输入框的值
        $.get("checkAccount?account="+account,function (data){
            if(data=="no"){
                $("#msg").text("该账号已经被占用！");
                $("#account").focus();
            }else{
                $("#msg").text("");
                $("#pwd").focus();
            }
        });
    }
</script>