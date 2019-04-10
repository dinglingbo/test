<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" session="false" %>
<%@include file="/common/sysCommon.jsp"%>	
<html>
<!-- 
  - Author(s): Administrator
  - Date: 2019-02-18 08:58:42
  - Description:
-->
<head>
<title>七牛上传</title>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8" />
    <script src="https://cdn.staticfile.org/jquery/2.2.1/jquery.min.js"></script>
 	<link rel="stylesheet" href="https://cdn.bootcss.com/bootstrap/4.0.0-beta/css/bootstrap.min.css">
 	<script src="<%= request.getContextPath() %>/common/qiniu/qiniu1.0.14.js" type="text/javascript"></script>
  	<script src="https://cdn.staticfile.org/plupload/2.1.9/moxie.js"></script>
 	<script src="https://cdn.staticfile.org/plupload/2.1.9/plupload.dev.js"></script>  
</head>
<body>
	<div class="page-header" id="btn-uploader">
	    <h1><p class="text-primary">upload your picture！</p></h1>
	    <small>
	        <button class="btn btn-link" id="faker">
	                <span class="glyphicon  glyphicon-upload" aria-hidden="true">点击上传</span>
	        </button>
	    </small>
	</div>
<script type="text/javascript">
			uploader = Qiniu.uploader({
			    runtimes: 'html5,flash,html4',
			    browse_button: 'faker',//上传按钮的ID
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
			    domain: 'http://qxy60.7xdr.com/',//自己的七牛云存储空间域名
			    multi_selection: true,//是否允许同时选择多文件
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
			            //每个文件上传成功后,处理相关的事情
			            //其中 info 是文件上传成功后，服务端返回的json，形式如
			            //{
			            //  "hash": "Fh8xVqod2MQ1mocfI4S4KpRL6D98",
			            //  "key": "gogopher.jpg"
			            //}
			            var domain = up.getOption('domain');
			            //var sourceLink = domain + res.key;//获取上传文件的链接地址
			            var info1 = JSON.parse(info);
			            alert("上传成功！");
			            console.log("http://qxy60.7xdr.com/" + info1.hash);
			        },
			        'Error': function (up, err, errTip) {
			            alert(errTip);
			        },
			        'Key': function (up, file) {
			            //当save_key和unique_names设为false时，该方法将被调用
			            /* var key = "";
			             $.ajax({
			             url: '/getToken',
			             type: 'post',
			             async: false,//这里应设置为同步的方式
			             success: function(data) {
			             var ext = Qiniu.getFileExtension(file.name);
			             key = data + '.' + ext;
			             },
			             cache: false
			             });
			             return key;*/
			        }
			    }
			});
			
</script>
</body>
</html>