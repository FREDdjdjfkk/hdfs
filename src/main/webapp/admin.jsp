<%--
  Created by IntelliJ IDEA.
  User: 李鹏程
  Date: 2025-03-31
  Time: 18:46
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta charset="UTF-8">
    <title>管理员后台管理系统</title>
    <!-- 引入公共样式 -->
    <link rel="stylesheet" type="text/css" href="css/style.css">
    <style> /* 针对管理员页面的自定义样式 */
    .admin-header { background-color: #3d96c9;
                    color: #fff;
                    padding: 15px;
                    text-align: center; }
    .admin-nav { background-color: #f5f5f5; padding: 10px; }
    .admin-nav ul { list-style: none; margin: 0; padding: 0; }
    .admin-nav ul li { display: inline-block; margin-right: 20px; }
    .admin-nav ul li a { text-decoration: none; color: #333; font-weight: bold; }
    .admin-content { padding: 20px; } .admin-footer { background-color: #ddd; text-align: center; padding: 10px; margin-top: 20px; }
    </style>
</head>
<body>
<!-- 页面头部 -->
<div class="admin-header">
    <h1>管理员后台管理系统</h1>
</div>
<!-- 导航菜单 -->
<div class="admin-nav">
    <ul>
        <li><a href="${pageContext.request.contextPath}/list">用户管理</a></li>
        <li><a href="show">文档管理</a></li>
        <li><a href="downlogList.jsp">下载日志</a></li>
        <li><a href="logout">退出登录</a></li>
    </ul>
</div>

<!-- 主要内容区 -->
<div class="admin-content">
    <h2>欢迎, 管理员</h2>
    <p>请从上面的菜单选择需要管理的功能：</p>
    <!-- 这里可以添加统计图表或其它动态内容，例如使用 Chart.js 绘制下载统计图 -->
    <div id="admin-dashboard">
        <!-- 示例：可通过 AJAX 请求后端接口获取统计数据 -->
    </div>
</div>


</div>

<!-- 如果需要图表等动态功能，可以在此引入 JS 库，并编写相应脚本 -->
<!-- 示例：使用 fetch 调用后端 chart 接口绘制下载统计图 -->
<!--
<script src="js/Chart.min.js"></script>
<script>
  fetch('chart')
    .then(response => response.json())
    .then(data => {
        var ctx = document.getElementById('downloadChart').getContext('2d');
        new Chart(ctx, {
            type: 'bar',
            data: {
                labels: data.bts,
                datasets: [{
                    label: '下载次数',
                    data: data.nums,
                    backgroundColor: 'rgba(75, 192, 192, 0.2)',
                    borderColor: 'rgba(75, 192, 192, 1)',
                    borderWidth: 1
                }]
            },
            options: {
                scales: {
                    y: { beginAtZero: true }
                }
            }
        });
    });
</script>
-->
</body>
</html>