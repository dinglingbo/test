<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" session="false" %>
<%@include file="/common/sysVarCommon.jsp"%>	
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
<title>聊天记录</title>

<!-- <link rel="stylesheet" href="http://local.res.layui.com/layui/src/css/layui.css"> -->
<link rel="stylesheet" href="../../../layui.css?v=1">
<style>
body .layim-chat-main{height: auto;}
</style>
</head>
<body>

<div class="layim-chat-main">
  <ul id="LAY_view"></ul>
</div>

<div id="LAY_page" style="margin: 0 10px;"></div>


<textarea title="消息模版" id="LAY_tpl" style="display:none;">
{{# layui.each(d.data, function(index, item){
  if(item.id == parent.layui.layim.cache().mine.id){ }}
    <li class="layim-chat-mine"><div class="layim-chat-user"><img src="{{ item.avatar }}"><cite><i>{{ layui.data.date(item.timestamp) }}</i>{{ item.username }}</cite></div><div class="layim-chat-text">{{ layui.layim.content(item.content) }}</div></li>
  {{# } else { }}
    <li><div class="layim-chat-user"><img src="{{ item.avatar }}"><cite>{{ item.username }}<i>{{ layui.data.date(item.timestamp) }}</i></cite></div><div class="layim-chat-text">{{ layui.layim.content(item.content) }}</div></li>
  {{# }
}); }}
</textarea>

<div id="test1" style="float:right"></div>

<!-- 
上述模版采用了 laytpl 语法，不了解的同学可以去看下文档：http://www.layui.com/doc/modules/laytpl.html

-->


<script src="../../../../layui.js?v=1"></script>
<script>
layui.use(['layim', 'laypage'], function(){
  var layim = layui.layim
  ,layer = layui.layer
  ,laytpl = layui.laytpl
  ,$ = layui.jquery
  ,laypage = layui.laypage;
  
  //聊天记录的分页此处不做演示，你可以采用laypage，不了解的同学见文档：http://www.layui.com/doc/modules/laypage.html
  
  
  //开始请求聊天记录
  var param =  location.search; //获得URL参数。该窗口url会携带会话id和type，他们是你请求聊天记录的重要凭据
  var res = {};
  
  //请求消息
  var renderMsg = function(page, callback){
    $.get(apiPath + sysApi + "/com.hsapi.system.im.message.getChatList.biz.ext"+ location.search, {
      page: page || 1, senduser: currImCode
    }, function(res){
      callback && callback(res.data, res.count);
    });
  };

  layui.use('laypage', function(){
	  var laypage = layui.laypage;
	  
	  renderMsg(1, function(data, count) {
	    var html = laytpl(LAY_tpl.value).render({
	    	data: data
	    });
	    $('#LAY_view').html(html);
		  //执行一个laypage实例
		  laypage.render({
		    elem: 'test1' //注意，这里的 test1 是 ID，不用加 # 号
		    ,count: count //数据总数，从服务端得到
		    ,jump: function(obj, first){
			    //obj包含了当前分页的所有参数，比如：
			    console.log(obj.curr); //得到当前页，以便向服务端请求对应页的数据。
			    console.log(obj.limit); //得到每页显示的条数
			    
			    //首次不执行
			    if(!first){
			      renderMsg(obj.curr, function(data,count){
			      	var html = laytpl(LAY_tpl.value).render({
				    	data: data
				    });
				    $('#LAY_view').html(html);
			      });
			    }
			 }
		  });
	  });
	  
	  
  });
	
});
</script>
</body>
</html>