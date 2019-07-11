var webBaseUrl = webPath + contextPath + "/";
var baseUrl = apiPath + repairApi + "/"; 

var  index = 0;//汽车图片的下标
var photos = [];//汽车图片
var isOpen = true;
var row = {};//全局传过来的行
$(document).ready(function (){
	
	uploader = Qiniu.uploader({
		    runtimes: 'html5,flash,html4',
		    browse_button: 'faker4',//上传按钮的ID
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
		            if(photos.length>=3){
		            	showMsg("最多上传三张照片！","W");		            	
		            }else{
			            var html=imageHtml(getCompanyLogoUrl() + info1.hash,index);
			            $(".photos").before(html);
			            mouseImage();
			            photos[index]={
			            		address:getCompanyLogoUrl() + info1.hash,
			            	    index : index
			            }
			            index++;
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

function setData(data){
	row = nui.clone(data);
	if(row.pictureOne!=null&&row.pictureOne!=""){
		
		var html= imageHtml(row.pictureOne,index);
		$(".photos").before(html);
        mouseImage();
        photos[index]={
        		address:row.pictureOne,
        	    index : index
        }
        index++;
	}
	if(row.pictureTwo!=null&&row.pictureTwo!=""){
		
		var html= imageHtml(row.pictureTwo,index);
		$(".photos").before(html);
        mouseImage();
        photos[index]={
        		address:row.pictureTwo,
        	    index : index
        }
        index++;
	}
	if(row.pictureThree!=null&&row.pictureThree!=""){
		
		var html= imageHtml(row.pictureThree,index);
		$(".photos").before(html);
        mouseImage();
        photos[index]={
        		address:row.pictureThree,
        	    index : index
        }
        index++;
	}

}
function mouseImage(){
	//鼠标移动到图片上时触发
	$(".imgListA").mouseover(function(){
    		$(this).css("cursor","default");
		$(this).find(".imgListOneDiv").show();
		
		var height = $(this).find(".imgStyle").height();
		var width = $(this).find(".imgStyle").width();
		$( $(this).find(".imgListOneDiv") ).css("height","100px");
		$( $(this).find(".imgListOneDiv") ).css("width","150px");
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
		for(var i =0;i<photos.length;i++){
			if(photos[i].index==num){
				photos.splice(i,1); 
				index--;
			}
		}
		$(".fileImage"+num).remove();
		$(".imagers"+num).remove();
	});
	//预览选择的图片
	$(".preview").click(function(e){
		var num=$(this).attr("num");
		if(isOpen){
			for(var i =0;i<photos.length;i++){
				if(photos[i].index==num){
					preview(photos[i].address); 
				}
			}
		}

	});
}

function changeShow1(src){
	var str = src.substr(src.length-8, 4);
	if(str=="logo"){
		return;
	}
	$("#maxImgShow1").attr("src",src);
	$(".max_img1").show();
}
function changeShow(src){
	var str = src.substr(src.length-8, 4);
	if(str=="logo"){
		return;
	}
	$("#maxImgShow").attr("src",src);
	$(".max_img").show();
}
function changeHide(){
	$(".max_img").hide();
	$(".max_img1").hide();
}


function imageHtml(imageUrl,indexss){
	var html="";
	var imagerText="imagers"+indexss;
	var imagerShow="imageshow"+indexss;
	/*if(indexss%4==0){
		html+='<br>';
	}*/
	html+='<a href="#" class="imgListA '+imagerText+'" >';
	html+='		<div class="" style="width:150px;height: 100px;float: left;" >';
	html+='		<div class="imgListOneDiv" style="display:none;" >';
	html+='			<img id="" alt="" src="'+webPath + contextPath +'/repair/prototype/images/preview.png" class="imgListone preview" num="'+indexss+'" >';
	html+='			<img  id="" alt="" src="'+webPath + contextPath +'/repair/prototype/images/deleteImage.png"  class="imgListtwo imgDelete" num="'+indexss+'" >';
	html+='		</div>';
	html+='			<img id=""  alt="" src="'+imageUrl+'" class="imgStyle '+imagerShow+'" >';
	html+='		</div>';
	html+='</a>';

	return html;
};

function addCarListPhoto(){
      if(photos[0]==null){
    	  row.pictureOne = "";
      }else{
    	  row.pictureOne =  photos[0].address||"";
      }
      
      if(photos[1]==null){
    	  row.pictureTwo = "";
      }else{
    	  row.pictureTwo =  photos[1].address||"";
      }
      
      if(photos[2]==null){
    	  row.pictureThree = "";
      }else{
    	  row.pictureThree =  photos[2].address||"";
      }

    CloseWindow({
    	errCode:"S",
    	row : row
    });
}

//关闭窗口
function CloseWindow(action) {
    if (window.CloseOwnerWindow)
        return window.CloseOwnerWindow(action);
    else window.close();
}
//取消
function onCancel() {
    CloseWindow(row);
}