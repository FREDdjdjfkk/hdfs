<%--
  Created by IntelliJ IDEA.
  User: 李鹏程
  Date: 2025-03-18
  Time: 11:54
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title>文档列表</title>
    <link href="css/style.css" rel="stylesheet" type="text/css"/>
    <script type="text/javascript" src="js/jquery.js"></script>
    <script language="javascript">
        $(function (){
            // 导航切换效果：点击后为当前项添加 selected 样式
            $(".imglist li").click(function (){
                $(".imglist li.selected").removeClass("selected");
                $(this).addClass("selected");
            });
        });
    </script>
</head>
<body>
<div class="place">
    <span>位置</span>
    <ul class="placeul">
        <li><a href="#">首页</a></li>
        <li><a href="#">文档列表</a></li>
    </ul>

</div>
<div class="rightinfo">
    <div class="tools">
        <ul class="toolbar">
            <li onclick="window.location.href='/upload'"><span><img src="images/t01.png"></span>添加</li>
            <li ><span><img src="images/t02.png"></span>修改</li>
            <li ><span><img src="images/t03.png"></span>删除</li>
            <li ><span><img src="images/t04.png"></span>统计</li>
        </ul>

        <ul class="toolbar1">
            <li><span><img src="images/t05.png"></span>设置</li>
        </ul>
    </div>

    <table class="imgtable">

        <thead>
        <tr>
            <th>编号</th>
            <th>文档标题</th>
            <th>类别</th>
            <th>文档地址</th>
            <th>操作</th>

        </tr>
        </thead>
        <tbody>
        <c:forEach items="${list}" var="docs" varStatus="status">
            <tr>
                <td>${status.index + 1}</td>
                <td>${docs.title}<p>ID: ${docs.id}</p></td>
                <td>${docs.type}</td>
                <td>${docs.url}</td>
                <td>
                    <a href="javascript:void(0);" onclick="openEditModal(${docs.id})" class="tablelink">修改</a>&nbsp;
                    <a href="down?filePath=${docs.url}" class="tablelink">下载</a>&nbsp;
                    <a href="delete?id=${docs.id}&filePath=${docs.url}" class="tablelink">删除</a>
                </td>
            </tr>
        </c:forEach>
        </tbody>
    </table>
    <div class="pagin">
        <div class="message">共<i class="blue">${pageInfo.getTotal()}</i>条记录，当前显示第&nbsp; <i class="blue" >${pageInfo.getPages()}&nbsp;</i>页</div>
        <ul class="paginList">
            <li class="paginItem"><a href="search?page=1">首页</a></li>
<%--            这里可以完善一下做一个判断等等--%>
            <li class="paginItem"><a href="search?page=${pageInfo.pageNum-1}"><<</a> </li>
            <c:forEach begin="1" end="${pageInfo.getPages()}" step="1" var="pageNo">
                <li class="paginItem"><a href="search?page=${pageInfo.pageNum}">${pageNo}</a> </li>
            </c:forEach>
            <li class="paginItem"><a href="search?page=${pageInfo.pageNum+1}">>></a> </li>
            <li class="paginItem"><a href="search?page=${pageInfo.pages}">末页</a> </li>

        </ul>
    </div>
</div>
<div id="editModal" style="display:none; position:fixed; top:20%; left:35%; background:#fff; border:1px solid #ccc; padding:20px; z-index:9999;">
    <h3>编辑文档</h3>
    <form id="editForm">
        <input type="hidden" name="id" id="editId">
        标题：<input type="text" name="title" id="editTitle"><br><br>
        类型：<input type="text" name="type" id="editType"><br><br>
        <button type="button" onclick="submitEdit()">保存</button>
        <button type="button" onclick="closeEditModal()">取消</button>
    </form>
</div>
<script>
    function openEditModal(docUniqueId) {
        const url = `editDocument?id=`+docUniqueId;
        fetch(url)
            .then(response => {
                if (!response.ok) throw new Error("请求失败：" + response.status);
                return response.json();
            })
            .then(data => {
                if (data) {
                    document.getElementById("editId").value = data.id;
                    document.getElementById("editTitle").value = data.title;
                    document.getElementById("editType").value = data.type;
                    document.getElementById("editModal").style.display = "block";
                } else {
                    alert("未找到文档！");
                }
            })
            .catch(err => {
                console.error("❌ fetch 失败：", err);
            });
    }


    function closeEditModal() {
        document.getElementById("editModal").style.display = "none";
    }

    function submitEdit() {
        const formData = new URLSearchParams(new FormData(document.getElementById("editForm")));

        fetch("updateDocument", {
            method: "POST",
            body: formData,
            headers: { 'Content-Type': 'application/x-www-form-urlencoded' }
        })
            .then(response => {
                if (response.ok) {
                    alert("修改成功！");
                    location.reload(); // 或者用 JS 更新表格内容
                } else {
                    alert("修改失败！");
                }
            });
    }
</script>

</body>
</html>