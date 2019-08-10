/**
 * Created by Administrator on 2018/1/23.
 */
var baseUrl = apiPath + cloudPartApi + "/";//window._rootUrl || "http://127.0.0.1:8080/default/";
var logisticsUrl = baseUrl + "com.hsapi.cloud.part.baseDataCrud.crud.getLogisticsByGuestId.biz.ext";
var mainForm = null;
var otherForm = null;
var logisticsGrid = null;
var editLogisticsForm = null;

var provinceHash = {};
var cityHash = {};
var countyHash = {};
var aprovinceEl = null;
var acityEl = null;
var acountyEl = null;
var astreetAddressEl = null;
var aaddressEl = null;
var nrow = null;
var guestPropertyList=[];
var guestPropertyHash={};
var guestPropertyEl=null;
var dictDefs ={"guestProperty":"10042"};

var guestGrid = null;
var guestGridUrl = baseUrl+"com.hsapi.cloud.part.baseDataCrud.crud.queryCustomList.biz.ext";
var haveSelectGrid =null;
var haveSelectGridUrl = baseUrl+"com.hsapi.cloud.part.baseDataCrud.crud.queryGuestCon.biz.ext";
function initForm(){
    mainForm = new nui.Form("#mainForm");
    otherForm = new nui.Form("#otherForm");
    //editLogisticsForm = new nui.Form("#editLogisticsForm");   
    editLogisticsForm = document.getElementById("editLogisticsForm");

    aprovinceEl = nui.get("aprovinceId");
	acityEl = nui.get("acityId");
	acountyEl = nui.get("acountyId");
	astreetAddressEl = nui.get("astreetAddress");
	aaddressEl = nui.get("addressA");
	
	guestGrid =nui.get("guestGrid");
	guestGrid.setUrl(guestGridUrl);
	
	haveSelectGrid =nui.get('haveSelectGrid');
	haveSelectGrid.setUrl(haveSelectGridUrl);
	/*getRegion(null,function(data) {
		//provinceHash = data.rs || [];
		//provinceEl.setData(provinceHash);

	});*/
	

}

