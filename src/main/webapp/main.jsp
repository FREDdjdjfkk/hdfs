<%--
  Created by IntelliJ IDEA.
  User: 李鹏程
  Date: 2025-03-18
  Time: 9:42
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Frameset//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-frameset.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title>网络云盘系统</title>
    <style>
        /* 设置整体布局 */
        body {
            display: flex;
            flex-direction: column;
            height: 100vh; /* 让页面充满整个浏览器 */
            margin: 0;
        }

        /* 顶部区域 */
        header {
            height: 88px;
            background: #f1f1f1; /* 你可以根据需要调整 */
            border-bottom: 1px solid #ccc;
        }

        /* 主体内容区域 */
        main {
            display: flex;
            flex: 1; /* 让主体区域充满剩余空间 */
        }

        /* 左侧导航栏 */
        nav {
            width: 187px;
            background: #f1f1f1; /* 你可以根据需要调整 */
            border-right: 1px solid #ccc;
        }

        /* 右侧内容区域 */
        section {
            flex: 1; /* 让右侧区域占用剩余空间 */
            background: #fff;
        }

        /* iframe 样式设置 */
        iframe {
            width: 100%;
            height: 100%;
            border: none;
        }
    </style>
</head>
<body>

<!-- 顶部区域 -->
<header>
    <iframe src="top.jsp" title="Top" name="topFrame"></iframe>
</header>

<!-- 主体内容区域 -->
<main>
    <!-- 左侧导航栏 -->
    <nav>
        <iframe src="left.jsp" title="Left" name="leftFrame"></iframe>
    </nav>

    <!-- 右侧内容区域 -->
    <section>
        <iframe src="dataview.jsp" title="Right" name="rightFrame"></iframe>
    </section>
</main>

</body>
</html>

