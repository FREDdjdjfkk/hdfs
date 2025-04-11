<%--
  Created by IntelliJ IDEA.
  User: 李鹏程
  Date: 2025-03-18
  Time: 10:30
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title>文档列表</title>
    <link href="css/style.css" rel="stylesheet" type="text/css" />
    <script type="text/javascript" src="js/jquery.js"></script>

    <script type="text/javascript">
        $(document).ready(function(){
            $(".click").click(function(){
                $(".tip").fadeIn(200);
            });

            $(".tiptop a").click(function(){
                $(".tip").fadeOut(200);
            });

            $(".sure").click(function(){
                $(".tip").fadeOut(100);
            });

            $(".cancel").click(function(){
                $(".tip").fadeOut(100);
            });

        });
    </script>


</head>


<body>

<div class="place">
    <span>位置：</span>
    <ul class="placeul">
        <li><a href="#">首页</a></li>
        <li><a href="#">我的文档</a></li>
    </ul>
</div>

<div class="rightinfo">

    <div class="tools">

        <ul class="toolbar">
            <li class="click"><span><img src="images/t01.png" /></span>添加</li>
            <li class="click"><span><img src="images/t02.png" /></span>修改</li>
            <li><span><img src="images/t03.png" /></span>删除</li>
            <li><span><img src="images/t04.png" /></span>统计</li>
        </ul>


        <ul class="toolbar1">
            <li><span><img src="images/t05.png" /></span>设置</li>
        </ul>

    </div>


    <table class="tablelist">
        <thead>
        <tr>
            <th><input name="" type="checkbox" value="" checked="checked"/></th>
            <th>编号<i class="sort"><img src="images/px.gif" /></i></th>
            <th>文档标题</th>
            <th>类别</th>
            <th>文档地址</th>
            <th>操作</th>
        </tr>
        </thead>
        <tbody>
        <c:forEach items="${list}" var="docs" varStatus="status">
            <tr>
                <td><input name="" type="checkbox" value="" /></td>
                <td>${status.index + 1}</td>
                <td>${docs.getTitle()}</td>
                <td>${docs.getType()}</td>
                <td>${docs.getUrl()}</td>
                <td><a href="down?filePath=${docs.getUrl()}" class="tablelink">下载</a>     <a href="del?id=${docs.getId()}&filePath=${docs.getUrl()}" class="tablelink"> 删除</a></td>
            </tr>
        </c:forEach>

        </tbody>
    </table>


    <div class="pagin">
        <div class="message">共<i class="blue">${pageInfo.getTotal()}</i>条记录，当前显示第&nbsp;<i class="blue">${pageInfo.getPages()}&nbsp;</i>页</div>
        <ul class="paginList">
            <li class="paginItem"> <a href = "search?page=1">首页</a> </li>
            <li class="paginItem"><a href="search?page=${pageInfo.pageNum-1 }">«</a></li>
            <c:forEach begin="1" end="${pageInfo.getPages()}" step="1" var="pageNo">
                <li class="paginItem"><a href="search?page=${pageNo}">${pageNo}</a></li>
            </c:forEach>
            <li class="paginItem"><a href="search?page=${pageInfo.pageNum+1}">»</a></li>
            <li class="paginItem"> <a href ="search?page=${page.pages }">尾页</a> </li>

        </ul>
    </div>


    <div class="tip">
        <div class="tiptop"><span>提示信息</span><a></a></div>

        <div class="tipinfo">
            <span><img src="images/ticon.png" /></span>
            <div class="tipright">
                <p>是否确认对信息的修改 ？</p>
                <cite>如果是请点击确定按钮 ，否则请点取消。</cite>
            </div>
        </div>

        <div class="tipbtn">
            <input name="" type="button"  class="sure" value="确定" />&nbsp;
            <input name="" type="button"  class="cancel" value="取消" />
        </div>

    </div>




</div>

<script type="text/javascript">
    $('.tablelist tbody tr:odd').addClass('odd');
</script>
</body>
</html>

