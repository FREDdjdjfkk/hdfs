<%--
  Created by IntelliJ IDEA.
  User: 李鹏程
  Date: 2025-03-18
  Time: 10:32
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html style="height: 100%">
<head>
  <meta charset="utf-8">
  <!-- 引入echarts.min.js文件 -->
  <script type="text/javascript" src="js/echarts.min.js"></script>
  <script type="text/javascript" src="js/jquery.js"></script>
</head>
<body style="height: 100%; margin: 0">

<!-- 用于显示图表 -->
<div id="container" style="height: 100%"></div>


<script type="text/javascript">
  $.get("chart",function(data){
    var bts=data.bts;
    var nums=data.nums;

    var dom = document.getElementById("container");
    var myChart = echarts.init(dom);

    var option;
    option = {
      tooltip: {
        trigger: 'axis',
        axisPointer: {
          type: 'shadow'
        }
      },

      xAxis: [
        {
          type: 'category',
          data: bts,
          axisTick: {
            alignWithLabel: true
          }
        }
      ],
      yAxis: [
        {
          type: 'value'
        }
      ],
      series: [
        {
          name: 'Direct',
          type: 'bar',
          barWidth: '60%',
          data: nums
        }
      ]
    };

    myChart.setOption(option);


  });





</script>
</body>
</html>
