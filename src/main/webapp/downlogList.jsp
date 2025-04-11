<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>下载日志</title>
    <script src="https://cdn.jsdelivr.net/npm/jquery@3.6.0/dist/jquery.min.js"></script>
    <style>
        table {
            border-collapse: collapse;
            width: 80%;
            margin: 20px auto;
        }

        th, td {
            border: 1px solid #ccc;
            padding: 8px 12px;
            text-align: center;
        }

        th {
            background-color: #f2f2f2;
        }

        caption {
            font-size: 20px;
            margin-bottom: 10px;
        }
    </style>
</head>
<body>
<table>
    <caption>下载日志列表</caption>
    <thead>
    <tr>
        <th>文档标题</th>
        <th>下载用户</th>
        <th>下载时间</th>
    </tr>
    </thead>
    <tbody id="logTable">
    <!-- 数据将由 JS 填充 -->
    </tbody>
</table>

<script>
    $(function () {
        console.log("页面加载，准备请求 downlogAll 接口");

        $.get("downlogAll", function (data) {
            console.log("成功收到数据：", data); //  打印返回结果

            let html = "";
            data.forEach(function (log) {
                const title = log.title || "（无标题）";
                const author = log.author || "（无作者）";
                const formattedDate = log.downdate ? new Date(Number(log.downdate)).toLocaleString() : "无时间";

                html += "<tr>" +
                    "<td>" + title + "</td>" +
                    "<td>" + author + "</td>" +
                    "<td>" + formattedDate + "</td>" +
                    "</tr>";
                console.log("单条日志记录：", log);
            });
            $("#logTable").html(html);
        }).fail(function (err) {
            console.error("接口调用失败：", err); //  如果请求失败，打印错误
        });
    });

</script>
</body>
</html>
