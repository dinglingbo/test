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
 	<script src="<%= request.getContextPath() %>/common/qiniu/qiniu1.0.14.js" type="text/javascript"></script>
  	<script src="https://cdn.staticfile.org/plupload/2.1.9/moxie.js"></script>
 	<script src="https://cdn.staticfile.org/plupload/2.1.9/plupload.dev.js"></script>  
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

    <div class="layui-form-item" style="margin-top: 20px;">
    <label class="layui-form-label" style="width: 75px">群头像：</label>
    <div class="layui-input-block" id="btn-uploader">
      <img id="avatar" src=""  style="width: 100px;height:100px"></img>
	  	 <%-- <div class="page-header" id="btn-uploader">
			<div class="div1" id="faker" onchange="xmTanUploadImg(this)">
				<img id="xmTanImg" style="width: 100px;height: 100px" onchange="xmTanUploadImg(this)" src="<%= request.getContextPath() %>/common/images/logo.jpg"/>
		        <div id="xmTanDiv"></div>
		    </div>
	    </div>
		<input  class="nui-textbox" id="avatar" name="avatar"  style="display:none" > --%>
		
	    <div class="layui-inline" style="margin-top: 5px;">
	    	<button type="button" class="layui-btn layui-btn-primary" id="LAY_avatarUpload">
	                  <i class="layui-icon"></i>上传图片
	        </button>
	    </div>
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
  <!-- <div class="layui-form-item">
    <div class="layui-input-block" >
      <button class=" layui-btn-xs " id="apply" lay-submit lay-filter="apply"  style="margin-left: 130px;margin-top: 10px;">保存</button>
      <button  id="cancel"  lay-submit lay-filter="cancel" class=" layui-btn-xs" >取消</button>
    </div>
  </div> -->
  <div class="layui-layer-btn layui-layer-btn-">
	<a class="layui-layer-btn0" id="apply" lay-submit lay-filter="apply" >确认</button>
	<a id="cancel"  lay-submit lay-filter="cancel" class="layui-layer-btn1" >取消</button>
  </div>
</form>

         
<script>
var baseUrl = apiPath + sysApi + "/";
var groupInfo ={};
var tcallback = null;
//Demo
layui.use(['form', 'upload'], function(){  //如果只加载一个模块，可以不填数组。如：layui.use('form')
  var form = layui.form //获取form模块
  ,upload = layui.upload; //获取upload模块
  
  //监听申请按钮
  form.on('submit(apply)', function(data){
  			groupInfo.userName=parent.layui.layim.cache().mine.username;
  			groupInfo.userId=currImCode;
  			groupInfo.groupName=$('#name').val();
  			groupInfo.avatar=$('#avatar')[0].src;
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
		        url:baseUrl + "com.hsapi.system.im.message.updateGroup.biz.ext",
		        success:function(data){
		        	if(data.errCode=="S"){
		        		
		        		var index = parent.layer.getFrameIndex(window.name); 
						parent.layer.close(index);//关闭当前页  
					    parent.layer.msg('修改成功',{icon: 1,time: 1000});
					    
					    tcallback(groupInfo);
					    
		        	}else{
		        		parent.layer.msg('修改异常',{icon: 7,time: 2000});
		        	}
		        }
		    });

     });
  //监听取消按钮
  form.on('submit(cancel)', function(data){
		var index = parent.layer.getFrameIndex(window.name); 
		parent.layer.close(index);//关闭当前页  
     });
     
  });
 function setData(group, callback) {
  groupInfo.id = group.groupId;
  tcallback = callback;
  
  $.ajax({
        type:'post',
        dataType:'json',
        contentType:'application/json',
        cache : false,
        data: JSON.stringify({
        	groupId:group.groupId,
        	token:token
        }),
        url:baseUrl + "com.hsapi.system.im.message.getGroupInfo.biz.ext",
        async:false, 
        success:function(text){
        	if(text.code=="0"){
        	  $('#name').val(text.data.groupName);
		      $("#avatar").attr("src",text.data.avatar);
		  	  $('#remark').val(text.data.remark); 
        	}
        }
    });

 }
 
 
 uploader = Qiniu.uploader({
		    runtimes: 'html5,flash,html4',
		    browse_button: 'LAY_avatarUpload',//上传按钮的ID
		    container: 'btn-uploader',//上传按钮的上级元素ID
		    drop_element: 'btn-uploader',
		    max_file_size: '100mb',//最大文件限制
		    //flash_swf_url: '/static/js/plupload/Moxie.swf',
		    dragdrop: false,
		    chunk_size: '4mb',//分块大小
		    uptoken_url: webPath + sysDomain + "/com.hs.common.login.getQNAccessToken.biz.ext",//设置请求qiniu-token的url
		    //Ajax请求upToken的Url，**强烈建议设置**（服务端提供）
		    // uptoken : '<Your upload token>',
		    //若未指定uptoken_url,则必须指定 uptoken ,uptoken由其他程序生成
		    unique_names: false,
		    // 默认 false，key为文件名。若开启该选项，SDK会为每个文件自动生成key（文件名）
		    // save_key: true,
		    // 默认 false。若在服务端生成uptoken的上传策略中指定了 `sava_key`，则开启，SDK在前端将不对key进行任何处理
		    domain: getCompanyLogoUrl(),//自己的七牛云存储空间域名
		    multi_selection: false,//是否允许同时选择多文件
		    //文件类型过滤，这里限制为图片类型
		    filters: {
		        mime_types: [
		            {title: "Image files", extensions: "jpg,jpeg,gif,png"}
		        ]
		    },
		    auto_start: true,
		    init: {
		        'FilesAdded': function (up, files) {
		            //do something
		        },
		        'BeforeUpload': function (up, file) {
		            //do something
		        },
		        'UploadProgress': function (up, file) {
		            //可以在这里控制上传进度的显示
		            //可参考七牛的例子
		        },
		        'UploadComplete': function () {
		            //do something
		        },
		        'FileUploaded': function (up, file, info) {
		            var domain = up.getOption('domain');
		            var info1 = JSON.parse(info);
		            $("#avatar").attr("src",domain + "/" + info1.hash);
		        },
		        'Error': function (up, err, errTip) {
		            alert(errTip);
		        },
		        'Key': function (up, file) {
		        }
		    }
		});

</script>
</body>
</html>