/**
 * Created by steven on 2018/1/31.
 */

baseUrl = apiPath + sysApi + "/";;
var saveUrl = baseUrl + "com.hsapi.system.tenant.tenant.saveCompany.biz.ext";
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

});
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
    streetAddress : "详细地址",
    tel : "公司电话",
    softOpenDate:"开店日期"
};
function save(action) {
	var form = new nui.Form("#basicInfoForm");
    var data = form.getData();

    for ( var key in requiredField) {
        if (!data[key] || $.trim(data[key]).length == 0) {
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
                showMsg("保存成功!","S");
            }else{
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
