<%--
  Created by IntelliJ IDEA.
  User: 李鹏程
  Date: 2025-03-18
  Time: 10:38
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title>文档上传</title>
    <link href="css/style.css" rel="stylesheet" type="text/css" />
</head>

<body>

<div class="place">
    <span>位置：</span>
    <ul class="placeul">
        <li><a href="#">首页</a></li>
        <li><a href="#">表单</a></li>
    </ul>
</div>

<div class="formbody">

    <div class="formtitle"><span>文档上传</span></div>
    <form action="upload" method="post" enctype="multipart/form-data">

        <ul class="forminfo">
            <li><label>文档名称</label><input name="title" type="text" class="dfinput" /><i>名称不能超过30个字符</i></li>

            <li>
                <label>文档类型</label>
                <select name="type" class="dfinput">
                    <option value="text">文本</option>
                    <option value="image">图片</option>
                    <option value="video">视频</option>
                    <option value="presentation">幻灯片</option>
                    <option value="pdf">PDF</option>
                    <option value="audio">音频</option>
                    <option value="archive">压缩包</option>
                    <option value="other">其他</option>
                </select>
            </li>

            <li><label>选择文件</label><input name="myfile" type="file" class="dfinput"/></li>
            <li><label></label><input name="tijiao" type="submit" class="btn" value="上传"/></li>
        </ul>
    </form>

</div>
</body>
</html>

