<%--
  Created by IntelliJ IDEA.
  User: 李鹏程
  Date: 2025-03-18
  Time: 10:29
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title>菜单</title>
    <link href="css/style.css" rel="stylesheet" type="text/css" />
    <script language="JavaScript" src="js/jquery.js"></script>

    <script type="text/javascript">
        $(function(){
            //导航切换
            $(".menuson li").click(function(){
                $(".menuson li.active").removeClass("active")
                $(this).addClass("active");
            });

            $('.title').click(function(){
                var $ul = $(this).next('ul');
                $('dd').find('ul').slideUp();
                if($ul.is(':visible')){
                    $(this).next('ul').slideUp();
                }else{
                    $(this).next('ul').slideDown();
                }
            });
        })
    </script>


</head>

<body style="background:#f0f9fd;">
<div class="lefttop"><span></span>网络云盘</div>

<dl class="leftmenu">

    <dd>
        <div class="title">
            <span><img src="images/leftico01.png" /></span>文档管理
        </div>
        <ul class="menuson">
            <li><cite></cite><a href="search" target="rightFrame">我的文档</a><i></i></li>
            <li><cite></cite><a href="toUpload" target="rightFrame">文档上传</a><i></i></li>
            <li><cite></cite><a href="dataview.jsp" target="rightFrame">下载分析</a><i></i></li>

        </ul>
    </dd>


    <dd>
        <div class="title">
            <span><img src="images/leftico02.png" /></span>个人中心
        </div>
        <ul class="menuson">
            <li><cite></cite><a href="editPwd.jsp" target="rightFrame">密码修改</a><i></i></li>

        </ul>
    </dd>
</dl>
</body>
</html>

