<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" session="false" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<!-- 
  - Author(s): Administrator
  - Date: 2019-05-10 17:37:06
  - Description:
-->
<head>
<title>添加好友</title>
   
    <script src="<%=request.getContextPath()%>/common/nui/jquery/jQuery-2.2.0.min.js?v=1.0.1"></script>
	<%@include file="/common/sysVarCommon.jsp" %>
<link href="<%=request.getContextPath()%>/layim-v3.8.0/dist/css/layui.css?v=1.0.11" rel="stylesheet" type="text/css" />
<script src="<%=request.getContextPath()%>/layim-v3.8.0/dist/layui.js?v=1.0.1"></script>
    <style type="text/css">
    	.yuan{width:80px;height:80px;border-radius:80px}
    </style>
</head>
<body>
<div class="layui-tab layui-tab-brief" lay-filter="docDemoTabBrief">
<!--   <ul class="layui-tab-title">
    <li class="layui-this">找人</li>
  </ul> -->
  <div class="layui-tab-content" style="height: 50px;">
    <div class="layui-tab-item layui-show">
    	<input type="text" name="friend" id="friend" required  lay-verify="required" placeholder="请输入查找名称"  class="layui-input" style="width: 400px;display: inline-block;">
    	<button class="layui-btn" lay-submit lay-filter="find" style="width: 80px;">查找</button>
    	<div></div>
    </div>
  </div>
</div> 
<fieldset class="layui-elem-field layui-field-title" >
  <legend>查找结果</legend>
</fieldset>
	<div id="photos" class="photos"   style="width:1000px; display:block;word-break: break-all;word-wrap: break-word;">
<%-- 		<div style="width:150px;height: 100px">
			<div style="width:100px;height: 80px;float: left;">
				<img alt="" style="height: 100px;width: 80px;" src="<%=webPath + contextPath%>/layim-v3.8.0/dist/css/modules/layim/skin/1.jpg">
			</div>
			<div style="width:50px;height: 100px;float: left;">
					<li>张三</li>
					<li>男</li>
					<button class="layui-btn" lay-submit lay-filter="formDemo" style="height: 35px;width: 50px;margin-top: 20px;padding: 0px;">+好友</button>
			</div>			
		</div>	 --%>
	</div>     
<script>
var baseUrl = apiPath + sysApi + "/";
var friendList = [];//查询的所有好友
layui.use(['form', 'upload'], function(){  //如果只加载一个模块，可以不填数组。如：layui.use('form')
  var form = layui.form //获取form模块
  ,upload = layui.upload; //获取upload模块
  
  //监听提交按钮
  form.on('submit(find)', function(data){
  var name  = $('#friend').val();
  //var name  = document.getElementById("friend").value;
  //转码
  name = encodeURI(name); 
  var json ={
  	params: { name : name },
	token:token
  };
    var paramst ={
  	 name : name ,
	 token:token
  };
    //查询
    $.ajax({
        type:'post',
        dataType:'json',
        contentType:'application/json',
        cache : false,
        data: JSON.stringify({
        	params:paramst
        }),
        url:baseUrl + "com.hs.common.env.queryUserInfo.biz.ext",
        success:function(data){
        	friendList = data.result;
        	var htmlStr = "";
        	for(var i =0;i<friendList.length;i++){
        			htmlStr+='<div style="width:240px;height: 100px;float: left;">';
					htmlStr+='	<div style="width:100px;height: 100px;float: left;" >';
					htmlStr+='		<img alt="" class="yuan" src="<%=webPath + contextPath%>/layim-v3.8.0/dist/css/modules/layim/skin/1.jpg">';
					htmlStr+='	</div>';
					htmlStr+='	<div style="width:140px;height: 100px;float: left;">';
					htmlStr+='		<li>'+friendList[i].name+'</li>';
					htmlStr+='		<li>男</li>';
					htmlStr+='		<button class="layui-btn layui-btn-xs layui-btn-normal" id='+friendList[i].id+'   onclick="addFriend(this.id)">+好友</button>';
					htmlStr+='	</div>';
					htmlStr+='</div>';
        	}
        	$(".photos").html("");
            $(".photos").html(htmlStr);
        }
    })
  });
  
});
function addFriend(id){
	var htmlStr = layui.cache.dir + 'css/modules/layim/html/applyFriend.jsp';
	var flag = false;
	for(var i =0;i<friendList.length;i++){
		if(friendList[i].id==id){
			flag = true;
			layer.open({
			  type: 2, 
			  title: '好友申请',
			  content: htmlStr, //这里content是一个普通的String
			  area:['400px','400px'],
			  maxmin:true,
			  success: function (layero, index) {
			  // 获取子页面的iframe
			  var iframe = window['layui-layer-iframe' + index];
			  // 向子页面的全局函数child传参
			  iframe.child(friendList[i]);
			  
			    }
			});
		}
		if(flag){
			break;
		}
	}

}

</script>
</body>
</html>