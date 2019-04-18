 var baseUrl = apiPath + repairApi + "/";  
 var beforeIndex = 0;//维修前的图片下标
 var afterIndex = 0;//维修后的图片下标
 var before = [];
 var after = [];
 var add = [];
 var serviceId =0;
$(document).ready(function(v) {
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
		    domain: getCompanyLogoUrl(),//自己的七牛云存储空间域名
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
		            beforeIndex++;
		            var html=imageHtml(getCompanyLogoUrl() + info1.hash,beforeIndex);
		            $(".before").before(html);
		            mouseImage();
		            before[before.length]={
		            		attachName:getCompanyLogoUrl() + info1.hash,
		            		serviceId: serviceId,
		            	    type: 1
		            }
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
    	uploader = Qiniu.uploader({
		    runtimes: 'html5,flash,html4',
		    browse_button: 'faker1',//上传按钮的ID
		    container: 'btnuploader',//上传按钮的上级元素ID
		    drop_element: 'btnuploader',
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
		            afterIndex++;
		            var html=imageHtml(getCompanyLogoUrl() + info1.hash,afterIndex);
		            $(".after").before(html);
		            mouseImage();
		            after[after.length]={
		            		attachName:getCompanyLogoUrl() + info1.hash,
		            		serviceId: serviceId,
		            	    type: 2
		            }
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

    	
});

function getCompanyLogoUrl(){
	  var url="";
  nui.ajax({
    url:webPath + sysDomain +"/com.hs.common.login.getCompanyLogoUrl.biz.ext",
    type:"post",
    data:{},
    async:false,
    success:function(data)
    {
        nui.unmask();
        data = data||{};
        if(data.errCode && data.errCode == 'S'){
      	  url =  data.companyLogoUrl;
        }else{
            showMsg(data.errMsg,"W");
        }
        
    },
    error:function(jqXHR, textStatus, errorThrown){
        //  nui.alert(jqXHR.responseText);
    	  nui.unmask();
        closeWindow("cal");
    }
});
return url;
};


function SetData(serviceId1, serviceCode, state) {
	serviceId = serviceId1;
    nui.get("serviceId").setValue(serviceId);
    nui.get("serviceCode").setValue(serviceCode);
	nui.ajax({
		url: baseUrl+ "com.hsapi.repair.repairService.waveBox.searchUploadPhoto.biz.ext",
		type: "post",
		cache: false,
		async: false,
		data: {
			serviceId : nui.get("serviceId").value
		},
		success: function (text) {
				if(text.errCode == "S"){
					var data = text.data;
					for(var i = 0 , l = data.length ; i < l ;i ++){
						if(data[i].type == 1){
				            var html=imageHtml(data[i].attachName,beforeIndex);
				            beforeIndex++;
							 $(".before").before(html);
							 mouseImage();
							 before[before.length]={
					            		attachName:data[i].attachName,
					            		serviceId: serviceId,
					            	    type: 1
					            }

						}else{
							 var html=imageHtml(data[i].attachName,afterIndex);
							 afterIndex++;
							 $(".after").before(html);
							 mouseImage();
					            after[after.length]={
					            		attachName:data[i].attachName,
					            		serviceId: serviceId,
					            	    type: 2
					            }
						}
					}
					
				}else{
					showMsg(text.errMsg,"W");
				}
		},
		error: function (jqXHR, textStatus, errorThrown) {
			console.log(jqXHR.responseText);
			showMsg("网络出错", "E");
		}
	});
}



function imageHtml(imageUrl,indexss){
	var str = imageUrl.substr(imageUrl.length-28, 28);
	var html="";
	var imagerText="imagers"+str;
	var imagerShow="imageshow"+indexss;
	html+='<a href="#" class="imgListA '+imagerText+'">';
	html+='		<div class="" style="position: relative;" >';
	html+='		<div class="imgListOneDiv" style="display:none;" >';
	html+='			<img  id="" alt="" src="'+webPath + contextPath +'/repair/prototype/images/deleteImage.png"  class="imgListtwo imgDelete" num="'+imageUrl+'" >';
	html+='		</div>';
	html+='			<img id=""  alt="" src="'+imageUrl+'" class="imgStyle '+imageUrl+'" >';
	html+='		</div>';
	html+='</a>';
	return html;
};



function save(){
	for(var i=0;i<before.length;i++){
		after.push(before[i]);
	}

    if(after.length == 0){
    	showMsg("暂无图片需要保存","W");
    	return;
    }

    nui.ajax({
		url: baseUrl+ "com.hsapi.repair.repairService.waveBox.addUploadPhoto.biz.ext",
		type: "post",
		cache: false,
		async: false,
		data: {
			add: after,
			serviceId : serviceId
		},
		success: function (text) {
				if(text.errCode == "S"){
					showMsg("执行成功","S");
				}else{
					showMsg(text.errMsg,"W");
				}
		},
		error: function (jqXHR, textStatus, errorThrown) {
			console.log(jqXHR.responseText);
			showMsg("网络出错", "E");
		}
	});
}

function mouseImage(){
	//鼠标移动到图片上时触发
	$(".imgListA").mouseover(function(){
    		$(this).css("cursor","default");
		$(this).find(".imgListOneDiv").show();
		var height = $(this).find(".imgStyle").height();
		var width = $(this).find(".imgStyle").width();
		$( $(this).find(".imgListOneDiv") ).css("height",height+"px");
		$( $(this).find(".imgListOneDiv") ).css("width",width+"px");
		var heightTo=height/2;
		if( heightTo>20 ){
			heightTo-=20;
			$( $(this).find(".imgListOneDiv") ).css("padding-top",heightTo+"px");
		}else{
			$( $(this).find(".imgListOneDiv") ).css("padding-top",heightTo+"px");
		}
	});

	//鼠标从图片上离开时触发
	$(".imgListA").mouseout(function(){
		$(this).css("cursor","pointer");
		$(this).find(".imgListOneDiv").hide();
		
	});
	
	//删除选择的图片
	$(".imgDelete").click(function(e){
		var num=$(this).attr("num");
		/*$(".fileImage"+num).remove();*/
		var str = num.substr(num.length-28, 28);
		$(".imagers"+str).remove();
	});
}