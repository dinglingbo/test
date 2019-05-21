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
    <meta http-equiv="content-type" content="text/html; charset=UTF-8" />
    <script src="<%=request.getContextPath()%>/common/nui/jquery/jQuery-2.2.0.min.js?v=1.0.1"></script>
	<%@include file="/common/sysVarCommon.jsp" %>
<link href="<%=request.getContextPath()%>/layim-v3.8.0/dist/css/layui.css?v=1.0.11" rel="stylesheet" type="text/css" />
    <script src="<%=request.getContextPath()%>/layim-v3.8.0/dist/layui.js?v=1.0.1"></script>
    <style type="text/css">
    	.yuan{width:80px;height:80px;border-radius:80px}
    </style>
</head>
<body>
<div >
<form class="layui-form" action="">
  <div class="layui-tab-item layui-show" style="margin-top: 20px;margin-left: 20px;height:100px">
	<input type="text" name="groudName" id="groudName" required  lay-verify="required" placeholder="请输入群昵称"  class="layui-input" style="width: 250px;display: inline-block;margin-top:20px,margin-left: 10px;">
	<button class="layui-btn" lay-submit lay-filter="find" style="width: 80px;" >确定</button>
  </div>
  </form>
</div>     
<script>
var baseUrl = apiPath + repairApi + "/";
var groupTemp = {};
function setData(group){
  groupTemp = group;
  			    $.ajax({
			        type:'post',
			        dataType:'json',
			        contentType:'application/json',
			        cache : false,
			        async:false, 
			        data: JSON.stringify({
			        	userId:currImCode,
			        	groupId : groupTemp.id     	
			        }),
			        url:baseUrl + "com.hs.common.env.queryGroupName.biz.ext",
			        success:function(data){
			        	if(data.errCode=="S"){
							$('#groudName').val(data.name);
			        	}else{
			        	
			        	}
			        }
			    });
  
}

/* function addGroup(){
 var s  = $("#groud").value();
} */


layui.use(['form', 'upload'], function(){  //如果只加载一个模块，可以不填数组。如：layui.use('form')
  var form = layui.form //获取form模块
  ,upload = layui.upload; //获取upload模块
  
  //监听提交按钮
   form.on('submit(find)', function(data){
	  var name  = $('#groudName').val();	  
    //修改群昵称
    $.ajax({
        type:'post',
        dataType:'json',
        contentType:'application/json',
        cache : false,
        data: JSON.stringify({
        	userId:currImCode,
        	groupId : groupTemp.id,
        	name : name   	
        }),
        url:baseUrl + "com.hs.common.env.updateGroupName.biz.ext",
        async:false, 
        success:function(data){
        	if(data.errCode=="S"){
	   		    var index = parent.layer.getFrameIndex(window.name); 
				parent.layer.close(index);//关闭当前页  
			    parent.layer.msg('修改成功！',{icon: 1,time: 2000});
        	}else{
        	   parent.layer.msg('修改异常',{icon: 7,time: 2000});
        	}
        	
        }
    }) 
   }); 
  
});
</script>
</body>
</html>