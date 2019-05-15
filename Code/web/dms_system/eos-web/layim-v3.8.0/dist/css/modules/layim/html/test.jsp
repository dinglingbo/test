<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" session="false" %>
	
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
  <meta charset="utf-8">
  <title>layPage快速使用</title>
  <link rel="stylesheet" href="/layim-v3.8.0/dist/css/layui.css" media="all">
</head>
<body>
 
<div id="test1"></div>
 
<script src="<%=request.getContextPath()%>/layim-v3.8.0/dist/layui.js"></script>
<script>
layui.use('laypage', function(){
  var laypage = layui.laypage;
  
  //执行一个laypage实例
  laypage.render({
    elem: 'test1' //注意，这里的 test1 是 ID，不用加 # 号
    ,count: 50 //数据总数，从服务端得到
  });
});
</script>
</body>
</html>