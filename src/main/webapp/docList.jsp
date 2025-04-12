<%--
  Created by IntelliJ IDEA.
  User: 李鹏程
  Date: 2025-03-18
  Time: 11:54
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%
    String path = request.getParameter("parentPath");
    if (path == null || path.trim().equals("")) {
        path = "/";
    }
    String upPath = "/";
    if (!path.equals("/") && path.lastIndexOf("/") > 0) {
        upPath = path.substring(0, path.lastIndexOf("/"));
        if (!upPath.endsWith("/")) {
            upPath += "/";
        }
    }
%>
<%--Tomcat + JSP 编译器不支持嵌套 JSTL 函数调用--%>
<%--<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>--%>
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
        <div style="margin:10px 0;">
            <strong>当前位置：</strong> ${currentPath}
            <c:if test="${not empty currentPath && currentPath != '/'}">
                <a href="search?parentPath=${upPath}">⬅ 返回上一级</a>
            </c:if>
        </div>
        <ul class="toolbar">
            <li onclick="openUploadModal('${currentPath}')"><span><img src="images/t01.png"></span>添加</li>
            <li ><span><img src="images/t04.png"></span>统计</li>
            <li onclick="document.getElementById('folderModal').style.display='block'">
                <span><img src="images/t01.png"></span>新建文件夹
            </li>
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
                    <c:choose>
                        <c:when test="${docs.folder}">
                            <a href="search?parentPath=${docs.url}/" class="tablelink">进入</a>&nbsp;
                            <a href="javascript:void(0);" onclick="openRenameModal(${docs.id}, '${docs.title}')" class="tablelink">修改名称</a>&nbsp;
                            <a href="delete?id=${docs.id}&filePath=${docs.url}" class="tablelink">删除</a>
                        </c:when>
                        <c:otherwise>
                            <a href="down?filePath=${docs.url}" class="tablelink">下载</a>&nbsp;
                            <a href="javascript:void(0);" onclick="openEditModal(${docs.id})" class="tablelink">修改</a>&nbsp;
                            <a href="delete?id=${docs.id}&filePath=${docs.url}" class="tablelink">删除</a>
                        </c:otherwise>
                    </c:choose>
                </td>
            </tr>
        </c:forEach>
        </tbody>
    </table>
    <div class="pagin">
        <div class="message">共<i class="blue">${pageInfo.getTotal()}</i>条记录，当前显示第&nbsp; <i class="blue" >${pageInfo.getPages()}&nbsp;</i>页</div>
        <ul class="paginList">
            <li class="paginItem"><a href="search?page=1&parentPath=${currentPath}">首页</a></li>
<%--            这里可以完善一下做一个判断等等--%>
            <li class="paginItem"><a href="search?page=${pageInfo.pageNum-1}&parentPath=${currentPath}"><<</a> </li>
            <c:forEach begin="1" end="${pageInfo.getPages()}" step="1" var="pageNo">
                <li class="paginItem"><a href="search?page=${pageInfo.pageNum}&parentPath=${currentPath}">${pageNo}</a> </li>
            </c:forEach>
            <li class="paginItem"><a href="search?page=${pageInfo.pageNum+1}&parentPath=${currentPath}">>></a> </li>
            <li class="paginItem"><a href="search?page=${pageInfo.pages}&parentPath=${currentPath}">末页</a> </li>

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
//新建文件夹
<div id="folderModal" style="display:none; position:fixed; top:20%; left:35%; background:#fff; border:1px solid #ccc; padding:20px; z-index:9999;">
    <h3>新建文件夹</h3>
    <form action="createFolder" method="post">
        文件夹名称：<input type="text" name="folderName" required /><br><br>
        <input type="hidden" name="parentPath" value="${currentPath}" />
        <button type="submit">创建</button>
        <button type="button" onclick="document.getElementById('folderModal').style.display='none'">取消</button>
    </form>
</div>
//重命名文件夹
<div id="renameModal" style="display:none; position:fixed; top:25%; left:35%; background:#fff; border:1px solid #ccc; padding:20px; z-index:9999;">
    <h3>重命名文件夹</h3>
    <form id="renameForm">
        <input type="hidden" name="id" id="renameId">
        新名称：<input type="text" name="newTitle" id="renameTitle"><br><br>
        <button type="button" onclick="submitRename()">保存</button>
        <button type="button" onclick="closeRenameModal()">取消</button>
    </form>
</div>
<script>
    function openRenameModal(id, title) {
        document.getElementById("renameId").value = id;
        document.getElementById("renameTitle").value = title;
        document.getElementById("renameModal").style.display = "block";
    }

    function closeRenameModal() {
        document.getElementById("renameModal").style.display = "none";
    }

    function submitRename() {
        const formData = new URLSearchParams(new FormData(document.getElementById("renameForm")));

        fetch("renameFolder", {
            method: "POST",
            body: formData,
            headers: { 'Content-Type': 'application/x-www-form-urlencoded' }
        })
            .then(response => {
                if (response.ok) {
                    alert("修改成功！");
                    location.reload();
                } else {
                    alert("修改失败！");
                }
            });
    }
</script>
//添加弹窗
<div id="uploadModal" class="tip" style="display:none;">
    <div class="tiptop">
        <span>上传文件</span>
        <a onclick="closeUploadModal()"></a>
    </div>
    <div class="tipinfo">
        <form id="uploadForm" method="post" enctype="multipart/form-data" action="upload">
            <input type="hidden" name="parentPath" id="modalParentPath">
            <ul class="forminfo">
                <li>
                    <label>标题：</label>
                    <input type="text" name="title" class="dfinput" required>
                </li>
                <li>
                    <label>类型：</label>
                    <input type="text" name="type" class="dfinput" required>
                </li>
                <li>
                    <label>文件：</label>
                    <input type="file" name="myfile" required>
                </li>
                <li>
                    <input type="submit" value="上传" class="btn">
                    <input type="button" value="取消" class="btn" onclick="closeUploadModal()">
                </li>
            </ul>
        </form>
    </div>
</div>
<script>
    function openUploadModal(currentPath) {
        document.getElementById("uploadModal").style.display = "block";
        document.getElementById("modalParentPath").value = currentPath;
    }

    function closeUploadModal() {
        document.getElementById("uploadModal").style.display = "none";
    }
</script>
</body>
</html>