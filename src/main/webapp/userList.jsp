<%--
  Created by IntelliJ IDEA.
  User: 李鹏程
  Date: 2025-03-31
  Time: 19:17
  To change this template use File | Settings | File Templates.
--%>
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ page import="com.lpc.pojo.User" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <title>用户管理</title>
    <meta charset="UTF-8"/>
    <link rel="stylesheet" href="css/style.css">
</head>
<body>

<h2>用户列表</h2>
<!-- 用户列表表格 -->
<table class="imgtable">
    <tr>
        <th>ID</th>
        <th>Account</th>
        <th>Password(MD5后)</th>
        <th>Name</th>
        <th>操作</th>
    </tr>
    <c:forEach var="u" items="${userList}">
        <tr>
            <td>${u.id}</td>
            <td>${u.account}</td>
            <td>${u.pwd}</td>
            <td>${u.name}</td>
            <td>
                <!-- 删除按钮 -->
                <a href="${pageContext.request.contextPath}/deleteUser?id=${u.id}"
                   onclick="return confirm('确定要删除该用户吗？');">删除</a>
                &nbsp;|&nbsp;
                <!-- 编辑按钮，跳转到 Controller 的 toEdit 方法 -->
<%--                <a href="${pageContext.request.contextPath}/toEdit?id=${u.id}">编辑</a>--%>
                <a href="#" onclick="openEditModal(${u.id})">编辑</a>
            </td>
        </tr>
    </c:forEach>
</table>
<br/>

<!-- 添加用户按钮 -->
<button onclick="openAddModal()">添加新用户</button>

<!-- 添加用户弹窗 -->
<div id="addModal" style="display:none; position:fixed; left:50%; top:50%; transform:translate(-50%, -50%);
           background:white; padding:20px; border:1px solid #ccc; z-index:9999; box-shadow:0 0 10px #888;">
    <h3>添加用户</h3>
    <form id="addForm">
        <ul>
            <li>
                <label>账号:
                    <input type="text" name="account" id="addAccount" required/>
                </label>
            </li>
            <li>
                <label>密码:
                    <input type="password" name="pwd" id="addPwd" required/>
                </label>
            </li>
            <li>
                <label>昵称:
                    <input type="text" name="name" id="addName"/>
                </label>
            </li>
            <li>
                <button type="button" onclick="submitAddForm()">确认添加</button>
                <button type="button" onclick="closeAddModal()">取消</button>
            </li>

        </ul>
    </form>
</div>

<hr/>
<!-- 编辑弹窗 -->
<div id="editModal" style="display:none; position:fixed; left:50%; top:50%; transform:translate(-50%, -50%);
           background:white; padding:20px; border:1px solid #ccc; z-index:9999; box-shadow:0 0 10px #888;">
    <h3>编辑用户</h3>
    <form id="editForm">
    <ul>
        <li> <input type="hidden" name="id" id="editId" />
            <label>账号:
                <input type="text" name="account" id="editAccount" required/>
            </label>
        </li>
        <li>
            <label>密码:
                <input type="password" name="pwd" id="editPwd" placeholder="如需修改密码可填写"/>
            </label>
        </li>
        <li>
            <label>昵称:
                <input type="text" name="name" id="editName"/>
            </label>
        </li>
        <li>
            <button type="button" onclick="submitEditForm()">确认修改</button>
            <button type="button" onclick="closeEditModal()">取消</button>
        </li>
    </ul>
    </form>

</div>
<script>
    // 打开弹窗并加载用户数据
    function openEditModal(id) {
        fetch('${pageContext.request.contextPath}/getUserById?id=' + id)
            .then(resp => resp.json())
            .then(user => {
                document.getElementById('editId').value = user.id;
                document.getElementById('editAccount').value = user.account;
                document.getElementById('editPwd').value = '';
                document.getElementById('editName').value = user.name;
                document.getElementById('editModal').style.display = 'block';
            });
    }

    // 关闭弹窗
    function closeEditModal() {
        document.getElementById('editModal').style.display = 'none';
    }

    // 提交修改（Ajax）
    function submitEditForm() {
        const data = {
            id: document.getElementById('editId').value,
            account: document.getElementById('editAccount').value,
            pwd: document.getElementById('editPwd').value,
            name: document.getElementById('editName').value
        };

        fetch('${pageContext.request.contextPath}/ajaxUpdateUser', {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json'
            },
            body: JSON.stringify(data)
        })
            .then(resp => resp.text())
            .then(msg => {
                alert("修改成功");
                closeEditModal();
                // location.reload(); // 刷新页面
                window.location.href = '${pageContext.request.contextPath}/list';
            })
            .catch(err => {
                alert("修改失败：" + err);
            });
    }
    // 打开添加用户弹窗
    function openAddModal() {
        document.getElementById('addAccount').value = '';
        document.getElementById('addPwd').value = '';
        document.getElementById('addName').value = '';
        document.getElementById('addModal').style.display = 'block';
    }

    // 关闭添加弹窗
    function closeAddModal() {
        document.getElementById('addModal').style.display = 'none';
    }

    // 提交添加用户请求
    function submitAddForm() {
        const data = {
            account: document.getElementById('addAccount').value,
            pwd: document.getElementById('addPwd').value,
            name: document.getElementById('addName').value
        };

        fetch('${pageContext.request.contextPath}/add', {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json'
            },
            body: JSON.stringify(data)
        })
            .then(resp => resp.text())
            .then(msg => {
                alert("添加成功");
                closeAddModal();
                location.reload();
            })
            .catch(err => {
                alert("添加失败：" + err);
            });
    }
</script>

</body>
</html>
