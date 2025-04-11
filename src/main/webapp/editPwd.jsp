<%--
  Created by IntelliJ IDEA.
  User: 李鹏程
  Date: 2025-03-27
  Time: 17:53
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title>修改密码</title>
    <link href="css/style.css" rel="stylesheet" type="text/css" />
    <script type="text/javascript" src="js/jquery.js"></script>
    <script type="text/javascript" src="js/validate.js"></script>
</head>

<body>

<div class="formbody">

    <div class="formtitle"><span>修改密码</span></div>

    <form id="frm" action="updatePassword" method="post" validate="true" onsubmit="return check('frm')">
        <ul class="forminfo">
            <!-- 当前密码 -->
            <li><label>当前密码:</label><input name="currentPassword" id="currentPassword" type="password" class="dfinput" dataType="Require" msg="请输入当前密码" placeholder="请输入当前密码" /></li>

            <!-- 新密码 -->
            <li><label>新密码:</label><input name="newPassword" id="newPassword" type="password" class="dfinput" dataType="Require" msg="请输入新密码" placeholder="请输入新密码" /></li>

            <!-- 确认新密码 -->
            <li><label>确认新密码:</label><input name="confirmPassword" id="confirmPassword" type="password" class="dfinput" dataType="Require" msg="请确认新密码" placeholder="请确认新密码" /></li>

            <!-- 提交按钮 -->
            <li><label>&nbsp;</label><input name="" type="submit" class="btn" value="提交修改" /></li>
        </ul>
    </form>

</div>

</body>
</html>

<script type="text/javascript">
    function checkPassword() {
        var newPassword = $("#newPassword").val();
        var confirmPassword = $("#confirmPassword").val();

        // 确保新密码和确认密码一致
        if (newPassword !== confirmPassword) {
            $("#msg").text("新密码和确认密码不一致！");
            $("#confirmPassword").focus();
            return false;
        }
        return true;
    }
</script>
