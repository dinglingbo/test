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
  <%@include file="/common/sysVarCommon.jsp" %>
<link href="<%=request.getContextPath()%>/layim-v3.8.0/dist/css/layui.css?v=1.0.11" rel="stylesheet" type="text/css" />
<link href="<%=request.getContextPath()%>/layim-v3.8.0/dist/css/modules/layer/default/layer.css" rel="stylesheet" type="text/css" />
    <script src="<%=request.getContextPath()%>/layim-v3.8.0/dist/layui.js?v=1.0.1"></script>
     	<script src="<%= request.getContextPath() %>/common/qiniu/qiniu1.0.14.js" type="text/javascript"></script>
  	<script src="https://cdn.staticfile.org/plupload/2.1.9/moxie.js"></script>
 	<script src="https://cdn.staticfile.org/plupload/2.1.9/plupload.dev.js"></script>  
    <style type="text/css">
    	.yuan{width:80px;height:80px;border-radius:80px}
    </style>
</head>
<body>
<div >
<form class="layui-form" action="">
  <div class="layui-tab-item layui-show" style="margin-top: 20px;margin-left: 20px;height:80px">
	<input type="text" name="friend" id="groud" required  lay-verify="required" placeholder="请输入分组名称"  class="layui-input" style="width:340px;display: inline-block;margin-top:20px;margin-left: 10px;">
	<!-- <br></br>
	<button class="layui-layer-btn0" lay-submit lay-filter="find" style="width: 80px;" >确定</button>
	<button class="layui-layer-btn1" lay-submit lay-filter="find" style="width: 80px;" >取消</button> -->
  </div>
  <!-- <div class="layui-layer-btn layui-layer-btn-">
	  <a class="layui-layer-btn0" onclick="sure()">确定</a>
	  <a class="layui-layer-btn1" onclick="cancel()">取消</a>
  </div> -->
</form>
</div>     
<script>
var baseUrl = apiPath + repairApi + "/";
var user = null;
var frameIndex = 0;
function setData(params,index){
  user = params;
  frameIndex = index;
  if(user){
    $('#groud').val(user.groupname);
  }
  
}

function addGroup(){
 var s  = $("#groud").value();
}

/* function sure() {
	layer.msg('删除分组成功！', {
        icon: 1,
        time: 2000
    });
    
    parent.layer.close(frameIndex);//关闭当前页 
}

function cancel() {
	parent.layer.close(frameIndex);//关闭当前页 
} */

//layui.use(['form', 'upload'], function(){  //如果只加载一个模块，可以不填数组。如：layui.use('form')
//  var form = layui.form //获取form模块
//  ,upload = layui.upload; //获取upload模块
  
  //监听提交按钮
//   form.on('submit(find)', function(data){
//	  var name  = $('#groud').val();
	  //如果参数放在URL后面，需要转码
	 // name = encodeURI(name); 
	  //修改
	  //var json = {};
//	  var params = {};
//	  if(user && user.id>0){
//	    params ={
//	  	  name:name,
//	  	  id:user.id,
//	  	  edit:"update"
//	     };
//	      json = nui.encode({
//	          params:params,
//			  edit:"update",
//			  token:token
//		}); 
//	  }else{
//		   params ={
//		  	  name:name,
//		  	  userid:currImCode,
//		     };
//		    json = nui.encode({
//		          params:params,
//				  token:token
//			}); 
	  
//	  }
	  
    //查询
//    $.ajax({
//        type:'post',
//        dataType:'json',
//        contentType:'application/json',
//        cache : false,
//       data: json,
//        url:baseUrl + "com.hs.common.env.editUserType.biz.ext",
//        async:false, 
//        success:function(data){
//        	if(data.errCode=="S"){
//        	    var index = parent.layer.getFrameIndex(window.name);  
//                parent.layer.close(index);//关闭当前页  
               // window.parent.location.replace(location.href)//刷新父级页面  
               // window.parent.location.reload(); 
//        	}else{
//        	   showMsg("保存失败","E");
//        	}
        	
//        }
//    }) 
//   }); 
  
//});
</script>
</body>
</html>