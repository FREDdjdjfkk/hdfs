<%--
  Created by IntelliJ IDEA.
  User: 李鹏程
  Date: 2025-03-31
  Time: 19:20
  To change this template use File | Settings | File Templates.
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>文档管理</title>
    <link rel="stylesheet" type="text/css" href="css/style.css">
    <script type="text/javascript" src="js/jquery.js"></script>
    <style>
        table { border-collapse: collapse; width: 100%; margin-top: 20px; }
        th, td { border: 1px solid #ccc; padding: 10px; text-align: center; }
        th { background-color: #f5f5f5; }
        .pagination { margin-top: 20px; text-align: center; }
        .pagination a { margin: 0 5px; text-decoration: none; color: #3d96c9; }
    </style>
</head>
<body>
<h1>文档管理</h1>
<table>
    <tr>
        <th>序号</th><th>ID</th> <th>标题</th> <th>类型</th><th>地址</th> <th>作者</th> <th>创建日期</th> <th>操作</th>
    </tr>
    <!-- 后台传入的 list 属性为文档集合 -->
    <c:forEach items="${list}" var="docs" varStatus="status">
        <tr>
            <td>${status.index+1}</td>
            <td>ID:${docs.getId()}</td>
            <td>${docs.getTitle()}</td>
            <td>${docs.getType()}</td>
            <td>${docs.getUrl()}</td>
            <td>${docs.getAuthor()}</td>
            <td>${docs.getCreatedate()}</td>


            <td><a href="javascript:void(0);" onclick="openEditModal(${docs.id})" class="tablelink">修改</a>&nbsp;<a href="down?filePath=${docs.getUrl()}" class="tablelink">下载 </a>&nbsp;<a href="deleteA?id=${docs.getId()}&filePath=${docs.getUrl()}" class="tablelink">删除</a></td>
        </tr>
    </c:forEach>
    </tbody>
</table>
<div class="pagin">
    <div class="message">共<i class="blue">${pageInfo.getTotal()}</i>条记录，当前显示第&nbsp; <i class="blue" >${pageInfo.getPages()}&nbsp;</i>页</div>
    <ul class="paginList">
        <li class="paginItem"><a href="show?page=1">首页</a></li>
        <%--            这里可以完善一下做一个判断等等--%>
        <li class="paginItem"><a href="show?page=${pageInfo.pageNum-1}"><<</a> </li>
        <c:forEach begin="1" end="${pageInfo.getPages()}" step="1" var="pageNo">
            <li class="paginItem"><a href="show?page=${pageInfo.pageNum}">${pageNo}</a> </li>
        </c:forEach>
        <li class="paginItem"><a href="show?page=${pageInfo.pageNum+1}">>></a> </li>
        <li class="paginItem"><a href="show?page=${pageInfo.pages}">末页</a> </li>

    </ul>
</div>
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
