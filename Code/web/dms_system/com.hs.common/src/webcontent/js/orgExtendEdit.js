/**
 * Created by steven on 2018/1/31.
 */

baseUrl = apiPath + sysApi + "/";;
var saveUrl = baseUrl + "com.hsapi.system.tenant.tenant.saveCompany.biz.ext";
var wachSaveUrl = apiPath + wechatApi + "/" + "wechatApi/com.hsapi.wechat.autoServiceBackstage.weChatInterface.updateStoreSystentInfoChenDao.biz.ext";
var sex;
var isservice;
var isservicelist = [{id: 1, name: '是'}, {id: 0, name: '否'}];
var sexlist = [{id: 1, name: '女'}, {id: 0, name: '男'}]; //[{id:0, name:"女"}, {id:1, name:"男"}];
var dimissionlist = [{id:0, name:"在职"}, {id:1, name:"离职"}];
var list = null;
var provinceCode = null;
var provinceHash = null;
var cityHash = null;
var countyHash = null;
var provinceEl = null;
var cityEl = null;
var countyEl = null;
var streetAddressEl = null;
var addressEl = null;
$(document).ready(function(v) {
    provinceEl = nui.get("provinceId");
    cityEl = nui.get("cityId");
    countyEl = nui.get("countyId");
    streetAddressEl = nui.get("streetAddress");
    addressEl = nui.get("address");

    getRegion(null,function(data) {
        provinceHash = data.rs || [];
        provinceEl.setData(provinceHash);

    });
    nui.get("code").focus();
	document.onkeyup=function(event){
        var e=event||window.event;
        var keyCode=e.keyCode||e.which;//38向上 40向下

        if((keyCode==27))  {  //ESC
        	closeWindow("cal");
        }
      };

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
		            nui.get("logoImg").setValue(getCompanyLogoUrl() + info1.hash);
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

function SetInitData(data) {
    if (data.softopenDate) {
        data.softopenDate = format(data.softopenDate, 'yyyy-MM-dd');
    }
    if (data.recordDate) {
        data.recordDate = format(data.recordDate, 'yyyy-MM-dd HH:mm:ss');
    }
    if (data.modifyDate) {
        data.modifyDate = format(data.modifyDate, 'yyyy-MM-dd');
    }



    
    var form = new nui.Form("#basicInfoForm");
    $("#xmTanImg").attr("src",data.logoImg||webPath + contextPath + "/common/images/logo.jpg");
    form.setData(data);  

    setInitRegionData(provinceEl, null);
    if(data && data.provinceId){
        setInitRegionData(cityEl, data.provinceId);    
    }
    if(data && data.cityId){
        setInitRegionData(countyEl, data.cityId);    
    }
    
}

var requiredField = {
    code : "企业号",
    name : "公司全称",
    shortName : "公司简称",
    provinceId : "省份",
    cityId : "城市",
    countyId : "地区",
    streetAddress : "详细地址",
    tel : "公司电话",
    softOpenDate:"开店日期"
};
function save(action) {
	var form = new nui.Form("#basicInfoForm");
    var data = form.getData();
    var data1 = form.getData();
    var provinceId = 0;
    for ( var key in requiredField) {
    	if(key == "provinceId"){
    		provinceId = data[key];
    	}
        if (!data[key] || $.trim(data[key]).length == 0) {
        	if(key == "cityId" && (provinceId==81 || provinceId==82) ){
        		continue;
        	}
            showMsg(requiredField[key] + "不能为空!","W");
            return;
        }
    }

    /*data.cityId = "";
    data.provinceId = "";
    data.countyId = "";*/
    
    nui.mask({
        el : document.body,
        cls : 'mini-mask-loading',
        html : '保存中...'
    });
   
    nui.ajax({
        url:saveUrl,
        type:"post",
        data:JSON.stringify({
        	comd:data,
        	token: token
        }),
        success:function(data)
        {
            nui.unmask();
            data = data||{};
            if(data.errCode && data.errCode == 'S'){
            	//修改门店信息同步到微信
            	   var storeMap = {
            		   modifier:currUserName,
                       modifierId:currEmpId,
                       orgid:data1.orgid,
                       storeCityId:data1.cityId,
                       storeLatitude:data1.latitude,
                       storeLongitude:data1.longitude,
                       storePhone:data1.tel,
                       storeProvinceId:data1.provinceId,
                       storeRegionId:data1.countyId,
                       storeStreetAddress:data1.address,
                       tenantId:currTenantId
            	   }
            	   nui.ajax({
                    url:wachSaveUrl,
                    type:"post",
                    data:JSON.stringify({
                    	storeMap:storeMap,
                    	token: token
                    }),
                    success:function(data2)
                    {
                        nui.unmask();
                        data2 = data2||{};
                        if(data2.errCode && data2.errCode == 'S'){
                            showMsg("保存成功!","S");
                        }else{
                            showMsg(data2.errMsg,"W");
                        }
                       
                    },
                    error:function(jqXHR, textStatus, errorThrown){
                        //  nui.alert(jqXHR.responseText);
                    	  nui.unmask();
                         console.log(jqXHR.responseText);
                    }
                });
            }else{
            	nui.unmask();
                showMsg(data.errMsg,"W");
            }
            
            if (data.errCode == 'S' && action != 'new') {
            	if (window.CloseOwnerWindow){
            		 closeWindow("ok");
                } else {
                	 closeWindow("cal");
                }
            }
        },
        error:function(jqXHR, textStatus, errorThrown){
            //  nui.alert(jqXHR.responseText);
        	  nui.unmask();
            closeWindow("cal");
        }
    });
}

function close() {
	if (window.CloseOwnerWindow){
		return window.CloseOwnerWindow('OK');
    } else {
        window.close();
        return ;
    }
}
function Oncancel(){
 	closeWindow("cal");
	
}

var getRegionUrl = apiPath + sysApi + "/" + "com.hs.common.region.getRegin.biz.ext";
function getRegion(parentId,callback) {
    nui.ajax({
        url : getRegionUrl,
        data : {
            token: token, 
            parentId: parentId
        },
        type : "post",
        success : function(data) {
            if (data && data.rs) {
                callback && callback(data);
            }
        },
        error : function(jqXHR, textStatus, errorThrown) {
            //  nui.alert(jqXHR.responseText);
            console.log(jqXHR.responseText);
        }
    });
}
function setInitRegionData(el, value){
    getRegion(value,function(data) {
        hash = data.rs || [];
        el.setData(hash);
    });
}
function onProvinceChange(e){
    var value = e.value;
    cityEl.setValue(null);
    countyEl.setValue(null);
    getRegion(value,function(data) {
        cityHash = data.rs || [];
        cityEl.setData(cityHash);

    });
    setAddress();
}
function onCityChange(e){
    var value = e.value;
    countyEl.setValue(null);
    getRegion(value,function(data) {
        countyHash = data.rs || [];
        countyEl.setData(countyHash);

    });
    setAddress();
}
function onCountyChange(e){
    setAddress();
}
function onStreetChange(e){
    setAddress();
}
function setAddress() {
    var provinceT = provinceEl.getText()||'';
    var cityT = cityEl.getText()||'';
    var countyT = countyEl.getText()||'';
    var streetAddressT = streetAddressEl.getValue()||'';
    var address = provinceT + cityT + countyT + streetAddressT;
    addressEl.setValue(address);
    addressEl.getValue();
}
function onMobileValidation(e) {
	if(e.value=="" || e.value==null){ return;}
	if (e.isValid) {
        var pattern = /^0\d{2,3}-\d{7,8}$/; ///0\d{2}-\d{7,8}/;
        if (pattern.test(e.value) == false) {
            e.errorText = "必须是电话，如：028-2580344";
            e.isValid = false;
        }
    }
}

jQuery.extend({

    handleError: function (s, xhr, status, e) {
        // If a local callback was specified, fire it  
        if (s.error) {
            s.error.call(s.context || s, xhr, status, e);
        }

        // Fire the global callback  
        if (s.global) {
            (s.context ? jQuery(s.context) : jQuery.event).trigger("ajaxError", [xhr, s, e]);
        }
    },

    createUploadIframe: function (id, uri) {
        //create frame
        var frameId = 'jUploadFrame' + id;
        var iframeHtml = '<iframe id="' + frameId + '" name="' + frameId + '" style="position:absolute; top:-9999px; left:-9999px"';
        if (window.ActiveXObject) {
            if (typeof uri == 'boolean') {
                iframeHtml += ' src="' + 'javascript:false' + '"';

            }
            else if (typeof uri == 'string') {
                iframeHtml += ' src="' + uri + '"';

            }
        }
        iframeHtml += ' />';
        jQuery(iframeHtml).appendTo(document.body);

        return jQuery('#' + frameId).get(0);
    },
    createUploadForm: function (id, fileElementId, data) {
        //create form	
        var formId = 'jUploadForm' + id;
        var fileId = 'jUploadFile' + id;
        var form = jQuery('<form  action="" method="POST" name="' + formId + '" id="' + formId + '" enctype="multipart/form-data"></form>');
        if (data) {
            for (var i in data) {
                jQuery('<input type="hidden" name="' + i + '" value="' + data[i] + '" />').appendTo(form);
            }
        }

        var oldElement = typeof fileElementId == "string" ? jQuery('#' + fileElementId) : fileElementId;
        var newElement = jQuery(oldElement).clone();
        jQuery(oldElement).attr('id', fileId);
        jQuery(oldElement).before(newElement);
        jQuery(oldElement).appendTo(form);



        //set attributes
        jQuery(form).css('position', 'absolute');
        jQuery(form).css('top', '-1200px');
        jQuery(form).css('left', '-1200px');
        jQuery(form).appendTo('body');
        return form;
    },

    ajaxFileUpload: function (s) {
        // TODO introduce global settings, allowing the client to modify them for all requests, not only timeout		
        s = jQuery.extend({}, jQuery.ajaxSettings, s);
        var id = new Date().getTime()
        var form = jQuery.createUploadForm(id, s.fileElementId, (typeof (s.data) == 'undefined' ? false : s.data));
        var io = jQuery.createUploadIframe(id, s.secureuri);
        var frameId = 'jUploadFrame' + id;
        var formId = 'jUploadForm' + id;
        // Watch for a new set of requests
        if (s.global && !jQuery.active++) {
            jQuery.event.trigger("ajaxStart");
        }
        var requestDone = false;
        // Create the request object
        var xml = {}
        if (s.global)
            jQuery.event.trigger("ajaxSend", [xml, s]);
        // Wait for a response to come back
        var uploadCallback = function (isTimeout) {
            var io = document.getElementById(frameId);
            try {
                if (io.contentWindow) {
                    xml.responseText = io.contentWindow.document.body ? io.contentWindow.document.body.innerHTML : null;
                    xml.responseXML = io.contentWindow.document.XMLDocument ? io.contentWindow.document.XMLDocument : io.contentWindow.document;

                } else if (io.contentDocument) {
                    xml.responseText = io.contentDocument.document.body ? io.contentDocument.document.body.innerHTML : null;
                    xml.responseXML = io.contentDocument.document.XMLDocument ? io.contentDocument.document.XMLDocument : io.contentDocument.document;
                }
            } catch (e) {
                jQuery.handleError(s, xml, null, e);
            }
            if (xml || isTimeout == "timeout") {
                requestDone = true;
                var status;
                try {
                    status = isTimeout != "timeout" ? "success" : "error";
                    // Make sure that the request was successful or notmodified
                    if (status != "error") {
                        // process the data (runs the xml through httpData regardless of callback)
                        var data = jQuery.uploadHttpData(xml, s.dataType);
                        // If a local callback was specified, fire it and pass it the data
                        if (s.success)
                            s.success(data, status);

                        // Fire the global callback
                        if (s.global)
                            jQuery.event.trigger("ajaxSuccess", [xml, s]);
                    } else
                        jQuery.handleError(s, xml, status);
                } catch (e) {
                    status = "error";
                    jQuery.handleError(s, xml, status, e);
                }

                // The request was completed
                if (s.global)
                    jQuery.event.trigger("ajaxComplete", [xml, s]);

                // Handle the global AJAX counter
                if (s.global && ! --jQuery.active)
                    jQuery.event.trigger("ajaxStop");

                // Process result
                if (s.complete)
                    s.complete(xml, status);

                jQuery(io).unbind()

                setTimeout(function () {
                    try {
                        jQuery(io).remove();
                        jQuery(form).remove();

                    } catch (e) {
                        jQuery.handleError(s, xml, null, e);
                    }

                }, 100)

                xml = null

            }
        }
        // Timeout checker
        if (s.timeout > 0) {
            setTimeout(function () {
                // Check to see if the request is still happening
                if (!requestDone) uploadCallback("timeout");
            }, s.timeout);
        }
        try {

            var form = jQuery('#' + formId);
            jQuery(form).attr('action', s.url);
            jQuery(form).attr('method', 'POST');
            jQuery(form).attr('target', frameId);
            if (form.encoding) {
                jQuery(form).attr('encoding', 'multipart/form-data');
            }
            else {
                jQuery(form).attr('enctype', 'multipart/form-data');
            }
            jQuery(form).submit();

        } catch (e) {
            jQuery.handleError(s, xml, null, e);
        }

        jQuery('#' + frameId).load(uploadCallback);
        return { abort: function () { } };

    },

    uploadHttpData: function (r, type) {

        var data = !type;
        data = type == "xml" || data ? r.responseXML : r.responseText;
        // If the type is "script", eval it in global context
        if (type == "script")
            jQuery.globalEval(data);
        // Get the JavaScript object, if JSON is used.
        if (type == "json")
            eval("data = " + data);
        // evaluate scripts within html
        if (type == "html")
            jQuery("<div>").html(data).evalScripts();

        return data;
    }
})

function onCountyChange(e){
   var data = e.selected;
   if(data.latitude){
      nui.get("latitude").setValue(data.latitude);
   }
   if(data.longitude){
       nui.get("longitude").setValue(data.longitude);
   }
}