var billTypeId = null;
var settTypeId = null;
var managerDuty = null;
var tgrade = null;
function initComboBox()
{
    provinceEl = nui.get("provinceId");
    billTypeId = nui.get("billTypeId");
    settTypeId = nui.get("settTypeId");
    managerDuty = nui.get("managerDuty");
    tgrade = nui.get("tgrade");
    logisticsGrid = nui.get("logisticsGrid");
    logisticsGrid.setUrl(logisticsUrl);
}
$(document).ready(function(v)
{
	
	initComboBox();
    initForm();
    initDicts(dictDefs,function()
	    {   
          	guestPropertyList = nui.get("guestProperty").getData();
          	guestPropertyList.filter(function(v)
	        {
          		guestPropertyHash[v.customid] = v;
	            return true;
	        });

	    });
    
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
	            $("#xmTanImg").attr("src",qiNiuUrl + info1.hash);
	            nui.get("licenseUrl").setValue(qiNiuUrl+ info1.hash);
	            var imgPath=qiNiuUrl+ info1.hash;
	            getLicense(imgPath);
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
	    browse_button: 'up',//上传按钮的ID
	    container: 'idno-uploader',//上传按钮的上级元素ID
	    drop_element: 'idno-uploader',
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
	            $("#idNoImg").attr("src",qiNiuUrl + info1.hash);
	            nui.get("idCardUrl").setValue(qiNiuUrl+ info1.hash);
	            var imgPath=qiNiuUrl+ info1.hash;
	            getIdCard(imgPath);
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
	    browse_button: 'other',//上传按钮的ID
	    container: 'other-uploader',//上传按钮的上级元素ID
	    drop_element: 'other-uploader',
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
	            $("#otherImg").attr("src",qiNiuUrl + info1.hash);
	            nui.get("otherPictueUrl").setValue(qiNiuUrl+ info1.hash);
	            var imgPath=qiNiuUrl+ info1.hash;
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

var address=null;
var legalPerson=null;
var licenseCode=null;
var name=null;
var registerMoney=null;
function getLicense(imgPath){
	var guestProperty =nui.get('guestProperty').getValue().replace(/\s+/g, "");
	nui.mask({
        el : document.body,
    	cls : 'mini-mask-loading',
    	html : '识别中...'
    });
	nui.ajax({
	    url:webPath + sysDomain +"/com.hs.common.sysService.getLicenseRecog.biz.ext",
	    type:"post",
	    data:{imgPath:imgPath},
	    async:false,
	    success:function(data)
	    {
	        nui.unmask();
	        data = data.result||{};
	        if(data.errCode && data.errCode == 'S'){
	        	address=data.address;
	        	legalPerson =data.legal_person;
	        	licenseCode = data.license_code;
	        	name= data.name;
	        	registerMoney =data.register_money;
	        	
	        	nui.get('shortName').setValue(name);
        		nui.get('fullName').setValue(name);
        		nui.get('licenseCode').setValue(licenseCode);
    			if(guestProperty && guestProperty!='013902'){    		
    				var params={};
    	        	params.licenseCode=licenseCode;
    	        	params.noOrgId=1;
    	        	queryCustomer(params);
	        	}
        		
	        	showMsg("营业执照识别成功","S");
	        }else{
	            showMsg("营业执照识别失败","W");
	            return;
	        }
	        
	    },
	    error:function(jqXHR, textStatus, errorThrown){
	        //  nui.alert(jqXHR.responseText);
	    	  nui.unmask();
	        
	    }
	});
}
var idCard=null;
var legalPerson=null;
function getIdCard(imgPath){
	var guestProperty =nui.get('guestProperty').getValue().replace(/\s+/g, "");
	nui.mask({
        el : document.body,
    	cls : 'mini-mask-loading',
    	html : '识别中...'
    });
	nui.ajax({
	    url:webPath + sysDomain +"/com.hs.common.sysService.getIdCardRecog.biz.ext",
	    type:"post",
	    data:{imgPath:imgPath},
	    async:false,
	    success:function(data)
	    {
	        nui.unmask();
	        data = data.result||{};
	        if(data.errCode && data.errCode == 'S'){
	        	idCard=data.id_card;
	        	legalPerson =data.legal_person;
	        	nui.get('idCard').setValue(idCard);
	        	if(guestProperty=='013902'){
	        		
	        		nui.get('shortName').setValue(legalPerson);
	        		nui.get('fullName').setValue(legalPerson);
	        		var params={};
		        	params.idCard=idCard;
		        	params.noOrgId=1;
		        	queryCustomer(params);
	        	}
	        	
	        	showMsg("身份证识别成功","S");
	        	
	        }else{
	            showMsg("身份证识别失败","W");
	        }
	        
	    },
	    error:function(jqXHR, textStatus, errorThrown){
	        //  nui.alert(jqXHR.responseText);
	    	  nui.unmask();
	     
	    }
	});
}
function setInitData(){
	mainForm.setData(supplier);
    otherForm.setData(supplier);

    onProvinceSelected("cityId");
    nui.get('cityId').setValue(supplier.cityId);     
    nui.get("isClient").setValue(supplier.isClient);
    nui.get("isSupplier").setValue(supplier.isSupplier);
    nui.get("isDisabled").setValue(supplier.isDisabled);
    nui.get("isInternal").setValue(supplier.isInternal);
    if(provinceEl.getText()){	
    	onCitySelected("cityId");
    }
    
    if(supplier.addr){
    	 nui.get("addr").setValue(supplier.addr);
    }
    if(supplier.isInternal == 1)
    {
        nui.get("fullName").hide();
        nui.get("fullName1").show();
        nui.get("fullName1").setValue(supplier.isInternalId);
        nui.get("fullName1").setText(supplier.fullName);
    }

    logisticsGrid.load({
    	guestId:supplier.id,
    	token:token
    });
    if(supplier.id){
    	haveSelectGrid.load({guestId: supplier.id ,token:token});
    }
}
function queryCustomer(params){
	nui.mask({
        el : document.body,
    	cls : 'mini-mask-loading',
    	html : '识别中...'
    });
	nui.ajax({
	    url:webPath + sysDomain +"/com.hsapi.cloud.part.baseDataCrud.crud.queryCustomList.biz.ext",
	    type:"post",
	    data:{params: params},
	    async:false,
	    success:function(data)
	    {
	        nui.unmask();
	        data = data||{};
	
	        supplier =  data.customers[0];
	        if(supplier){
	        	
	        	setInitData(supplier);
	        }
        	
	        
	    },
	    error:function(jqXHR, textStatus, errorThrown){
	        //  nui.alert(jqXHR.responseText);
	    	  nui.unmask();
	    }
	});
}
var qiNiuUrl='';
function getCompanyLogoUrl(){

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
        	qiNiuUrl =  data.companyLogoUrl;
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
return qiNiuUrl;
};
function onValueChanged(){
	var value = nui.get("isInternal").getValue();
    if(value == 1)
    {
        nui.get("fullName").hide();
        nui.get("fullName1").show();
    }
    else{
        nui.get("fullName1").hide();
        nui.get("fullName").show();
    }
}

function format(time, format) {
    var t = new Date(time);
    var tf = function (i) { return (i < 10 ? '0' : '') + i; };
    return format.replace(/yyyy|MM|dd|HH|mm|ss/g, function(a) {
    switch (a) {
    case 'yyyy':
    return tf(t.getFullYear());
    break;
    case 'MM':
    return tf(t.getMonth() + 1);
    break;
    case 'mm':
    return tf(t.getMinutes());
    break;
    case 'dd':
    return tf(t.getDate());
    break;
    case 'HH':
    return tf(t.getHours());
    break;
    case 'ss':
    return tf(t.getSeconds());
    break;
    }
    });
}

function CloseWindow(action) {
    //if (action == "close" && form.isChanged()) {
    //    if (confirm("数据被修改了，是否先保存？")) {
    //        return false;
    //    }
    //}
    if (window.CloseOwnerWindow) return window.CloseOwnerWindow(action);
    else window.close();
}
function onCancel(e) {
    CloseWindow("cancel");
}
//非个人且非现结
var requiredField2 = {
	    code:"客户编码",
	    guestProperty :"客户属性",
	    licenseUrl :"营业执照图片",
	    licenseCode :"营业执照号",
	    idCardUrl :"身份证图片",
	    idCard :"身份证",
	    shortName:"客户简称",
	    fullName:"客户全称",
	    billTypeId:"票据类型",
	    settTypeId:"结算方式",
	    manager:"联系人",
	    mobile:"联系人手机",
	    provinceId:"省份",
	    cityId:"城市"
	};
//个人且非现结
var requiredField = {
	    code:"客户编码",
	    guestProperty :"客户属性",
	    idCardUrl :"身份证图片",
	    idCard :"身份证",
	    shortName:"客户简称",
	    fullName:"客户全称",
	    billTypeId:"票据类型",
	    settTypeId:"结算方式",
	    manager:"联系人",
	    mobile:"联系人手机",
	    provinceId:"省份",
	    cityId:"城市"
	};
//现结
var requiredField3 = {
	    code:"客户编码",
	    guestProperty :"客户属性",
	    shortName:"客户简称",
	    fullName:"客户全称",
	    billTypeId:"票据类型",
	    settTypeId:"结算方式",
	    manager:"联系人",
	    mobile:"联系人手机",
	    provinceId:"省份",
	    cityId:"城市"
	};
var saveUrl = baseUrl + "com.hsapi.cloud.part.baseDataCrud.crud.saveSupplier.biz.ext";
function onOk()
{
    var dataList = [];
    dataList[0] = mainForm.getData();
    dataList[1] = otherForm.getData();
    var data = {};
    for(var i=0;i<dataList.length;i++)
    {
        for(var key in dataList[i])
        {
        	if(typeof dataList[i][key] != "function"){
                data[key] = dataList[i][key]
            }
        }
    }
    data.isClient = nui.get("isClient").getValue();
    data.isSupplier = nui.get("isSupplier").getValue();
    data.isDisabled = nui.get("isDisabled").getValue();
    data.isInternal = nui.get("isInternal").getValue();
    data.tenantId = currTenantId;
    data.orgid = currOrgId;
    if(data.isInternal == 1)
    {
    	if(!data.fullName1)
        {
            parent.showMsg("请选择公司","W");
            return;
        }
        data.isInternalId = data.fullName1;
        data.fullName = nui.get("fullName1").getText();
    }
    else{
        data.isInternalId = "";
    }
    var settleId = nui.get('settTypeId').value;
    var guestProperty=nui.get("guestProperty").getValue();
    //现结
    if(settleId =='020501'){
    	for(var key in requiredField3)
    	{
    		if(!data[key] || data[key].trim().length==0)
    		{
    			parent.showMsg(requiredField[key]+"不能为空","W");
    			return;
    		}
    	}
    }
    //个人且不是现结
	if(guestProperty=='013902' && settleId !='020501'){
    	
    	for(var key in requiredField)
    	{
    		if(!data[key] || data[key].trim().length==0)
    		{
    			parent.showMsg(requiredField[key]+"不能为空","W");
    			return;
    		}
    	}
    }
    //非个人且不是现结
	else if(guestProperty!='013902' && settleId !='020501'){
    	for(var key in requiredField2)
    	{
    		if(!data[key] || data[key].trim().length==0)
    		{
    			parent.showMsg(requiredField2[key]+"不能为空","W");
    			return;
    		}
    	}
    }
/*    data.moblie=nui.get('mobile').getValue();
    var pattern = /^[1][3,4,5,7,8]\d{9}$/;
    if(data.mobile !=pattern || data.mobile.length!=11){
    	parent.showMsg("请输入正确的手机号");
    	return;
    }*/

  
    if (data.modifyDate) {
        data.modifyDate = format(data.modifyDate, 'yyyy-MM-dd HH:mm:ss');
    }
    /*if(data.isEdit != "Y")
    {
        data.guestType = '01020102';
    }*/

    nui.mask({
        el : document.body,
    	cls : 'mini-mask-loading',
    	html : '保存中...'
    });
    nui.ajax({
        url:saveUrl,
        type:"post",
        data:JSON.stringify({
            supplier:data,
            token:token
        }),
        success:function(data)
        {
            nui.unmask();
            data = data||{};
            if(data.errCode == "S")
            {
            	saveLogistics(data.guestId);
            	//保存客户关系
            	saveGuestCon(data.guestId);
                parent.showMsg("保存成功","S");
                CloseWindow("ok");
            }
            else{
                parent.showMsg(data.errMsg||"保存失败","W");
            }
        },
        error:function(jqXHR, textStatus, errorThrown){
            //  nui.alert(jqXHR.responseText);
            console.log(jqXHR.responseText);
        }
    });
}
var saveLogisticsUrl = baseUrl + "com.hsapi.cloud.part.baseDataCrud.crud.saveGuestLogistics.biz.ext";
function saveLogistics(guestId){
	var logisticsAdd = logisticsGrid.getChanges("added");
	var logisticsUpdate = logisticsGrid.getChanges("modified");
	var logisticsDelete = logisticsGrid.getChanges("removed");
	nui.ajax({
        url:saveLogisticsUrl,
        type:"post",
        async:false,
        data:JSON.stringify({
            guestId:guestId,
            logisticsAdd:logisticsAdd,
            logisticsUpdate:logisticsUpdate,
            logisticsDelete:logisticsDelete,
            token:token
        }),
        success:function(data)
        {
            if(data.errCode == "S"){
            }else{
                parent.showMsg(data.errMsg||"收货信息保存失败","W");
            }
        },
        error:function(jqXHR, textStatus, errorThrown){
            //  nui.alert(jqXHR.responseText);
            console.log(jqXHR.responseText);
        }
    });
}

var tgradeList = [];
var tgradeHash = {};
var billTypeIdList = [];
var billTypeIdHash = {};
var settTypeIdList = [];
var settTypeIdHash = {};
var managerDutyList = [];
var managerDutyHash = {};
function setData(data)
{
	provinceList = data.province||[];
    if(provinceList.length == 0){
        getProvinceAndCity(function(data){
            provinceList.forEach(function(v){
                provinceHash[v.code] = v;
            });
            if(!provinceEl)
            {
                provinceEl = nui.get("provinceId");
            }
            provinceEl.setData(provinceList);
            cityList.forEach(function(v){
                cityHash[v.code] = v;
            });
        });
    }else {
        provinceList.forEach(function(v){
            provinceHash[v.code] = v;
        });
        if(!provinceEl)
        {
            provinceEl = nui.get("provinceId");
        }
        provinceEl.setData(provinceList);
        cityList = data.city||[];
        cityList.forEach(function(v){
            cityHash[v.code] = v;
        });
    }
    tgradeList = data.tgrade||[];
    tgradeList.forEach(function(v){
        tgradeHash[v.customid] = v;
    });
    billTypeIdList = data.billTypeId||[];
    billTypeIdList.forEach(function(v){
        billTypeIdHash[v.customid] = v;
    });
    settTypeIdList = data.settTypeId||[];
    settTypeIdList.forEach(function(v){
        settTypeIdHash[v.customid] = v;
    });
    managerDutyList = data.managerDuty||[];
    managerDutyList.forEach(function(v){
        managerDutyHash[v.customid] = v;
    });
    billTypeId.setData(billTypeIdList);
    settTypeId.setData(settTypeIdList);
    managerDuty.setData(managerDutyList);
    tgrade.setData(tgradeList);
 
    if(!mainForm)
    {
        initForm();
    }
    if(data.supplier)
    {
        var supplier = data.supplier;
        supplier.isEdit="Y";
        mainForm.setData(supplier);
        otherForm.setData(supplier);

        onProvinceSelected("cityId");
        nui.get('cityId').setValue(supplier.cityId);     
        nui.get("isClient").setValue(supplier.isClient);
        nui.get("isSupplier").setValue(supplier.isSupplier);
        nui.get("isDisabled").setValue(supplier.isDisabled);
        nui.get("isInternal").setValue(supplier.isInternal);
        if(provinceEl.getText()){	
        	onCitySelected("cityId");
        }
        
        if(supplier.addr){
       	 nui.get("addr").setValue(supplier.addr);
       }
        var guestProperty =nui.get('guestProperty').getValue();
        var settleId = nui.get('settTypeId').value;
      //个人且不是现结
    	if(guestProperty=='013902' && settleId !='020501'){
    		$('#idNo').show();
    		$('#lince').css("display","none");
    		$('#otherPicture').show();
    	//不是个人且不是现结
    	}else if(guestProperty !='013902' && settleId !='020501'){
    		$('#idNo').show();
    		$('#lince').show();
    		$('#otherPicture').show();
    	}
    	
        if(supplier.isInternal == 1)
        {
            nui.get("fullName").hide();
            nui.get("fullName1").show();
            nui.get("fullName1").setValue(supplier.isInternalId);
            nui.get("fullName1").setText(supplier.fullName);
        }

        logisticsGrid.load({
        	guestId:supplier.id,
        	token:token
        });
        if(supplier.id){
        	haveSelectGrid.load({guestId: supplier.id ,token:token});
        }
    }
    else{
        mainForm.setData({
            code:currentTimeMillis
        });
    }
}
/*function onActionRenderer(e) {
    var grid = e.sender;
    var record = e.record;
    var uid = record._uid;
    var rowIndex = e.rowIndex;

    var s = '<a class="nui-button" href="javascript:newRow()">新增</a> '
            + '<a class="nui-button" href="javascript:editRow(\'' + uid + '\')">修改</a> '
            + '<a class="nui-button" href="javascript:delRow(\'' + uid + '\')">删除</a> ';
               
    return s;
}*/
function newRow() {            
    var row = {};
    logisticsGrid.addRow(row, 0);
    nrow = row;

    edit(row);
}
function editRow(){
	var row = logisticsGrid.getSelected();
	nrow = row;
	edit(row);
}
function edit(row) {

	aprovinceEl.setData(provinceList);

    if (row) {
        //显示行详细
        logisticsGrid.hideAllRowDetail();
        logisticsGrid.showRowDetail(row);

        //将editForm元素，加入行详细单元格内
        var td = logisticsGrid.getRowDetailCellEl(row);
        td.appendChild(editLogisticsForm);
        editLogisticsForm.style.display = "";

        //表单加载员工信息
        var form = new nui.Form("editLogisticsForm");
        form.setData(row);

        var province = aprovinceEl.getValue();
        getRegion(province,function(data) {
			cityHash = data.rs || [];
			acityEl.setData(cityHash);

		});

        var city = acityEl.getValue();
		getRegion(city,function(data) {
			countyHash = data.rs || [];
			acountyEl.setData(countyHash);
		});
        /*if (logisticsGrid.isNewRow(row)) {                    
            form.reset();
        } else {
            form.loading();
            $.ajax({
                url: "../data/AjaxService.aspx?method=GetEmployee&id=" + row.id,
                success: function (text) {
                    var o = mini.decode(text);
                    form.setData(o);                            

                    form.unmask();
                }
            });
        }*/

        //logisticsGrid.doLayout();

    }
}
function cancelRow() {
    //logisticsGrid.reload();
    editLogisticsForm.style.display = "none";

    var form = new nui.Form("editLogisticsForm");
    form.setData([]);

    nrow = null;
}
function delRow(row_uid) {
	var row = logisticsGrid.getSelected();
	
    logisticsGrid.removeRow(row);
}

function updateRow() {
    var form = new nui.Form("editLogisticsForm");
    var newRow = form.getData();
    if(nrow){
    	logisticsGrid.updateRow(nrow, newRow);
    }
    
    cancelRow();
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
function onProvinceChange(e){
	var value = e.value;
	acityEl.setValue(null);
	acountyEl.setValue(null);
	getRegion(value,function(data) {
		cityHash = data.rs || [];
		acityEl.setData(cityHash);

	});
	setAddress();
}
function onCityChange(e){
	var value = e.value;
	acountyEl.setValue(null);
	getRegion(value,function(data) {
		countyHash = data.rs || [];
		acountyEl.setData(countyHash);

	});
	setAddress();
}
function onCountyChange(e){
	setAddress();
}
function onStreetChange(e){
	setAddress();
}

function onGuestPropertyChange(e){
	var settleId = nui.get('settTypeId').value;
	var guestProperty =nui.get('guestProperty').getValue();
	//个人且不是现结
	if(guestProperty=='013902' && settleId !='020501'){
		$('#idNo').show();
		$('#lince').css("display","none");
		$('#otherPicture').show();
	//不是个人且不是现结
	}else if(guestProperty !='013902' && settleId !='020501'){
		$('#idNo').show();
		$('#lince').show();
		$('#otherPicture').show();
	}
}

function onSettTypeIdChange(e){
	var settleId = nui.get('settTypeId').value;
	var guestProperty =nui.get('guestProperty').getValue();
	//现结
	if(settleId == '020501'){
		$('#idNo').css("display","none");
		$('#lince').css("display","none");
		$('#otherPicture').css("display","none");
	}
	//月结且个人
	if(settleId == '020502' && guestProperty=='013902'){
		$('#idNo').show();
		$('#lince').css("display","none");
		$('#otherPicture').show();
	}
	//月结且非个人
	if(settleId == '020502' && guestProperty!='013902'){
		$('#idNo').show();
		$('#lince').show();
		$('#otherPicture').show();
	}
}
function setAddress() {
	var provinceT = aprovinceEl.getText()||'';
	var cityT = acityEl.getText()||'';
	var countyT = acountyEl.getText()||'';
	var streetAddressT = astreetAddressEl.getValue()||'';
	var address = provinceT + cityT + countyT + streetAddressT;
	aaddressEl.setValue(address);
	aaddressEl.getValue();
}
var guestGrid = null;
var guestGridUrl = baseUrl+"com.hsapi.cloud.part.baseDataCrud.crud.queryCustomList.biz.ext";
function searchGuest(){
  var params = {
	        fullName:nui.get("guestName").getValue().replace(/\s+/g, ""),
	    };
  guestGrid.load({params:params,token:token});
}

function selectGuest(){
	var haveSelectHash={};
	haveSelectGrid.getData().forEach(function(v){
		if(v.guestConnectId){
			haveSelectHash[v.guestConnectId] =v;
		}		
	});
	var rows=guestGrid.getSelecteds();
	var newRows=[];
	for(var i=0;i<rows.length;i++){
		if(haveSelectHash[rows[i].id]){
			showMsg("已关联客户"+rows[i].fullName,"W");
			return;
		}
		var newRow={guestConnectId:rows[i].id,
			shortName:rows[i].shortName,
			fullName: rows[i].fullName};
		newRows.push(newRow);
	}
	haveSelectGrid.addRows(newRows);
}
function deleteRows(){
	var rows= haveSelectGrid.getSelecteds();
	haveSelectGrid.removeRows(rows);
}

var saveGuestConsUrl = baseUrl + "com.hsapi.cloud.part.baseDataCrud.crud.saveGuestConnect.biz.ext";
function saveGuestCon(guestId){
	var guestConAdd = haveSelectGrid.getChanges("added");
	var guestConDelete = haveSelectGrid.getChanges("removed");
	nui.ajax({
        url:saveGuestConsUrl,
        type:"post",
        async:false,
        data:JSON.stringify({
            guestId:guestId,
            guestConAdd:guestConAdd,
            guestConDelete:guestConDelete,
            token:token
        }),
        success:function(data)
        {
            if(data.errCode == "S"){
            }else{
                parent.showMsg(data.errMsg||"保存客户关系失败","W");
            }
        },
        error:function(jqXHR, textStatus, errorThrown){
            //  nui.alert(jqXHR.responseText);
            console.log(jqXHR.responseText);
        }
    });
}

