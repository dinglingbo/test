var baseUrl = window._rootUrl||"http://127.0.0.1:8080/default/";
var dataform1 = null;
//必填
var requiredField = {
	carBrandEn: "品牌英文名",
	carBrandZh: "品牌中文名"
};

$(document).ready(function(){
	dataform1 = new nui.Form("#dataform1");
	nui.get('carBrandEn').focus();
	 document.onkeyup = function(event) {
        var e = event || window.event;
        var keyCode = e.keyCode || e.which;// 38向上 40向下
        

        if ((keyCode == 27)) { // ESC
            CloseWindow('cancle');
        }

    }
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
		            //每个文件上传成功后,处理相关的事情
		            //其中 info 是文件上传成功后，服务端返回的json，形式如
		            //{
		            //  "hash": "Fh8xVqod2MQ1mocfI4S4KpRL6D98",
		            //  "key": "gogopher.jpg"
		            //}
		            var domain = up.getOption('domain');
		            //var sourceLink = domain + res.key;//获取上传文件的链接地址
		            var info1 = JSON.parse(info);
		            $("#xmTanImg").attr("src",getCompanyLogoUrl() + info1.hash);
		            nui.get("imageUrl").setValue(getCompanyLogoUrl() + info1.hash);
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
function setData(data){
	if(!dataform1){
		dataform1 = new nui.Form("#dataform1");
	}
	data = data||{};
	if(data.brand)
	{
		var brand = data.brand;
		dataform1.setData(brand);
	}
	 $("#xmTanImg").attr("src",data.brand.imageUrl||webPath + contextPath + "/common/images/logo.jpg");
}
var brandUrl = baseUrl + "com.hsapi.repair.baseData.brand.saveBrand.biz.ext";
function onOk(){
	var data = dataform1.getData();
	console.log(data);
	for(var key in requiredField){
		if(!data[key] || data[key].trim().length==0)
        {
            nui.alert(requiredField[key]+"不能为空");
            return;
        }
	}
	nui.mask({
		html:'保存中..'
	});
	doPost({
		url:brandUrl,
		data:{
			brand:data
		},
		success:function(data)
		{
			nui.unmask();
			data = data||{};
			if(data.errCode == "S")
			{
				nui.alert("保存成功");
				CloseWindow("ok");
			}
			else{
				nui.alert(data.errMsg||"保存失败");
			}
		},
		error:function(jqXHR, textStatus, errorThrown)
		{
			console.log(jqXHR.responseText);
			nui.unmask();
			nui.alert("网络出错");
		}
	});
}

function CloseWindow(action)
{
    if (window.CloseOwnerWindow)
    return window.CloseOwnerWindow(action);
    else window.close();
}

function onCancel() {
    CloseWindow("cancel");
}