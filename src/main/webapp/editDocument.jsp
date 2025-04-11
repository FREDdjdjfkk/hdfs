<%--
  Created by IntelliJ IDEA.
  User: 李鹏程
  Date: 2025-03-27
  Time: 15:15
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<html>
<head>
  <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
  <title>编辑文档</title>
  <link href="css/style.css" rel="stylesheet" type="text/css"/>
</head>
<body>
<div class="formbody">
  <div class="formtitle"><span>编辑文档</span></div>

  <!-- 错误信息 -->
  <c:if test="${not empty error}">
    <div class="error">${error}</div>
  </c:if>

  <!-- 文档编辑表单 -->
<%--  调用了属性--%>
  <form action="updateDocument" method="post" name="editForm" onsubmit="return validateForm()">
    <input type="hidden" name="id" value="${doc.id}"/>
    <ul class="forminfo">
      <li>
        <label>文档标题</label>
        <input name="title" type="text" class="dfinput" value="${doc.title}"/>
      </li>
      <li>
        <label>文档类别</label>
        <select name="type" class="dfinput">
          <option value="text" ${doc.type == 'text' ? 'selected' : ''}>文本</option>
          <option value="image" ${doc.type == 'image' ? 'selected' : ''}>图片</option>
          <option value="video" ${doc.type == 'video' ? 'selected' : ''}>视频</option>
          <option value="presentation" ${doc.type == 'presentation' ? 'selected' : ''}>幻灯片</option>
        </select>
      </li>
      <li>
        <label>文档地址</label>
        <input name="url" type="text" class="dfinput" value="${doc.url}"/>
      </li>
      <li>
        <label></label>
        <input name="submit" type="submit" class="btn" value="提交修改"/>
      </li>
    </ul>
  </form>
</div>
</body>
</html>

