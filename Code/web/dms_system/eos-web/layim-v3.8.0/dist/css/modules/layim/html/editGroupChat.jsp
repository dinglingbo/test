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
<title>好友申请</title>
    <script src="<%=request.getContextPath()%>/common/nui/jquery/jQuery-2.2.0.min.js?v=1.0.1"></script>
	<%@include file="/common/sysVarCommon.jsp" %>
<link href="<%=request.getContextPath()%>/layim-v3.8.0/dist/css/layui.css?v=1.0.11" rel="stylesheet" type="text/css" />
    <script src="<%=request.getContextPath()%>/layim-v3.8.0/dist/layui.js?v=1.0.1"></script>
    <style type="text/css">
    	.layui-textarea{
    		height: 70px;
    	 min-height: 70px; 
    	}
    	.layui-input-block{
    		width: 240px;
    	}
    </style>
</head>
<body>
<form class="layui-form" action="">
  <div class="layui-form-item">
    <label class="layui-form-label" style="width: 75px">群名称：</label>
    <div class="layui-input-block">
      <input class="layui-input" type="text" id="groupName" name="groupName"  placeholder="请输入群名称"  autocomplete="off" >
    </div>
  </div>
    <div class="layui-form-item">
    <label class="layui-form-label" style="width: 75px">群头像：</label>
    <div class="layui-input-block">
      <img id="avatar" src=""  style="width: 100px;height: 100px">
    </div>
  </div>
    <div class="layui-form-item">
    <label class="layui-form-label" style="width: 75px">群昵称：</label>
    <div class="layui-input-block">
      <input class="layui-input" type="text" id="name" name="name"  placeholder="请输入我在本群昵称"  autocomplete="off" >
    </div>
  </div>
  <div class="layui-form-item layui-form-text">
    <label class="layui-form-label" style="width: 75px">群说明：</label>
    <div class="layui-input-block">
      <textarea name="remark" id="remark" placeholder="请输入群说明" class="layui-textarea" ></textarea>
    </div>
  </div>
  <div class="layui-form-item">
    <div class="layui-input-block" >
      <button class=" layui-btn-xs " id="apply" lay-submit lay-filter="apply"  style="margin-left: 130px;margin-top: 10px;">保存</button>
      <button  id="cancel"  lay-submit lay-filter="cancel" class=" layui-btn-xs" >取消</button>
    </div>
  </div>
</form>

         
<script>
var baseUrl = apiPath + sysApi + "/";
var groupInfo ={};
//Demo
layui.use(['form', 'upload'], function(){  //如果只加载一个模块，可以不填数组。如：layui.use('form')
  var form = layui.form //获取form模块
  ,upload = layui.upload; //获取upload模块
  
  //监听申请按钮
  form.on('submit(apply)', function(data){
  			groupInfo.userName=currUserName;
  			groupInfo.userId=currImCode;
  			groupInfo.groupName=$('#groupName').val();
  			groupInfo.avatar=$('#avatar').val();
  			groupInfo.remark=$('#remark').val();
			    //修改群资料
		    $.ajax({
		        type:'post',
		        dataType:'json',
		        contentType:'application/json',
		        cache : false,
		        async:false, 
		        data: JSON.stringify({
		        	groupInfo:groupInfo
		        }),
		        url:baseUrl + "com.hs.common.env.updateGroup.biz.ext",
		        success:function(data){
		        	if(data.errCode=="S"){
		        		var index = parent.layer.getFrameIndex(window.name); 
						parent.layer.close(index);//关闭当前页  
					    parent.layer.msg('修改成功！！',{icon: 1,time: 2000});
		        	}else{
		        		parent.layer.msg('修改异常',{icon: 7,time: 2000});
		        	}
		        }
		    });

     });cancel
  //监听取消按钮
  form.on('submit(cancel)', function(data){
		var index = parent.layer.getFrameIndex(window.name); 
		parent.layer.close(index);//关闭当前页  
     });
     
  });
 function setData(group) {
 groupInfo = group;
  $('#groupName').val(groupInfo.groupName);
  $("#avatar").attr("src",groupInfo.avatar);
   //$('#avatar').val(groupInfo.avatar);
  $('#remark').val(groupInfo.remark);
}

</script>
</body>
</html>